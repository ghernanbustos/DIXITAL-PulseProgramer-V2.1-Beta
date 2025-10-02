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
-- Generated on "09/19/2023 14:25:53"
                                                            
-- Vhdl Test Bench template for design  :  genericChrono_sf
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY genericChrono_sf_vhd_tst IS
END genericChrono_sf_vhd_tst;
ARCHITECTURE genericChrono_sf_arch OF genericChrono_sf_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk_count : STD_LOGIC;
SIGNAL en_count : STD_LOGIC;
SIGNAL en_preload : STD_LOGIC;
SIGNAL nRst_count : STD_LOGIC;
SIGNAL preload_count : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL window : STD_LOGIC;
SIGNAL window_db : STD_LOGIC;
COMPONENT genericChrono_sf
	PORT (
	clk_count : IN STD_LOGIC;
	en_count : IN STD_LOGIC;
	en_preload : IN STD_LOGIC;
	nRst_count : IN STD_LOGIC;
	preload_count : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	window : OUT STD_LOGIC;
	window_db : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : genericChrono_sf
	PORT MAP (
-- list connections between master ports and signals
	clk_count => clk_count,
	en_count => en_count,
	en_preload => en_preload,
	nRst_count => nRst_count,
	preload_count => preload_count,
	window => window,
	window_db => window_db
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
END genericChrono_sf_arch;
