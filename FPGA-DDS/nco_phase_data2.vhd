LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------
ENTITY nco_phase_data2 IS
	PORT (
			data_Out1	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			);			
END nco_phase_data2;

ARCHITECTURE phaseData OF nco_phase_data2 IS
BEGIN
    data_Out1 <= "00000000000101011101100001101000";
					   
 
END phaseData;