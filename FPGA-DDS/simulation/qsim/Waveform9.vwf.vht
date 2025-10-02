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
-- Generated on "07/22/2025 12:53:34"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          testChronoVers
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY testChronoVers_vhd_vec_tst IS
END testChronoVers_vhd_vec_tst;
ARCHITECTURE testChronoVers_arch OF testChronoVers_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL en : STD_LOGIC;
SIGNAL flagOut : STD_LOGIC;
SIGNAL nRst : STD_LOGIC;
SIGNAL precount : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL setPre : STD_LOGIC;
SIGNAL WindowOutput : STD_LOGIC;
COMPONENT testChronoVers
	PORT (
	clk : IN STD_LOGIC;
	en : IN STD_LOGIC;
	flagOut : OUT STD_LOGIC;
	nRst : IN STD_LOGIC;
	precount : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	setPre : IN STD_LOGIC;
	WindowOutput : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : testChronoVers
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	en => en,
	flagOut => flagOut,
	nRst => nRst,
	precount => precount,
	setPre => setPre,
	WindowOutput => WindowOutput
	);

-- clk
t_prcs_clk: PROCESS
BEGIN
LOOP
	clk <= '0';
	WAIT FOR 10000 ps;
	clk <= '1';
	WAIT FOR 10000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_clk;

-- nRst
t_prcs_nRst: PROCESS
BEGIN
	nRst <= '0';
	WAIT FOR 70000 ps;
	nRst <= '1';
	WAIT FOR 540000 ps;
	nRst <= '0';
	WAIT FOR 30000 ps;
	nRst <= '1';
WAIT;
END PROCESS t_prcs_nRst;

-- setPre
t_prcs_setPre: PROCESS
BEGIN
	setPre <= '0';
	WAIT FOR 90000 ps;
	setPre <= '1';
	WAIT FOR 20000 ps;
	setPre <= '0';
	WAIT FOR 170000 ps;
	setPre <= '1';
	WAIT FOR 20000 ps;
	setPre <= '0';
	WAIT FOR 360000 ps;
	setPre <= '1';
	WAIT FOR 20000 ps;
	setPre <= '0';
WAIT;
END PROCESS t_prcs_setPre;

-- en
t_prcs_en: PROCESS
BEGIN
	en <= '0';
	WAIT FOR 110000 ps;
	en <= '1';
	WAIT FOR 500000 ps;
	en <= '0';
	WAIT FOR 190000 ps;
	en <= '1';
	WAIT FOR 50000 ps;
	en <= '0';
WAIT;
END PROCESS t_prcs_en;
-- precount[31]
t_prcs_precount_31: PROCESS
BEGIN
	precount(31) <= '1';
WAIT;
END PROCESS t_prcs_precount_31;
-- precount[30]
t_prcs_precount_30: PROCESS
BEGIN
	precount(30) <= '1';
WAIT;
END PROCESS t_prcs_precount_30;
-- precount[29]
t_prcs_precount_29: PROCESS
BEGIN
	precount(29) <= '1';
WAIT;
END PROCESS t_prcs_precount_29;
-- precount[28]
t_prcs_precount_28: PROCESS
BEGIN
	precount(28) <= '1';
WAIT;
END PROCESS t_prcs_precount_28;
-- precount[27]
t_prcs_precount_27: PROCESS
BEGIN
	precount(27) <= '1';
WAIT;
END PROCESS t_prcs_precount_27;
-- precount[26]
t_prcs_precount_26: PROCESS
BEGIN
	precount(26) <= '1';
WAIT;
END PROCESS t_prcs_precount_26;
-- precount[25]
t_prcs_precount_25: PROCESS
BEGIN
	precount(25) <= '1';
WAIT;
END PROCESS t_prcs_precount_25;
-- precount[24]
t_prcs_precount_24: PROCESS
BEGIN
	precount(24) <= '1';
WAIT;
END PROCESS t_prcs_precount_24;
-- precount[23]
t_prcs_precount_23: PROCESS
BEGIN
	precount(23) <= '1';
WAIT;
END PROCESS t_prcs_precount_23;
-- precount[22]
t_prcs_precount_22: PROCESS
BEGIN
	precount(22) <= '1';
WAIT;
END PROCESS t_prcs_precount_22;
-- precount[21]
t_prcs_precount_21: PROCESS
BEGIN
	precount(21) <= '1';
WAIT;
END PROCESS t_prcs_precount_21;
-- precount[20]
t_prcs_precount_20: PROCESS
BEGIN
	precount(20) <= '1';
WAIT;
END PROCESS t_prcs_precount_20;
-- precount[19]
t_prcs_precount_19: PROCESS
BEGIN
	precount(19) <= '1';
WAIT;
END PROCESS t_prcs_precount_19;
-- precount[18]
t_prcs_precount_18: PROCESS
BEGIN
	precount(18) <= '1';
WAIT;
END PROCESS t_prcs_precount_18;
-- precount[17]
t_prcs_precount_17: PROCESS
BEGIN
	precount(17) <= '1';
WAIT;
END PROCESS t_prcs_precount_17;
-- precount[16]
t_prcs_precount_16: PROCESS
BEGIN
	precount(16) <= '1';
WAIT;
END PROCESS t_prcs_precount_16;
-- precount[15]
t_prcs_precount_15: PROCESS
BEGIN
	precount(15) <= '1';
WAIT;
END PROCESS t_prcs_precount_15;
-- precount[14]
t_prcs_precount_14: PROCESS
BEGIN
	precount(14) <= '1';
WAIT;
END PROCESS t_prcs_precount_14;
-- precount[13]
t_prcs_precount_13: PROCESS
BEGIN
	precount(13) <= '1';
WAIT;
END PROCESS t_prcs_precount_13;
-- precount[12]
t_prcs_precount_12: PROCESS
BEGIN
	precount(12) <= '1';
WAIT;
END PROCESS t_prcs_precount_12;
-- precount[11]
t_prcs_precount_11: PROCESS
BEGIN
	precount(11) <= '1';
WAIT;
END PROCESS t_prcs_precount_11;
-- precount[10]
t_prcs_precount_10: PROCESS
BEGIN
	precount(10) <= '1';
WAIT;
END PROCESS t_prcs_precount_10;
-- precount[9]
t_prcs_precount_9: PROCESS
BEGIN
	precount(9) <= '1';
WAIT;
END PROCESS t_prcs_precount_9;
-- precount[8]
t_prcs_precount_8: PROCESS
BEGIN
	precount(8) <= '1';
WAIT;
END PROCESS t_prcs_precount_8;
-- precount[7]
t_prcs_precount_7: PROCESS
BEGIN
	precount(7) <= '1';
WAIT;
END PROCESS t_prcs_precount_7;
-- precount[6]
t_prcs_precount_6: PROCESS
BEGIN
	precount(6) <= '1';
WAIT;
END PROCESS t_prcs_precount_6;
-- precount[5]
t_prcs_precount_5: PROCESS
BEGIN
	precount(5) <= '1';
WAIT;
END PROCESS t_prcs_precount_5;
-- precount[4]
t_prcs_precount_4: PROCESS
BEGIN
	precount(4) <= '1';
WAIT;
END PROCESS t_prcs_precount_4;
-- precount[3]
t_prcs_precount_3: PROCESS
BEGIN
	precount(3) <= '1';
	WAIT FOR 80000 ps;
	precount(3) <= '0';
	WAIT FOR 170000 ps;
	precount(3) <= '1';
	WAIT FOR 390000 ps;
	precount(3) <= '0';
	WAIT FOR 80000 ps;
	precount(3) <= '1';
WAIT;
END PROCESS t_prcs_precount_3;
-- precount[2]
t_prcs_precount_2: PROCESS
BEGIN
	precount(2) <= '0';
	WAIT FOR 80000 ps;
	precount(2) <= '1';
	WAIT FOR 170000 ps;
	precount(2) <= '0';
	WAIT FOR 10000 ps;
	precount(2) <= '1';
	WAIT FOR 100000 ps;
	precount(2) <= '0';
	WAIT FOR 280000 ps;
	precount(2) <= '1';
	WAIT FOR 80000 ps;
	precount(2) <= '0';
WAIT;
END PROCESS t_prcs_precount_2;
-- precount[1]
t_prcs_precount_1: PROCESS
BEGIN
	precount(1) <= '1';
	WAIT FOR 80000 ps;
	precount(1) <= '0';
	WAIT FOR 170000 ps;
	precount(1) <= '1';
	WAIT FOR 10000 ps;
	precount(1) <= '0';
	WAIT FOR 100000 ps;
	precount(1) <= '1';
WAIT;
END PROCESS t_prcs_precount_1;
-- precount[0]
t_prcs_precount_0: PROCESS
BEGIN
	precount(0) <= '0';
	WAIT FOR 80000 ps;
	precount(0) <= '1';
	WAIT FOR 170000 ps;
	precount(0) <= '0';
	WAIT FOR 10000 ps;
	precount(0) <= '1';
	WAIT FOR 100000 ps;
	precount(0) <= '0';
	WAIT FOR 280000 ps;
	precount(0) <= '1';
	WAIT FOR 80000 ps;
	precount(0) <= '0';
WAIT;
END PROCESS t_prcs_precount_0;
END testChronoVers_arch;
