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
-- Generated on "07/24/2023 18:03:20"
                                                            
-- Vhdl Test Bench template for design  :  osk_blockTest
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY osk_blockTest_vhd_tst IS
END osk_blockTest_vhd_tst;
ARCHITECTURE osk_blockTest_arch OF osk_blockTest_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clock_50 : STD_LOGIC;
SIGNAL DataNCOin : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL fsk : STD_LOGIC;
SIGNAL initfsm : STD_LOGIC;
SIGNAL mstRst : STD_LOGIC;
SIGNAL osk_16bitDataOut : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL rd_n : STD_LOGIC;
SIGNAL rst : STD_LOGIC;
SIGNAL ud_dds_clock : STD_LOGIC;
SIGNAL wr_n : STD_LOGIC;
COMPONENT osk_blockTest
	PORT (
	clock_50 : IN STD_LOGIC;
	DataNCOin : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	fsk : OUT STD_LOGIC;
	initfsm : IN STD_LOGIC;
	mstRst : OUT STD_LOGIC;
	osk_16bitDataOut : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	rd_n : OUT STD_LOGIC;
	rst : IN STD_LOGIC;
	ud_dds_clock : OUT STD_LOGIC;
	wr_n : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : osk_blockTest
	PORT MAP (
-- list connections between master ports and signals
	clock_50 => clock_50,
	DataNCOin => DataNCOin,
	fsk => fsk,
	initfsm => initfsm,
	mstRst => mstRst,
	osk_16bitDataOut => osk_16bitDataOut,
	rd_n => rd_n,
	rst => rst,
	ud_dds_clock => ud_dds_clock,
	wr_n => wr_n
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
END osk_blockTest_arch;
