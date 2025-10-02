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
-- Generated on "07/21/2023 11:48:13"
                                                            
-- Vhdl Test Bench template for design  :  fsm_osk_write
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY fsm_osk_write_vhd_tst IS
END fsm_osk_write_vhd_tst;
ARCHITECTURE fsm_osk_write_arch OF fsm_osk_write_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL dds_FSK_BPSK_HOLD : STD_LOGIC;
SIGNAL dds_I_O_update : STD_LOGIC;
SIGNAL dds_masterRst : STD_LOGIC;
SIGNAL dds_rd_n : STD_LOGIC;
SIGNAL dds_wr_n : STD_LOGIC;
SIGNAL osk_12bitDataIn : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL osk_16bitDataOut : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL osk_clk : STD_LOGIC;
SIGNAL osk_initFsm : STD_LOGIC;
SIGNAL osk_rst_n : STD_LOGIC;
COMPONENT fsm_osk_write
	PORT (
	dds_FSK_BPSK_HOLD : OUT STD_LOGIC;
	dds_I_O_update : OUT STD_LOGIC;
	dds_masterRst : OUT STD_LOGIC;
	dds_rd_n : OUT STD_LOGIC;
	dds_wr_n : OUT STD_LOGIC;
	osk_12bitDataIn : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
	osk_16bitDataOut : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	osk_clk : IN STD_LOGIC;
	osk_initFsm : IN STD_LOGIC;
	osk_rst_n : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : fsm_osk_write
	PORT MAP (
-- list connections between master ports and signals
	dds_FSK_BPSK_HOLD => dds_FSK_BPSK_HOLD,
	dds_I_O_update => dds_I_O_update,
	dds_masterRst => dds_masterRst,
	dds_rd_n => dds_rd_n,
	dds_wr_n => dds_wr_n,
	osk_12bitDataIn => osk_12bitDataIn,
	osk_16bitDataOut => osk_16bitDataOut,
	osk_clk => osk_clk,
	osk_initFsm => osk_initFsm,
	osk_rst_n => osk_rst_n
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
END fsm_osk_write_arch;
