LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------
ENTITY constantReg IS
	PORT (	
			count	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			);			
END constantReg;

ARCHITECTURE regcte OF constantReg IS
BEGIN
					 
		count <= "00000000000000000000000000001100"; 

	
 END regcte;