-------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         mux3_fsm.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 03/2023 Guillermo H. Bustos
--
--	  Brief: 
--			Mux for output signals to the input DDS ports
-- 		For fully combinational behaviour be aware to list all inputs and sel singal in process sensitive
--				list.	 
--			This mux set defined DDS input port states wheter if buffers writes dds registers or not.mux
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------
ENTITY mux3_fsm IS
	PORT (	
			-- sel_fsm
			sel_fsm	: IN  STD_LOGIC_VECTOR(2 DOWNTO 0); -- eight bus mutilplexed
			-- Data In
			data_0	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			data_1	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);	
			data_2	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);	
			data_3	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);	
			data_4	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);	
			data_5	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);	
			data_6	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);	
			data_7	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);	
			-- OUT PORTS
			data_Out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			--data_Out_db : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- for debug purpose
			);			
END mux3_fsm;

ARCHITECTURE mux3_fsm1 OF mux3_fsm IS
BEGIN
    PROCESS (sel_fsm, data_1, data_2, data_3,data_4,data_5,data_6)
    BEGIN
        CASE sel_fsm IS
            WHEN "000" =>
                data_Out <= data_0;
					 --data_Out_db <= data_0;
            WHEN "001" =>
                data_Out <= data_1;
					 --data_Out_db <= data_1;
            WHEN "010" =>
                data_Out <= data_2;
					 --data_Out_db <= data_2;
            WHEN "011" =>
                data_Out <= data_3;
					 --data_Out_db <= data_3;
            WHEN "100" =>
                data_Out <= data_4;
					 --data_Out_db <= data_4;
            WHEN "101" =>
                data_Out <= data_5;
					 --data_Out_db <= data_4;
            WHEN "110" =>
                data_Out <= data_6;
					 --data_Out_db <= data_4
            WHEN "111" =>
                data_Out <= data_7;
					 --data_Out_db <= data_4;
            WHEN OTHERS =>
                data_Out <= (others => '0');
        END CASE;
    END PROCESS;
	
 END mux3_fsm1;