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
-- Generated on "07/29/2025 14:59:21"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          pgrFSM
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY pgrFSM_vhd_vec_tst IS
END pgrFSM_vhd_vec_tst;
ARCHITECTURE pgrFSM_arch OF pgrFSM_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL addressMemBuffer : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL bufferEndFlag : STD_LOGIC;
SIGNAL clc_buffer : STD_LOGIC;
SIGNAL clk : STD_LOGIC;
SIGNAL ctrlBuffer : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL en_buffer : STD_LOGIC;
SIGNAL endProgram : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL flag1 : STD_LOGIC;
SIGNAL flagEND : STD_LOGIC;
SIGNAL rd_buffer : STD_LOGIC;
SIGNAL rst_n : STD_LOGIC;
SIGNAL start : STD_LOGIC;
SIGNAL wr_buffer : STD_LOGIC;
COMPONENT pgrFSM
	PORT (
	addressMemBuffer : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	bufferEndFlag : IN STD_LOGIC;
	clc_buffer : OUT STD_LOGIC;
	clk : IN STD_LOGIC;
	ctrlBuffer : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	en_buffer : OUT STD_LOGIC;
	endProgram : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	flag1 : OUT STD_LOGIC;
	flagEND : OUT STD_LOGIC;
	rd_buffer : OUT STD_LOGIC;
	rst_n : IN STD_LOGIC;
	start : IN STD_LOGIC;
	wr_buffer : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : pgrFSM
	PORT MAP (
-- list connections between master ports and signals
	addressMemBuffer => addressMemBuffer,
	bufferEndFlag => bufferEndFlag,
	clc_buffer => clc_buffer,
	clk => clk,
	ctrlBuffer => ctrlBuffer,
	en_buffer => en_buffer,
	endProgram => endProgram,
	flag1 => flag1,
	flagEND => flagEND,
	rd_buffer => rd_buffer,
	rst_n => rst_n,
	start => start,
	wr_buffer => wr_buffer
	);

-- rst_n
t_prcs_rst_n: PROCESS
BEGIN
	rst_n <= '0';
	WAIT FOR 70000 ps;
	rst_n <= '1';
WAIT;
END PROCESS t_prcs_rst_n;

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

-- start
t_prcs_start: PROCESS
BEGIN
	start <= '0';
	WAIT FOR 80000 ps;
	start <= '1';
	WAIT FOR 20000 ps;
	start <= '0';
WAIT;
END PROCESS t_prcs_start;

-- bufferEndFlag
t_prcs_bufferEndFlag: PROCESS
BEGIN
	bufferEndFlag <= '0';
	WAIT FOR 220000 ps;
	bufferEndFlag <= '1';
	WAIT FOR 20000 ps;
	bufferEndFlag <= '0';
	WAIT FOR 160000 ps;
	bufferEndFlag <= '1';
	WAIT FOR 20000 ps;
	bufferEndFlag <= '0';
WAIT;
END PROCESS t_prcs_bufferEndFlag;
-- endProgram[31]
t_prcs_endProgram_31: PROCESS
BEGIN
	endProgram(31) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_31;
-- endProgram[30]
t_prcs_endProgram_30: PROCESS
BEGIN
	endProgram(30) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_30;
-- endProgram[29]
t_prcs_endProgram_29: PROCESS
BEGIN
	endProgram(29) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_29;
-- endProgram[28]
t_prcs_endProgram_28: PROCESS
BEGIN
	endProgram(28) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_28;
-- endProgram[27]
t_prcs_endProgram_27: PROCESS
BEGIN
	endProgram(27) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_27;
-- endProgram[26]
t_prcs_endProgram_26: PROCESS
BEGIN
	endProgram(26) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_26;
-- endProgram[25]
t_prcs_endProgram_25: PROCESS
BEGIN
	endProgram(25) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_25;
-- endProgram[24]
t_prcs_endProgram_24: PROCESS
BEGIN
	endProgram(24) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_24;
-- endProgram[23]
t_prcs_endProgram_23: PROCESS
BEGIN
	endProgram(23) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_23;
-- endProgram[22]
t_prcs_endProgram_22: PROCESS
BEGIN
	endProgram(22) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_22;
-- endProgram[21]
t_prcs_endProgram_21: PROCESS
BEGIN
	endProgram(21) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_21;
-- endProgram[20]
t_prcs_endProgram_20: PROCESS
BEGIN
	endProgram(20) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_20;
-- endProgram[19]
t_prcs_endProgram_19: PROCESS
BEGIN
	endProgram(19) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_19;
-- endProgram[18]
t_prcs_endProgram_18: PROCESS
BEGIN
	endProgram(18) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_18;
-- endProgram[17]
t_prcs_endProgram_17: PROCESS
BEGIN
	endProgram(17) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_17;
-- endProgram[16]
t_prcs_endProgram_16: PROCESS
BEGIN
	endProgram(16) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_16;
-- endProgram[15]
t_prcs_endProgram_15: PROCESS
BEGIN
	endProgram(15) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_15;
-- endProgram[14]
t_prcs_endProgram_14: PROCESS
BEGIN
	endProgram(14) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_14;
-- endProgram[13]
t_prcs_endProgram_13: PROCESS
BEGIN
	endProgram(13) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_13;
-- endProgram[12]
t_prcs_endProgram_12: PROCESS
BEGIN
	endProgram(12) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_12;
-- endProgram[11]
t_prcs_endProgram_11: PROCESS
BEGIN
	endProgram(11) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_11;
-- endProgram[10]
t_prcs_endProgram_10: PROCESS
BEGIN
	endProgram(10) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_10;
-- endProgram[9]
t_prcs_endProgram_9: PROCESS
BEGIN
	endProgram(9) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_9;
-- endProgram[8]
t_prcs_endProgram_8: PROCESS
BEGIN
	endProgram(8) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_8;
-- endProgram[7]
t_prcs_endProgram_7: PROCESS
BEGIN
	endProgram(7) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_7;
-- endProgram[6]
t_prcs_endProgram_6: PROCESS
BEGIN
	endProgram(6) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_6;
-- endProgram[5]
t_prcs_endProgram_5: PROCESS
BEGIN
	endProgram(5) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_5;
-- endProgram[4]
t_prcs_endProgram_4: PROCESS
BEGIN
	endProgram(4) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_4;
-- endProgram[3]
t_prcs_endProgram_3: PROCESS
BEGIN
	endProgram(3) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_3;
-- endProgram[2]
t_prcs_endProgram_2: PROCESS
BEGIN
	endProgram(2) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_2;
-- endProgram[1]
t_prcs_endProgram_1: PROCESS
BEGIN
	endProgram(1) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_1;
-- endProgram[0]
t_prcs_endProgram_0: PROCESS
BEGIN
	endProgram(0) <= '0';
WAIT;
END PROCESS t_prcs_endProgram_0;
END pgrFSM_arch;
