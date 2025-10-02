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
-- Generated on "06/28/2023 16:39:39"
                                                            
-- Vhdl Test Bench template for design  :  StartPulseTest
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY StartPulseTest_vhd_tst IS
END StartPulseTest_vhd_tst;
ARCHITECTURE StartPulseTest_arch OF StartPulseTest_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clock_in : STD_LOGIC;
SIGNAL OnePulse : STD_LOGIC;
SIGNAL pulseSwitch : STD_LOGIC;
COMPONENT StartPulseTest
	PORT (
	clock_in : IN STD_LOGIC;
	OnePulse : OUT STD_LOGIC;
	pulseSwitch : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : StartPulseTest
	PORT MAP (
-- list connections between master ports and signals
	clock_in => clock_in,
	OnePulse => OnePulse,
	pulseSwitch => pulseSwitch
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
END StartPulseTest_arch;
