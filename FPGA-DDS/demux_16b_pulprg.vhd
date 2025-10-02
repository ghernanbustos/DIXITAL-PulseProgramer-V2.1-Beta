--	  Autor: 			  Guillermo H. Bustos
--   FileName:         demux_16b_pulprg.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 03/2023 Guillermo H. Bustos	  
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------
ENTITY demux_16b_pulprg IS
	PORT (	
			-- wr_rd_sel
			sel_data		: IN STD_LOGIC_VECTOR(2 downto 0) := "000";
			-- Data In
			data_in_A	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);	
			data_in_B	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);	
			-- OUT PORTS
			data_out1 	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			data_out2	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			data_out3	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			data_out4	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);	
			data_out5	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			data_out6	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			data_out7	: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
			);			
END demux_16b_pulprg;

ARCHITECTURE mux3 OF demux_16b_pulprg IS
BEGIN	
    PROCESS (sel_data, data_in_A,data_in_B)
    BEGIN	
        CASE sel_data IS
            WHEN "000" =>
                data_out1 <= data_in_A & data_in_B;
                data_out2 <= (others => '0');
                data_out3 <= (others => '0');
                data_out4 <= (others => '0');
                data_out5 <= (others => '0');
                data_out6 <= (others => '0');
                data_out7 <= (others => '0');
					 
            WHEN "001" =>
                data_out2 <= data_in_A & data_in_B;
					 data_out1 <= (others => '0');
                data_out3 <= (others => '0');
                data_out4 <= (others => '0');
                data_out5 <= (others => '0');
                data_out6 <= (others => '0');
                data_out7 <= (others => '0');
					 
            WHEN "010" =>
                data_out3 <= data_in_A & data_in_B;
					 data_out1 <= (others => '0');
                data_out2 <= (others => '0');
                data_out4 <= (others => '0');
                data_out5 <= (others => '0');
                data_out6 <= (others => '0');
                data_out7 <= (others => '0');
					 
            WHEN "011" =>
                data_out4 <= data_in_A & data_in_B;
					 data_out1 <= (others => '0');
                data_out2 <= (others => '0');
                data_out3 <= (others => '0');
                data_out5 <= (others => '0');
                data_out6 <= (others => '0');
                data_out7 <= (others => '0');
					 
            WHEN "100" =>
                data_out5 <= data_in_A & data_in_B;
					 data_out1 <= (others => '0');
                data_out2 <= (others => '0');
                data_out3 <= (others => '0');
                data_out4 <= (others => '0');
                data_out6 <= (others => '0');
                data_out7 <= (others => '0');
					 
            WHEN "101" =>
                data_out6 <= data_in_A & data_in_B;
					 data_out1 <= (others => '0');
                data_out2 <= (others => '0');
                data_out3 <= (others => '0');
                data_out4 <= (others => '0');
                data_out5 <= (others => '0');
                data_out7 <= (others => '0');
					 
            WHEN "110" =>
                data_out7 <= data_in_A & data_in_B;
					 data_out1 <= (others => '0');
                data_out2 <= (others => '0');
                data_out3 <= (others => '0');
                data_out4 <= (others => '0');
                data_out5 <= (others => '0');
                data_out6 <= (others => '0');
					 
            WHEN OTHERS =>
					 data_out1 <= (others => '0');
                data_out2 <= (others => '0');
                data_out3 <= (others => '0');
                data_out4 <= (others => '0');
                data_out5 <= (others => '0');
                data_out6 <= (others => '0');
                data_out7 <= (others => '0');
        END CASE;
    END PROCESS;
	
 END mux3;