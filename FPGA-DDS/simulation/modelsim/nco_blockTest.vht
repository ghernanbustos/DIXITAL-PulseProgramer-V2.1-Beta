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
-- Generated on "09/18/2023 18:15:09"
                                                            
-- Vhdl Test Bench template for design  :  nco_blockTest
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY nco_blockTest_vhd_tst IS
END nco_blockTest_vhd_tst;
ARCHITECTURE nco_blockTest_arch OF nco_blockTest_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL addressDebug : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL clk_50 : STD_LOGIC;
SIGNAL cos_out : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL enable : STD_LOGIC;
SIGNAL flag_clkout : STD_LOGIC;
SIGNAL phaseInc : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL rst : STD_LOGIC;
SIGNAL saw_out : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL Senoidal : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL SincOut : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL square_out : STD_LOGIC_VECTOR(11 DOWNTO 0);
COMPONENT nco_blockTest
	PORT (
	addressDebug : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	clk_50 : IN STD_LOGIC;
	cos_out : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	enable : IN STD_LOGIC;
	flag_clkout : OUT STD_LOGIC;
	phaseInc : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	rst : IN STD_LOGIC;
	saw_out : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	Senoidal : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	SincOut : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	square_out : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : nco_blockTest
	PORT MAP (
-- list connections between master ports and signals
	addressDebug => addressDebug,
	clk_50 => clk_50,
	cos_out => cos_out,
	enable => enable,
	flag_clkout => flag_clkout,
	phaseInc => phaseInc,
	rst => rst,
	saw_out => saw_out,
	Senoidal => Senoidal,
	SincOut => SincOut,
	square_out => square_out
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
END nco_blockTest_arch;
