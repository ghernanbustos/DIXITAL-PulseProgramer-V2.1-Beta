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

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 22.1std.1 Build 917 02/14/2023 SC Lite Edition"

-- DATE "07/29/2025 14:59:24"

-- 
-- Device: Altera 5CSEMA4U23C6 Package UFBGA672
-- 

-- 
-- This VHDL file should be used for Questa Intel FPGA (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	pgrFSM IS
    PORT (
	rd_buffer : OUT std_logic;
	clk : IN std_logic;
	rst_n : IN std_logic;
	start : IN std_logic;
	bufferEndFlag : IN std_logic;
	endProgram : IN std_logic_vector(31 DOWNTO 0);
	wr_buffer : OUT std_logic;
	en_buffer : OUT std_logic;
	clc_buffer : OUT std_logic;
	flag1 : OUT std_logic;
	flagEND : OUT std_logic;
	addressMemBuffer : OUT std_logic_vector(5 DOWNTO 0);
	ctrlBuffer : OUT std_logic_vector(7 DOWNTO 0)
	);
END pgrFSM;

ARCHITECTURE structure OF pgrFSM IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_rd_buffer : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_rst_n : std_logic;
SIGNAL ww_start : std_logic;
SIGNAL ww_bufferEndFlag : std_logic;
SIGNAL ww_endProgram : std_logic_vector(31 DOWNTO 0);
SIGNAL ww_wr_buffer : std_logic;
SIGNAL ww_en_buffer : std_logic;
SIGNAL ww_clc_buffer : std_logic;
SIGNAL ww_flag1 : std_logic;
SIGNAL ww_flagEND : std_logic;
SIGNAL ww_addressMemBuffer : std_logic_vector(5 DOWNTO 0);
SIGNAL ww_ctrlBuffer : std_logic_vector(7 DOWNTO 0);
SIGNAL \rd_buffer~output_o\ : std_logic;
SIGNAL \wr_buffer~output_o\ : std_logic;
SIGNAL \en_buffer~output_o\ : std_logic;
SIGNAL \clc_buffer~output_o\ : std_logic;
SIGNAL \flag1~output_o\ : std_logic;
SIGNAL \flagEND~output_o\ : std_logic;
SIGNAL \addressMemBuffer[5]~output_o\ : std_logic;
SIGNAL \addressMemBuffer[4]~output_o\ : std_logic;
SIGNAL \addressMemBuffer[3]~output_o\ : std_logic;
SIGNAL \addressMemBuffer[2]~output_o\ : std_logic;
SIGNAL \addressMemBuffer[1]~output_o\ : std_logic;
SIGNAL \addressMemBuffer[0]~output_o\ : std_logic;
SIGNAL \ctrlBuffer[7]~output_o\ : std_logic;
SIGNAL \ctrlBuffer[6]~output_o\ : std_logic;
SIGNAL \ctrlBuffer[5]~output_o\ : std_logic;
SIGNAL \ctrlBuffer[4]~output_o\ : std_logic;
SIGNAL \ctrlBuffer[3]~output_o\ : std_logic;
SIGNAL \ctrlBuffer[2]~output_o\ : std_logic;
SIGNAL \ctrlBuffer[1]~output_o\ : std_logic;
SIGNAL \ctrlBuffer[0]~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \start~input_o\ : std_logic;
SIGNAL \inst|state.state_rst~0_combout\ : std_logic;
SIGNAL \rst_n~input_o\ : std_logic;
SIGNAL \inst|state.state_rst~q\ : std_logic;
SIGNAL \bufferEndFlag~input_o\ : std_logic;
SIGNAL \inst|state.state_2~q\ : std_logic;
SIGNAL \inst|state.state_3~q\ : std_logic;
SIGNAL \inst|state.state_4~q\ : std_logic;
SIGNAL \endProgram[1]~input_o\ : std_logic;
SIGNAL \endProgram[0]~input_o\ : std_logic;
SIGNAL \inst|Equal0~0_combout\ : std_logic;
SIGNAL \endProgram[7]~input_o\ : std_logic;
SIGNAL \endProgram[6]~input_o\ : std_logic;
SIGNAL \endProgram[5]~input_o\ : std_logic;
SIGNAL \endProgram[4]~input_o\ : std_logic;
SIGNAL \endProgram[3]~input_o\ : std_logic;
SIGNAL \endProgram[2]~input_o\ : std_logic;
SIGNAL \inst|Equal0~1_combout\ : std_logic;
SIGNAL \endProgram[13]~input_o\ : std_logic;
SIGNAL \endProgram[12]~input_o\ : std_logic;
SIGNAL \endProgram[11]~input_o\ : std_logic;
SIGNAL \endProgram[10]~input_o\ : std_logic;
SIGNAL \endProgram[9]~input_o\ : std_logic;
SIGNAL \endProgram[8]~input_o\ : std_logic;
SIGNAL \inst|Equal0~2_combout\ : std_logic;
SIGNAL \endProgram[19]~input_o\ : std_logic;
SIGNAL \endProgram[18]~input_o\ : std_logic;
SIGNAL \endProgram[17]~input_o\ : std_logic;
SIGNAL \endProgram[16]~input_o\ : std_logic;
SIGNAL \endProgram[15]~input_o\ : std_logic;
SIGNAL \endProgram[14]~input_o\ : std_logic;
SIGNAL \inst|Equal0~3_combout\ : std_logic;
SIGNAL \endProgram[31]~input_o\ : std_logic;
SIGNAL \endProgram[30]~input_o\ : std_logic;
SIGNAL \endProgram[29]~input_o\ : std_logic;
SIGNAL \endProgram[28]~input_o\ : std_logic;
SIGNAL \endProgram[27]~input_o\ : std_logic;
SIGNAL \endProgram[26]~input_o\ : std_logic;
SIGNAL \inst|Equal0~4_combout\ : std_logic;
SIGNAL \endProgram[25]~input_o\ : std_logic;
SIGNAL \endProgram[24]~input_o\ : std_logic;
SIGNAL \endProgram[23]~input_o\ : std_logic;
SIGNAL \endProgram[22]~input_o\ : std_logic;
SIGNAL \endProgram[21]~input_o\ : std_logic;
SIGNAL \endProgram[20]~input_o\ : std_logic;
SIGNAL \inst|Equal0~5_combout\ : std_logic;
SIGNAL \inst|Equal0~6_combout\ : std_logic;
SIGNAL \inst|Selector1~0_combout\ : std_logic;
SIGNAL \inst|state.state_5~q\ : std_logic;
SIGNAL \inst|state~13_combout\ : std_logic;
SIGNAL \inst|state.state_6~q\ : std_logic;
SIGNAL \inst|Selector0~0_combout\ : std_logic;
SIGNAL \inst|state.state_1~q\ : std_logic;
SIGNAL \inst|state.state_7~0_combout\ : std_logic;
SIGNAL \inst|state.state_7~q\ : std_logic;
SIGNAL \inst|WideOr3~combout\ : std_logic;
SIGNAL \inst|countVarAddressPos[0]~6_combout\ : std_logic;
SIGNAL \inst|countVarAddressPos[1]~5_combout\ : std_logic;
SIGNAL \inst|countVarAddressPos[2]~4_combout\ : std_logic;
SIGNAL \inst|countVarAddressPos[3]~3_combout\ : std_logic;
SIGNAL \inst|countVarAddressPos[4]~2_combout\ : std_logic;
SIGNAL \inst|countVarAddressPos[3]~0_combout\ : std_logic;
SIGNAL \inst|countVarAddressPos[5]~1_combout\ : std_logic;
SIGNAL \inst|AddressMempulse[5]~1_combout\ : std_logic;
SIGNAL \inst|AddressMempulse[5]~3_combout\ : std_logic;
SIGNAL \inst|AddressMempulse[5]~_emulated_q\ : std_logic;
SIGNAL \inst|AddressMempulse[5]~2_combout\ : std_logic;
SIGNAL \inst|AddressMempulse[4]~5_combout\ : std_logic;
SIGNAL \inst|AddressMempulse[4]~7_combout\ : std_logic;
SIGNAL \inst|AddressMempulse[4]~_emulated_q\ : std_logic;
SIGNAL \inst|AddressMempulse[4]~6_combout\ : std_logic;
SIGNAL \inst|AddressMempulse[3]~9_combout\ : std_logic;
SIGNAL \inst|AddressMempulse[3]~11_combout\ : std_logic;
SIGNAL \inst|AddressMempulse[3]~_emulated_q\ : std_logic;
SIGNAL \inst|AddressMempulse[3]~10_combout\ : std_logic;
SIGNAL \inst|AddressMempulse[2]~13_combout\ : std_logic;
SIGNAL \inst|AddressMempulse[2]~15_combout\ : std_logic;
SIGNAL \inst|AddressMempulse[2]~_emulated_q\ : std_logic;
SIGNAL \inst|AddressMempulse[2]~14_combout\ : std_logic;
SIGNAL \inst|AddressMempulse[1]~17_combout\ : std_logic;
SIGNAL \inst|AddressMempulse[1]~19_combout\ : std_logic;
SIGNAL \inst|AddressMempulse[1]~_emulated_q\ : std_logic;
SIGNAL \inst|AddressMempulse[1]~18_combout\ : std_logic;
SIGNAL \inst|AddressMempulse[0]~21_combout\ : std_logic;
SIGNAL \inst|AddressMempulse[0]~23_combout\ : std_logic;
SIGNAL \inst|AddressMempulse[0]~_emulated_q\ : std_logic;
SIGNAL \inst|AddressMempulse[0]~22_combout\ : std_logic;
SIGNAL \inst|WideOr4~combout\ : std_logic;
SIGNAL \inst|countVarAddressPos\ : std_logic_vector(5 DOWNTO 0);
SIGNAL \inst|ALT_INV_AddressMempulse[2]~_emulated_q\ : std_logic;
SIGNAL \inst|ALT_INV_Equal0~0_combout\ : std_logic;
SIGNAL \inst|ALT_INV_Equal0~5_combout\ : std_logic;
SIGNAL \inst|ALT_INV_countVarAddressPos\ : std_logic_vector(5 DOWNTO 0);
SIGNAL \inst|ALT_INV_Equal0~6_combout\ : std_logic;
SIGNAL \inst|ALT_INV_Equal0~2_combout\ : std_logic;
SIGNAL \inst|ALT_INV_AddressMempulse[1]~_emulated_q\ : std_logic;
SIGNAL \inst|ALT_INV_Equal0~4_combout\ : std_logic;
SIGNAL \inst|ALT_INV_state.state_6~q\ : std_logic;
SIGNAL \inst|ALT_INV_state.state_1~q\ : std_logic;
SIGNAL \inst|ALT_INV_state.state_7~q\ : std_logic;
SIGNAL \inst|ALT_INV_WideOr3~combout\ : std_logic;
SIGNAL \inst|ALT_INV_AddressMempulse[3]~_emulated_q\ : std_logic;
SIGNAL \inst|ALT_INV_AddressMempulse[0]~_emulated_q\ : std_logic;
SIGNAL \inst|ALT_INV_AddressMempulse[5]~_emulated_q\ : std_logic;
SIGNAL \inst|ALT_INV_state.state_rst~q\ : std_logic;
SIGNAL \inst|ALT_INV_AddressMempulse[4]~_emulated_q\ : std_logic;
SIGNAL \inst|ALT_INV_state.state_5~q\ : std_logic;
SIGNAL \inst|ALT_INV_state.state_4~q\ : std_logic;
SIGNAL \inst|ALT_INV_Equal0~1_combout\ : std_logic;
SIGNAL \inst|ALT_INV_Equal0~3_combout\ : std_logic;
SIGNAL \ALT_INV_endProgram[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[2]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[13]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[10]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[9]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[8]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[19]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[16]~input_o\ : std_logic;
SIGNAL \ALT_INV_bufferEndFlag~input_o\ : std_logic;
SIGNAL \inst|ALT_INV_AddressMempulse[1]~17_combout\ : std_logic;
SIGNAL \inst|ALT_INV_AddressMempulse[5]~1_combout\ : std_logic;
SIGNAL \ALT_INV_endProgram[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[11]~input_o\ : std_logic;
SIGNAL \inst|ALT_INV_AddressMempulse[2]~13_combout\ : std_logic;
SIGNAL \ALT_INV_start~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[12]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[18]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[17]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[15]~input_o\ : std_logic;
SIGNAL \inst|ALT_INV_AddressMempulse[3]~9_combout\ : std_logic;
SIGNAL \inst|ALT_INV_AddressMempulse[4]~5_combout\ : std_logic;
SIGNAL \ALT_INV_rst_n~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[7]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[5]~input_o\ : std_logic;
SIGNAL \inst|ALT_INV_countVarAddressPos[3]~0_combout\ : std_logic;
SIGNAL \inst|ALT_INV_AddressMempulse[0]~21_combout\ : std_logic;
SIGNAL \ALT_INV_endProgram[4]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[14]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[21]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[29]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[23]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[27]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[24]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[28]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[25]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[26]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[31]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[30]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[22]~input_o\ : std_logic;
SIGNAL \ALT_INV_endProgram[20]~input_o\ : std_logic;

BEGIN

rd_buffer <= ww_rd_buffer;
ww_clk <= clk;
ww_rst_n <= rst_n;
ww_start <= start;
ww_bufferEndFlag <= bufferEndFlag;
ww_endProgram <= endProgram;
wr_buffer <= ww_wr_buffer;
en_buffer <= ww_en_buffer;
clc_buffer <= ww_clc_buffer;
flag1 <= ww_flag1;
flagEND <= ww_flagEND;
addressMemBuffer <= ww_addressMemBuffer;
ctrlBuffer <= ww_ctrlBuffer;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\inst|ALT_INV_AddressMempulse[2]~_emulated_q\ <= NOT \inst|AddressMempulse[2]~_emulated_q\;
\inst|ALT_INV_Equal0~0_combout\ <= NOT \inst|Equal0~0_combout\;
\inst|ALT_INV_Equal0~5_combout\ <= NOT \inst|Equal0~5_combout\;
\inst|ALT_INV_countVarAddressPos\(2) <= NOT \inst|countVarAddressPos\(2);
\inst|ALT_INV_Equal0~6_combout\ <= NOT \inst|Equal0~6_combout\;
\inst|ALT_INV_countVarAddressPos\(4) <= NOT \inst|countVarAddressPos\(4);
\inst|ALT_INV_countVarAddressPos\(1) <= NOT \inst|countVarAddressPos\(1);
\inst|ALT_INV_Equal0~2_combout\ <= NOT \inst|Equal0~2_combout\;
\inst|ALT_INV_AddressMempulse[1]~_emulated_q\ <= NOT \inst|AddressMempulse[1]~_emulated_q\;
\inst|ALT_INV_countVarAddressPos\(3) <= NOT \inst|countVarAddressPos\(3);
\inst|ALT_INV_Equal0~4_combout\ <= NOT \inst|Equal0~4_combout\;
\inst|ALT_INV_state.state_6~q\ <= NOT \inst|state.state_6~q\;
\inst|ALT_INV_state.state_1~q\ <= NOT \inst|state.state_1~q\;
\inst|ALT_INV_state.state_7~q\ <= NOT \inst|state.state_7~q\;
\inst|ALT_INV_WideOr3~combout\ <= NOT \inst|WideOr3~combout\;
\inst|ALT_INV_AddressMempulse[3]~_emulated_q\ <= NOT \inst|AddressMempulse[3]~_emulated_q\;
\inst|ALT_INV_AddressMempulse[0]~_emulated_q\ <= NOT \inst|AddressMempulse[0]~_emulated_q\;
\inst|ALT_INV_AddressMempulse[5]~_emulated_q\ <= NOT \inst|AddressMempulse[5]~_emulated_q\;
\inst|ALT_INV_countVarAddressPos\(5) <= NOT \inst|countVarAddressPos\(5);
\inst|ALT_INV_state.state_rst~q\ <= NOT \inst|state.state_rst~q\;
\inst|ALT_INV_AddressMempulse[4]~_emulated_q\ <= NOT \inst|AddressMempulse[4]~_emulated_q\;
\inst|ALT_INV_countVarAddressPos\(0) <= NOT \inst|countVarAddressPos\(0);
\inst|ALT_INV_state.state_5~q\ <= NOT \inst|state.state_5~q\;
\inst|ALT_INV_state.state_4~q\ <= NOT \inst|state.state_4~q\;
\inst|ALT_INV_Equal0~1_combout\ <= NOT \inst|Equal0~1_combout\;
\inst|ALT_INV_Equal0~3_combout\ <= NOT \inst|Equal0~3_combout\;
\ALT_INV_endProgram[3]~input_o\ <= NOT \endProgram[3]~input_o\;
\ALT_INV_endProgram[2]~input_o\ <= NOT \endProgram[2]~input_o\;
\ALT_INV_endProgram[13]~input_o\ <= NOT \endProgram[13]~input_o\;
\ALT_INV_endProgram[10]~input_o\ <= NOT \endProgram[10]~input_o\;
\ALT_INV_endProgram[9]~input_o\ <= NOT \endProgram[9]~input_o\;
\ALT_INV_endProgram[8]~input_o\ <= NOT \endProgram[8]~input_o\;
\ALT_INV_endProgram[19]~input_o\ <= NOT \endProgram[19]~input_o\;
\ALT_INV_endProgram[16]~input_o\ <= NOT \endProgram[16]~input_o\;
\ALT_INV_bufferEndFlag~input_o\ <= NOT \bufferEndFlag~input_o\;
\inst|ALT_INV_AddressMempulse[1]~17_combout\ <= NOT \inst|AddressMempulse[1]~17_combout\;
\inst|ALT_INV_AddressMempulse[5]~1_combout\ <= NOT \inst|AddressMempulse[5]~1_combout\;
\ALT_INV_endProgram[1]~input_o\ <= NOT \endProgram[1]~input_o\;
\ALT_INV_endProgram[0]~input_o\ <= NOT \endProgram[0]~input_o\;
\ALT_INV_endProgram[11]~input_o\ <= NOT \endProgram[11]~input_o\;
\inst|ALT_INV_AddressMempulse[2]~13_combout\ <= NOT \inst|AddressMempulse[2]~13_combout\;
\ALT_INV_start~input_o\ <= NOT \start~input_o\;
\ALT_INV_endProgram[12]~input_o\ <= NOT \endProgram[12]~input_o\;
\ALT_INV_endProgram[18]~input_o\ <= NOT \endProgram[18]~input_o\;
\ALT_INV_endProgram[17]~input_o\ <= NOT \endProgram[17]~input_o\;
\ALT_INV_endProgram[15]~input_o\ <= NOT \endProgram[15]~input_o\;
\inst|ALT_INV_AddressMempulse[3]~9_combout\ <= NOT \inst|AddressMempulse[3]~9_combout\;
\inst|ALT_INV_AddressMempulse[4]~5_combout\ <= NOT \inst|AddressMempulse[4]~5_combout\;
\ALT_INV_rst_n~input_o\ <= NOT \rst_n~input_o\;
\ALT_INV_endProgram[7]~input_o\ <= NOT \endProgram[7]~input_o\;
\ALT_INV_endProgram[6]~input_o\ <= NOT \endProgram[6]~input_o\;
\ALT_INV_endProgram[5]~input_o\ <= NOT \endProgram[5]~input_o\;
\inst|ALT_INV_countVarAddressPos[3]~0_combout\ <= NOT \inst|countVarAddressPos[3]~0_combout\;
\inst|ALT_INV_AddressMempulse[0]~21_combout\ <= NOT \inst|AddressMempulse[0]~21_combout\;
\ALT_INV_endProgram[4]~input_o\ <= NOT \endProgram[4]~input_o\;
\ALT_INV_endProgram[14]~input_o\ <= NOT \endProgram[14]~input_o\;
\ALT_INV_endProgram[21]~input_o\ <= NOT \endProgram[21]~input_o\;
\ALT_INV_endProgram[29]~input_o\ <= NOT \endProgram[29]~input_o\;
\ALT_INV_endProgram[23]~input_o\ <= NOT \endProgram[23]~input_o\;
\ALT_INV_endProgram[27]~input_o\ <= NOT \endProgram[27]~input_o\;
\ALT_INV_endProgram[24]~input_o\ <= NOT \endProgram[24]~input_o\;
\ALT_INV_endProgram[28]~input_o\ <= NOT \endProgram[28]~input_o\;
\ALT_INV_endProgram[25]~input_o\ <= NOT \endProgram[25]~input_o\;
\ALT_INV_endProgram[26]~input_o\ <= NOT \endProgram[26]~input_o\;
\ALT_INV_endProgram[31]~input_o\ <= NOT \endProgram[31]~input_o\;
\ALT_INV_endProgram[30]~input_o\ <= NOT \endProgram[30]~input_o\;
\ALT_INV_endProgram[22]~input_o\ <= NOT \endProgram[22]~input_o\;
\ALT_INV_endProgram[20]~input_o\ <= NOT \endProgram[20]~input_o\;

\rd_buffer~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|ALT_INV_WideOr3~combout\,
	devoe => ww_devoe,
	o => \rd_buffer~output_o\);

\wr_buffer~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \wr_buffer~output_o\);

\en_buffer~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|ALT_INV_WideOr3~combout\,
	devoe => ww_devoe,
	o => \en_buffer~output_o\);

\clc_buffer~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|ALT_INV_state.state_rst~q\,
	devoe => ww_devoe,
	o => \clc_buffer~output_o\);

\flag1~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|ALT_INV_state.state_rst~q\,
	devoe => ww_devoe,
	o => \flag1~output_o\);

\flagEND~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|state.state_7~q\,
	devoe => ww_devoe,
	o => \flagEND~output_o\);

\addressMemBuffer[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|AddressMempulse[5]~2_combout\,
	devoe => ww_devoe,
	o => \addressMemBuffer[5]~output_o\);

\addressMemBuffer[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|AddressMempulse[4]~6_combout\,
	devoe => ww_devoe,
	o => \addressMemBuffer[4]~output_o\);

\addressMemBuffer[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|AddressMempulse[3]~10_combout\,
	devoe => ww_devoe,
	o => \addressMemBuffer[3]~output_o\);

\addressMemBuffer[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|AddressMempulse[2]~14_combout\,
	devoe => ww_devoe,
	o => \addressMemBuffer[2]~output_o\);

\addressMemBuffer[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|AddressMempulse[1]~18_combout\,
	devoe => ww_devoe,
	o => \addressMemBuffer[1]~output_o\);

\addressMemBuffer[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|AddressMempulse[0]~22_combout\,
	devoe => ww_devoe,
	o => \addressMemBuffer[0]~output_o\);

\ctrlBuffer[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|WideOr4~combout\,
	devoe => ww_devoe,
	o => \ctrlBuffer[7]~output_o\);

\ctrlBuffer[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ctrlBuffer[6]~output_o\);

\ctrlBuffer[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|state.state_5~q\,
	devoe => ww_devoe,
	o => \ctrlBuffer[5]~output_o\);

\ctrlBuffer[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|state.state_5~q\,
	devoe => ww_devoe,
	o => \ctrlBuffer[4]~output_o\);

\ctrlBuffer[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ctrlBuffer[3]~output_o\);

\ctrlBuffer[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ctrlBuffer[2]~output_o\);

\ctrlBuffer[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ctrlBuffer[1]~output_o\);

\ctrlBuffer[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \ctrlBuffer[0]~output_o\);

\clk~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

\start~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_start,
	o => \start~input_o\);

\inst|state.state_rst~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|state.state_rst~0_combout\ = (\start~input_o\) # (\inst|state.state_rst~q\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0111011101110111011101110111011101110111011101110111011101110111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_state.state_rst~q\,
	datab => \ALT_INV_start~input_o\,
	combout => \inst|state.state_rst~0_combout\);

\rst_n~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rst_n,
	o => \rst_n~input_o\);

\inst|state.state_rst\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|state.state_rst~0_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|state.state_rst~q\);

\bufferEndFlag~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_bufferEndFlag,
	o => \bufferEndFlag~input_o\);

\inst|state.state_2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|state.state_1~q\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|state.state_2~q\);

\inst|state.state_3\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|state.state_2~q\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|state.state_3~q\);

\inst|state.state_4\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|state.state_3~q\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|state.state_4~q\);

\endProgram[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(1),
	o => \endProgram[1]~input_o\);

\endProgram[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(0),
	o => \endProgram[0]~input_o\);

\inst|Equal0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|Equal0~0_combout\ = (\endProgram[1]~input_o\ & \endProgram[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001000100010001000100010001000100010001000100010001000100010001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_endProgram[1]~input_o\,
	datab => \ALT_INV_endProgram[0]~input_o\,
	combout => \inst|Equal0~0_combout\);

\endProgram[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(7),
	o => \endProgram[7]~input_o\);

\endProgram[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(6),
	o => \endProgram[6]~input_o\);

\endProgram[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(5),
	o => \endProgram[5]~input_o\);

\endProgram[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(4),
	o => \endProgram[4]~input_o\);

\endProgram[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(3),
	o => \endProgram[3]~input_o\);

\endProgram[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(2),
	o => \endProgram[2]~input_o\);

\inst|Equal0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|Equal0~1_combout\ = ( \endProgram[3]~input_o\ & ( \endProgram[2]~input_o\ & ( (\endProgram[7]~input_o\ & (\endProgram[6]~input_o\ & (\endProgram[5]~input_o\ & \endProgram[4]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_endProgram[7]~input_o\,
	datab => \ALT_INV_endProgram[6]~input_o\,
	datac => \ALT_INV_endProgram[5]~input_o\,
	datad => \ALT_INV_endProgram[4]~input_o\,
	datae => \ALT_INV_endProgram[3]~input_o\,
	dataf => \ALT_INV_endProgram[2]~input_o\,
	combout => \inst|Equal0~1_combout\);

\endProgram[13]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(13),
	o => \endProgram[13]~input_o\);

\endProgram[12]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(12),
	o => \endProgram[12]~input_o\);

\endProgram[11]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(11),
	o => \endProgram[11]~input_o\);

\endProgram[10]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(10),
	o => \endProgram[10]~input_o\);

\endProgram[9]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(9),
	o => \endProgram[9]~input_o\);

\endProgram[8]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(8),
	o => \endProgram[8]~input_o\);

\inst|Equal0~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|Equal0~2_combout\ = ( \endProgram[9]~input_o\ & ( \endProgram[8]~input_o\ & ( (\endProgram[13]~input_o\ & (\endProgram[12]~input_o\ & (\endProgram[11]~input_o\ & \endProgram[10]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_endProgram[13]~input_o\,
	datab => \ALT_INV_endProgram[12]~input_o\,
	datac => \ALT_INV_endProgram[11]~input_o\,
	datad => \ALT_INV_endProgram[10]~input_o\,
	datae => \ALT_INV_endProgram[9]~input_o\,
	dataf => \ALT_INV_endProgram[8]~input_o\,
	combout => \inst|Equal0~2_combout\);

\endProgram[19]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(19),
	o => \endProgram[19]~input_o\);

\endProgram[18]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(18),
	o => \endProgram[18]~input_o\);

\endProgram[17]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(17),
	o => \endProgram[17]~input_o\);

\endProgram[16]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(16),
	o => \endProgram[16]~input_o\);

\endProgram[15]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(15),
	o => \endProgram[15]~input_o\);

\endProgram[14]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(14),
	o => \endProgram[14]~input_o\);

\inst|Equal0~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|Equal0~3_combout\ = ( \endProgram[15]~input_o\ & ( \endProgram[14]~input_o\ & ( (\endProgram[19]~input_o\ & (\endProgram[18]~input_o\ & (\endProgram[17]~input_o\ & \endProgram[16]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_endProgram[19]~input_o\,
	datab => \ALT_INV_endProgram[18]~input_o\,
	datac => \ALT_INV_endProgram[17]~input_o\,
	datad => \ALT_INV_endProgram[16]~input_o\,
	datae => \ALT_INV_endProgram[15]~input_o\,
	dataf => \ALT_INV_endProgram[14]~input_o\,
	combout => \inst|Equal0~3_combout\);

\endProgram[31]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(31),
	o => \endProgram[31]~input_o\);

\endProgram[30]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(30),
	o => \endProgram[30]~input_o\);

\endProgram[29]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(29),
	o => \endProgram[29]~input_o\);

\endProgram[28]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(28),
	o => \endProgram[28]~input_o\);

\endProgram[27]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(27),
	o => \endProgram[27]~input_o\);

\endProgram[26]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(26),
	o => \endProgram[26]~input_o\);

\inst|Equal0~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|Equal0~4_combout\ = ( \endProgram[27]~input_o\ & ( \endProgram[26]~input_o\ & ( (\endProgram[31]~input_o\ & (\endProgram[30]~input_o\ & (\endProgram[29]~input_o\ & \endProgram[28]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_endProgram[31]~input_o\,
	datab => \ALT_INV_endProgram[30]~input_o\,
	datac => \ALT_INV_endProgram[29]~input_o\,
	datad => \ALT_INV_endProgram[28]~input_o\,
	datae => \ALT_INV_endProgram[27]~input_o\,
	dataf => \ALT_INV_endProgram[26]~input_o\,
	combout => \inst|Equal0~4_combout\);

\endProgram[25]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(25),
	o => \endProgram[25]~input_o\);

\endProgram[24]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(24),
	o => \endProgram[24]~input_o\);

\endProgram[23]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(23),
	o => \endProgram[23]~input_o\);

\endProgram[22]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(22),
	o => \endProgram[22]~input_o\);

\endProgram[21]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(21),
	o => \endProgram[21]~input_o\);

\endProgram[20]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_endProgram(20),
	o => \endProgram[20]~input_o\);

\inst|Equal0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|Equal0~5_combout\ = ( \endProgram[21]~input_o\ & ( \endProgram[20]~input_o\ & ( (\endProgram[25]~input_o\ & (\endProgram[24]~input_o\ & (\endProgram[23]~input_o\ & \endProgram[22]~input_o\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_endProgram[25]~input_o\,
	datab => \ALT_INV_endProgram[24]~input_o\,
	datac => \ALT_INV_endProgram[23]~input_o\,
	datad => \ALT_INV_endProgram[22]~input_o\,
	datae => \ALT_INV_endProgram[21]~input_o\,
	dataf => \ALT_INV_endProgram[20]~input_o\,
	combout => \inst|Equal0~5_combout\);

\inst|Equal0~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|Equal0~6_combout\ = ( \inst|Equal0~4_combout\ & ( \inst|Equal0~5_combout\ & ( (\inst|Equal0~0_combout\ & (\inst|Equal0~1_combout\ & (\inst|Equal0~2_combout\ & \inst|Equal0~3_combout\))) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_Equal0~0_combout\,
	datab => \inst|ALT_INV_Equal0~1_combout\,
	datac => \inst|ALT_INV_Equal0~2_combout\,
	datad => \inst|ALT_INV_Equal0~3_combout\,
	datae => \inst|ALT_INV_Equal0~4_combout\,
	dataf => \inst|ALT_INV_Equal0~5_combout\,
	combout => \inst|Equal0~6_combout\);

\inst|Selector1~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|Selector1~0_combout\ = (!\inst|state.state_5~q\ & (((\inst|state.state_4~q\ & !\inst|Equal0~6_combout\)))) # (\inst|state.state_5~q\ & ((!\bufferEndFlag~input_o\) # ((\inst|state.state_4~q\ & !\inst|Equal0~6_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0100111101000100010011110100010001001111010001000100111101000100",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_state.state_5~q\,
	datab => \ALT_INV_bufferEndFlag~input_o\,
	datac => \inst|ALT_INV_state.state_4~q\,
	datad => \inst|ALT_INV_Equal0~6_combout\,
	combout => \inst|Selector1~0_combout\);

\inst|state.state_5\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|Selector1~0_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|state.state_5~q\);

\inst|state~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|state~13_combout\ = (\inst|state.state_5~q\ & \bufferEndFlag~input_o\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0001000100010001000100010001000100010001000100010001000100010001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_state.state_5~q\,
	datab => \ALT_INV_bufferEndFlag~input_o\,
	combout => \inst|state~13_combout\);

\inst|state.state_6\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|state~13_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|state.state_6~q\);

\inst|Selector0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|Selector0~0_combout\ = ((!\inst|state.state_rst~q\ & \start~input_o\)) # (\inst|state.state_6~q\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011101100111011001110110011101100111011001110110011101100111011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_state.state_rst~q\,
	datab => \inst|ALT_INV_state.state_6~q\,
	datac => \ALT_INV_start~input_o\,
	combout => \inst|Selector0~0_combout\);

\inst|state.state_1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|Selector0~0_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|state.state_1~q\);

\inst|state.state_7~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|state.state_7~0_combout\ = ((\inst|state.state_4~q\ & \inst|Equal0~6_combout\)) # (\inst|state.state_7~q\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101011101010111010101110101011101010111010101110101011101010111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_state.state_7~q\,
	datab => \inst|ALT_INV_state.state_4~q\,
	datac => \inst|ALT_INV_Equal0~6_combout\,
	combout => \inst|state.state_7~0_combout\);

\inst|state.state_7\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|state.state_7~0_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|state.state_7~q\);

\inst|WideOr3\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|WideOr3~combout\ = (!\inst|state.state_rst~q\) # (((\inst|state.state_7~q\) # (\inst|state.state_6~q\)) # (\inst|state.state_1~q\))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1011111111111111101111111111111110111111111111111011111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_state.state_rst~q\,
	datab => \inst|ALT_INV_state.state_1~q\,
	datac => \inst|ALT_INV_state.state_6~q\,
	datad => \inst|ALT_INV_state.state_7~q\,
	combout => \inst|WideOr3~combout\);

\inst|countVarAddressPos[0]~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|countVarAddressPos[0]~6_combout\ = !\inst|state.state_6~q\ $ (!\inst|countVarAddressPos\(0))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0110011001100110011001100110011001100110011001100110011001100110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_state.state_6~q\,
	datab => \inst|ALT_INV_countVarAddressPos\(0),
	combout => \inst|countVarAddressPos[0]~6_combout\);

\inst|countVarAddressPos[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|countVarAddressPos[0]~6_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|countVarAddressPos\(0));

\inst|countVarAddressPos[1]~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|countVarAddressPos[1]~5_combout\ = !\inst|countVarAddressPos\(1) $ (((!\inst|state.state_6~q\) # (!\inst|countVarAddressPos\(0))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011011000110110001101100011011000110110001101100011011000110110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_state.state_6~q\,
	datab => \inst|ALT_INV_countVarAddressPos\(1),
	datac => \inst|ALT_INV_countVarAddressPos\(0),
	combout => \inst|countVarAddressPos[1]~5_combout\);

\inst|countVarAddressPos[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|countVarAddressPos[1]~5_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|countVarAddressPos\(1));

\inst|countVarAddressPos[2]~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|countVarAddressPos[2]~4_combout\ = !\inst|countVarAddressPos\(2) $ (((!\inst|state.state_6~q\) # ((!\inst|countVarAddressPos\(1)) # (!\inst|countVarAddressPos\(0)))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100110110001100110011011000110011001101100011001100110110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_state.state_6~q\,
	datab => \inst|ALT_INV_countVarAddressPos\(2),
	datac => \inst|ALT_INV_countVarAddressPos\(1),
	datad => \inst|ALT_INV_countVarAddressPos\(0),
	combout => \inst|countVarAddressPos[2]~4_combout\);

\inst|countVarAddressPos[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|countVarAddressPos[2]~4_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|countVarAddressPos\(2));

\inst|countVarAddressPos[3]~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|countVarAddressPos[3]~3_combout\ = ( \inst|countVarAddressPos\(0) & ( !\inst|countVarAddressPos\(3) $ (((!\inst|state.state_6~q\) # ((!\inst|countVarAddressPos\(2)) # (!\inst|countVarAddressPos\(1))))) ) ) # ( !\inst|countVarAddressPos\(0) & ( 
-- \inst|countVarAddressPos\(3) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100110011001100110011011000110011001100110011001100110110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_state.state_6~q\,
	datab => \inst|ALT_INV_countVarAddressPos\(3),
	datac => \inst|ALT_INV_countVarAddressPos\(2),
	datad => \inst|ALT_INV_countVarAddressPos\(1),
	datae => \inst|ALT_INV_countVarAddressPos\(0),
	combout => \inst|countVarAddressPos[3]~3_combout\);

\inst|countVarAddressPos[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|countVarAddressPos[3]~3_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|countVarAddressPos\(3));

\inst|countVarAddressPos[4]~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|countVarAddressPos[4]~2_combout\ = ( \inst|countVarAddressPos\(1) & ( \inst|countVarAddressPos\(0) & ( !\inst|countVarAddressPos\(4) $ (((!\inst|state.state_6~q\) # ((!\inst|countVarAddressPos\(3)) # (!\inst|countVarAddressPos\(2))))) ) ) ) # ( 
-- !\inst|countVarAddressPos\(1) & ( \inst|countVarAddressPos\(0) & ( \inst|countVarAddressPos\(4) ) ) ) # ( \inst|countVarAddressPos\(1) & ( !\inst|countVarAddressPos\(0) & ( \inst|countVarAddressPos\(4) ) ) ) # ( !\inst|countVarAddressPos\(1) & ( 
-- !\inst|countVarAddressPos\(0) & ( \inst|countVarAddressPos\(4) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0011001100110011001100110011001100110011001100110011001100110110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_state.state_6~q\,
	datab => \inst|ALT_INV_countVarAddressPos\(4),
	datac => \inst|ALT_INV_countVarAddressPos\(3),
	datad => \inst|ALT_INV_countVarAddressPos\(2),
	datae => \inst|ALT_INV_countVarAddressPos\(1),
	dataf => \inst|ALT_INV_countVarAddressPos\(0),
	combout => \inst|countVarAddressPos[4]~2_combout\);

\inst|countVarAddressPos[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|countVarAddressPos[4]~2_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|countVarAddressPos\(4));

\inst|countVarAddressPos[3]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|countVarAddressPos[3]~0_combout\ = (\inst|state.state_6~q\ & (\inst|countVarAddressPos\(2) & (\inst|countVarAddressPos\(1) & \inst|countVarAddressPos\(0))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000001000000000000000100000000000000010000000000000001",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_state.state_6~q\,
	datab => \inst|ALT_INV_countVarAddressPos\(2),
	datac => \inst|ALT_INV_countVarAddressPos\(1),
	datad => \inst|ALT_INV_countVarAddressPos\(0),
	combout => \inst|countVarAddressPos[3]~0_combout\);

\inst|countVarAddressPos[5]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|countVarAddressPos[5]~1_combout\ = !\inst|countVarAddressPos\(5) $ (((!\inst|countVarAddressPos\(4)) # ((!\inst|countVarAddressPos\(3)) # (!\inst|countVarAddressPos[3]~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010110010101010101011001010101010101100101010101010110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_countVarAddressPos\(5),
	datab => \inst|ALT_INV_countVarAddressPos\(4),
	datac => \inst|ALT_INV_countVarAddressPos\(3),
	datad => \inst|ALT_INV_countVarAddressPos[3]~0_combout\,
	combout => \inst|countVarAddressPos[5]~1_combout\);

\inst|countVarAddressPos[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|countVarAddressPos[5]~1_combout\,
	clrn => \rst_n~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|countVarAddressPos\(5));

\inst|AddressMempulse[5]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|AddressMempulse[5]~1_combout\ = ( \inst|AddressMempulse[5]~1_combout\ & ( \rst_n~input_o\ ) ) # ( \inst|AddressMempulse[5]~1_combout\ & ( !\rst_n~input_o\ & ( \inst|countVarAddressPos\(5) ) ) ) # ( !\inst|AddressMempulse[5]~1_combout\ & ( 
-- !\rst_n~input_o\ & ( \inst|countVarAddressPos\(5) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \inst|ALT_INV_countVarAddressPos\(5),
	datae => \inst|ALT_INV_AddressMempulse[5]~1_combout\,
	dataf => \ALT_INV_rst_n~input_o\,
	combout => \inst|AddressMempulse[5]~1_combout\);

\inst|AddressMempulse[5]~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|AddressMempulse[5]~3_combout\ = !\inst|countVarAddressPos\(5) $ (!\inst|AddressMempulse[5]~1_combout\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0110011001100110011001100110011001100110011001100110011001100110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_countVarAddressPos\(5),
	datab => \inst|ALT_INV_AddressMempulse[5]~1_combout\,
	combout => \inst|AddressMempulse[5]~3_combout\);

\inst|AddressMempulse[5]~_emulated\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|AddressMempulse[5]~3_combout\,
	clrn => \rst_n~input_o\,
	ena => \inst|state.state_1~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|AddressMempulse[5]~_emulated_q\);

\inst|AddressMempulse[5]~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|AddressMempulse[5]~2_combout\ = (!\rst_n~input_o\ & (((\inst|countVarAddressPos\(5))))) # (\rst_n~input_o\ & (!\inst|AddressMempulse[5]~_emulated_q\ $ ((!\inst|AddressMempulse[5]~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000011011110110000001101111011000000110111101100000011011110110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_AddressMempulse[5]~_emulated_q\,
	datab => \inst|ALT_INV_AddressMempulse[5]~1_combout\,
	datac => \ALT_INV_rst_n~input_o\,
	datad => \inst|ALT_INV_countVarAddressPos\(5),
	combout => \inst|AddressMempulse[5]~2_combout\);

\inst|AddressMempulse[4]~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|AddressMempulse[4]~5_combout\ = ( \inst|AddressMempulse[4]~5_combout\ & ( \rst_n~input_o\ ) ) # ( \inst|AddressMempulse[4]~5_combout\ & ( !\rst_n~input_o\ & ( \inst|countVarAddressPos\(4) ) ) ) # ( !\inst|AddressMempulse[4]~5_combout\ & ( 
-- !\rst_n~input_o\ & ( \inst|countVarAddressPos\(4) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \inst|ALT_INV_countVarAddressPos\(4),
	datae => \inst|ALT_INV_AddressMempulse[4]~5_combout\,
	dataf => \ALT_INV_rst_n~input_o\,
	combout => \inst|AddressMempulse[4]~5_combout\);

\inst|AddressMempulse[4]~7\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|AddressMempulse[4]~7_combout\ = !\inst|countVarAddressPos\(4) $ (!\inst|AddressMempulse[4]~5_combout\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0110011001100110011001100110011001100110011001100110011001100110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_countVarAddressPos\(4),
	datab => \inst|ALT_INV_AddressMempulse[4]~5_combout\,
	combout => \inst|AddressMempulse[4]~7_combout\);

\inst|AddressMempulse[4]~_emulated\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|AddressMempulse[4]~7_combout\,
	clrn => \rst_n~input_o\,
	ena => \inst|state.state_1~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|AddressMempulse[4]~_emulated_q\);

\inst|AddressMempulse[4]~6\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|AddressMempulse[4]~6_combout\ = (!\rst_n~input_o\ & (((\inst|countVarAddressPos\(4))))) # (\rst_n~input_o\ & (!\inst|AddressMempulse[4]~_emulated_q\ $ ((!\inst|AddressMempulse[4]~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000011011110110000001101111011000000110111101100000011011110110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_AddressMempulse[4]~_emulated_q\,
	datab => \inst|ALT_INV_AddressMempulse[4]~5_combout\,
	datac => \ALT_INV_rst_n~input_o\,
	datad => \inst|ALT_INV_countVarAddressPos\(4),
	combout => \inst|AddressMempulse[4]~6_combout\);

\inst|AddressMempulse[3]~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|AddressMempulse[3]~9_combout\ = ( \inst|AddressMempulse[3]~9_combout\ & ( \rst_n~input_o\ ) ) # ( \inst|AddressMempulse[3]~9_combout\ & ( !\rst_n~input_o\ & ( \inst|countVarAddressPos\(3) ) ) ) # ( !\inst|AddressMempulse[3]~9_combout\ & ( 
-- !\rst_n~input_o\ & ( \inst|countVarAddressPos\(3) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \inst|ALT_INV_countVarAddressPos\(3),
	datae => \inst|ALT_INV_AddressMempulse[3]~9_combout\,
	dataf => \ALT_INV_rst_n~input_o\,
	combout => \inst|AddressMempulse[3]~9_combout\);

\inst|AddressMempulse[3]~11\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|AddressMempulse[3]~11_combout\ = !\inst|countVarAddressPos\(3) $ (!\inst|AddressMempulse[3]~9_combout\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0110011001100110011001100110011001100110011001100110011001100110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_countVarAddressPos\(3),
	datab => \inst|ALT_INV_AddressMempulse[3]~9_combout\,
	combout => \inst|AddressMempulse[3]~11_combout\);

\inst|AddressMempulse[3]~_emulated\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|AddressMempulse[3]~11_combout\,
	clrn => \rst_n~input_o\,
	ena => \inst|state.state_1~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|AddressMempulse[3]~_emulated_q\);

\inst|AddressMempulse[3]~10\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|AddressMempulse[3]~10_combout\ = (!\rst_n~input_o\ & (((\inst|countVarAddressPos\(3))))) # (\rst_n~input_o\ & (!\inst|AddressMempulse[3]~_emulated_q\ $ ((!\inst|AddressMempulse[3]~9_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000011011110110000001101111011000000110111101100000011011110110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_AddressMempulse[3]~_emulated_q\,
	datab => \inst|ALT_INV_AddressMempulse[3]~9_combout\,
	datac => \ALT_INV_rst_n~input_o\,
	datad => \inst|ALT_INV_countVarAddressPos\(3),
	combout => \inst|AddressMempulse[3]~10_combout\);

\inst|AddressMempulse[2]~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|AddressMempulse[2]~13_combout\ = ( \inst|AddressMempulse[2]~13_combout\ & ( \rst_n~input_o\ ) ) # ( \inst|AddressMempulse[2]~13_combout\ & ( !\rst_n~input_o\ & ( \inst|countVarAddressPos\(2) ) ) ) # ( !\inst|AddressMempulse[2]~13_combout\ & ( 
-- !\rst_n~input_o\ & ( \inst|countVarAddressPos\(2) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \inst|ALT_INV_countVarAddressPos\(2),
	datae => \inst|ALT_INV_AddressMempulse[2]~13_combout\,
	dataf => \ALT_INV_rst_n~input_o\,
	combout => \inst|AddressMempulse[2]~13_combout\);

\inst|AddressMempulse[2]~15\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|AddressMempulse[2]~15_combout\ = !\inst|countVarAddressPos\(2) $ (!\inst|AddressMempulse[2]~13_combout\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0110011001100110011001100110011001100110011001100110011001100110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_countVarAddressPos\(2),
	datab => \inst|ALT_INV_AddressMempulse[2]~13_combout\,
	combout => \inst|AddressMempulse[2]~15_combout\);

\inst|AddressMempulse[2]~_emulated\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|AddressMempulse[2]~15_combout\,
	clrn => \rst_n~input_o\,
	ena => \inst|state.state_1~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|AddressMempulse[2]~_emulated_q\);

\inst|AddressMempulse[2]~14\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|AddressMempulse[2]~14_combout\ = (!\rst_n~input_o\ & (((\inst|countVarAddressPos\(2))))) # (\rst_n~input_o\ & (!\inst|AddressMempulse[2]~_emulated_q\ $ ((!\inst|AddressMempulse[2]~13_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000011011110110000001101111011000000110111101100000011011110110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_AddressMempulse[2]~_emulated_q\,
	datab => \inst|ALT_INV_AddressMempulse[2]~13_combout\,
	datac => \ALT_INV_rst_n~input_o\,
	datad => \inst|ALT_INV_countVarAddressPos\(2),
	combout => \inst|AddressMempulse[2]~14_combout\);

\inst|AddressMempulse[1]~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|AddressMempulse[1]~17_combout\ = ( \inst|AddressMempulse[1]~17_combout\ & ( \rst_n~input_o\ ) ) # ( \inst|AddressMempulse[1]~17_combout\ & ( !\rst_n~input_o\ & ( \inst|countVarAddressPos\(1) ) ) ) # ( !\inst|AddressMempulse[1]~17_combout\ & ( 
-- !\rst_n~input_o\ & ( \inst|countVarAddressPos\(1) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \inst|ALT_INV_countVarAddressPos\(1),
	datae => \inst|ALT_INV_AddressMempulse[1]~17_combout\,
	dataf => \ALT_INV_rst_n~input_o\,
	combout => \inst|AddressMempulse[1]~17_combout\);

\inst|AddressMempulse[1]~19\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|AddressMempulse[1]~19_combout\ = !\inst|countVarAddressPos\(1) $ (!\inst|AddressMempulse[1]~17_combout\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0110011001100110011001100110011001100110011001100110011001100110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_countVarAddressPos\(1),
	datab => \inst|ALT_INV_AddressMempulse[1]~17_combout\,
	combout => \inst|AddressMempulse[1]~19_combout\);

\inst|AddressMempulse[1]~_emulated\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|AddressMempulse[1]~19_combout\,
	clrn => \rst_n~input_o\,
	ena => \inst|state.state_1~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|AddressMempulse[1]~_emulated_q\);

\inst|AddressMempulse[1]~18\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|AddressMempulse[1]~18_combout\ = (!\rst_n~input_o\ & (((\inst|countVarAddressPos\(1))))) # (\rst_n~input_o\ & (!\inst|AddressMempulse[1]~_emulated_q\ $ ((!\inst|AddressMempulse[1]~17_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000011011110110000001101111011000000110111101100000011011110110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_AddressMempulse[1]~_emulated_q\,
	datab => \inst|ALT_INV_AddressMempulse[1]~17_combout\,
	datac => \ALT_INV_rst_n~input_o\,
	datad => \inst|ALT_INV_countVarAddressPos\(1),
	combout => \inst|AddressMempulse[1]~18_combout\);

\inst|AddressMempulse[0]~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|AddressMempulse[0]~21_combout\ = ( \inst|AddressMempulse[0]~21_combout\ & ( \rst_n~input_o\ ) ) # ( \inst|AddressMempulse[0]~21_combout\ & ( !\rst_n~input_o\ & ( \inst|countVarAddressPos\(0) ) ) ) # ( !\inst|AddressMempulse[0]~21_combout\ & ( 
-- !\rst_n~input_o\ & ( \inst|countVarAddressPos\(0) ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111000000001111111100000000000000001111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => \inst|ALT_INV_countVarAddressPos\(0),
	datae => \inst|ALT_INV_AddressMempulse[0]~21_combout\,
	dataf => \ALT_INV_rst_n~input_o\,
	combout => \inst|AddressMempulse[0]~21_combout\);

\inst|AddressMempulse[0]~23\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|AddressMempulse[0]~23_combout\ = !\inst|countVarAddressPos\(0) $ (!\inst|AddressMempulse[0]~21_combout\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0110011001100110011001100110011001100110011001100110011001100110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_countVarAddressPos\(0),
	datab => \inst|ALT_INV_AddressMempulse[0]~21_combout\,
	combout => \inst|AddressMempulse[0]~23_combout\);

\inst|AddressMempulse[0]~_emulated\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~input_o\,
	d => \inst|AddressMempulse[0]~23_combout\,
	clrn => \rst_n~input_o\,
	ena => \inst|state.state_1~q\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \inst|AddressMempulse[0]~_emulated_q\);

\inst|AddressMempulse[0]~22\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|AddressMempulse[0]~22_combout\ = (!\rst_n~input_o\ & (((\inst|countVarAddressPos\(0))))) # (\rst_n~input_o\ & (!\inst|AddressMempulse[0]~_emulated_q\ $ ((!\inst|AddressMempulse[0]~21_combout\))))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000011011110110000001101111011000000110111101100000011011110110",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_AddressMempulse[0]~_emulated_q\,
	datab => \inst|ALT_INV_AddressMempulse[0]~21_combout\,
	datac => \ALT_INV_rst_n~input_o\,
	datad => \inst|ALT_INV_countVarAddressPos\(0),
	combout => \inst|AddressMempulse[0]~22_combout\);

\inst|WideOr4\ : cyclonev_lcell_comb
-- Equation(s):
-- \inst|WideOr4~combout\ = ((\inst|state.state_5~q\) # (\inst|state.state_7~q\)) # (\inst|state.state_6~q\)

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0111111101111111011111110111111101111111011111110111111101111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \inst|ALT_INV_state.state_6~q\,
	datab => \inst|ALT_INV_state.state_7~q\,
	datac => \inst|ALT_INV_state.state_5~q\,
	combout => \inst|WideOr4~combout\);

ww_rd_buffer <= \rd_buffer~output_o\;

ww_wr_buffer <= \wr_buffer~output_o\;

ww_en_buffer <= \en_buffer~output_o\;

ww_clc_buffer <= \clc_buffer~output_o\;

ww_flag1 <= \flag1~output_o\;

ww_flagEND <= \flagEND~output_o\;

ww_addressMemBuffer(5) <= \addressMemBuffer[5]~output_o\;

ww_addressMemBuffer(4) <= \addressMemBuffer[4]~output_o\;

ww_addressMemBuffer(3) <= \addressMemBuffer[3]~output_o\;

ww_addressMemBuffer(2) <= \addressMemBuffer[2]~output_o\;

ww_addressMemBuffer(1) <= \addressMemBuffer[1]~output_o\;

ww_addressMemBuffer(0) <= \addressMemBuffer[0]~output_o\;

ww_ctrlBuffer(7) <= \ctrlBuffer[7]~output_o\;

ww_ctrlBuffer(6) <= \ctrlBuffer[6]~output_o\;

ww_ctrlBuffer(5) <= \ctrlBuffer[5]~output_o\;

ww_ctrlBuffer(4) <= \ctrlBuffer[4]~output_o\;

ww_ctrlBuffer(3) <= \ctrlBuffer[3]~output_o\;

ww_ctrlBuffer(2) <= \ctrlBuffer[2]~output_o\;

ww_ctrlBuffer(1) <= \ctrlBuffer[1]~output_o\;

ww_ctrlBuffer(0) <= \ctrlBuffer[0]~output_o\;
END structure;


