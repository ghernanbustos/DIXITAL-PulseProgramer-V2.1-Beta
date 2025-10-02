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
-- Generated on "05/25/2023 16:05:59"
                                                            
-- Vhdl Test Bench template for design  :  chrono_block
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY chrono_block_vhd_tst IS
END chrono_block_vhd_tst;
ARCHITECTURE chrono_block_arch OF chrono_block_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clock_50 : STD_LOGIC;
SIGNAL flag_timer : STD_LOGIC;
SIGNAL flagAddress : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL rst_nn : STD_LOGIC;
SIGNAL start_fsm : STD_LOGIC;
COMPONENT chrono_block
	PORT (
	clock_50 : IN STD_LOGIC;
	flag_timer : OUT STD_LOGIC;
	flagAddress : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	rst_nn : IN STD_LOGIC;
	start_fsm : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : chrono_block
	PORT MAP (
-- list connections between master ports and signals
	clock_50 => clock_50,
	flag_timer => flag_timer,
	flagAddress => flagAddress,
	rst_nn => rst_nn,
	start_fsm => start_fsm
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
END chrono_block_arch;
