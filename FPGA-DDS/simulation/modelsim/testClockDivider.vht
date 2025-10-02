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
-- Generated on "08/04/2023 16:45:16"
                                                            
-- Vhdl Test Bench template for design  :  testClockDivider
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY testClockDivider_vhd_tst IS
END testClockDivider_vhd_tst;
ARCHITECTURE testClockDivider_arch OF testClockDivider_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk_1mhz : STD_LOGIC;
SIGNAL clk_2mhz : STD_LOGIC;
COMPONENT testClockDivider
	PORT (
	clk_1mhz : OUT STD_LOGIC;
	clk_2mhz : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : testClockDivider
	PORT MAP (
-- list connections between master ports and signals
	clk_1mhz => clk_1mhz,
	clk_2mhz => clk_2mhz
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
END testClockDivider_arch;
