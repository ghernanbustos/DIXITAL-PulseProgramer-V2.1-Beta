--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         clockdivider_half_V2.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 08/2023 Guillermo H. Bustos
--
--	  Brief: 
-- 	Divide input frequency by 4
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clockdivider_half_V2 is
    Port (
        clk_in : in  std_logic;
        clk_out : out std_logic
    );
end clockdivider_half_V2;

architecture Behavioral of clockdivider_half_V2 is
    signal clk_out_internal : std_logic := '0';
begin
    process(clk_in)
        variable divider_counter : integer range 0 to 1 := 0;
    begin
        if rising_edge(clk_in) then
            divider_counter := divider_counter + 1;
            if divider_counter = 1 then
                clk_out_internal <= not clk_out_internal;
            end if;
        end if;
    end process;

    clk_out <= clk_out_internal;
end Behavioral;
