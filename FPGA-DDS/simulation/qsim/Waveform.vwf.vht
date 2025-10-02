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
-- Generated on "07/15/2025 12:38:16"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          pulse_fsm
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY pulse_fsm_vhd_vec_tst IS
END pulse_fsm_vhd_vec_tst;
ARCHITECTURE pulse_fsm_arch OF pulse_fsm_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL AddressMempulse : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL buffer_fsm_endFlag : STD_LOGIC;
SIGNAL clc_pulseMem : STD_LOGIC;
SIGNAL clk_pulse : STD_LOGIC;
SIGNAL ctrl_reg_buffer : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL en_pulseMem : STD_LOGIC;
SIGNAL end_pgr : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL fsm_end_flag : STD_LOGIC;
SIGNAL fsm_rdytoStart : STD_LOGIC;
SIGNAL rd_pulseMem : STD_LOGIC;
SIGNAL rst_n_pulse : STD_LOGIC;
SIGNAL start_pulse : STD_LOGIC;
SIGNAL wr_pulseMem : STD_LOGIC;
COMPONENT pulse_fsm
	PORT (
	AddressMempulse : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	buffer_fsm_endFlag : IN STD_LOGIC;
	clc_pulseMem : OUT STD_LOGIC;
	clk_pulse : IN STD_LOGIC;
	ctrl_reg_buffer : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	en_pulseMem : OUT STD_LOGIC;
	end_pgr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	fsm_end_flag : OUT STD_LOGIC;
	fsm_rdytoStart : OUT STD_LOGIC;
	rd_pulseMem : OUT STD_LOGIC;
	rst_n_pulse : IN STD_LOGIC;
	start_pulse : IN STD_LOGIC;
	wr_pulseMem : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : pulse_fsm
	PORT MAP (
-- list connections between master ports and signals
	AddressMempulse => AddressMempulse,
	buffer_fsm_endFlag => buffer_fsm_endFlag,
	clc_pulseMem => clc_pulseMem,
	clk_pulse => clk_pulse,
	ctrl_reg_buffer => ctrl_reg_buffer,
	en_pulseMem => en_pulseMem,
	end_pgr => end_pgr,
	fsm_end_flag => fsm_end_flag,
	fsm_rdytoStart => fsm_rdytoStart,
	rd_pulseMem => rd_pulseMem,
	rst_n_pulse => rst_n_pulse,
	start_pulse => start_pulse,
	wr_pulseMem => wr_pulseMem
	);

-- rst_n_pulse
t_prcs_rst_n_pulse: PROCESS
BEGIN
	rst_n_pulse <= '1';
	WAIT FOR 770000 ps;
	rst_n_pulse <= '0';
WAIT;
END PROCESS t_prcs_rst_n_pulse;

-- clk_pulse
t_prcs_clk_pulse: PROCESS
BEGIN
	clk_pulse <= '1';
	WAIT FOR 20000 ps;
	FOR i IN 1 TO 24
	LOOP
		clk_pulse <= '0';
		WAIT FOR 20000 ps;
		clk_pulse <= '1';
		WAIT FOR 20000 ps;
	END LOOP;
	clk_pulse <= '0';
WAIT;
END PROCESS t_prcs_clk_pulse;

-- start_pulse
t_prcs_start_pulse: PROCESS
BEGIN
	start_pulse <= '0';
	WAIT FOR 30000 ps;
	start_pulse <= '1';
	WAIT FOR 20000 ps;
	start_pulse <= '0';
WAIT;
END PROCESS t_prcs_start_pulse;

-- buffer_fsm_endFlag
t_prcs_buffer_fsm_endFlag: PROCESS
BEGIN
	buffer_fsm_endFlag <= '0';
	WAIT FOR 230000 ps;
	buffer_fsm_endFlag <= '1';
	WAIT FOR 20000 ps;
	buffer_fsm_endFlag <= '0';
	WAIT FOR 180000 ps;
	buffer_fsm_endFlag <= '1';
	WAIT FOR 20000 ps;
	buffer_fsm_endFlag <= '0';
WAIT;
END PROCESS t_prcs_buffer_fsm_endFlag;
-- end_pgr[31]
t_prcs_end_pgr_31: PROCESS
BEGIN
	end_pgr(31) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(31) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(31) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_31;
-- end_pgr[30]
t_prcs_end_pgr_30: PROCESS
BEGIN
	end_pgr(30) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(30) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(30) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_30;
-- end_pgr[29]
t_prcs_end_pgr_29: PROCESS
BEGIN
	end_pgr(29) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(29) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(29) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_29;
-- end_pgr[28]
t_prcs_end_pgr_28: PROCESS
BEGIN
	end_pgr(28) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(28) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(28) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_28;
-- end_pgr[27]
t_prcs_end_pgr_27: PROCESS
BEGIN
	end_pgr(27) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(27) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(27) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_27;
-- end_pgr[26]
t_prcs_end_pgr_26: PROCESS
BEGIN
	end_pgr(26) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(26) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(26) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_26;
-- end_pgr[25]
t_prcs_end_pgr_25: PROCESS
BEGIN
	end_pgr(25) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(25) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(25) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_25;
-- end_pgr[24]
t_prcs_end_pgr_24: PROCESS
BEGIN
	end_pgr(24) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(24) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(24) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_24;
-- end_pgr[23]
t_prcs_end_pgr_23: PROCESS
BEGIN
	end_pgr(23) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(23) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(23) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_23;
-- end_pgr[22]
t_prcs_end_pgr_22: PROCESS
BEGIN
	end_pgr(22) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(22) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(22) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_22;
-- end_pgr[21]
t_prcs_end_pgr_21: PROCESS
BEGIN
	end_pgr(21) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(21) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(21) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_21;
-- end_pgr[20]
t_prcs_end_pgr_20: PROCESS
BEGIN
	end_pgr(20) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(20) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(20) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_20;
-- end_pgr[19]
t_prcs_end_pgr_19: PROCESS
BEGIN
	end_pgr(19) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(19) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(19) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_19;
-- end_pgr[18]
t_prcs_end_pgr_18: PROCESS
BEGIN
	end_pgr(18) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(18) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(18) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_18;
-- end_pgr[17]
t_prcs_end_pgr_17: PROCESS
BEGIN
	end_pgr(17) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(17) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(17) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_17;
-- end_pgr[16]
t_prcs_end_pgr_16: PROCESS
BEGIN
	end_pgr(16) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(16) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(16) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_16;
-- end_pgr[15]
t_prcs_end_pgr_15: PROCESS
BEGIN
	end_pgr(15) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(15) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(15) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_15;
-- end_pgr[14]
t_prcs_end_pgr_14: PROCESS
BEGIN
	end_pgr(14) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(14) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(14) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_14;
-- end_pgr[13]
t_prcs_end_pgr_13: PROCESS
BEGIN
	end_pgr(13) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(13) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(13) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_13;
-- end_pgr[12]
t_prcs_end_pgr_12: PROCESS
BEGIN
	end_pgr(12) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(12) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(12) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_12;
-- end_pgr[11]
t_prcs_end_pgr_11: PROCESS
BEGIN
	end_pgr(11) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(11) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(11) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_11;
-- end_pgr[10]
t_prcs_end_pgr_10: PROCESS
BEGIN
	end_pgr(10) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(10) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(10) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_10;
-- end_pgr[9]
t_prcs_end_pgr_9: PROCESS
BEGIN
	end_pgr(9) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(9) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(9) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_9;
-- end_pgr[8]
t_prcs_end_pgr_8: PROCESS
BEGIN
	end_pgr(8) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(8) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(8) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_8;
-- end_pgr[7]
t_prcs_end_pgr_7: PROCESS
BEGIN
	end_pgr(7) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(7) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(7) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_7;
-- end_pgr[6]
t_prcs_end_pgr_6: PROCESS
BEGIN
	end_pgr(6) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(6) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(6) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_6;
-- end_pgr[5]
t_prcs_end_pgr_5: PROCESS
BEGIN
	end_pgr(5) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(5) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(5) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_5;
-- end_pgr[4]
t_prcs_end_pgr_4: PROCESS
BEGIN
	end_pgr(4) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(4) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(4) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_4;
-- end_pgr[3]
t_prcs_end_pgr_3: PROCESS
BEGIN
	end_pgr(3) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(3) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(3) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_3;
-- end_pgr[2]
t_prcs_end_pgr_2: PROCESS
BEGIN
	end_pgr(2) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(2) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(2) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_2;
-- end_pgr[1]
t_prcs_end_pgr_1: PROCESS
BEGIN
	end_pgr(1) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(1) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(1) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_1;
-- end_pgr[0]
t_prcs_end_pgr_0: PROCESS
BEGIN
	end_pgr(0) <= '0';
	WAIT FOR 550000 ps;
	end_pgr(0) <= '1';
	WAIT FOR 60000 ps;
	end_pgr(0) <= '0';
WAIT;
END PROCESS t_prcs_end_pgr_0;
END pulse_fsm_arch;
