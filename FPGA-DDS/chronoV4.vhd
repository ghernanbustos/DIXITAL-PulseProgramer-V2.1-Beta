--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         chronoV4.vhd
--   DepENDencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version -- 03/2023 Guillermo H. Bustos
--
--	  Brief: 
--			This chrono has to be used with the adds of Finite State Machine. This will 
--			controls the signal moments to set prescaler, init counting and stop chrono 
--			after overflow. If this is not well synchronized. Chrono will start again right
--			after signal overflows.
--			Remember that Singal variables update out of the process. 
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity chronoV4 is
    port (
        clk_chrono       : in  std_logic;  -- Clock in 50 MHz
        nRst_chrono      : in  std_logic;  -- Active-low reset
        --
        en_chrono        : in  std_logic;  -- Start signal from FSM
        setPrecount      : in  std_logic;  -- Load precount value
        precountValue    : in  std_logic_vector(31 downto 0); -- Preload value
        --
        pulseSignal      : out std_logic;  -- High when counting
        overflowChrono   : out std_logic   -- High when overflow reached
    );
end chronoV4;

architecture Behavioral of chronoV4 is
    signal precount_reg  : unsigned(31 downto 0) := (others => '0');
    signal counter       : unsigned(31 downto 0) := (others => '0');
    signal is_counting   : std_logic := '0';
begin

    process(clk_chrono,nRst_chrono)
    begin
        if nRst_chrono = '0' then
                precount_reg    <= (others => '0');
                counter         <= (others => '0');
                is_counting     <= '0';
                overflowChrono  <= '0';
            else if rising_edge(clk_chrono) then
                overflowChrono <= '0';  -- default low

                -- Load precount register
                if setPrecount = '1' then
                    precount_reg <= unsigned(precountValue);
                end if;

                -- Start counting
                if en_chrono = '1' and is_counting = '0' then
                    counter      <= precount_reg;
                    is_counting  <= '1';
                elsif is_counting = '1' then
                    if counter = x"FFFFFFFF" then
                        is_counting    <= '0';
                        overflowChrono <= '1';
                    else
                        counter <= counter + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    pulseSignal <= is_counting;

end architecture;