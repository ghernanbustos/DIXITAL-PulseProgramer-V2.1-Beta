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
-- Generated on "07/18/2025 14:29:17"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          fsm_chorno_sim
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY fsm_chorno_sim_vhd_vec_tst IS
END fsm_chorno_sim_vhd_vec_tst;
ARCHITECTURE fsm_chorno_sim_arch OF fsm_chorno_sim_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL AddressOffsetfsm : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL chronoprecaountVal : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL clk : STD_LOGIC;
SIGNAL en_chr : STD_LOGIC;
SIGNAL frsm_rst : STD_LOGIC;
SIGNAL fsm_endFlag : STD_LOGIC;
SIGNAL fsm_start : STD_LOGIC;
SIGNAL mem_clc : STD_LOGIC;
SIGNAL mem_en : STD_LOGIC;
SIGNAL mem_rd : STD_LOGIC;
SIGNAL mem_wr : STD_LOGIC;
SIGNAL memAddress : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL OutWindow : STD_LOGIC;
SIGNAL rst_chrono : STD_LOGIC;
SIGNAL s0 : STD_LOGIC;
SIGNAL s1 : STD_LOGIC;
SIGNAL s1_bis : STD_LOGIC;
SIGNAL s2 : STD_LOGIC;
SIGNAL s3 : STD_LOGIC;
SIGNAL s_extra : STD_LOGIC;
SIGNAL s_init : STD_LOGIC;
SIGNAL setPrecountChrono : STD_LOGIC;
COMPONENT fsm_chorno_sim
	PORT (
	AddressOffsetfsm : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	chronoprecaountVal : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	clk : IN STD_LOGIC;
	en_chr : OUT STD_LOGIC;
	frsm_rst : IN STD_LOGIC;
	fsm_endFlag : OUT STD_LOGIC;
	fsm_start : IN STD_LOGIC;
	mem_clc : OUT STD_LOGIC;
	mem_en : OUT STD_LOGIC;
	mem_rd : OUT STD_LOGIC;
	mem_wr : OUT STD_LOGIC;
	memAddress : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	OutWindow : OUT STD_LOGIC;
	rst_chrono : OUT STD_LOGIC;
	s0 : OUT STD_LOGIC;
	s1 : OUT STD_LOGIC;
	s1_bis : OUT STD_LOGIC;
	s2 : OUT STD_LOGIC;
	s3 : OUT STD_LOGIC;
	s_extra : OUT STD_LOGIC;
	s_init : OUT STD_LOGIC;
	setPrecountChrono : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : fsm_chorno_sim
	PORT MAP (
-- list connections between master ports and signals
	AddressOffsetfsm => AddressOffsetfsm,
	chronoprecaountVal => chronoprecaountVal,
	clk => clk,
	en_chr => en_chr,
	frsm_rst => frsm_rst,
	fsm_endFlag => fsm_endFlag,
	fsm_start => fsm_start,
	mem_clc => mem_clc,
	mem_en => mem_en,
	mem_rd => mem_rd,
	mem_wr => mem_wr,
	memAddress => memAddress,
	OutWindow => OutWindow,
	rst_chrono => rst_chrono,
	s0 => s0,
	s1 => s1,
	s1_bis => s1_bis,
	s2 => s2,
	s3 => s3,
	s_extra => s_extra,
	s_init => s_init,
	setPrecountChrono => setPrecountChrono
	);

-- clk
t_prcs_clk: PROCESS
BEGIN
LOOP
	clk <= '0';
	WAIT FOR 20000 ps;
	clk <= '1';
	WAIT FOR 20000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_clk;

-- frsm_rst
t_prcs_frsm_rst: PROCESS
BEGIN
	frsm_rst <= '0';
	WAIT FOR 110000 ps;
	frsm_rst <= '1';
WAIT;
END PROCESS t_prcs_frsm_rst;

-- fsm_start
t_prcs_fsm_start: PROCESS
BEGIN
	fsm_start <= '0';
	WAIT FOR 170000 ps;
	fsm_start <= '1';
	WAIT FOR 20000 ps;
	fsm_start <= '0';
WAIT;
END PROCESS t_prcs_fsm_start;
-- chronoprecaountVal[31]
t_prcs_chronoprecaountVal_31: PROCESS
BEGIN
	chronoprecaountVal(31) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_31;
-- chronoprecaountVal[30]
t_prcs_chronoprecaountVal_30: PROCESS
BEGIN
	chronoprecaountVal(30) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_30;
-- chronoprecaountVal[29]
t_prcs_chronoprecaountVal_29: PROCESS
BEGIN
	chronoprecaountVal(29) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_29;
-- chronoprecaountVal[28]
t_prcs_chronoprecaountVal_28: PROCESS
BEGIN
	chronoprecaountVal(28) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_28;
-- chronoprecaountVal[27]
t_prcs_chronoprecaountVal_27: PROCESS
BEGIN
	chronoprecaountVal(27) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_27;
-- chronoprecaountVal[26]
t_prcs_chronoprecaountVal_26: PROCESS
BEGIN
	chronoprecaountVal(26) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_26;
-- chronoprecaountVal[25]
t_prcs_chronoprecaountVal_25: PROCESS
BEGIN
	chronoprecaountVal(25) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_25;
-- chronoprecaountVal[24]
t_prcs_chronoprecaountVal_24: PROCESS
BEGIN
	chronoprecaountVal(24) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_24;
-- chronoprecaountVal[23]
t_prcs_chronoprecaountVal_23: PROCESS
BEGIN
	chronoprecaountVal(23) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_23;
-- chronoprecaountVal[22]
t_prcs_chronoprecaountVal_22: PROCESS
BEGIN
	chronoprecaountVal(22) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_22;
-- chronoprecaountVal[21]
t_prcs_chronoprecaountVal_21: PROCESS
BEGIN
	chronoprecaountVal(21) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_21;
-- chronoprecaountVal[20]
t_prcs_chronoprecaountVal_20: PROCESS
BEGIN
	chronoprecaountVal(20) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_20;
-- chronoprecaountVal[19]
t_prcs_chronoprecaountVal_19: PROCESS
BEGIN
	chronoprecaountVal(19) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_19;
-- chronoprecaountVal[18]
t_prcs_chronoprecaountVal_18: PROCESS
BEGIN
	chronoprecaountVal(18) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_18;
-- chronoprecaountVal[17]
t_prcs_chronoprecaountVal_17: PROCESS
BEGIN
	chronoprecaountVal(17) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_17;
-- chronoprecaountVal[16]
t_prcs_chronoprecaountVal_16: PROCESS
BEGIN
	chronoprecaountVal(16) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_16;
-- chronoprecaountVal[15]
t_prcs_chronoprecaountVal_15: PROCESS
BEGIN
	chronoprecaountVal(15) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_15;
-- chronoprecaountVal[14]
t_prcs_chronoprecaountVal_14: PROCESS
BEGIN
	chronoprecaountVal(14) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_14;
-- chronoprecaountVal[13]
t_prcs_chronoprecaountVal_13: PROCESS
BEGIN
	chronoprecaountVal(13) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_13;
-- chronoprecaountVal[12]
t_prcs_chronoprecaountVal_12: PROCESS
BEGIN
	chronoprecaountVal(12) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_12;
-- chronoprecaountVal[11]
t_prcs_chronoprecaountVal_11: PROCESS
BEGIN
	chronoprecaountVal(11) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_11;
-- chronoprecaountVal[10]
t_prcs_chronoprecaountVal_10: PROCESS
BEGIN
	chronoprecaountVal(10) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_10;
-- chronoprecaountVal[9]
t_prcs_chronoprecaountVal_9: PROCESS
BEGIN
	chronoprecaountVal(9) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_9;
-- chronoprecaountVal[8]
t_prcs_chronoprecaountVal_8: PROCESS
BEGIN
	chronoprecaountVal(8) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_8;
-- chronoprecaountVal[7]
t_prcs_chronoprecaountVal_7: PROCESS
BEGIN
	chronoprecaountVal(7) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_7;
-- chronoprecaountVal[6]
t_prcs_chronoprecaountVal_6: PROCESS
BEGIN
	chronoprecaountVal(6) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_6;
-- chronoprecaountVal[5]
t_prcs_chronoprecaountVal_5: PROCESS
BEGIN
	chronoprecaountVal(5) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_5;
-- chronoprecaountVal[4]
t_prcs_chronoprecaountVal_4: PROCESS
BEGIN
	chronoprecaountVal(4) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_4;
-- chronoprecaountVal[3]
t_prcs_chronoprecaountVal_3: PROCESS
BEGIN
	chronoprecaountVal(3) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_3;
-- chronoprecaountVal[2]
t_prcs_chronoprecaountVal_2: PROCESS
BEGIN
	chronoprecaountVal(2) <= '0';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_2;
-- chronoprecaountVal[1]
t_prcs_chronoprecaountVal_1: PROCESS
BEGIN
	chronoprecaountVal(1) <= '1';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_1;
-- chronoprecaountVal[0]
t_prcs_chronoprecaountVal_0: PROCESS
BEGIN
	chronoprecaountVal(0) <= '0';
WAIT;
END PROCESS t_prcs_chronoprecaountVal_0;
-- AddressOffsetfsm[5]
t_prcs_AddressOffsetfsm_5: PROCESS
BEGIN
	AddressOffsetfsm(5) <= '0';
WAIT;
END PROCESS t_prcs_AddressOffsetfsm_5;
-- AddressOffsetfsm[4]
t_prcs_AddressOffsetfsm_4: PROCESS
BEGIN
	AddressOffsetfsm(4) <= '0';
WAIT;
END PROCESS t_prcs_AddressOffsetfsm_4;
-- AddressOffsetfsm[3]
t_prcs_AddressOffsetfsm_3: PROCESS
BEGIN
	AddressOffsetfsm(3) <= '0';
WAIT;
END PROCESS t_prcs_AddressOffsetfsm_3;
-- AddressOffsetfsm[2]
t_prcs_AddressOffsetfsm_2: PROCESS
BEGIN
	AddressOffsetfsm(2) <= '0';
WAIT;
END PROCESS t_prcs_AddressOffsetfsm_2;
-- AddressOffsetfsm[1]
t_prcs_AddressOffsetfsm_1: PROCESS
BEGIN
	AddressOffsetfsm(1) <= '1';
WAIT;
END PROCESS t_prcs_AddressOffsetfsm_1;
-- AddressOffsetfsm[0]
t_prcs_AddressOffsetfsm_0: PROCESS
BEGIN
	AddressOffsetfsm(0) <= '0';
WAIT;
END PROCESS t_prcs_AddressOffsetfsm_0;
END fsm_chorno_sim_arch;
