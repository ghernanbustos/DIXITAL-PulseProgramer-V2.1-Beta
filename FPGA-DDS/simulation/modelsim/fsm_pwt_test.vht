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
-- Generated on "05/25/2023 16:04:10"
                                                            
-- Vhdl Test Bench template for design  :  fsm_pwt_test
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY fsm_pwt_test_vhd_tst IS
END fsm_pwt_test_vhd_tst;
ARCHITECTURE fsm_pwt_test_arch OF fsm_pwt_test_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL aclk_mem : STD_LOGIC;
SIGNAL address_en : STD_LOGIC;
SIGNAL address_n_rst : STD_LOGIC;
SIGNAL clk_en_mem : STD_LOGIC;
SIGNAL clk_fsmpwt : STD_LOGIC;
SIGNAL count_en : STD_LOGIC;
SIGNAL count_n_rst : STD_LOGIC;
SIGNAL count_preload_en : STD_LOGIC;
SIGNAL overflow_flag : STD_LOGIC;
SIGNAL rd_en_mem : STD_LOGIC;
SIGNAL rst_n_fsmpwt : STD_LOGIC;
SIGNAL start_fsmpwt : STD_LOGIC;
SIGNAL wr_en_mem : STD_LOGIC;
COMPONENT fsm_pwt_test
	PORT (
	aclk_mem : BUFFER STD_LOGIC;
	address_en : BUFFER STD_LOGIC;
	address_n_rst : BUFFER STD_LOGIC;
	clk_en_mem : BUFFER STD_LOGIC;
	clk_fsmpwt : IN STD_LOGIC;
	count_en : BUFFER STD_LOGIC;
	count_n_rst : BUFFER STD_LOGIC;
	count_preload_en : BUFFER STD_LOGIC;
	overflow_flag : IN STD_LOGIC;
	rd_en_mem : BUFFER STD_LOGIC;
	rst_n_fsmpwt : IN STD_LOGIC;
	start_fsmpwt : IN STD_LOGIC;
	wr_en_mem : BUFFER STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : fsm_pwt_test
	PORT MAP (
-- list connections between master ports and signals
	aclk_mem => aclk_mem,
	address_en => address_en,
	address_n_rst => address_n_rst,
	clk_en_mem => clk_en_mem,
	clk_fsmpwt => clk_fsmpwt,
	count_en => count_en,
	count_n_rst => count_n_rst,
	count_preload_en => count_preload_en,
	overflow_flag => overflow_flag,
	rd_en_mem => rd_en_mem,
	rst_n_fsmpwt => rst_n_fsmpwt,
	start_fsmpwt => start_fsmpwt,
	wr_en_mem => wr_en_mem
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
END fsm_pwt_test_arch;
