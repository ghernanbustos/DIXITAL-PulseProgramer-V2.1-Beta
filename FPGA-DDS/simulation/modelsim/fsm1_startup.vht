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

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "03/06/2023 17:19:46"
                                                            
-- Vhdl Test Bench template for design  :  fsm1_startup
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY fsm1_startup_vhd_tst IS
END fsm1_startup_vhd_tst;
ARCHITECTURE fsm1_startup_arch OF fsm1_startup_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL address : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL clk : STD_LOGIC;
SIGNAL data : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL FSK_BPSK_HOLD : STD_LOGIC;
SIGNAL I_O_update : STD_LOGIC;
SIGNAL in_button : STD_LOGIC;
SIGNAL Led_flag_state_0 : STD_LOGIC;
SIGNAL masterRst : STD_LOGIC;
SIGNAL out_mux : STD_LOGIC;
SIGNAL rd_n : STD_LOGIC;
SIGNAL rst_fsm1 : STD_LOGIC;
SIGNAL wd_n : STD_LOGIC;
COMPONENT fsm1_startup
	PORT (
	address : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	clk : IN STD_LOGIC;
	data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	FSK_BPSK_HOLD : OUT STD_LOGIC;
	I_O_update : OUT STD_LOGIC;
	in_button : IN STD_LOGIC;
	Led_flag_state_0 : OUT STD_LOGIC;
	masterRst : OUT STD_LOGIC;
	out_mux : OUT STD_LOGIC;
	rd_n : OUT STD_LOGIC;
	rst_fsm1 : IN STD_LOGIC;
	wd_n : OUT STD_LOGIC
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
	Led_flag_state_0 => Led_flag_state_0,
	masterRst => masterRst,
	out_mux => out_mux,
	rd_n => rd_n,
	rst_fsm1 => rst_fsm1,
	wd_n => wd_n
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;                                          
END fsm1_startup_arch;
