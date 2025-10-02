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
-- Generated on "09/18/2023 16:37:26"
                                                            
-- Vhdl Test Bench template for design  :  block_nco_rf_pulse
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY block_nco_rf_pulse_vhd_tst IS
END block_nco_rf_pulse_vhd_tst;
ARCHITECTURE block_nco_rf_pulse_arch OF block_nco_rf_pulse_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL chronoLedOut : STD_LOGIC;
SIGNAL clock_50mhz : STD_LOGIC;
SIGNAL rf_pulse_window : STD_LOGIC;
SIGNAL rst : STD_LOGIC;
SIGNAL startPhaseTest : STD_LOGIC;
SIGNAL windowEdge : STD_LOGIC;
COMPONENT block_nco_rf_pulse
	PORT (
	chronoLedOut : OUT STD_LOGIC;
	clock_50mhz : IN STD_LOGIC;
	rf_pulse_window : OUT STD_LOGIC;
	rst : IN STD_LOGIC;
	startPhaseTest : IN STD_LOGIC;
	windowEdge : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : block_nco_rf_pulse
	PORT MAP (
-- list connections between master ports and signals
	chronoLedOut => chronoLedOut,
	clock_50mhz => clock_50mhz,
	rf_pulse_window => rf_pulse_window,
	rst => rst,
	startPhaseTest => startPhaseTest,
	windowEdge => windowEdge
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
END block_nco_rf_pulse_arch;
