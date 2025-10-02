--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos, ghernanbustos@gmail.com
--   FileName:         ip_wrapper.vhdl
--   Design Software:  Quartus Prime Lite Edition 22.1 Std Edition
--	  Company:   Universidad Nacional de Cordoba - FAMAF - LARTE - IFEG
--   Project: 			  Dixital 
--	  Company: 			  LARTE -IFEG
--   Version History
--   	Version 03/2024
--	
--	  Brief: 
--		lw_axi_master max width = 32bits
--		ip wrapper to mux different modules and read/write data frames
--		When set address ensure multiple of 4 to maintain memory alignment with 32bits data

--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity ip_wrapper_data is 
	port(
		clk						: in 	std_logic 						 		:= '0';
		reset_n					: in 	std_logic 						 		:= '0';
		-------- Avalon Bus 
		avs_s0_address 		: in 	std_logic_vector(5 downto 0) 	:= (others => '0'); -- Op Code
		avs_s0_read				: in	std_logic 						 		:= '0';
		avs_s0_readdata		: out 	std_logic_vector(31 downto 0);
		avs_s0_write			: in 	std_logic 						 		:= '0';
		avs_s0_writedata 		: in 	std_logic_vector(31 downto 0) 	:= (others => '0');
		-------- CONDUITS 
		rd_ramOut_init			: in  std_logic_vector	(31 downto 0) 	:= (others => '0'); -- for debugging purpose
		rd_ramOut_ftw			: in  std_logic_vector 	(31 downto 0) 	:= (others => '0'); -- for debugging purpose
		rd_ramOut_ptw			: in  std_logic_vector 	(31 downto 0) 	:= (others => '0'); -- for debugging purpose
		rd_ramOut_chrono		: in  std_logic_vector 	(31 downto 0) 	:= (others => '0'); -- for debugging purpose
		rd_ramOut_modulation	: in  std_logic_vector 	(31 downto 0)	:= (others => '0'); -- for debugging purpose
		debug_data_in 			: in  std_logic_vector 	(31 downto 0) 	:= (others => '0'); -- for debugging purpose
		rd_ramOut_chrono2		: in 	std_logic_vector	(31 downto 0) 	:= (others => '0');
		rd_ramOut_adc			: in 	std_logic_vector	(31 downto 0) 	:= (others => '0');
		rd_ramOut_pulse_pgr	: in 	std_logic_vector	(31 downto 0) 	:= (others => '0');
		--	
		init_ram_data			: out std_logic_vector 	(31 downto 0) 	:= (others => '0');	
		ftw_ram_data			: out std_logic_vector 	(31 downto 0) 	:= (others => '0');
		ptw_ram_data			: out std_logic_vector 	(31 downto 0) 	:= (others => '0');
		chrono_ram_data		: out std_logic_vector 	(31 downto 0) 	:= (others => '0');
		modulation_ram_data	: out std_logic_vector 	(31 downto 0) 	:= (others => '0');
		debug_ram_data			: out std_logic_vector 	(31 downto 0) 	:= (others => '0');
		chrono2_ram_data		: out std_logic_vector	(31 downto 0) 	:= (others => '0');
		adc_ram_data			: out std_logic_vector	(31 downto 0) 	:= (others => '0');
		pulse_pgr_ram_data	: out std_logic_vector	(31 downto 0) 	:= (others => '0')

	);
end ip_wrapper_data;

ARCHITECTURE behavioral OF ip_wrapper_data IS

begin
wrapper_data:	process(clk, reset_n)
	begin
	if (reset_n = '0') then
		init_ram_data		<= (others => '0');
		ftw_ram_data 		<= (others => '0');
		ptw_ram_data 		<= (others => '0');
		chrono_ram_data 	<= (others => '0');
		modulation_ram_data <= (others => '0');
		debug_ram_data 	<= (others => '0');
		avs_s0_readdata	<= (others => '0'); 
		chrono2_ram_data 	  	<= (others => '0'); 
		adc_ram_data 	  		<= (others => '0'); 
		pulse_pgr_ram_data 	<= (others => '0'); 
		
	elsif (rising_edge(clk)) then -- edge sensitive
		if (avs_s0_read = '1') then -- Set right PORT config in Qsys module section
			case avs_s0_address is
				when "000000" => 
					avs_s0_readdata <= rd_ramOut_init; -- External asigned value 
				when "000100" => 
					avs_s0_readdata <= rd_ramOut_ftw; -- Register Value
				when "001000" => 
					avs_s0_readdata <= rd_ramOut_ptw; -- Register Value
				when "001100" => 
					avs_s0_readdata <= rd_ramOut_chrono; -- Register Value
				when "010000" => 
					avs_s0_readdata <= rd_ramOut_modulation; -- Register Value
				when "010100" => 
					avs_s0_readdata <= debug_data_in; -- Register Value
				when "011000" => 
					avs_s0_readdata <= rd_ramOut_chrono2; -- Register Value
				when "011100" => 
					avs_s0_readdata <= rd_ramOut_adc; -- Register Value
				when "100000" => 
					avs_s0_readdata <= rd_ramOut_pulse_pgr; -- Register Value
				when others => 
					avs_s0_readdata <= (others => '0'); 
			end case;
		elsif (avs_s0_write = '1') then -- address multiple of 4 to maintain memory alignment with 32bits
			case avs_s0_address is
				when "000000" => 				-- 0
					init_ram_data    		<= avs_s0_writedata;
				when "000100" => 				-- 4
					ftw_ram_data 	  		<= avs_s0_writedata; 
				when "001000" => 				-- 8
					ptw_ram_data 	  		<= avs_s0_writedata;
				when "001100" => 				-- 12
					chrono_ram_data 	  	<= avs_s0_writedata;
				when "010000" => 				-- 16
					modulation_ram_data 	<= avs_s0_writedata;
				when "010100" => 				-- 20
					debug_ram_data 	  	<= avs_s0_writedata;
				when "011000" => 				-- 24
					chrono2_ram_data 	  	<= avs_s0_writedata;
				when "011100" => 				-- 28
					adc_ram_data 	  		<= avs_s0_writedata;
				when "100000" => 				-- 32
					pulse_pgr_ram_data 	<= avs_s0_writedata;
				when others =>
					init_ram_data			<= (others => '0');
					ftw_ram_data 			<= (others => '0');
					ptw_ram_data 			<= (others => '0');
					chrono_ram_data 		<= (others => '0');
					modulation_ram_data 	<= (others => '0');
					debug_ram_data 		<= (others => '0');
					chrono2_ram_data 		<= (others => '0');
					adc_ram_data 			<= (others => '0');
					pulse_pgr_ram_data 	<= (others => '0');
			end case;
		end if;
	end if;
	end process wrapper_data;
end behavioral;
