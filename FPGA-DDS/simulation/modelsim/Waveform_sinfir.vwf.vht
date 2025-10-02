-- Copyright (C) 2023  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "09/16/2024 12:59:54"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          lut_fir
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY lut_fir_vhd_vec_tst IS
END lut_fir_vhd_vec_tst;
ARCHITECTURE lut_fir_arch OF lut_fir_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL ast_error : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL ast_sink_error : STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL ast_sink_valid : STD_LOGIC;
SIGNAL ast_valid : STD_LOGIC;
SIGNAL clk_3mhz : STD_LOGIC;
SIGNAL data_fir_out : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL flag_output : STD_LOGIC;
SIGNAL nco_enable : STD_LOGIC;
SIGNAL phase_inc : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL reset_n : STD_LOGIC;
COMPONENT lut_fir
	PORT (
	ast_error : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	ast_sink_error : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	ast_sink_valid : IN STD_LOGIC;
	ast_valid : OUT STD_LOGIC;
	clk_3mhz : IN STD_LOGIC;
	data_fir_out : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	flag_output : OUT STD_LOGIC;
	nco_enable : IN STD_LOGIC;
	phase_inc : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	reset_n : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : lut_fir
	PORT MAP (
-- list connections between master ports and signals
	ast_error => ast_error,
	ast_sink_error => ast_sink_error,
	ast_sink_valid => ast_sink_valid,
	ast_valid => ast_valid,
	clk_3mhz => clk_3mhz,
	data_fir_out => data_fir_out,
	flag_output => flag_output,
	nco_enable => nco_enable,
	phase_inc => phase_inc,
	reset_n => reset_n
	);

-- reset_n
t_prcs_reset_n: PROCESS
BEGIN
	reset_n <= '1';
WAIT;
END PROCESS t_prcs_reset_n;

-- clk_3mhz
t_prcs_clk_3mhz: PROCESS
BEGIN
	FOR i IN 1 TO 301
	LOOP
		clk_3mhz <= '0';
		WAIT FOR 166000 ps;
		clk_3mhz <= '1';
		WAIT FOR 166000 ps;
	END LOOP;
	clk_3mhz <= '0';
WAIT;
END PROCESS t_prcs_clk_3mhz;

-- nco_enable
t_prcs_nco_enable: PROCESS
BEGIN
	nco_enable <= '1';
WAIT;
END PROCESS t_prcs_nco_enable;
-- phase_inc[31]
t_prcs_phase_inc_31: PROCESS
BEGIN
	phase_inc(31) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_31;
-- phase_inc[30]
t_prcs_phase_inc_30: PROCESS
BEGIN
	phase_inc(30) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_30;
-- phase_inc[29]
t_prcs_phase_inc_29: PROCESS
BEGIN
	phase_inc(29) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_29;
-- phase_inc[28]
t_prcs_phase_inc_28: PROCESS
BEGIN
	phase_inc(28) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_28;
-- phase_inc[27]
t_prcs_phase_inc_27: PROCESS
BEGIN
	phase_inc(27) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_27;
-- phase_inc[26]
t_prcs_phase_inc_26: PROCESS
BEGIN
	phase_inc(26) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_26;
-- phase_inc[25]
t_prcs_phase_inc_25: PROCESS
BEGIN
	phase_inc(25) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_25;
-- phase_inc[24]
t_prcs_phase_inc_24: PROCESS
BEGIN
	phase_inc(24) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_24;
-- phase_inc[23]
t_prcs_phase_inc_23: PROCESS
BEGIN
	phase_inc(23) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_23;
-- phase_inc[22]
t_prcs_phase_inc_22: PROCESS
BEGIN
	phase_inc(22) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_22;
-- phase_inc[21]
t_prcs_phase_inc_21: PROCESS
BEGIN
	phase_inc(21) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_21;
-- phase_inc[20]
t_prcs_phase_inc_20: PROCESS
BEGIN
	phase_inc(20) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_20;
-- phase_inc[19]
t_prcs_phase_inc_19: PROCESS
BEGIN
	phase_inc(19) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_19;
-- phase_inc[18]
t_prcs_phase_inc_18: PROCESS
BEGIN
	phase_inc(18) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_18;
-- phase_inc[17]
t_prcs_phase_inc_17: PROCESS
BEGIN
	phase_inc(17) <= '1';
WAIT;
END PROCESS t_prcs_phase_inc_17;
-- phase_inc[16]
t_prcs_phase_inc_16: PROCESS
BEGIN
	phase_inc(16) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_16;
-- phase_inc[15]
t_prcs_phase_inc_15: PROCESS
BEGIN
	phase_inc(15) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_15;
-- phase_inc[14]
t_prcs_phase_inc_14: PROCESS
BEGIN
	phase_inc(14) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_14;
-- phase_inc[13]
t_prcs_phase_inc_13: PROCESS
BEGIN
	phase_inc(13) <= '1';
WAIT;
END PROCESS t_prcs_phase_inc_13;
-- phase_inc[12]
t_prcs_phase_inc_12: PROCESS
BEGIN
	phase_inc(12) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_12;
-- phase_inc[11]
t_prcs_phase_inc_11: PROCESS
BEGIN
	phase_inc(11) <= '1';
WAIT;
END PROCESS t_prcs_phase_inc_11;
-- phase_inc[10]
t_prcs_phase_inc_10: PROCESS
BEGIN
	phase_inc(10) <= '1';
WAIT;
END PROCESS t_prcs_phase_inc_10;
-- phase_inc[9]
t_prcs_phase_inc_9: PROCESS
BEGIN
	phase_inc(9) <= '1';
WAIT;
END PROCESS t_prcs_phase_inc_9;
-- phase_inc[8]
t_prcs_phase_inc_8: PROCESS
BEGIN
	phase_inc(8) <= '1';
WAIT;
END PROCESS t_prcs_phase_inc_8;
-- phase_inc[7]
t_prcs_phase_inc_7: PROCESS
BEGIN
	phase_inc(7) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_7;
-- phase_inc[6]
t_prcs_phase_inc_6: PROCESS
BEGIN
	phase_inc(6) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_6;
-- phase_inc[5]
t_prcs_phase_inc_5: PROCESS
BEGIN
	phase_inc(5) <= '1';
WAIT;
END PROCESS t_prcs_phase_inc_5;
-- phase_inc[4]
t_prcs_phase_inc_4: PROCESS
BEGIN
	phase_inc(4) <= '1';
WAIT;
END PROCESS t_prcs_phase_inc_4;
-- phase_inc[3]
t_prcs_phase_inc_3: PROCESS
BEGIN
	phase_inc(3) <= '1';
WAIT;
END PROCESS t_prcs_phase_inc_3;
-- phase_inc[2]
t_prcs_phase_inc_2: PROCESS
BEGIN
	phase_inc(2) <= '1';
WAIT;
END PROCESS t_prcs_phase_inc_2;
-- phase_inc[1]
t_prcs_phase_inc_1: PROCESS
BEGIN
	phase_inc(1) <= '1';
WAIT;
END PROCESS t_prcs_phase_inc_1;
-- phase_inc[0]
t_prcs_phase_inc_0: PROCESS
BEGIN
	phase_inc(0) <= '0';
WAIT;
END PROCESS t_prcs_phase_inc_0;

-- ast_sink_valid
t_prcs_ast_sink_valid: PROCESS
BEGIN
	ast_sink_valid <= '1';
WAIT;
END PROCESS t_prcs_ast_sink_valid;
-- ast_sink_error[1]
t_prcs_ast_sink_error_1: PROCESS
BEGIN
	ast_sink_error(1) <= '0';
WAIT;
END PROCESS t_prcs_ast_sink_error_1;
-- ast_sink_error[0]
t_prcs_ast_sink_error_0: PROCESS
BEGIN
	ast_sink_error(0) <= '0';
WAIT;
END PROCESS t_prcs_ast_sink_error_0;
END lut_fir_arch;
