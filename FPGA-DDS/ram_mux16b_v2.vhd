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
-- 		For fully combinational behaviour be aware to list all inputs and sel singal in process sensitive
--				list.
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------
ENTITY ram_mux16b_v2 IS
	PORT (	
			-- wr_rd_sel
			data_sel	: IN  STD_LOGIC := '0';
			-- Data In
			data_1_a	: IN STD_LOGIC_VECTOR(5 DOWNTO 0); --6bit long address and extra bits for padding
			data_1_b	: IN STD_LOGIC_VECTOR(3 DOWNTO 0); --4bit long control bits
			data_2	: IN STD_LOGIC_VECTOR(15 DOWNTO 0);--16bit long because the input comes from one bus.
	
			-- OUT PORTS
			data_Out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
			);			
END ram_mux16b_v2;

ARCHITECTURE mux3 OF ram_mux16b_v2 IS
BEGIN
    PROCESS (data_sel, data_1_a,data_1_b, data_2)
    BEGIN
        CASE data_sel IS
            WHEN '0' =>
                data_Out <= (data_1_a & data_1_b) OR "0000000000000000"; -- TO COMPLETE 16BIT output
            WHEN '1' =>
                data_Out <= data_2;
            WHEN OTHERS =>
                data_Out <= (others => '0');
        END CASE;
    END PROCESS;
	
 END mux3;