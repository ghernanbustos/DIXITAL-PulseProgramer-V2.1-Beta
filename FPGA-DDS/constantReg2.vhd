LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------
ENTITY constantReg2 IS
	PORT (	
			count	: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
			);			
END constantReg2;

ARCHITECTURE regcte OF constantReg2 IS
BEGIN
					 
		count <= "000"; 

	
 END regcte;