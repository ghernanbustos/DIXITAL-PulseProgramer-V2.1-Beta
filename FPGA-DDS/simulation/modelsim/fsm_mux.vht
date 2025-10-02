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
-- Generated on "03/13/2023 17:30:35"
                                                            
-- Vhdl Test Bench template for design  :  fsm_mux
-- 
-- Simulation tool : ModelSim (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY fsm_mux_vhd_tst IS
END fsm_mux_vhd_tst;
ARCHITECTURE fsm_mux_arch OF fsm_mux_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL address_1 : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL address_2 : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL address_x : STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL data_1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL data_2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL data_x : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL FSK_1 : STD_LOGIC;
SIGNAL FSK_2 : STD_LOGIC;
SIGNAL FSK_x : STD_LOGIC;
SIGNAL io_ud_1 : STD_LOGIC;
SIGNAL io_ud_2 : STD_LOGIC;
SIGNAL io_ud_x : STD_LOGIC;
SIGNAL mRst_1 : STD_LOGIC;
SIGNAL mRst_2 : STD_LOGIC;
SIGNAL mRst_x : STD_LOGIC;
SIGNAL osk_1 : STD_LOGIC;
SIGNAL osk_2 : STD_LOGIC;
SIGNAL osk_x : STD_LOGIC;
SIGNAL sel_fsm : STD_LOGIC;
COMPONENT fsm_mux
	PORT (
	address_1 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	address_2 : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
	address_x : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
	data_1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	data_2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	data_x : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	FSK_1 : IN STD_LOGIC;
	FSK_2 : IN STD_LOGIC;
	FSK_x : OUT STD_LOGIC;
	io_ud_1 : IN STD_LOGIC;
	io_ud_2 : IN STD_LOGIC;
	io_ud_x : OUT STD_LOGIC;
	mRst_1 : IN STD_LOGIC;
	mRst_2 : IN STD_LOGIC;
	mRst_x : OUT STD_LOGIC;
	osk_1 : IN STD_LOGIC;
	osk_2 : IN STD_LOGIC;
	osk_x : OUT STD_LOGIC;
	sel_fsm : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : fsm_mux
	PORT MAP (
-- list connections between master ports and signals
	address_1 => address_1,
	address_2 => address_2,
	address_x => address_x,
	data_1 => data_1,
	data_2 => data_2,
	data_x => data_x,
	FSK_1 => FSK_1,
	FSK_2 => FSK_2,
	FSK_x => FSK_x,
	io_ud_1 => io_ud_1,
	io_ud_2 => io_ud_2,
	io_ud_x => io_ud_x,
	mRst_1 => mRst_1,
	mRst_2 => mRst_2,
	mRst_x => mRst_x,
	osk_1 => osk_1,
	osk_2 => osk_2,
	osk_x => osk_x,
	sel_fsm => sel_fsm
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
END fsm_mux_arch;
