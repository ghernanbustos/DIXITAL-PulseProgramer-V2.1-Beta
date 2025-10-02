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
-- Generated on "05/18/2023 12:36:41"
                                                            
-- Vhdl Test Bench template for design  :  counter_pwt
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY counter_pwt_vhd_tst IS
END counter_pwt_vhd_tst;
ARCHITECTURE counter_pwt_arch OF counter_pwt_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL count_clk : STD_LOGIC;
SIGNAL count_en : STD_LOGIC;
SIGNAL count_overflow : STD_LOGIC;
SIGNAL count_preload : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL count_rst : STD_LOGIC;
SIGNAL preload_en : STD_LOGIC;
COMPONENT counter_pwt
	PORT (
	count_clk : IN STD_LOGIC;
	count_en : IN STD_LOGIC;
	count_overflow : OUT STD_LOGIC;
	count_preload : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	count_rst : IN STD_LOGIC;
	preload_en : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : counter_pwt
	PORT MAP (
-- list connections between master ports and signals
	count_clk => count_clk,
	count_en => count_en,
	count_overflow => count_overflow,
	count_preload => count_preload,
	count_rst => count_rst,
	preload_en => preload_en
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
END counter_pwt_arch;
