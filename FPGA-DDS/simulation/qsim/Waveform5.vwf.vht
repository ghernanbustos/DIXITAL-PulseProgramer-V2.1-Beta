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
-- Generated on "07/15/2025 17:21:30"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          ramTest
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY ramTest_vhd_vec_tst IS
END ramTest_vhd_vec_tst;
ARCHITECTURE ramTest_arch OF ramTest_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL aclear : STD_LOGIC;
SIGNAL address : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL clk : STD_LOGIC;
SIGNAL clk_en : STD_LOGIC;
SIGNAL datainput : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL q_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL rd : STD_LOGIC;
SIGNAL wr : STD_LOGIC;
COMPONENT ramTest
	PORT (
	aclear : IN STD_LOGIC;
	address : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	clk : IN STD_LOGIC;
	clk_en : IN STD_LOGIC;
	datainput : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	q_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	rd : IN STD_LOGIC;
	wr : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : ramTest
	PORT MAP (
-- list connections between master ports and signals
	aclear => aclear,
	address => address,
	clk => clk,
	clk_en => clk_en,
	datainput => datainput,
	q_out => q_out,
	rd => rd,
	wr => wr
	);

-- clk_en
t_prcs_clk_en: PROCESS
BEGIN
	clk_en <= '0';
	WAIT FOR 150000 ps;
	clk_en <= '1';
	WAIT FOR 250000 ps;
	clk_en <= '0';
	WAIT FOR 100000 ps;
	clk_en <= '1';
	WAIT FOR 180000 ps;
	clk_en <= '0';
	WAIT FOR 50000 ps;
	clk_en <= '1';
WAIT;
END PROCESS t_prcs_clk_en;

-- aclear
t_prcs_aclear: PROCESS
BEGIN
	aclear <= '0';
	WAIT FOR 210000 ps;
	aclear <= '1';
	WAIT FOR 40000 ps;
	aclear <= '0';
	WAIT FOR 370000 ps;
	aclear <= '1';
	WAIT FOR 30000 ps;
	aclear <= '0';
WAIT;
END PROCESS t_prcs_aclear;

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
-- address[5]
t_prcs_address_5: PROCESS
BEGIN
	address(5) <= '0';
WAIT;
END PROCESS t_prcs_address_5;
-- address[4]
t_prcs_address_4: PROCESS
BEGIN
	address(4) <= '0';
WAIT;
END PROCESS t_prcs_address_4;
-- address[3]
t_prcs_address_3: PROCESS
BEGIN
	address(3) <= '0';
WAIT;
END PROCESS t_prcs_address_3;
-- address[2]
t_prcs_address_2: PROCESS
BEGIN
	address(2) <= '0';
WAIT;
END PROCESS t_prcs_address_2;
-- address[1]
t_prcs_address_1: PROCESS
BEGIN
	address(1) <= '0';
	WAIT FOR 380000 ps;
	address(1) <= '1';
	WAIT FOR 220000 ps;
	address(1) <= '0';
WAIT;
END PROCESS t_prcs_address_1;
-- address[0]
t_prcs_address_0: PROCESS
BEGIN
	address(0) <= '0';
	WAIT FOR 270000 ps;
	address(0) <= '1';
	WAIT FOR 60000 ps;
	address(0) <= '0';
WAIT;
END PROCESS t_prcs_address_0;
-- datainput[31]
t_prcs_datainput_31: PROCESS
BEGIN
	datainput(31) <= '0';
WAIT;
END PROCESS t_prcs_datainput_31;
-- datainput[30]
t_prcs_datainput_30: PROCESS
BEGIN
	datainput(30) <= '0';
WAIT;
END PROCESS t_prcs_datainput_30;
-- datainput[29]
t_prcs_datainput_29: PROCESS
BEGIN
	datainput(29) <= '0';
WAIT;
END PROCESS t_prcs_datainput_29;
-- datainput[28]
t_prcs_datainput_28: PROCESS
BEGIN
	datainput(28) <= '0';
WAIT;
END PROCESS t_prcs_datainput_28;
-- datainput[27]
t_prcs_datainput_27: PROCESS
BEGIN
	datainput(27) <= '0';
WAIT;
END PROCESS t_prcs_datainput_27;
-- datainput[26]
t_prcs_datainput_26: PROCESS
BEGIN
	datainput(26) <= '0';
WAIT;
END PROCESS t_prcs_datainput_26;
-- datainput[25]
t_prcs_datainput_25: PROCESS
BEGIN
	datainput(25) <= '0';
WAIT;
END PROCESS t_prcs_datainput_25;
-- datainput[24]
t_prcs_datainput_24: PROCESS
BEGIN
	datainput(24) <= '0';
WAIT;
END PROCESS t_prcs_datainput_24;
-- datainput[23]
t_prcs_datainput_23: PROCESS
BEGIN
	datainput(23) <= '0';
WAIT;
END PROCESS t_prcs_datainput_23;
-- datainput[22]
t_prcs_datainput_22: PROCESS
BEGIN
	datainput(22) <= '0';
WAIT;
END PROCESS t_prcs_datainput_22;
-- datainput[21]
t_prcs_datainput_21: PROCESS
BEGIN
	datainput(21) <= '0';
WAIT;
END PROCESS t_prcs_datainput_21;
-- datainput[20]
t_prcs_datainput_20: PROCESS
BEGIN
	datainput(20) <= '0';
WAIT;
END PROCESS t_prcs_datainput_20;
-- datainput[19]
t_prcs_datainput_19: PROCESS
BEGIN
	datainput(19) <= '0';
WAIT;
END PROCESS t_prcs_datainput_19;
-- datainput[18]
t_prcs_datainput_18: PROCESS
BEGIN
	datainput(18) <= '0';
WAIT;
END PROCESS t_prcs_datainput_18;
-- datainput[17]
t_prcs_datainput_17: PROCESS
BEGIN
	datainput(17) <= '0';
WAIT;
END PROCESS t_prcs_datainput_17;
-- datainput[16]
t_prcs_datainput_16: PROCESS
BEGIN
	datainput(16) <= '0';
WAIT;
END PROCESS t_prcs_datainput_16;
-- datainput[15]
t_prcs_datainput_15: PROCESS
BEGIN
	datainput(15) <= '0';
WAIT;
END PROCESS t_prcs_datainput_15;
-- datainput[14]
t_prcs_datainput_14: PROCESS
BEGIN
	datainput(14) <= '0';
WAIT;
END PROCESS t_prcs_datainput_14;
-- datainput[13]
t_prcs_datainput_13: PROCESS
BEGIN
	datainput(13) <= '0';
WAIT;
END PROCESS t_prcs_datainput_13;
-- datainput[12]
t_prcs_datainput_12: PROCESS
BEGIN
	datainput(12) <= '0';
WAIT;
END PROCESS t_prcs_datainput_12;
-- datainput[11]
t_prcs_datainput_11: PROCESS
BEGIN
	datainput(11) <= '0';
WAIT;
END PROCESS t_prcs_datainput_11;
-- datainput[10]
t_prcs_datainput_10: PROCESS
BEGIN
	datainput(10) <= '0';
WAIT;
END PROCESS t_prcs_datainput_10;
-- datainput[9]
t_prcs_datainput_9: PROCESS
BEGIN
	datainput(9) <= '0';
WAIT;
END PROCESS t_prcs_datainput_9;
-- datainput[8]
t_prcs_datainput_8: PROCESS
BEGIN
	datainput(8) <= '0';
WAIT;
END PROCESS t_prcs_datainput_8;
-- datainput[7]
t_prcs_datainput_7: PROCESS
BEGIN
	datainput(7) <= '0';
	WAIT FOR 140000 ps;
	datainput(7) <= '1';
	WAIT FOR 190000 ps;
	datainput(7) <= '0';
WAIT;
END PROCESS t_prcs_datainput_7;
-- datainput[6]
t_prcs_datainput_6: PROCESS
BEGIN
	datainput(6) <= '0';
	WAIT FOR 140000 ps;
	datainput(6) <= '1';
	WAIT FOR 190000 ps;
	datainput(6) <= '0';
WAIT;
END PROCESS t_prcs_datainput_6;
-- datainput[5]
t_prcs_datainput_5: PROCESS
BEGIN
	datainput(5) <= '0';
	WAIT FOR 140000 ps;
	datainput(5) <= '1';
	WAIT FOR 190000 ps;
	datainput(5) <= '0';
WAIT;
END PROCESS t_prcs_datainput_5;
-- datainput[4]
t_prcs_datainput_4: PROCESS
BEGIN
	datainput(4) <= '0';
	WAIT FOR 140000 ps;
	datainput(4) <= '1';
	WAIT FOR 190000 ps;
	datainput(4) <= '0';
WAIT;
END PROCESS t_prcs_datainput_4;
-- datainput[3]
t_prcs_datainput_3: PROCESS
BEGIN
	datainput(3) <= '0';
WAIT;
END PROCESS t_prcs_datainput_3;
-- datainput[2]
t_prcs_datainput_2: PROCESS
BEGIN
	datainput(2) <= '0';
WAIT;
END PROCESS t_prcs_datainput_2;
-- datainput[1]
t_prcs_datainput_1: PROCESS
BEGIN
	datainput(1) <= '0';
	WAIT FOR 280000 ps;
	datainput(1) <= '1';
	WAIT FOR 50000 ps;
	datainput(1) <= '0';
WAIT;
END PROCESS t_prcs_datainput_1;
-- datainput[0]
t_prcs_datainput_0: PROCESS
BEGIN
	datainput(0) <= '0';
	WAIT FOR 140000 ps;
	datainput(0) <= '1';
	WAIT FOR 140000 ps;
	datainput(0) <= '0';
WAIT;
END PROCESS t_prcs_datainput_0;

-- rd
t_prcs_rd: PROCESS
BEGIN
	rd <= '1';
	WAIT FOR 400000 ps;
	rd <= '0';
	WAIT FOR 100000 ps;
	rd <= '1';
WAIT;
END PROCESS t_prcs_rd;

-- wr
t_prcs_wr: PROCESS
BEGIN
	wr <= '0';
	WAIT FOR 120000 ps;
	wr <= '1';
	WAIT FOR 70000 ps;
	wr <= '0';
WAIT;
END PROCESS t_prcs_wr;
END ramTest_arch;
