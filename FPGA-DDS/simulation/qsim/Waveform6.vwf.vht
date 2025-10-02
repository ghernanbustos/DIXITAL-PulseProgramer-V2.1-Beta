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
-- Generated on "07/16/2025 14:33:19"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          fsmchorno
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY fsmchorno_vhd_vec_tst IS
END fsmchorno_vhd_vec_tst;
ARCHITECTURE fsmchorno_arch OF fsmchorno_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL addresspreload : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL chronoOverflow : STD_LOGIC;
SIGNAL clcchr : STD_LOGIC;
SIGNAL clkFsm : STD_LOGIC;
SIGNAL enchr : STD_LOGIC;
SIGNAL enchrono : STD_LOGIC;
SIGNAL fsm_flagend : STD_LOGIC;
SIGNAL initFsm : STD_LOGIC;
SIGNAL ramMem : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL rdchr : STD_LOGIC;
SIGNAL rst_nFsm : STD_LOGIC;
SIGNAL rstchrono : STD_LOGIC;
SIGNAL setchronoprecount : STD_LOGIC;
SIGNAL wrchr : STD_LOGIC;
COMPONENT fsmchorno
	PORT (
	addresspreload : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	chronoOverflow : IN STD_LOGIC;
	clcchr : OUT STD_LOGIC;
	clkFsm : IN STD_LOGIC;
	enchr : OUT STD_LOGIC;
	enchrono : OUT STD_LOGIC;
	fsm_flagend : OUT STD_LOGIC;
	initFsm : IN STD_LOGIC;
	ramMem : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	rdchr : OUT STD_LOGIC;
	rst_nFsm : IN STD_LOGIC;
	rstchrono : OUT STD_LOGIC;
	setchronoprecount : OUT STD_LOGIC;
	wrchr : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : fsmchorno
	PORT MAP (
-- list connections between master ports and signals
	addresspreload => addresspreload,
	chronoOverflow => chronoOverflow,
	clcchr => clcchr,
	clkFsm => clkFsm,
	enchr => enchr,
	enchrono => enchrono,
	fsm_flagend => fsm_flagend,
	initFsm => initFsm,
	ramMem => ramMem,
	rdchr => rdchr,
	rst_nFsm => rst_nFsm,
	rstchrono => rstchrono,
	setchronoprecount => setchronoprecount,
	wrchr => wrchr
	);

-- clkFsm
t_prcs_clkFsm: PROCESS
BEGIN
LOOP
	clkFsm <= '0';
	WAIT FOR 20000 ps;
	clkFsm <= '1';
	WAIT FOR 20000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_clkFsm;

-- rst_nFsm
t_prcs_rst_nFsm: PROCESS
BEGIN
	rst_nFsm <= '0';
	WAIT FOR 60000 ps;
	rst_nFsm <= '1';
WAIT;
END PROCESS t_prcs_rst_nFsm;

-- initFsm
t_prcs_initFsm: PROCESS
BEGIN
	initFsm <= '0';
	WAIT FOR 90000 ps;
	initFsm <= '1';
	WAIT FOR 20000 ps;
	initFsm <= '0';
WAIT;
END PROCESS t_prcs_initFsm;
-- addresspreload[5]
t_prcs_addresspreload_5: PROCESS
BEGIN
	addresspreload(5) <= '0';
WAIT;
END PROCESS t_prcs_addresspreload_5;
-- addresspreload[4]
t_prcs_addresspreload_4: PROCESS
BEGIN
	addresspreload(4) <= '0';
WAIT;
END PROCESS t_prcs_addresspreload_4;
-- addresspreload[3]
t_prcs_addresspreload_3: PROCESS
BEGIN
	addresspreload(3) <= '0';
WAIT;
END PROCESS t_prcs_addresspreload_3;
-- addresspreload[2]
t_prcs_addresspreload_2: PROCESS
BEGIN
	addresspreload(2) <= '0';
WAIT;
END PROCESS t_prcs_addresspreload_2;
-- addresspreload[1]
t_prcs_addresspreload_1: PROCESS
BEGIN
	addresspreload(1) <= '0';
WAIT;
END PROCESS t_prcs_addresspreload_1;
-- addresspreload[0]
t_prcs_addresspreload_0: PROCESS
BEGIN
	addresspreload(0) <= '0';
	WAIT FOR 70000 ps;
	addresspreload(0) <= '1';
	WAIT FOR 310000 ps;
	addresspreload(0) <= '0';
WAIT;
END PROCESS t_prcs_addresspreload_0;

-- chronoOverflow
t_prcs_chronoOverflow: PROCESS
BEGIN
	chronoOverflow <= '0';
	WAIT FOR 570000 ps;
	chronoOverflow <= '1';
	WAIT FOR 20000 ps;
	chronoOverflow <= '0';
WAIT;
END PROCESS t_prcs_chronoOverflow;
END fsmchorno_arch;
