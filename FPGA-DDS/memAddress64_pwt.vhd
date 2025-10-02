--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         memAddress64_pwt.vhd
--   DepENDencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version -- 05/2023 Guillermo H. Bustos
--
--	  Brief: 
--			The counter generates the values of the addresses to sequentially traverse the RAM memory with the timing words.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- for the signed, unsigned types and arithmetic ops

ENTITY memAddress64_pwt is
  port (
		address_clk 		: in 	std_logic; -- Clock in 50Mhz
		address_rst 		: in 	std_logic;
		address_en   		: in  std_logic;
		-- 
		address_mem			: out std_logic_vector(5 downto 0);
		address_db_flag	: out std_logic_vector(5 downto 0) -- Debug Flag
  );
END memAddress64_pwt;

ARCHITECTURE behavioral of memAddress64_pwt is
	signal count : std_logic_vector(5 downto 0) := (others => '0');
BEGIN
	PROCESS( address_clk,address_rst) -- sensitive list
	BEGIN
		IF (address_rst = '0') THEN -- asynchronous reset
			count <= (OTHERS => '0');
			-------------------------
		ELSIF (rising_edge(address_clk ) and address_en = '1') THEN -- edge activation
			if (count = "111111") then
				count <= (OTHERS => '0');
			else
				count <= std_logic_vector(unsigned(count) + 1);
			end if;
		END IF;
	END PROCESS;
	address_mem <= count;
	address_db_flag <= count;
END behavioral;