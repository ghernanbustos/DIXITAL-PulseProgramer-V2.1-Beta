library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity genericPreloadValue2 is
    Port (
        clk : in STD_LOGIC;
        rst_n : in STD_LOGIC;
        output_data : out STD_LOGIC_VECTOR(31 downto 0)
    );
end entity genericPreloadValue2;

architecture Behavioral of genericPreloadValue2 is
    -- Define your desired 32-bit value here 
    constant desired_value : STD_LOGIC_VECTOR(31 downto 0) := "11111111111111111111110000011000"; 
																					
    signal output_reg : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
begin
    process (clk, rst_n)
    begin
        if rst_n = '0' then
            output_reg <= (others => '0'); -- rst_n the output to all zeroes
        elsif rising_edge(clk) then
            output_reg <= desired_value; -- Set the output to the desired value on the rising edge of the clock
        end if;
    end process;

    -- Assign the output signal to the registered value
    output_data <= output_reg;
end architecture Behavioral;