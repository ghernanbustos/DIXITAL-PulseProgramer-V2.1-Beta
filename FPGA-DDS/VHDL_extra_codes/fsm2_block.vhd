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

library ieee;
use ieee.std_logic_1164.all;
library altera;
use altera.altera_syn_attributes.all;

entity fsm2_block is
	port
	(
-- {ALTERA_IO_BEGIN} DO NOT REMOVE THIS LINE!

		address : out std_logic_vector(5 downto 0);
		clk : in std_logic;
		data : out std_logic_vector(7 downto 0);
		FSK_BPSK_HOLD : out std_logic;
		I_O_update : out std_logic;
		in_button : in std_logic;
		Led_flag_state_0 : out std_logic;
		masterRst : out std_logic;
		out_mux : out std_logic;
		rd_n : out std_logic;
		rst_n_fsm1 : in std_logic;
		wd_n : out std_logic;
		reset : in std_logic;
		init_fsm : in std_logic;
		Flag_state0 : in std_logic;
		Flag_mst_rst : in std_logic;
		Flag_wr : in std_logic;
		Flag_rd : in std_logic;
		Flag_mux : in std_logic;
		clock_50 : in std_logic;
		clk_enable : in std_logic;
		clock_flag : in std_logic
-- {ALTERA_IO_END} DO NOT REMOVE THIS LINE!

	);

-- {ALTERA_ATTRIBUTE_BEGIN} DO NOT REMOVE THIS LINE!
-- {ALTERA_ATTRIBUTE_END} DO NOT REMOVE THIS LINE!
end fsm2_block;

architecture ppl_type of fsm2_block is

-- {ALTERA_COMPONENTS_BEGIN} DO NOT REMOVE THIS LINE!
-- {ALTERA_COMPONENTS_END} DO NOT REMOVE THIS LINE!
begin
-- {ALTERA_INSTANTIATION_BEGIN} DO NOT REMOVE THIS LINE!
-- {ALTERA_INSTANTIATION_END} DO NOT REMOVE THIS LINE!

end;
