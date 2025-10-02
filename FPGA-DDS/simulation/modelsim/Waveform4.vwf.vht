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
-- Generated on "06/09/2025 15:37:33"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          fsmChronoTest
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY fsmChronoTest_vhd_vec_tst IS
END fsmChronoTest_vhd_vec_tst;
ARCHITECTURE fsmChronoTest_arch OF fsmChronoTest_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL addressMem : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL addressMemoffset : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL chronoOverflowFlag : STD_LOGIC;
SIGNAL clc : STD_LOGIC;
SIGNAL clk_input : STD_LOGIC;
SIGNAL en : STD_LOGIC;
SIGNAL enChrono : STD_LOGIC;
SIGNAL fsm_chronoEnd : STD_LOGIC;
SIGNAL init_fsm : STD_LOGIC;
SIGNAL nRst : STD_LOGIC;
SIGNAL nRst_fsm : STD_LOGIC;
SIGNAL rd : STD_LOGIC;
SIGNAL s0 : STD_LOGIC;
SIGNAL s1 : STD_LOGIC;
SIGNAL s2 : STD_LOGIC;
SIGNAL s3 : STD_LOGIC;
SIGNAL s4 : STD_LOGIC;
SIGNAL s5 : STD_LOGIC;
SIGNAL set_precount : STD_LOGIC;
SIGNAL wr : STD_LOGIC;
COMPONENT fsmChronoTest
	PORT (
	addressMem : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	addressMemoffset : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	chronoOverflowFlag : IN STD_LOGIC;
	clc : OUT STD_LOGIC;
	clk_input : IN STD_LOGIC;
	en : OUT STD_LOGIC;
	enChrono : OUT STD_LOGIC;
	fsm_chronoEnd : OUT STD_LOGIC;
	init_fsm : IN STD_LOGIC;
	nRst : OUT STD_LOGIC;
	nRst_fsm : IN STD_LOGIC;
	rd : OUT STD_LOGIC;
	s0 : OUT STD_LOGIC;
	s1 : OUT STD_LOGIC;
	s2 : OUT STD_LOGIC;
	s3 : OUT STD_LOGIC;
	s4 : OUT STD_LOGIC;
	s5 : OUT STD_LOGIC;
	set_precount : OUT STD_LOGIC;
	wr : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : fsmChronoTest
	PORT MAP (
-- list connections between master ports and signals
	addressMem => addressMem,
	addressMemoffset => addressMemoffset,
	chronoOverflowFlag => chronoOverflowFlag,
	clc => clc,
	clk_input => clk_input,
	en => en,
	enChrono => enChrono,
	fsm_chronoEnd => fsm_chronoEnd,
	init_fsm => init_fsm,
	nRst => nRst,
	nRst_fsm => nRst_fsm,
	rd => rd,
	s0 => s0,
	s1 => s1,
	s2 => s2,
	s3 => s3,
	s4 => s4,
	s5 => s5,
	set_precount => set_precount,
	wr => wr
	);

-- clk_input
t_prcs_clk_input: PROCESS
BEGIN
LOOP
	clk_input <= '0';
	WAIT FOR 20000 ps;
	clk_input <= '1';
	WAIT FOR 20000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_clk_input;

-- init_fsm
t_prcs_init_fsm: PROCESS
BEGIN
	init_fsm <= '0';
	WAIT FOR 10000 ps;
	init_fsm <= '1';
	WAIT FOR 20000 ps;
	init_fsm <= '0';
WAIT;
END PROCESS t_prcs_init_fsm;
-- addressMemoffset[5]
t_prcs_addressMemoffset_5: PROCESS
BEGIN
	addressMemoffset(5) <= '0';
WAIT;
END PROCESS t_prcs_addressMemoffset_5;
-- addressMemoffset[4]
t_prcs_addressMemoffset_4: PROCESS
BEGIN
	addressMemoffset(4) <= '0';
WAIT;
END PROCESS t_prcs_addressMemoffset_4;
-- addressMemoffset[3]
t_prcs_addressMemoffset_3: PROCESS
BEGIN
	addressMemoffset(3) <= '0';
WAIT;
END PROCESS t_prcs_addressMemoffset_3;
-- addressMemoffset[2]
t_prcs_addressMemoffset_2: PROCESS
BEGIN
	addressMemoffset(2) <= '0';
WAIT;
END PROCESS t_prcs_addressMemoffset_2;
-- addressMemoffset[1]
t_prcs_addressMemoffset_1: PROCESS
BEGIN
	addressMemoffset(1) <= '0';
WAIT;
END PROCESS t_prcs_addressMemoffset_1;
-- addressMemoffset[0]
t_prcs_addressMemoffset_0: PROCESS
BEGIN
	addressMemoffset(0) <= '1';
WAIT;
END PROCESS t_prcs_addressMemoffset_0;

-- chronoOverflowFlag
t_prcs_chronoOverflowFlag: PROCESS
BEGIN
	chronoOverflowFlag <= '0';
WAIT;
END PROCESS t_prcs_chronoOverflowFlag;

-- nRst_fsm
t_prcs_nRst_fsm: PROCESS
BEGIN
	nRst_fsm <= '1';
WAIT;
END PROCESS t_prcs_nRst_fsm;
END fsmChronoTest_arch;
