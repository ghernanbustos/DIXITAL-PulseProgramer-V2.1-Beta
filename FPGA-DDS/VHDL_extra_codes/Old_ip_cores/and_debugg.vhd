LIBRARY IEEE;
USE ieee.std_logic_1164.all;
---------------------------
ENTITY and_debugg IS
	GENERIC (n : INTEGER := 3);
PORT (	
			x_n	 			: IN STD_LOGIC_VECTOR(n-1 downto 0);
			overflow_and 	: OUT STD_LOGIC);
END and_debugg;
---------------------------
ARCHITECTURE dataflow OF and_debugg IS
	SIGNAL tmp : STD_LOGIC_VECTOR(n-1 downto 0);
BEGIN

	tmp <= (OTHERS => '1');
	
	overflow_and <= '1' WHEN x_n = tmp ELSE '0';
	
END dataflow;
