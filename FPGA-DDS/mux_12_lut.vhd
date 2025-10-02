-------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         data_demux_16b.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 09/2024 Guillermo H. Bustos
--
-- 		For fully combinational behaviour be aware to list all inputs and sel singal in process sensitive
--				list.	 
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------
ENTITY mux_12_lut IS
	PORT (	
			-- wr_rd_sel
			sel_data	: IN STD_LOGIC_VECTOR(1 downto 0);
			-- Data In
			data_A	: IN STD_LOGIC_VECTOR(11 DOWNTO 0);	
			data_B	: IN STD_LOGIC_VECTOR(11 DOWNTO 0);
			data_C	: IN STD_LOGIC_VECTOR(11 DOWNTO 0);	
			data_D	: IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	
			-- OUT PORTS
			msb_sign_fir : OUT STD_LOGIC :='0';
			fir_valid_on : OUT  STD_LOGIC := '0';
			data_Out	: OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
			);			
END mux_12_lut;

ARCHITECTURE mux3 OF mux_12_lut IS
BEGIN
    PROCESS (sel_data,data_A, data_B, data_C)
    BEGIN
        CASE sel_data IS
            WHEN "00" =>
                data_Out <= data_A;
					 fir_valid_on <= '1';
					 msb_sign_fir <= '0'; -- always positive sign bit
            WHEN "01" =>
                data_Out <= data_B;
					 fir_valid_on <= '1';
					 msb_sign_fir <= '0';
            WHEN "10" =>
                data_Out <= data_C;
					 fir_valid_on <= '1';
					 msb_sign_fir <= '0';
            WHEN "11" =>
                data_Out <= data_D;
					 fir_valid_on <= '1';
					 msb_sign_fir <= '0';
            WHEN OTHERS =>
                data_Out <= (others => '0');
					 msb_sign_fir <= '0';
        END CASE;
    END PROCESS;
	
 END mux3;