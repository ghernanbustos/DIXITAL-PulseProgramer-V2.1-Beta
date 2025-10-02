-- ###########################################################################
--  Title      : LTC2308 Pure-FPGA Acquisition for DE0-Nano-SoC
--  Description: Deterministic, high-throughput capture path in FPGA fabric.
--               - SPI/convert controller for LTC2308 (8-ch, 12-bit)
--               - Configurable SCK divider, sample rate, channel sequencing
--               - Ping-pong (double) buffer in BRAM for long bursts
--               - Simple read port so HPS/logic can drain the inactive bank
--
--  Files in this single unit:
--    1) ltc2308_ctrl       : SPI + conversion FSM for LTC2308
--    2) pingpong_ram       : Dual-port 2-bank buffer (BRAM-friendly)
--    3) ltc2308_top        : Glue — sequences channels, writes RAM
--
--  Notes:
--    * Map the ports to the actual ADC pins on your DE0-Nano-SoC per the
--      board user manual (ADC_CONVST, ADC_SCLK, ADC_SDI, ADC_SDO, ADC_CS_N).
--    * Timing numbers in the LTC2308 datasheet vary by mode. Use generics
--      here to keep safe margins; tweak after bring-up with SignalTap.
--    * The controller emits (chan_id, 12b data) words to the RAM writer.
--    * Keep FPGA clk high (e.g., 50 MHz). SCK comes from integer divider.
--
--  License: MIT (use freely in your lab)
-- ###########################################################################

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- ===========================================================================
-- 1) LTC2308 Controller: SPI + CONVST sequencing
-- ===========================================================================
-- Protocol (simplified typical mode):
--   - For each sample frame:
--     * Assert CS low
--     * Pulse CONVST low->high to start conversion
--     * Provide 16 SCK cycles while sending 4 config bits (SDI) and
--       simultaneously shifting in 12 result bits on SDO (MSB-first)
--     * Deassert CS
--   - This controller supports single-channel (fixed) or round-robin.

entity ltc2308_ctrl is
  generic (
    G_CLK_HZ        : natural := 50000000; -- FPGA system clock
    G_SCK_HZ        : natural := 10000000; -- SPI SCK target (<= ADC max)
    G_CONVST_CLKS   : natural := 4;        -- width of CONVST pulse in clk cycles
    G_GAP_CLKS      : natural := 2;        -- inter-frame gap in clk cycles
    G_ROUND_ROBIN   : boolean := true      -- if true, auto-advance channel
  );
  port (
    clk       : in  std_logic;
    rst_n     : in  std_logic;

    -- Control
    en        : in  std_logic;             -- run continuously when '1'
    start     : in  std_logic;             -- single-shot when en='0'
    ch_fixed  : in  unsigned(2 downto 0);  -- used if G_ROUND_ROBIN=false

    -- Output sample
    sample_valid : out std_logic;
    sample_chan  : out unsigned(2 downto 0);
    sample_data  : out unsigned(11 downto 0);

    -- ADC pins
    adc_convst_n : out std_logic;  -- active-low pulse
    adc_cs_n     : out std_logic;  -- active-low frame select
    adc_sck      : out std_logic;  -- SPI clock
    adc_sdi      : out std_logic;  -- config out to ADC
    adc_sdo      : in  std_logic   -- data in from ADC
  );
end entity;

architecture rtl of ltc2308_ctrl is
  constant C_DIV : natural := integer(max(1, G_CLK_HZ / (2*G_SCK_HZ))); -- 2 ticks per SCK toggle

  type t_state is (S_IDLE, S_CS_LO, S_CONVST, S_SCK_SHIFT, S_GAP);
  signal st           : t_state := S_IDLE;

  signal div_cnt      : natural range 0 to C_DIV := 0;
  signal sck_int      : std_logic := '0';
  signal sck_en       : std_logic := '0';
  signal bit_cnt      : integer range 0 to 15 := 0; -- 16 SCK edges for frame

  signal conv_cnt     : natural range 0 to G_CONVST_CLKS := 0;
  signal gap_cnt      : natural range 0 to G_GAP_CLKS := 0;

  signal cs_n         : std_logic := '1';
  signal convst_n     : std_logic := '1';

  -- Shift regs
  signal sh_out       : unsigned(15 downto 0) := (others=>'0'); -- config on MSBs
  signal sh_in        : unsigned(15 downto 0) := (others=>'0');

  signal cur_chan     : unsigned(2 downto 0) := (others=>'0');
  signal next_frame   : std_logic := '0';

  -- Helpers to build LTC2308 control word (see datasheet). Typical fields:
  --  S/D, O/S, S1, S0, UNI/BIP, SLP, etc. Here we craft a 4-bit channel field
  --  on the first 4 clocks; feel free to extend to full control word as needed.
  function build_cfg(c : unsigned(2 downto 0)) return unsigned is
    variable cfg : unsigned(15 downto 0) := (others=>'0');
  begin
    -- Place channel select bits on the first 4 SCKs (example mapping):
    -- [15:12] = 0 & c(2 downto 0)  (MSB first). Adjust to your exact mode.
    cfg(15) := '0';
    cfg(14 downto 12) := c;               -- 3-bit channel
    -- Remaining bits kept 0 => default: single-ended, unipolar, no sleep
    return cfg;
  end;

begin
  -- SCK divider
  process(clk) is
  begin
    if rising_edge(clk) then
      if rst_n='0' then
        div_cnt <= 0;
        sck_int <= '0';
      else
        if sck_en='1' then
          if div_cnt = C_DIV then
            div_cnt <= 0;
            sck_int <= not sck_int;
          else
            div_cnt <= div_cnt + 1;
          end if;
        else
          div_cnt <= 0;
          sck_int <= '0';
        end if;
      end if;
    end if;
  end process;

  adc_sck      <= sck_int;
  adc_cs_n     <= cs_n;
  adc_convst_n <= convst_n;
  adc_sdi      <= std_logic(sh_out(15)); -- MSB first

  -- FSM
  process(clk) is
  begin
    if rising_edge(clk) then
      if rst_n='0' then
        st           <= S_IDLE;
        cs_n         <= '1';
        convst_n     <= '1';
        sck_en       <= '0';
        bit_cnt      <= 0;
        conv_cnt     <= 0;
        gap_cnt      <= 0;
        sample_valid <= '0';
        cur_chan     <= (others=>'0');
        sh_out       <= (others=>'0');
        sh_in        <= (others=>'0');
      else
        sample_valid <= '0';

        -- Auto-advance channel if enabled and next frame requested
        if G_ROUND_ROBIN and next_frame='1' then
          cur_chan <= std_logic_vector(unsigned(cur_chan)+1)(2 downto 0);
        elsif not G_ROUND_ROBIN and next_frame='1' then
          cur_chan <= ch_fixed;
        end if;
        next_frame <= '0';

        case st is
          when S_IDLE =>
            cs_n     <= '1';
            convst_n <= '1';
            sck_en   <= '0';
            bit_cnt  <= 0;
            if en='1' or start='1' then
              sh_out   <= build_cfg(cur_chan);
              sh_in    <= (others=>'0');
              st       <= S_CS_LO;
            end if;

          when S_CS_LO =>
            cs_n     <= '0';
            convst_n <= '0';
            sck_en   <= '0';
            conv_cnt <= 0;
            st       <= S_CONVST;

          when S_CONVST =>
            -- Hold CONVST low for G_CONVST_CLKS cycles
            if conv_cnt = G_CONVST_CLKS then
              convst_n <= '1';
              sck_en   <= '1';
              bit_cnt  <= 0;
              st       <= S_SCK_SHIFT;
            else
              conv_cnt <= conv_cnt + 1;
            end if;

          when S_SCK_SHIFT =>
            -- Shift on SCK falling edge to sample SDO on rising edge
            if sck_en='1' and sck_int='1' and div_cnt=0 then
              -- rising edge just occurred -> sample SDO into sh_in MSB..LSB
              sh_in  <= sh_in(14 downto 0) & unsigned'(adc_sdo);
              -- also rotate sh_out to present next bit on SDI before next edge
            elsif sck_en='1' and sck_int='0' and div_cnt=0 then
              sh_out <= sh_out(14 downto 0) & '0';
              if bit_cnt = 15 then
                sck_en <= '0';
                st     <= S_GAP;
                gap_cnt<= 0;
                -- Emit sample (lower 12 bits of sh_in) with channel tag
                sample_valid <= '1';
                sample_data  <= sh_in(11 downto 0);
                sample_chan  <= cur_chan;
              else
                bit_cnt <= bit_cnt + 1;
              end if;
            end if;

          when S_GAP =>
            cs_n <= '1';
            if gap_cnt = G_GAP_CLKS then
              next_frame <= '1';
              if en='1' then
                st <= S_IDLE; -- loop
              else
                st <= S_IDLE; -- single-shot done
              end if;
            else
              gap_cnt <= gap_cnt + 1;
            end if;
        end case;
      end if;
    end if;
  end process;
end architecture;

-- ===========================================================================
-- 2) Ping-Pong RAM: two banks; writer fills active bank, reader drains other
--    BRAM-friendly simple-dual-port memories. Parameterizable sample width.
-- ===========================================================================
entity pingpong_ram is
  generic (
    G_WORD_W    : natural := 16;        -- e.g., 3b chan + 12b data + pad
    G_DEPTH     : natural := 4096       -- words per bank
  );
  port (
    clk      : in  std_logic;
    rst_n    : in  std_logic;

    -- Write side (from ADC path)
    w_en     : in  std_logic;
    w_data   : in  unsigned(G_WORD_W-1 downto 0);
    w_ready  : out std_logic;           -- '1' if writer can continue
    bank_wr_active : out std_logic;     -- 0/1 current bank id

    -- Reader side (to HPS/logic)
    r_bank_sel : in  std_logic;         -- choose which bank to read (opp. of active)
    r_addr     : in  unsigned(integer(ceil(log2(real(G_DEPTH))))-1 downto 0);
    r_data     : out unsigned(G_WORD_W-1 downto 0);

    -- Status/handshake
    bank_full      : out std_logic;     -- pulses when a bank just became full
    bank_switched  : out std_logic      -- pulses when writer switches banks
  );
end entity;

architecture rtl of pingpong_ram is
  function clog2(n : natural) return natural is
    variable r : natural := 0; variable v : natural := n-1; begin
      while v > 0 loop v := v/2; r := r+1; end loop; return r; end;

  constant C_AW : natural := clog2(G_DEPTH);

  type ram_t is array(0 to G_DEPTH-1) of unsigned(G_WORD_W-1 downto 0);
  signal ram0, ram1 : ram_t := (others=>(others=>'0'));

  signal wr_bank   : std_logic := '0';
  signal wr_addr   : unsigned(C_AW-1 downto 0) := (others=>'0');
  signal full_p    : std_logic := '0';
  signal switch_p  : std_logic := '0';
begin
  w_ready        <= not full_p;
  bank_wr_active <= wr_bank;
  bank_full      <= full_p;
  bank_switched  <= switch_p;

  -- Write process
  process(clk) is
  begin
    if rising_edge(clk) then
      if rst_n='0' then
        wr_addr  <= (others=>'0');
        wr_bank  <= '0';
        full_p   <= '0';
        switch_p <= '0';
      else
        full_p   <= '0';
        switch_p <= '0';
        if w_en='1' then
          if wr_bank='0' then
            ram0(to_integer(wr_addr)) <= w_data;
          else
            ram1(to_integer(wr_addr)) <= w_data;
          end if;

          if wr_addr = (G_DEPTH-1) then
            wr_addr  <= (others=>'0');
            wr_bank  <= not wr_bank;
            full_p   <= '1';
            switch_p <= '1';
          else
            wr_addr <= wr_addr + 1;
          end if;
        end if;
      end if;
    end if;
  end process;

  -- Read MUX (simple dual-port behavior). Registered read is optional.
  process(clk) is
  begin
    if rising_edge(clk) then
      if r_bank_sel='0' then
        r_data <= ram0(to_integer(r_addr));
      else
        r_data <= ram1(to_integer(r_addr));
      end if;
    end if;
  end process;
end architecture;

-- ===========================================================================
-- 3) Top-level: wire controller to ping-pong RAM; channel scheduler
-- ===========================================================================
entity ltc2308_top is
  generic (
    G_CLK_HZ      : natural := 50000000;
    G_SCK_HZ      : natural := 10000000;
    G_SAMPLES_PER_BANK : natural := 4096
  );
  port (
    clk       : in  std_logic;
    rst_n     : in  std_logic;

    run_cont  : in  std_logic;              -- run continuously

    -- Reader interface (e.g., HPS or logic on other clock domain can CDC)
    r_bank_sel : in  std_logic;             -- choose bank to read (opposite of write bank)
    r_addr     : in  unsigned(11 downto 0); -- enough for 4096
    r_data     : out unsigned(15 downto 0);

    -- Status
    bank_wr_active : out std_logic;         -- 0/1
    bank_full_pulse: out std_logic;         -- pulse when a bank fills

    -- ADC pins
    adc_convst_n : out std_logic;
    adc_cs_n     : out std_logic;
    adc_sck      : out std_logic;
    adc_sdi      : out std_logic;
    adc_sdo      : in  std_logic
  );
end entity;

architecture rtl of ltc2308_top is
  signal s_valid     : std_logic;
  signal s_chan      : unsigned(2 downto 0);
  signal s_data      : unsigned(11 downto 0);
  signal w_ready     : std_logic;

  signal word16      : unsigned(15 downto 0);
  signal bank_sw     : std_logic;

begin
  u_ctrl: entity work.ltc2308_ctrl
    generic map (
      G_CLK_HZ      => G_CLK_HZ,
      G_SCK_HZ      => G_SCK_HZ,
      G_CONVST_CLKS => 4,
      G_GAP_CLKS    => 2,
      G_ROUND_ROBIN => true
    )
    port map (
      clk           => clk,
      rst_n         => rst_n,
      en            => run_cont,
      start         => '0',
      ch_fixed      => (others=>'0'),
      sample_valid  => s_valid,
      sample_chan   => s_chan,
      sample_data   => s_data,
      adc_convst_n  => adc_convst_n,
      adc_cs_n      => adc_cs_n,
      adc_sck       => adc_sck,
      adc_sdi       => adc_sdi,
      adc_sdo       => adc_sdo
    );

  -- Pack into 16 bits: [15:13]=chan, [12:1]=data(11:0), [0]=0 pad
  word16 <= s_chan & s_data & "0";

  u_pp: entity work.pingpong_ram
    generic map (
      G_WORD_W => 16,
      G_DEPTH  => G_SAMPLES_PER_BANK
    )
    port map (
      clk            => clk,
      rst_n          => rst_n,
      w_en           => s_valid and w_ready,
      w_data         => word16,
      w_ready        => w_ready,
      bank_wr_active => bank_wr_active,
      r_bank_sel     => r_bank_sel,
      r_addr         => r_addr,
      r_data         => r_data,
      bank_full      => bank_full_pulse,
      bank_switched  => bank_sw
    );

  -- User logic should toggle r_bank_sel opposite to bank_wr_active
  -- after seeing bank_full_pulse, then drain the whole bank.

end architecture;

-- ###########################################################################
-- Bring-up Checklist
--  1) Constrain pins to ADC and 50 MHz clk; set I/O standards.
--  2) Start with low SCK (e.g., 2 MHz), verify data toggling.
--  3) Use SignalTap to watch sample_chan/data and SPI pins.
--  4) Increase G_SCK_HZ gradually, ensure setup/hold on SDO is met.
--  5) Validate channel order and control word mapping vs datasheet.
--  6) Integrate CDC/AXI/Avalon interface as needed for cross-domain reads.
-- ###########################################################################
