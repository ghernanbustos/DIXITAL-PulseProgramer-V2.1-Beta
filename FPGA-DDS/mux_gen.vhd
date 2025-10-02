-------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         mux_generic.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 09/2024 Guillermo H. Bustos

-- 		For fully combinational behaviour be aware to list all inputs and sel singal in process sensitive
--				list.	 		  
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------
ENTITY mux_gen IS  

	PORT (	
			-- wr_rd_sel
			sel_data	: IN STD_LOGIC;
			-- Data In
			data_A	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);	
			data_B	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			-- OUT PORTS
			data_Out	: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
			);			
END mux_gen;

ARCHITECTURE mux3 OF mux_gen IS
BEGIN
    PROCESS (sel_data,data_A,data_B)
    BEGIN
        CASE sel_data IS
            WHEN '0' =>
                data_Out <= data_A;

            WHEN '1' =>
                data_Out <= data_B;

            WHEN OTHERS =>
                data_Out <= (others => '0');
        END CASE;
    END PROCESS;
	
 END mux3;