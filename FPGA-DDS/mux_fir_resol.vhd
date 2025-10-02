-------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         mux_fir_resol.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 09/2024 Guillermo H. Bustos
--
--	 Set FIR output bit resolution
-- 		For fully combinational behaviour be aware to list all inputs and sel singal in process sensitive
--				list.	   
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------
ENTITY mux_fir_resol IS
	PORT (	
			-- wr_rd_sel
			sel_data	: IN STD_LOGIC_VECTOR(1 downto 0);
			-- Data In
			data_A	: IN STD_LOGIC_VECTOR(11 DOWNTO 0);	
			data_B	: IN STD_LOGIC_VECTOR(11 DOWNTO 0);
			data_C	: IN STD_LOGIC_VECTOR(11 DOWNTO 0);	
			data_D	: IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	
			-- OUT PORTS
			data_Out	: OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
			);			
END mux_fir_resol;

ARCHITECTURE mux3 OF mux_fir_resol IS
BEGIN
    PROCESS (sel_data, data_A, data_B, data_C)
    BEGIN
        CASE sel_data IS
            WHEN "00" =>
                data_Out <= data_A;

            WHEN "01" =>
                data_Out <= data_B;

            WHEN "10" =>
                data_Out <= data_C;

            WHEN "11" =>
                data_Out <= data_D;

            WHEN OTHERS =>
                data_Out <= (others => '0');
        END CASE;
    END PROCESS;
	
 END mux3;