-- Copyright (C) 2022  Intel Corporation. All rights reserved.
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
-- Generated on "03/03/2023 17:40:28"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          fsm1_startup
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY fsm1_startup_vhd_vec_tst IS
END fsm1_startup_vhd_vec_tst;
ARCHITECTURE fsm1_startup_arch OF fsm1_startup_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL address : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL clk : STD_LOGIC;
SIGNAL data : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL FSK_BPSK_HOLD : STD_LOGIC;
SIGNAL I_O_update : STD_LOGIC;
SIGNAL in_button : STD_LOGIC;
SIGNAL masterRst : STD_LOGIC;
SIGNAL out_mux : STD_LOGIC;
SIGNAL rd_n : STD_LOGIC;
SIGNAL rst_fsm1 : STD_LOGIC;
SIGNAL wd_n : STD_LOGIC;
COMPONENT fsm1_startup
	PORT (
	address : BUFFER STD_LOGIC_VECTOR(5 DOWNTO 0);
	clk : IN STD_LOGIC;
	data : BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
	FSK_BPSK_HOLD : BUFFER STD_LOGIC;
	I_O_update : BUFFER STD_LOGIC;
	in_button : IN STD_LOGIC;
	masterRst : BUFFER STD_LOGIC;
	out_mux : BUFFER STD_LOGIC;
	rd_n : BUFFER STD_LOGIC;
	rst_fsm1 : IN STD_LOGIC;
	wd_n : BUFFER STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : fsm1_startup
	PORT MAP (
-- list connections between master ports and signals
	address => address,
	clk => clk,
	data => data,
	FSK_BPSK_HOLD => FSK_BPSK_HOLD,
	I_O_update => I_O_update,
	in_button => in_button,
	masterRst => masterRst,
	out_mux => out_mux,
	rd_n => rd_n,
	rst_fsm1 => rst_fsm1,
	wd_n => wd_n
	);

-- clk
t_prcs_clk: PROCESS
BEGIN
	FOR i IN 1 TO 12
	LOOP
		clk <= '0';
		WAIT FOR 40000 ps;
		clk <= '1';
		WAIT FOR 40000 ps;
	END LOOP;
	clk <= '0';
WAIT;
END PROCESS t_prcs_clk;

-- rst_fsm1
t_prcs_rst_fsm1: PROCESS
BEGIN
	rst_fsm1 <= '0';
WAIT;
END PROCESS t_prcs_rst_fsm1;

-- in_button
t_prcs_in_button: PROCESS
BEGIN
	in_button <= '1';
	WAIT FOR 560000 ps;
	in_button <= '0';
WAIT;
END PROCESS t_prcs_in_button;
END fsm1_startup_arch;
