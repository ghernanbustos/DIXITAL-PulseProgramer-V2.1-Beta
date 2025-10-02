library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ltc2308_driver is
    generic (
        SYS_CLK_HZ : integer := 50_000_000; -- system clock (Hz)
        SCK_HZ     : integer := 5_000_000   -- desired SPI clock (Hz)
    );
    port (
        clk       : in  std_logic;          -- system clock
        rst       : in  std_logic;          -- async reset, active high
        start     : in  std_logic;          -- start conversion
        channel   : in  std_logic_vector(2 downto 0); -- channel select 0..7
        bipolar   : in  std_logic;          -- '0'=unipolar, '1'=bipolar
        sgl_diff  : in  std_logic;          -- '1'=single-ended, '0'=differential
        -- ADC interface
        cs_n      : out std_logic;
        sck       : out std_logic;
        sdi       : out std_logic;
        sdo       : in  std_logic;
        -- Result
        data_out  : out std_logic_vector(11 downto 0);
        done      : out std_logic           -- high when conversion result valid
    );
end ltc2308_driver;

architecture rtl of ltc2308_driver is

    constant DIVIDER : integer := SYS_CLK_HZ / (2 * SCK_HZ); -- half-period ticks
    signal clk_cnt   : integer range 0 to DIVIDER-1 := 0;
    signal sck_int   : std_logic := '0';

    type state_type is (IDLE, LOAD, SHIFT, DONE);
    signal state     : state_type := IDLE;

    signal shift_reg_out : std_logic_vector(15 downto 0);
    signal shift_reg_in  : std_logic_vector(15 downto 0);
    signal bit_cnt       : integer range 0 to 15 := 0;

    signal cs_n_reg      : std_logic := '1';
    signal data_reg      : std_logic_vector(11 downto 0) := (others=>'0');
    signal done_reg      : std_logic := '0';

begin
    -- outputs
    cs_n <= cs_n_reg;
    sck  <= sck_int;
    sdi  <= shift_reg_out(15);
    data_out <= data_reg;
    done <= done_reg;

    -- clock divider for SPI SCK
    process(clk, rst)
    begin
        if rst = '1' then
            clk_cnt <= 0;
            sck_int <= '0';
        elsif rising_edge(clk) then
            if state = SHIFT then
                if clk_cnt = DIVIDER-1 then
                    clk_cnt <= 0;
                    sck_int <= not sck_int;
                else
                    clk_cnt <= clk_cnt + 1;
                end if;
            else
                clk_cnt <= 0;
                sck_int <= '0';
            end if;
        end if;
    end process;

    -- main FSM
    process(clk, rst)
    begin
        if rst = '1' then
            state <= IDLE;
            cs_n_reg <= '1';
            shift_reg_out <= (others=>'0');
            shift_reg_in <= (others=>'0');
            bit_cnt <= 0;
            done_reg <= '0';
        elsif rising_edge(clk) then
            done_reg <= '0'; -- default

            case state is
                when IDLE =>
                    cs_n_reg <= '1';
                    if start = '1' then
                        -- prepare control word: [S/D][ODD/SIGN][UNI/BIP][MSB CHN]
                        shift_reg_out(15 downto 12) <= sgl_diff & channel(0) & bipolar & channel(2);
                        shift_reg_out(11 downto 0)  <= (others => '0'); -- don't care
                        bit_cnt <= 15;
                        cs_n_reg <= '0';
                        state <= LOAD;
                    end if;

                when LOAD =>
                    -- wait half SCK period before shifting
                    if clk_cnt = DIVIDER-1 then
                        state <= SHIFT;
                    end if;

                when SHIFT =>
                    if clk_cnt = DIVIDER-1 and sck_int = '1' then
                        -- on rising SCK: sample input
                        shift_reg_in(bit_cnt) <= sdo;
                    elsif clk_cnt = DIVIDER-1 and sck_int = '0' then
                        -- on falling SCK: shift output
                        if bit_cnt > 0 then
                            shift_reg_out <= shift_reg_out(14 downto 0) & '0';
                            bit_cnt <= bit_cnt - 1;
                        else
                            cs_n_reg <= '1';
                            data_reg <= shift_reg_in(11 downto 0);
                            state <= DONE;
                        end if;
                    end if;

                when DONE =>
                    done_reg <= '1';
                    state <= IDLE;
            end case;
        end if;
    end process;

end rtl;

