--	  Autor: 			  Guillermo H. Bustos
--   FileName:         demux_12b_lut.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 03/2023 Guillermo H. Bustos
--
--	 
--			  
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------
ENTITY demux_12b_lut IS
	PORT (	
			-- wr_rd_sel
			sel_data		: IN STD_LOGIC_VECTOR(1 downto 0) := "00";
			-- Data In
			data_in1 	: IN STD_LOGIC_VECTOR(11 DOWNTO 0);
			data_in2		: IN STD_LOGIC_VECTOR(11 DOWNTO 0);
			data_in3		: IN STD_LOGIC_VECTOR(11 DOWNTO 0);
			data_in4		: IN STD_LOGIC_VECTOR(11 DOWNTO 0);	
			
			-- OUT PORTS
			data_out		: OUT STD_LOGIC_VECTOR(11 DOWNTO 0)	
			);			
END demux_12b_lut;

ARCHITECTURE mux3 OF demux_12b_lut IS
BEGIN	
    PROCESS (sel_data, data_in1, data_in2, data_in3, data_in4)
    BEGIN	
        CASE sel_data IS
            WHEN "00" =>
                data_out <= data_in1;
            WHEN "01" =>
                data_out <= data_in2;
            WHEN "10" =>
                data_out <= data_in3;
            WHEN "11" =>
                data_out <= data_in4;
            WHEN OTHERS =>
                data_out <= (others => '0');
        END CASE;
    END PROCESS;
	
 END mux3;