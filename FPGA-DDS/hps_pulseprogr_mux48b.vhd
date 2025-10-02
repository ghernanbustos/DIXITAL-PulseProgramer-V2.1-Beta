-------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         data_demux_16b.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 2024 Guillermo H. Bustos
--
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------
ENTITY hps_pulseprogr_mux48b IS
	PORT (	
			-- wr_rd_sel
			data_sel	: IN  STD_LOGIC := '0';
			-- Data In
			data_1_A	: IN STD_LOGIC_VECTOR( 7 DOWNTO 0); -- Ctrl
			data_1_B	: IN STD_LOGIC_VECTOR( 7 DOWNTO 0);	-- Address
			data_1_C	: IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Data
			
			data_2_A	: IN STD_LOGIC_VECTOR( 7 DOWNTO 0); 
			data_2_B	: IN STD_LOGIC_VECTOR( 7 DOWNTO 0);
			data_2_C	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			-- OUT PORTS
			data_Out : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
			);			
END hps_pulseprogr_mux48b;

ARCHITECTURE mux3 OF hps_pulseprogr_mux48b IS
BEGIN
    PROCESS (data_sel,data_1_A,data_1_B,data_1_C,data_2_A,data_2_B,data_2_C)
    BEGIN
        CASE data_sel IS
            WHEN '0' =>
                data_Out <= (data_1_A & data_1_B & data_1_C); -- TO COMPLETE 48bits output
            WHEN '1' =>
                data_Out <= (data_2_A & data_2_B & data_2_C);
            WHEN OTHERS =>
                data_Out <= (others => '0');
        END CASE;
    END PROCESS;
	
 END mux3;