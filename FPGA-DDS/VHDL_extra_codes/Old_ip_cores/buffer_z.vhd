LIBRARY ieee;
USE ieee.std_logic_1164.all;
 ----------------------------------------------
ENTITY buffer_z IS
	GENERIC(d2_width : INTEGER := 80);
	PORT ( 	
			ena	: IN STD_LOGIC;
			input	: IN 	STD_LOGIC_VECTOR (d2_width-1 DOWNTO 0);
			output: OUT STD_LOGIC_VECTOR (d2_width-1 DOWNTO 0));
	END buffer_z;
 ----------------------------------------------
 ARCHITECTURE tri_state OF buffer_z IS
 BEGIN
	output <= input WHEN (ena='1') ELSE
						(OTHERS => 'Z');
END tri_state;
----------------------------------------------




