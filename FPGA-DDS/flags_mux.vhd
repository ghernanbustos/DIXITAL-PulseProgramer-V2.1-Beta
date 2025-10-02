-------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         flags_mux.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 09/2024 Guillermo H. Bustos
--
--	 Multiplex End Flags signal from Buffers
--			  
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------
ENTITY flags_mux IS
	PORT (	
			-- wr_rd_sel
			sel_data	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			-- Data In
			data_A	: IN STD_LOGIC;	
			data_B	: IN STD_LOGIC;
			data_C	: IN STD_LOGIC;	
			data_D	: IN STD_LOGIC;
			data_E	: IN STD_LOGIC;
			data_F	: IN STD_LOGIC;
			data_G	: IN STD_LOGIC;
			data_H	: IN STD_LOGIC;
			-- OUT PORTS
			data_Out	: OUT STD_LOGIC
			);			
END flags_mux;

ARCHITECTURE mux3 OF flags_mux IS
BEGIN
    PROCESS (sel_data,data_A,data_B,data_C,data_D,data_E,data_F,data_G,data_H)
    BEGIN
        CASE sel_data IS
            WHEN "000" =>
                data_Out <= data_A;

            WHEN "001" =>
                data_Out <= data_B;

            WHEN "010" =>
                data_Out <= data_C;

            WHEN "011" =>
                data_Out <= data_D;
					 
            WHEN "100" =>
                data_Out <= data_E;
					 
            WHEN "101" =>
                data_Out <= data_F;
					 
            WHEN "110" =>
                data_Out <= data_G;
					 
            WHEN "111" =>
                data_Out <= data_H;	
					 
            WHEN OTHERS =>
                data_Out <= '0';
        END CASE;
    END PROCESS;
	
 END mux3;