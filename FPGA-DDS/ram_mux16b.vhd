-------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         ram_mux16b_v2.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 03/2023 Guillermo H. Bustos
--
--	 Brief:
-- 		Because  an issue trying to connect data from different buses to one target bus
--				on Schematic. The input is splitted and concatenated to build one bus from differents inputs. 
--				It might not be a safe programming method. find a different solution in future
--			   This mux is for specific application. Not Generic
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------
ENTITY ram_mux16b IS
	PORT (	
			-- wr_rd_sel
			data_sel	: IN  STD_LOGIC := '0';
			-- Data In
			data_1	: IN STD_LOGIC_VECTOR(15 DOWNTO 0); 
			data_2	: IN STD_LOGIC_VECTOR(15 DOWNTO 0);--16bit long because the input comes from one bus.
	
			-- OUT PORTS
			data_Out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
			);			
END ram_mux16b;

ARCHITECTURE mux3 OF ram_mux16b IS
BEGIN
    PROCESS (data_sel, data_1, data_2)
    BEGIN
        CASE data_sel IS
            WHEN '0' =>
                data_Out <= data_1;
            WHEN '1' =>
                data_Out <= data_2;
            WHEN OTHERS =>
                data_Out <= (others => '0');
        END CASE;
    END PROCESS;
	
 END mux3;