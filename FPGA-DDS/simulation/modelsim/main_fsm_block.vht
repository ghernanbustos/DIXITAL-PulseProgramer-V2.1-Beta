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
-- Generated on "05/08/2023 13:02:34"
                                                            
-- Vhdl Test Bench template for design  :  main_fsm_block
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY main_fsm_block_vhd_tst IS
END main_fsm_block_vhd_tst;
ARCHITECTURE main_fsm_block_arch OF main_fsm_block_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL address_dds : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL clock_50 : STD_LOGIC;
SIGNAL clr_memOut : STD_LOGIC;
SIGNAL data_dds : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL flag_s0 : STD_LOGIC;
SIGNAL flag_s1 : STD_LOGIC;
SIGNAL flag_s2 : STD_LOGIC;
SIGNAL flag_s3 : STD_LOGIC;
SIGNAL flag_s4 : STD_LOGIC;
SIGNAL fsk_dds : STD_LOGIC;
SIGNAL fsm2_S5_Flag : STD_LOGIC;
SIGNAL init_fsm : STD_LOGIC;
SIGNAL io_dds : STD_LOGIC;
SIGNAL mRst_dds : STD_LOGIC;
SIGNAL nrd_dds : STD_LOGIC;
SIGNAL nwr_dds : STD_LOGIC;
SIGNAL reset : STD_LOGIC;
COMPONENT main_fsm_block
	PORT (
	address_dds : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	clock_50 : IN STD_LOGIC;
	clr_memOut : IN STD_LOGIC;
	data_dds : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	flag_s0 : OUT STD_LOGIC;
	flag_s1 : OUT STD_LOGIC;
	flag_s2 : OUT STD_LOGIC;
	flag_s3 : OUT STD_LOGIC;
	flag_s4 : OUT STD_LOGIC;
	fsk_dds : OUT STD_LOGIC;
	fsm2_S5_Flag : OUT STD_LOGIC;
	init_fsm : IN STD_LOGIC;
	io_dds : OUT STD_LOGIC;
	mRst_dds : OUT STD_LOGIC;
	nrd_dds : OUT STD_LOGIC;
	nwr_dds : OUT STD_LOGIC;
	reset : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : main_fsm_block
	PORT MAP (
-- list connections between master ports and signals
	address_dds => address_dds,
	clock_50 => clock_50,
	clr_memOut => clr_memOut,
	data_dds => data_dds,
	flag_s0 => flag_s0,
	flag_s1 => flag_s1,
	flag_s2 => flag_s2,
	flag_s3 => flag_s3,
	flag_s4 => flag_s4,
	fsk_dds => fsk_dds,
	fsm2_S5_Flag => fsm2_S5_Flag,
	init_fsm => init_fsm,
	io_dds => io_dds,
	mRst_dds => mRst_dds,
	nrd_dds => nrd_dds,
	nwr_dds => nwr_dds,
	reset => reset
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
END main_fsm_block_arch;
