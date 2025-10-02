--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos, ghernanbustos@gmail.com
--   FileName:         ip_wrapper.vhdl
--   Design Software:  Quartus Prime Lite Edition 22.1 Std Edition
--	  Company:    Universidad Nacional de Cordoba - FAMAF - LARTE - IFEG
--   Project: 			  Dixital 
--	  Company: 			  LARTE
--   Version History
--   	Version 03/2024
--	
--	  Brief: 
--		
--		ip wrapper to mux different modules, every module has its own control register

--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity ip_wrapper_ctrl is 
	port(
		clk						: in 	std_logic 						 		:= '0';
		reset_n					: in 	std_logic 						 		:= '0';
		-------- Avalon Bus 
		avs_s0_address 		: in  std_logic_vector(3 downto 0) := (others => '0'); -- Op Code
		avs_s0_read				: in  std_logic 						 		:= '0';
		avs_s0_readdata		: out std_logic_vector(7 downto 0);
		avs_s0_write			: in  std_logic 								:= '0';
		avs_s0_writedata 		: in  std_logic_vector(7 downto 0) := (others => '0');
		-------- CONDUITS - Custom outports
		endFsm_ctrl_flag		: in  std_logic_vector(7 downto 0) := (others => '0'); -- dds data send
		debug_ctrl_in			: in 	std_logic_vector(7 downto 0) := (others => '0'); -- extra input
		--	
		outMux_CtrlReg			: out std_logic_vector(7 downto 0) := (others => '0'); -- extra output
		init_CtrlReg			: out std_logic_vector(7 downto 0) := (others => '0');
		ftw_CtrlReg				: out std_logic_vector(7 downto 0) := (others => '0');
		ptw_CtrlReg				: out std_logic_vector(7 downto 0) := (others => '0');
		chrono_CtrlReg			: out std_logic_vector(7 downto 0) := (others => '0');
		modulation_CtrlReg	: out std_logic_vector(7 downto 0) := (others => '0');
		debug_CtrlReg			: out std_logic_vector(7 downto 0) := (others => '0'); -- extra output
		chrono2_CtrlReg		: out std_logic_vector(7 downto 0) := (others => '0');
		adc_CtrlReg				: out std_logic_vector(7 downto 0) := (others => '0');
		pulse_pgr_CtrlReg		: out std_logic_vector(7 downto 0) := (others => '0')
	);
end ip_wrapper_ctrl;

ARCHITECTURE behavioral OF ip_wrapper_ctrl IS
signal REG_0 : STD_LOGIC_VECTOR(7 downto 0) := "10100001"; -- Testing use only
signal REG_1 : STD_LOGIC_VECTOR(7 downto 0) := "10100010"; -- Testing use only
signal REG_2 : STD_LOGIC_VECTOR(7 downto 0) := "10100011"; -- Testing use only

begin
wrapper_data:	process(clk, reset_n)
	begin
	if (reset_n = '0') then
		init_CtrlReg			<= (others => '0'); 
		ftw_CtrlReg				<= (others => '0');
		ptw_CtrlReg				<= (others => '0');
		chrono_CtrlReg			<= (others => '0');
		modulation_CtrlReg	<= (others => '0');
		debug_CtrlReg 			<= (others => '0');
		avs_s0_readdata 		<= (others => '0');
		chrono2_CtrlReg 		<= (others => '0');
		adc_CtrlReg 			<= (others => '0');
		pulse_pgr_CtrlReg		<= (others => '0');
	elsif (rising_edge(clk)) then -- edge sensitive
		if (avs_s0_read = '1') then -- 
			case avs_s0_address is
				when "0000" => 
					avs_s0_readdata <= endFsm_ctrl_flag; -- array of fsms end signals
				when "0001" => 
					avs_s0_readdata <= debug_ctrl_in; -- vector
				when "0010" => 
					avs_s0_readdata <= REG_0; -- Testing use only
				when "0011" => 
					avs_s0_readdata <= REG_1; -- Testing use only
				when "0100" => 
					avs_s0_readdata <= REG_2; -- Testing use only
				when others => 
					avs_s0_readdata <= (others => '0'); 
			end case;
		elsif (avs_s0_write = '1') then 
			case avs_s0_address is -- Every option select a register to be set
				when "0000" => 								-- 0x0000
					init_CtrlReg  			<= avs_s0_writedata;
				when "0001" => 								-- 0x0001
					ftw_CtrlReg 	 		<= avs_s0_writedata; 
				when "0010" => 								-- 0x0002
					ptw_CtrlReg 	 		<= avs_s0_writedata;
				when "0011" => 								-- 0x0003
					chrono_CtrlReg 		<= avs_s0_writedata;
				when "0100" => 								-- 0x0004
					modulation_CtrlReg	<= avs_s0_writedata;
				when "0101" =>
					debug_CtrlReg   		<= avs_s0_writedata;	
				when "0110" =>
					outMux_CtrlReg   		<= avs_s0_writedata;	
				when "0111" =>
					chrono2_CtrlReg   	<= avs_s0_writedata;	
				when "1000" =>
					adc_CtrlReg   			<= avs_s0_writedata;	
				when "1001" =>
					pulse_pgr_CtrlReg  	<= avs_s0_writedata;	
				when others =>
					init_CtrlReg			<= (others => '0'); 
					ftw_CtrlReg				<= (others => '0');
					ptw_CtrlReg				<= (others => '0');
					chrono_CtrlReg			<= (others => '0');
					modulation_CtrlReg	<= (others => '0');
					debug_CtrlReg 			<= (others => '0');
					outMux_CtrlReg 		<= (others => '0');
					chrono2_CtrlReg   	<= (others => '0');	
					adc_CtrlReg   			<= (others => '0');	
					pulse_pgr_CtrlReg		<= (others => '0');	
			end case;
		end if;
	end if;
	end process wrapper_data;
end behavioral;
