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
-- Generated on "10/31/2024 14:31:10"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          fsm_init_SingleToneV2
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY fsm_init_SingleToneV2_vhd_vec_tst IS
END fsm_init_SingleToneV2_vhd_vec_tst;
ARCHITECTURE fsm_init_SingleToneV2_arch OF fsm_init_SingleToneV2_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL AddressMem_offset : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL AddressMemInit : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL clc_InitMem : STD_LOGIC;
SIGNAL clk_fsm_SingleTone : STD_LOGIC;
SIGNAL en_InitMem : STD_LOGIC;
SIGNAL flag1 : STD_LOGIC;
SIGNAL flag2 : STD_LOGIC;
SIGNAL flag3 : STD_LOGIC;
SIGNAL flag4 : STD_LOGIC;
SIGNAL flag5 : STD_LOGIC;
SIGNAL flag6 : STD_LOGIC;
SIGNAL flag7 : STD_LOGIC;
SIGNAL flag8 : STD_LOGIC;
SIGNAL FSK_BPSK_HOLD : STD_LOGIC;
SIGNAL fsm_initEND : STD_LOGIC;
SIGNAL I_O_update : STD_LOGIC;
SIGNAL masterRst : STD_LOGIC;
SIGNAL rd_InitMem : STD_LOGIC;
SIGNAL rd_n : STD_LOGIC;
SIGNAL rst_n_fsm_SingleTone : STD_LOGIC;
SIGNAL start_fsm_SingleTone : STD_LOGIC;
SIGNAL wd_n : STD_LOGIC;
SIGNAL wr_InitMem : STD_LOGIC;
COMPONENT fsm_init_SingleToneV2
	PORT (
	AddressMem_offset : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	AddressMemInit : BUFFER STD_LOGIC_VECTOR(5 DOWNTO 0);
	clc_InitMem : BUFFER STD_LOGIC;
	clk_fsm_SingleTone : IN STD_LOGIC;
	en_InitMem : BUFFER STD_LOGIC;
	flag1 : BUFFER STD_LOGIC;
	flag2 : BUFFER STD_LOGIC;
	flag3 : BUFFER STD_LOGIC;
	flag4 : BUFFER STD_LOGIC;
	flag5 : BUFFER STD_LOGIC;
	flag6 : BUFFER STD_LOGIC;
	flag7 : BUFFER STD_LOGIC;
	flag8 : BUFFER STD_LOGIC;
	FSK_BPSK_HOLD : BUFFER STD_LOGIC;
	fsm_initEND : BUFFER STD_LOGIC;
	I_O_update : BUFFER STD_LOGIC;
	masterRst : BUFFER STD_LOGIC;
	rd_InitMem : BUFFER STD_LOGIC;
	rd_n : BUFFER STD_LOGIC;
	rst_n_fsm_SingleTone : IN STD_LOGIC;
	start_fsm_SingleTone : IN STD_LOGIC;
	wd_n : BUFFER STD_LOGIC;
	wr_InitMem : BUFFER STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : fsm_init_SingleToneV2
	PORT MAP (
-- list connections between master ports and signals
	AddressMem_offset => AddressMem_offset,
	AddressMemInit => AddressMemInit,
	clc_InitMem => clc_InitMem,
	clk_fsm_SingleTone => clk_fsm_SingleTone,
	en_InitMem => en_InitMem,
	flag1 => flag1,
	flag2 => flag2,
	flag3 => flag3,
	flag4 => flag4,
	flag5 => flag5,
	flag6 => flag6,
	flag7 => flag7,
	flag8 => flag8,
	FSK_BPSK_HOLD => FSK_BPSK_HOLD,
	fsm_initEND => fsm_initEND,
	I_O_update => I_O_update,
	masterRst => masterRst,
	rd_InitMem => rd_InitMem,
	rd_n => rd_n,
	rst_n_fsm_SingleTone => rst_n_fsm_SingleTone,
	start_fsm_SingleTone => start_fsm_SingleTone,
	wd_n => wd_n,
	wr_InitMem => wr_InitMem
	);

-- clk_fsm_SingleTone
t_prcs_clk_fsm_SingleTone: PROCESS
BEGIN
LOOP
	clk_fsm_SingleTone <= '0';
	WAIT FOR 10000 ps;
	clk_fsm_SingleTone <= '1';
	WAIT FOR 10000 ps;
	IF (NOW >= 1000000 ps) THEN WAIT; END IF;
END LOOP;
END PROCESS t_prcs_clk_fsm_SingleTone;

-- rst_n_fsm_SingleTone
t_prcs_rst_n_fsm_SingleTone: PROCESS
BEGIN
	rst_n_fsm_SingleTone <= '1';
WAIT;
END PROCESS t_prcs_rst_n_fsm_SingleTone;

-- start_fsm_SingleTone
t_prcs_start_fsm_SingleTone: PROCESS
BEGIN
	start_fsm_SingleTone <= '0';
	WAIT FOR 20000 ps;
	start_fsm_SingleTone <= '1';
	WAIT FOR 20000 ps;
	start_fsm_SingleTone <= '0';
WAIT;
END PROCESS t_prcs_start_fsm_SingleTone;
-- AddressMem_offset[5]
t_prcs_AddressMem_offset_5: PROCESS
BEGIN
	AddressMem_offset(5) <= '0';
WAIT;
END PROCESS t_prcs_AddressMem_offset_5;
-- AddressMem_offset[4]
t_prcs_AddressMem_offset_4: PROCESS
BEGIN
	AddressMem_offset(4) <= '0';
WAIT;
END PROCESS t_prcs_AddressMem_offset_4;
-- AddressMem_offset[3]
t_prcs_AddressMem_offset_3: PROCESS
BEGIN
	AddressMem_offset(3) <= '0';
WAIT;
END PROCESS t_prcs_AddressMem_offset_3;
-- AddressMem_offset[2]
t_prcs_AddressMem_offset_2: PROCESS
BEGIN
	AddressMem_offset(2) <= '0';
WAIT;
END PROCESS t_prcs_AddressMem_offset_2;
-- AddressMem_offset[1]
t_prcs_AddressMem_offset_1: PROCESS
BEGIN
	AddressMem_offset(1) <= '0';
WAIT;
END PROCESS t_prcs_AddressMem_offset_1;
-- AddressMem_offset[0]
t_prcs_AddressMem_offset_0: PROCESS
BEGIN
	AddressMem_offset(0) <= '0';
WAIT;
END PROCESS t_prcs_AddressMem_offset_0;
END fsm_init_SingleToneV2_arch;
