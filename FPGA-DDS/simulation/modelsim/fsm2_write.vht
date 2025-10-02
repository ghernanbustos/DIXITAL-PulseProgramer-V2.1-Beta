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
-- Generated on "03/30/2023 11:33:40"
                                                            
-- Vhdl Test Bench template for design  :  fsm2_write
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY fsm2_write_vhd_tst IS
END fsm2_write_vhd_tst;
ARCHITECTURE fsm2_write_arch OF fsm2_write_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL addressMemData : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL addressMemReg : STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL clk_fsm2 : STD_LOGIC;
SIGNAL en_ftwMem : STD_LOGIC;
SIGNAL en_regMem : STD_LOGIC;
SIGNAL FSK_BPSK_HOLD_dds : STD_LOGIC;
SIGNAL I_O_update_dds : STD_LOGIC;
SIGNAL masterRst_dds : STD_LOGIC;
SIGNAL rd_ftwMem : STD_LOGIC;
SIGNAL rd_n_dds : STD_LOGIC;
SIGNAL rd_regMem : STD_LOGIC;
SIGNAL rst_n_fsm2 : STD_LOGIC;
SIGNAL start_fsm2 : STD_LOGIC;
SIGNAL wd_n_dds : STD_LOGIC;
SIGNAL wr_ftwMem : STD_LOGIC;
SIGNAL wr_regMem : STD_LOGIC;
COMPONENT fsm2_write
	PORT (
	addressMemData : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	addressMemReg : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
	clk_fsm2 : IN STD_LOGIC;
	en_ftwMem : OUT STD_LOGIC;
	en_regMem : OUT STD_LOGIC;
	FSK_BPSK_HOLD_dds : OUT STD_LOGIC;
	I_O_update_dds : OUT STD_LOGIC;
	masterRst_dds : OUT STD_LOGIC;
	rd_ftwMem : OUT STD_LOGIC;
	rd_n_dds : OUT STD_LOGIC;
	rd_regMem : OUT STD_LOGIC;
	rst_n_fsm2 : IN STD_LOGIC;
	start_fsm2 : IN STD_LOGIC;
	wd_n_dds : OUT STD_LOGIC;
	wr_ftwMem : OUT STD_LOGIC;
	wr_regMem : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : fsm2_write
	PORT MAP (
-- list connections between master ports and signals
	addressMemData => addressMemData,
	addressMemReg => addressMemReg,
	clk_fsm2 => clk_fsm2,
	en_ftwMem => en_ftwMem,
	en_regMem => en_regMem,
	FSK_BPSK_HOLD_dds => FSK_BPSK_HOLD_dds,
	I_O_update_dds => I_O_update_dds,
	masterRst_dds => masterRst_dds,
	rd_ftwMem => rd_ftwMem,
	rd_n_dds => rd_n_dds,
	rd_regMem => rd_regMem,
	rst_n_fsm2 => rst_n_fsm2,
	start_fsm2 => start_fsm2,
	wd_n_dds => wd_n_dds,
	wr_ftwMem => wr_ftwMem,
	wr_regMem => wr_regMem
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
END fsm2_write_arch;
