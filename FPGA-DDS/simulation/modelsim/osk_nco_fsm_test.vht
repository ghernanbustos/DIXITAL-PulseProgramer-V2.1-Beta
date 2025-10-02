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

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "07/25/2023 18:11:20"
                                                            
-- Vhdl Test Bench template for design  :  osk_nco_fsm_test
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY osk_nco_fsm_test_vhd_tst IS
END osk_nco_fsm_test_vhd_tst;
ARCHITECTURE osk_nco_fsm_test_arch OF osk_nco_fsm_test_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk1_50mhz : STD_LOGIC;
SIGNAL clk2_2mhz : STD_LOGIC;
SIGNAL clk3_1mhz : STD_LOGIC;
SIGNAL fsk : STD_LOGIC;
SIGNAL io_update : STD_LOGIC;
SIGNAL masterRst : STD_LOGIC;
SIGNAL NCO_enable : STD_LOGIC;
SIGNAL osk_fsm_16DataOut : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL rd : STD_LOGIC;
SIGNAL rst1_fsm : STD_LOGIC;
SIGNAL wr : STD_LOGIC;
COMPONENT osk_nco_fsm_test
	PORT (
	clk1_50mhz : IN STD_LOGIC;
	clk2_2mhz : IN STD_LOGIC;
	clk3_1mhz : IN STD_LOGIC;
	fsk : OUT STD_LOGIC;
	io_update : OUT STD_LOGIC;
	masterRst : OUT STD_LOGIC;
	NCO_enable : IN STD_LOGIC;
	osk_fsm_16DataOut : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	rd : OUT STD_LOGIC;
	rst1_fsm : IN STD_LOGIC;
	wr : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : osk_nco_fsm_test
	PORT MAP (
-- list connections between master ports and signals
	clk1_50mhz => clk1_50mhz,
	clk2_2mhz => clk2_2mhz,
	clk3_1mhz => clk3_1mhz,
	fsk => fsk,
	io_update => io_update,
	masterRst => masterRst,
	NCO_enable => NCO_enable,
	osk_fsm_16DataOut => osk_fsm_16DataOut,
	rd => rd,
	rst1_fsm => rst1_fsm,
	wr => wr
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
END osk_nco_fsm_test_arch;
