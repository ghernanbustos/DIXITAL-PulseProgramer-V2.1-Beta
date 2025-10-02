--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         count_test.vhd
--   DepENDencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version -- 03/2023 Guillermo H. Bustos
--
--	  Brief: 
--		testing use
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all; -- for the signed, unsigned types and arithmetic ops

ENTITY count_test is
  port (
		clock_50 : in 	std_logic;
		cout     : out std_logic;
		cout_flag: out std_logic
  );
END count_test;

ARCHITECTURE behavioral of count_test is
	-- Declare variable with its initial values
	--	signal count_test_val	: unsigned(22 downto 0) := (others => '0');
	--	constant modulus	: unsigned(22 downto 0) := to_unsigned(50000000, 23); -- Initial_valuie


BEGIN
	PROCESS(clock_50) -- sensitive list
		VARIABLE overflow : INTEGER RANGE 0 TO 99999999; -- 49999999
	BEGIN
	 IF rising_edge(clock_50) THEN
			overflow := overflow + 1;
			cout <= '0';
			cout_flag <= '0';
		IF (overflow = 99999999) THEN
			overflow := 0;
			cout <= '1';
			cout_flag <= '1';
		END IF;		
	 END IF;

	END PROCESS;

  --cout <= std_logic_vector(count_test_val); -- Update signal out of PROCESS statement

END behavioral;
