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
-- Generated on "04/20/2023 15:45:08"
                                                            
-- Vhdl Test Bench template for design  :  fsm2_block
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY fsm2_block_vhd_tst IS
END fsm2_block_vhd_tst;
ARCHITECTURE fsm2_block_arch OF fsm2_block_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk_enable : STD_LOGIC;
SIGNAL clock_50 : STD_LOGIC;
SIGNAL clr_mem : STD_LOGIC;
SIGNAL fsk : STD_LOGIC;
SIGNAL mRst : STD_LOGIC;
SIGNAL nrd : STD_LOGIC;
SIGNAL nwr : STD_LOGIC;
SIGNAL q_dir : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL q_ftw : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL rst_fsm : STD_LOGIC;
SIGNAL s0 : STD_LOGIC;
SIGNAL s1 : STD_LOGIC;
SIGNAL s2 : STD_LOGIC;
SIGNAL s3 : STD_LOGIC;
SIGNAL s4 : STD_LOGIC;
SIGNAL s5 : STD_LOGIC;
SIGNAL start_fsm : STD_LOGIC;
SIGNAL ud_clk : STD_LOGIC;
COMPONENT fsm2_block
	PORT (
	clk_enable : IN STD_LOGIC;
	clock_50 : IN STD_LOGIC;
	clr_mem : IN STD_LOGIC;
	fsk : OUT STD_LOGIC;
	mRst : OUT STD_LOGIC;
	nrd : OUT STD_LOGIC;
	nwr : OUT STD_LOGIC;
	q_dir : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	q_ftw : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	rst_fsm : IN STD_LOGIC;
	s0 : OUT STD_LOGIC;
	s1 : OUT STD_LOGIC;
	s2 : OUT STD_LOGIC;
	s3 : OUT STD_LOGIC;
	s4 : OUT STD_LOGIC;
	s5 : OUT STD_LOGIC;
	start_fsm : IN STD_LOGIC;
	ud_clk : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : fsm2_block
	PORT MAP (
-- list connections between master ports and signals
	clk_enable => clk_enable,
	clock_50 => clock_50,
	clr_mem => clr_mem,
	fsk => fsk,
	mRst => mRst,
	nrd => nrd,
	nwr => nwr,
	q_dir => q_dir,
	q_ftw => q_ftw,
	rst_fsm => rst_fsm,
	s0 => s0,
	s1 => s1,
	s2 => s2,
	s3 => s3,
	s4 => s4,
	s5 => s5,
	start_fsm => start_fsm,
	ud_clk => ud_clk
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
END fsm2_block_arch;
