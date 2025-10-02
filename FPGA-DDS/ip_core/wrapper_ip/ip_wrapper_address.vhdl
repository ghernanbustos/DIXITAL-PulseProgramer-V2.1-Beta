--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos, ghernanbustos@gmail.com
--   FileName:         ip_wrapper_address.vhdl
--   Design Software:  Quartus Prime Lite Edition 22.1 Std Edition
--	  Company:   Universidad Nacional de Cordoba - FAMAF - LARTE - IFEG
--   Project: 			  Dixital 
--	  Company: 			  LARTE -IFEG
--   Version History
--   	Version 03/2024
--	
--	  Brief: 
--		Address Wrapper, sets Address buffer for reading or writing

--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity ip_wrapper_address is 
	port(
		clk					: in 	std_logic 						 		:= '0';
		reset_n				: in 	std_logic 						 		:= '0';
		-------- Avalon Bus 
		avs_s0_address 	: in  std_logic_vector(3 downto 0) := (others => '0'); -- Op Code
		avs_s0_read			: in  std_logic 						 		:= '0';
		avs_s0_readdata	: out std_logic_vector(7 downto 0);
		avs_s0_write		: in  std_logic 								:= '0';
		avs_s0_writedata 	: in  std_logic_vector(7 downto 0) := (others => '0');
		-------- CONDUITS -  
		debug_address_in		: in 	std_logic_vector(7 downto 0) := (others => '0'); -- extra input
		init_address			: out std_logic_vector(7 downto 0) := (others => '0');
		ftw_address				: out std_logic_vector(7 downto 0) := (others => '0');
		ptw_address				: out std_logic_vector(7 downto 0) := (others => '0');
		chrono_address			: out std_logic_vector(7 downto 0) := (others => '0');
		modulation_address	: out std_logic_vector(7 downto 0) := (others => '0');
		chrono2_address		: out std_logic_vector(7 downto 0) := (others => '0');
		adc_address				: out std_logic_vector(7 downto 0) := (others => '0');
		pulse_pgr_address		: out std_logic_vector(7 downto 0) := (others => '0')
	);
end ip_wrapper_address;

ARCHITECTURE behavioral OF ip_wrapper_address IS
begin
wrapper_data:	process(clk, reset_n)
	begin
	if (reset_n = '0') then
		init_address		<= (others => '0'); 
		ftw_address			<= (others => '0');
		ptw_address			<= (others => '0');
		chrono_address		<= (others => '0');
		modulation_address<= (others => '0');
		avs_s0_readdata 	<= (others => '0');
		chrono2_address	<= (others => '0');
		adc_address			<= (others => '0');
		pulse_pgr_address	<= (others => '0');
	elsif (rising_edge(clk)) then -- edge sensitive
		if (avs_s0_read = '1') then -- 
			case avs_s0_address is
				when "0000" => 
					avs_s0_readdata <= debug_address_in; -- array of fsms end signals
				when others => 
					avs_s0_readdata <= (others => '0'); 
			end case;
		elsif (avs_s0_write = '1') then 
			case avs_s0_address is -- Every option select a register to be set
				when "0000" => 								-- 0x0000
					init_address  			<= avs_s0_writedata;
				when "0001" => 								-- 0x0001
					ftw_address 	 		<= avs_s0_writedata; 
				when "0010" => 								-- 0x0002
					ptw_address 	 		<= avs_s0_writedata;
				when "0011" => 								-- 0x0003
					chrono_address 		<= avs_s0_writedata;
				when "0100" => 								-- 0x0004
					modulation_address	<= avs_s0_writedata;
				when "0101" => 								-- 0x0004
					chrono2_address		<= avs_s0_writedata;
				when "0110" => 								-- 0x0004
					adc_address				<= avs_s0_writedata;
				when "0111" => 								-- 0x0004
					pulse_pgr_address		<= avs_s0_writedata;
				when others =>
					init_address		<= (others => '0'); 
					ftw_address			<= (others => '0');
					ptw_address			<= (others => '0');
					chrono_address		<= (others => '0');
					modulation_address<= (others => '0');
					chrono2_address	<= (others => '0');
					adc_address			<= (others => '0');
					pulse_pgr_address	<= (others => '0');
			end case;
		end if;
	end if;
	end process wrapper_data;
end behavioral;
