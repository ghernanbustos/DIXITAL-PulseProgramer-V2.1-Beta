-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 22.1std (Release Build #917)
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2023 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from fir_ip_bank_rtl_core
-- VHDL created on Thu Sep 26 18:26:59 2024


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity fir_ip_bank_rtl_core is
    port (
        xIn_v : in std_logic_vector(0 downto 0);  -- sfix1
        xIn_c : in std_logic_vector(7 downto 0);  -- sfix8
        xIn_0 : in std_logic_vector(12 downto 0);  -- sfix13
        bankIn_0 : in std_logic_vector(1 downto 0);  -- sfix2
        xOut_v : out std_logic_vector(0 downto 0);  -- ufix1
        xOut_c : out std_logic_vector(7 downto 0);  -- ufix8
        xOut_0 : out std_logic_vector(30 downto 0);  -- sfix31
        clk : in std_logic;
        areset : in std_logic
    );
end fir_ip_bank_rtl_core;

architecture normal of fir_ip_bank_rtl_core is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_memread_q_12_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_12_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_15_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr1_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr2_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr3_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr4_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr5_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr6_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr7_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr8_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr9_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr10_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr11_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr12_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr13_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr14_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr15_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr16_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr17_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr18_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr19_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr20_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr21_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr22_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr23_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr24_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr25_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr26_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr27_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr28_q : STD_LOGIC_VECTOR (12 downto 0);
    signal d_u0_m0_wo0_wi0_r0_delayr28_q_12_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr29_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr30_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr31_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr32_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr33_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr34_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr35_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_delayr36_q : STD_LOGIC_VECTOR (12 downto 0);
    signal d_u0_m0_wo0_bank_phasedelay0_q_12_q : STD_LOGIC_VECTOR (1 downto 0);
    signal d_u0_m0_wo0_bank_delayr1_q_12_q : STD_LOGIC_VECTOR (1 downto 0);
    signal d_u0_m0_wo0_bank_delayr2_q_12_q : STD_LOGIC_VECTOR (1 downto 0);
    signal d_u0_m0_wo0_bank_delayr3_q_12_q : STD_LOGIC_VECTOR (1 downto 0);
    signal d_u0_m0_wo0_bank_delayr4_q_12_q : STD_LOGIC_VECTOR (1 downto 0);
    signal d_u0_m0_wo0_bank_delayr5_q_12_q : STD_LOGIC_VECTOR (1 downto 0);
    signal d_u0_m0_wo0_bank_delayr6_q_12_q : STD_LOGIC_VECTOR (1 downto 0);
    signal d_u0_m0_wo0_bank_delayr7_q_12_q : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_mtree_add0_0_a : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_0_b : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_0_o : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_0_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_1_a : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_1_b : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_1_o : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_1_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_2_a : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_2_b : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_2_o : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_2_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_3_a : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_3_b : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_3_o : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_3_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_4_a : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_4_b : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_4_o : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add0_4_q : STD_LOGIC_VECTOR (27 downto 0);
    signal u0_m0_wo0_mtree_add1_0_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add1_0_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add1_0_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add1_0_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add1_1_a : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add1_1_b : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add1_1_o : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add1_1_q : STD_LOGIC_VECTOR (28 downto 0);
    signal u0_m0_wo0_mtree_add2_0_a : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add2_0_b : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add2_0_o : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add2_0_q : STD_LOGIC_VECTOR (29 downto 0);
    signal u0_m0_wo0_mtree_add3_0_a : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add3_0_b : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add3_0_o : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_mtree_add3_0_q : STD_LOGIC_VECTOR (30 downto 0);
    signal u0_m0_wo0_oseq_gated_reg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_cma_reset : std_logic;
    type u0_m0_wo0_mtree_mult1_0_cma_a0type is array(NATURAL range <>) of SIGNED(12 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_cma_a0 : u0_m0_wo0_mtree_mult1_0_cma_a0type(0 to 0);
    attribute preserve : boolean;
    attribute preserve of u0_m0_wo0_mtree_mult1_0_cma_a0 : signal is true;
    type u0_m0_wo0_mtree_mult1_0_cma_c0type is array(NATURAL range <>) of UNSIGNED(2 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_cma_c0 : u0_m0_wo0_mtree_mult1_0_cma_c0type(0 to 0);
    attribute preserve of u0_m0_wo0_mtree_mult1_0_cma_c0 : signal is true;
    type u0_m0_wo0_mtree_mult1_0_cma_rtype is array(NATURAL range <>) of SIGNED(11 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_cma_r : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 0);
    type u0_m0_wo0_mtree_mult1_0_cma_ptype is array(NATURAL range <>) of SIGNED(24 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_cma_p : u0_m0_wo0_mtree_mult1_0_cma_ptype(0 to 0);
    signal u0_m0_wo0_mtree_mult1_0_cma_u : u0_m0_wo0_mtree_mult1_0_cma_ptype(0 to 0);
    signal u0_m0_wo0_mtree_mult1_0_cma_w : u0_m0_wo0_mtree_mult1_0_cma_ptype(0 to 0);
    signal u0_m0_wo0_mtree_mult1_0_cma_x : u0_m0_wo0_mtree_mult1_0_cma_ptype(0 to 0);
    signal u0_m0_wo0_mtree_mult1_0_cma_y : u0_m0_wo0_mtree_mult1_0_cma_ptype(0 to 0);
    signal u0_m0_wo0_mtree_mult1_0_cma_k0 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-13,12),
        2 => TO_SIGNED(155,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_mult1_0_cma_s : u0_m0_wo0_mtree_mult1_0_cma_ptype(0 to 0);
    signal u0_m0_wo0_mtree_mult1_0_cma_qq : STD_LOGIC_VECTOR (24 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_cma_q : STD_LOGIC_VECTOR (24 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_cma_ena0 : std_logic;
    signal u0_m0_wo0_mtree_mult1_0_cma_ena1 : std_logic;
    signal u0_m0_wo0_mtree_madd4_9_cma_reset : std_logic;
    signal u0_m0_wo0_mtree_madd4_9_cma_a0 : u0_m0_wo0_mtree_mult1_0_cma_a0type(0 to 3);
    attribute preserve of u0_m0_wo0_mtree_madd4_9_cma_a0 : signal is true;
    signal u0_m0_wo0_mtree_madd4_9_cma_c0 : u0_m0_wo0_mtree_mult1_0_cma_c0type(0 to 3);
    attribute preserve of u0_m0_wo0_mtree_madd4_9_cma_c0 : signal is true;
    signal u0_m0_wo0_mtree_madd4_9_cma_r : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_9_cma_p : u0_m0_wo0_mtree_mult1_0_cma_ptype(0 to 3);
    type u0_m0_wo0_mtree_madd4_9_cma_utype is array(NATURAL range <>) of SIGNED(26 downto 0);
    signal u0_m0_wo0_mtree_madd4_9_cma_u : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_9_cma_w : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 1);
    signal u0_m0_wo0_mtree_madd4_9_cma_x : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_9_cma_y : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_9_cma_k0 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-13,12),
        2 => TO_SIGNED(155,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_9_cma_k1 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(6,12),
        1 => TO_SIGNED(-15,12),
        2 => TO_SIGNED(169,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_9_cma_k2 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-12,12),
        2 => TO_SIGNED(211,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_9_cma_k3 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(-12,12),
        1 => TO_SIGNED(0,12),
        2 => TO_SIGNED(279,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_9_cma_s : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_9_cma_qq : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_madd4_9_cma_q : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_madd4_9_cma_ena0 : std_logic;
    signal u0_m0_wo0_mtree_madd4_9_cma_ena1 : std_logic;
    signal u0_m0_wo0_mtree_madd4_8_cma_reset : std_logic;
    signal u0_m0_wo0_mtree_madd4_8_cma_a0 : u0_m0_wo0_mtree_mult1_0_cma_a0type(0 to 3);
    attribute preserve of u0_m0_wo0_mtree_madd4_8_cma_a0 : signal is true;
    signal u0_m0_wo0_mtree_madd4_8_cma_c0 : u0_m0_wo0_mtree_mult1_0_cma_c0type(0 to 3);
    attribute preserve of u0_m0_wo0_mtree_madd4_8_cma_c0 : signal is true;
    signal u0_m0_wo0_mtree_madd4_8_cma_r : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_8_cma_p : u0_m0_wo0_mtree_mult1_0_cma_ptype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_8_cma_u : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_8_cma_w : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 1);
    signal u0_m0_wo0_mtree_madd4_8_cma_x : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_8_cma_y : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_8_cma_k0 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(25,12),
        2 => TO_SIGNED(371,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_8_cma_k1 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(24,12),
        1 => TO_SIGNED(58,12),
        2 => TO_SIGNED(486,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_8_cma_k2 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(80,12),
        2 => TO_SIGNED(619,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_8_cma_k3 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(-45,12),
        1 => TO_SIGNED(66,12),
        2 => TO_SIGNED(767,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_8_cma_s : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_8_cma_qq : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_madd4_8_cma_q : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_madd4_8_cma_ena0 : std_logic;
    signal u0_m0_wo0_mtree_madd4_8_cma_ena1 : std_logic;
    signal u0_m0_wo0_mtree_madd4_7_cma_reset : std_logic;
    signal u0_m0_wo0_mtree_madd4_7_cma_a0 : u0_m0_wo0_mtree_mult1_0_cma_a0type(0 to 3);
    attribute preserve of u0_m0_wo0_mtree_madd4_7_cma_a0 : signal is true;
    signal u0_m0_wo0_mtree_madd4_7_cma_c0 : u0_m0_wo0_mtree_mult1_0_cma_c0type(0 to 3);
    attribute preserve of u0_m0_wo0_mtree_madd4_7_cma_c0 : signal is true;
    signal u0_m0_wo0_mtree_madd4_7_cma_r : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_7_cma_p : u0_m0_wo0_mtree_mult1_0_cma_ptype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_7_cma_u : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_7_cma_w : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 1);
    signal u0_m0_wo0_mtree_madd4_7_cma_x : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_7_cma_y : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_7_cma_k0 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(0,12),
        2 => TO_SIGNED(926,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_7_cma_k1 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(78,12),
        1 => TO_SIGNED(-114,12),
        2 => TO_SIGNED(1090,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_7_cma_k2 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-240,12),
        2 => TO_SIGNED(1255,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_7_cma_k3 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(-129,12),
        1 => TO_SIGNED(-308,12),
        2 => TO_SIGNED(1415,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_7_cma_s : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_7_cma_qq : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_madd4_7_cma_q : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_madd4_7_cma_ena0 : std_logic;
    signal u0_m0_wo0_mtree_madd4_7_cma_ena1 : std_logic;
    signal u0_m0_wo0_mtree_madd4_6_cma_reset : std_logic;
    signal u0_m0_wo0_mtree_madd4_6_cma_a0 : u0_m0_wo0_mtree_mult1_0_cma_a0type(0 to 3);
    attribute preserve of u0_m0_wo0_mtree_madd4_6_cma_a0 : signal is true;
    signal u0_m0_wo0_mtree_madd4_6_cma_c0 : u0_m0_wo0_mtree_mult1_0_cma_c0type(0 to 3);
    attribute preserve of u0_m0_wo0_mtree_madd4_6_cma_c0 : signal is true;
    signal u0_m0_wo0_mtree_madd4_6_cma_r : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_6_cma_p : u0_m0_wo0_mtree_mult1_0_cma_ptype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_6_cma_u : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_6_cma_w : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 1);
    signal u0_m0_wo0_mtree_madd4_6_cma_x : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_6_cma_y : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_6_cma_k0 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-245,12),
        2 => TO_SIGNED(1566,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_6_cma_k1 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(217,12),
        1 => TO_SIGNED(0,12),
        2 => TO_SIGNED(1703,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_6_cma_k2 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(427,12),
        2 => TO_SIGNED(1821,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_6_cma_k3 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(-407,12),
        1 => TO_SIGNED(969,12),
        2 => TO_SIGNED(1918,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_6_cma_s : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_6_cma_qq : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_madd4_6_cma_q : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_madd4_6_cma_ena0 : std_logic;
    signal u0_m0_wo0_mtree_madd4_6_cma_ena1 : std_logic;
    signal u0_m0_wo0_mtree_madd4_5_cma_reset : std_logic;
    signal u0_m0_wo0_mtree_madd4_5_cma_a0 : u0_m0_wo0_mtree_mult1_0_cma_a0type(0 to 3);
    attribute preserve of u0_m0_wo0_mtree_madd4_5_cma_a0 : signal is true;
    signal u0_m0_wo0_mtree_madd4_5_cma_c0 : u0_m0_wo0_mtree_mult1_0_cma_c0type(0 to 3);
    attribute preserve of u0_m0_wo0_mtree_madd4_5_cma_c0 : signal is true;
    signal u0_m0_wo0_mtree_madd4_5_cma_r : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_5_cma_p : u0_m0_wo0_mtree_mult1_0_cma_ptype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_5_cma_u : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_5_cma_w : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 1);
    signal u0_m0_wo0_mtree_madd4_5_cma_x : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_5_cma_y : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_5_cma_k0 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(1506,12),
        2 => TO_SIGNED(1988,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_5_cma_k1 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(1294,12),
        1 => TO_SIGNED(1901,12),
        2 => TO_SIGNED(2032,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_5_cma_k2 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(2046,12),
        1 => TO_SIGNED(2047,12),
        2 => TO_SIGNED(2047,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_5_cma_k3 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(1294,12),
        1 => TO_SIGNED(1901,12),
        2 => TO_SIGNED(2032,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_5_cma_s : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_5_cma_qq : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_madd4_5_cma_q : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_madd4_5_cma_ena0 : std_logic;
    signal u0_m0_wo0_mtree_madd4_5_cma_ena1 : std_logic;
    signal u0_m0_wo0_mtree_madd4_4_cma_reset : std_logic;
    signal u0_m0_wo0_mtree_madd4_4_cma_a0 : u0_m0_wo0_mtree_mult1_0_cma_a0type(0 to 3);
    attribute preserve of u0_m0_wo0_mtree_madd4_4_cma_a0 : signal is true;
    signal u0_m0_wo0_mtree_madd4_4_cma_c0 : u0_m0_wo0_mtree_mult1_0_cma_c0type(0 to 3);
    attribute preserve of u0_m0_wo0_mtree_madd4_4_cma_c0 : signal is true;
    signal u0_m0_wo0_mtree_madd4_4_cma_r : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_4_cma_p : u0_m0_wo0_mtree_mult1_0_cma_ptype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_4_cma_u : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_4_cma_w : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 1);
    signal u0_m0_wo0_mtree_madd4_4_cma_x : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_4_cma_y : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_4_cma_k0 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(1506,12),
        2 => TO_SIGNED(1988,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_4_cma_k1 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(-407,12),
        1 => TO_SIGNED(969,12),
        2 => TO_SIGNED(1918,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_4_cma_k2 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(427,12),
        2 => TO_SIGNED(1821,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_4_cma_k3 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(217,12),
        1 => TO_SIGNED(0,12),
        2 => TO_SIGNED(1703,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_4_cma_s : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_4_cma_qq : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_madd4_4_cma_q : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_madd4_4_cma_ena0 : std_logic;
    signal u0_m0_wo0_mtree_madd4_4_cma_ena1 : std_logic;
    signal u0_m0_wo0_mtree_madd4_3_cma_reset : std_logic;
    signal u0_m0_wo0_mtree_madd4_3_cma_a0 : u0_m0_wo0_mtree_mult1_0_cma_a0type(0 to 3);
    attribute preserve of u0_m0_wo0_mtree_madd4_3_cma_a0 : signal is true;
    signal u0_m0_wo0_mtree_madd4_3_cma_c0 : u0_m0_wo0_mtree_mult1_0_cma_c0type(0 to 3);
    attribute preserve of u0_m0_wo0_mtree_madd4_3_cma_c0 : signal is true;
    signal u0_m0_wo0_mtree_madd4_3_cma_r : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_3_cma_p : u0_m0_wo0_mtree_mult1_0_cma_ptype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_3_cma_u : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_3_cma_w : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 1);
    signal u0_m0_wo0_mtree_madd4_3_cma_x : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_3_cma_y : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_3_cma_k0 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-245,12),
        2 => TO_SIGNED(1566,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_3_cma_k1 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(-129,12),
        1 => TO_SIGNED(-308,12),
        2 => TO_SIGNED(1415,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_3_cma_k2 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-240,12),
        2 => TO_SIGNED(1255,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_3_cma_k3 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(78,12),
        1 => TO_SIGNED(-114,12),
        2 => TO_SIGNED(1090,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_3_cma_s : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_3_cma_qq : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_madd4_3_cma_q : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_madd4_3_cma_ena0 : std_logic;
    signal u0_m0_wo0_mtree_madd4_3_cma_ena1 : std_logic;
    signal u0_m0_wo0_mtree_madd4_2_cma_reset : std_logic;
    signal u0_m0_wo0_mtree_madd4_2_cma_a0 : u0_m0_wo0_mtree_mult1_0_cma_a0type(0 to 3);
    attribute preserve of u0_m0_wo0_mtree_madd4_2_cma_a0 : signal is true;
    signal u0_m0_wo0_mtree_madd4_2_cma_c0 : u0_m0_wo0_mtree_mult1_0_cma_c0type(0 to 3);
    attribute preserve of u0_m0_wo0_mtree_madd4_2_cma_c0 : signal is true;
    signal u0_m0_wo0_mtree_madd4_2_cma_r : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_2_cma_p : u0_m0_wo0_mtree_mult1_0_cma_ptype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_2_cma_u : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_2_cma_w : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 1);
    signal u0_m0_wo0_mtree_madd4_2_cma_x : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_2_cma_y : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_2_cma_k0 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(0,12),
        2 => TO_SIGNED(926,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_2_cma_k1 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(-45,12),
        1 => TO_SIGNED(66,12),
        2 => TO_SIGNED(767,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_2_cma_k2 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(80,12),
        2 => TO_SIGNED(619,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_2_cma_k3 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(24,12),
        1 => TO_SIGNED(58,12),
        2 => TO_SIGNED(486,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_2_cma_s : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_2_cma_qq : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_madd4_2_cma_q : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_madd4_2_cma_ena0 : std_logic;
    signal u0_m0_wo0_mtree_madd4_2_cma_ena1 : std_logic;
    signal u0_m0_wo0_mtree_madd4_1_cma_reset : std_logic;
    signal u0_m0_wo0_mtree_madd4_1_cma_a0 : u0_m0_wo0_mtree_mult1_0_cma_a0type(0 to 3);
    attribute preserve of u0_m0_wo0_mtree_madd4_1_cma_a0 : signal is true;
    signal u0_m0_wo0_mtree_madd4_1_cma_c0 : u0_m0_wo0_mtree_mult1_0_cma_c0type(0 to 3);
    attribute preserve of u0_m0_wo0_mtree_madd4_1_cma_c0 : signal is true;
    signal u0_m0_wo0_mtree_madd4_1_cma_r : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_1_cma_p : u0_m0_wo0_mtree_mult1_0_cma_ptype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_1_cma_u : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 3);
    signal u0_m0_wo0_mtree_madd4_1_cma_w : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 1);
    signal u0_m0_wo0_mtree_madd4_1_cma_x : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_1_cma_y : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_1_cma_k0 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(25,12),
        2 => TO_SIGNED(371,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_1_cma_k1 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(-12,12),
        1 => TO_SIGNED(0,12),
        2 => TO_SIGNED(279,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_1_cma_k2 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-12,12),
        2 => TO_SIGNED(211,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_1_cma_k3 : u0_m0_wo0_mtree_mult1_0_cma_rtype(0 to 7) := (
        0 => TO_SIGNED(6,12),
        1 => TO_SIGNED(-15,12),
        2 => TO_SIGNED(169,12),
        others => (others => '0'));
    signal u0_m0_wo0_mtree_madd4_1_cma_s : u0_m0_wo0_mtree_madd4_9_cma_utype(0 to 0);
    signal u0_m0_wo0_mtree_madd4_1_cma_qq : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_madd4_1_cma_q : STD_LOGIC_VECTOR (26 downto 0);
    signal u0_m0_wo0_mtree_madd4_1_cma_ena0 : std_logic;
    signal u0_m0_wo0_mtree_madd4_1_cma_ena1 : std_logic;
    signal xIn_bankIn_0_q : STD_LOGIC_VECTOR (14 downto 0);
    signal out0_m0_wo0_lineup_select_delay_0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bank_u0_m0_wi0_wo0_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal bank_u0_m0_wi0_wo0_merged_bit_select_c : STD_LOGIC_VECTOR (12 downto 0);
    signal out0_m0_wo0_assign_id3_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)@0
    VCC_q <= "1";

    -- xIn_bankIn_0(BITJOIN,3)@10
    xIn_bankIn_0_q <= bankIn_0 & xIn_0;

    -- bank_u0_m0_wi0_wo0_merged_bit_select(BITSELECT,172)@10
    bank_u0_m0_wi0_wo0_merged_bit_select_b <= STD_LOGIC_VECTOR(xIn_bankIn_0_q(14 downto 13));
    bank_u0_m0_wi0_wo0_merged_bit_select_c <= STD_LOGIC_VECTOR(xIn_bankIn_0_q(12 downto 0));

    -- d_u0_m0_wo0_bank_delayr3_q_12(DELAY,180)@10 + 2
    d_u0_m0_wo0_bank_delayr3_q_12 : dspba_delay
    GENERIC MAP ( width => 2, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => bank_u0_m0_wi0_wo0_merged_bit_select_b, xout => d_u0_m0_wo0_bank_delayr3_q_12_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_memread_q_12(DELAY,173)@10 + 2
    d_u0_m0_wo0_memread_q_12 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => xIn_v, xout => d_u0_m0_wo0_memread_q_12_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_compute_q_12(DELAY,174)@10 + 2
    d_u0_m0_wo0_compute_q_12 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => xIn_v, xout => d_u0_m0_wo0_compute_q_12_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr1(DELAY,23)@10
    u0_m0_wo0_wi0_r0_delayr1 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => bank_u0_m0_wi0_wo0_merged_bit_select_c, xout => u0_m0_wo0_wi0_r0_delayr1_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr2(DELAY,24)@10
    u0_m0_wo0_wi0_r0_delayr2 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr1_q, xout => u0_m0_wo0_wi0_r0_delayr2_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr3(DELAY,25)@10
    u0_m0_wo0_wi0_r0_delayr3 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr2_q, xout => u0_m0_wo0_wi0_r0_delayr3_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr4(DELAY,26)@10
    u0_m0_wo0_wi0_r0_delayr4 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr3_q, xout => u0_m0_wo0_wi0_r0_delayr4_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr5(DELAY,27)@10
    u0_m0_wo0_wi0_r0_delayr5 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr4_q, xout => u0_m0_wo0_wi0_r0_delayr5_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr6(DELAY,28)@10
    u0_m0_wo0_wi0_r0_delayr6 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr5_q, xout => u0_m0_wo0_wi0_r0_delayr6_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr7(DELAY,29)@10
    u0_m0_wo0_wi0_r0_delayr7 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr6_q, xout => u0_m0_wo0_wi0_r0_delayr7_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr8(DELAY,30)@10
    u0_m0_wo0_wi0_r0_delayr8 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr7_q, xout => u0_m0_wo0_wi0_r0_delayr8_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr9(DELAY,31)@10
    u0_m0_wo0_wi0_r0_delayr9 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr8_q, xout => u0_m0_wo0_wi0_r0_delayr9_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr10(DELAY,32)@10
    u0_m0_wo0_wi0_r0_delayr10 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr9_q, xout => u0_m0_wo0_wi0_r0_delayr10_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr11(DELAY,33)@10
    u0_m0_wo0_wi0_r0_delayr11 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr10_q, xout => u0_m0_wo0_wi0_r0_delayr11_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr12(DELAY,34)@10
    u0_m0_wo0_wi0_r0_delayr12 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr11_q, xout => u0_m0_wo0_wi0_r0_delayr12_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr13(DELAY,35)@10
    u0_m0_wo0_wi0_r0_delayr13 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr12_q, xout => u0_m0_wo0_wi0_r0_delayr13_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr14(DELAY,36)@10
    u0_m0_wo0_wi0_r0_delayr14 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr13_q, xout => u0_m0_wo0_wi0_r0_delayr14_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr15(DELAY,37)@10
    u0_m0_wo0_wi0_r0_delayr15 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr14_q, xout => u0_m0_wo0_wi0_r0_delayr15_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr16(DELAY,38)@10
    u0_m0_wo0_wi0_r0_delayr16 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr15_q, xout => u0_m0_wo0_wi0_r0_delayr16_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr17(DELAY,39)@10
    u0_m0_wo0_wi0_r0_delayr17 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr16_q, xout => u0_m0_wo0_wi0_r0_delayr17_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr18(DELAY,40)@10
    u0_m0_wo0_wi0_r0_delayr18 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr17_q, xout => u0_m0_wo0_wi0_r0_delayr18_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr19(DELAY,41)@10
    u0_m0_wo0_wi0_r0_delayr19 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr18_q, xout => u0_m0_wo0_wi0_r0_delayr19_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr20(DELAY,42)@10
    u0_m0_wo0_wi0_r0_delayr20 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr19_q, xout => u0_m0_wo0_wi0_r0_delayr20_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr21(DELAY,43)@10
    u0_m0_wo0_wi0_r0_delayr21 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr20_q, xout => u0_m0_wo0_wi0_r0_delayr21_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr22(DELAY,44)@10
    u0_m0_wo0_wi0_r0_delayr22 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr21_q, xout => u0_m0_wo0_wi0_r0_delayr22_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr23(DELAY,45)@10
    u0_m0_wo0_wi0_r0_delayr23 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr22_q, xout => u0_m0_wo0_wi0_r0_delayr23_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr24(DELAY,46)@10
    u0_m0_wo0_wi0_r0_delayr24 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr23_q, xout => u0_m0_wo0_wi0_r0_delayr24_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr25(DELAY,47)@10
    u0_m0_wo0_wi0_r0_delayr25 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr24_q, xout => u0_m0_wo0_wi0_r0_delayr25_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr26(DELAY,48)@10
    u0_m0_wo0_wi0_r0_delayr26 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr25_q, xout => u0_m0_wo0_wi0_r0_delayr26_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr27(DELAY,49)@10
    u0_m0_wo0_wi0_r0_delayr27 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr26_q, xout => u0_m0_wo0_wi0_r0_delayr27_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr28(DELAY,50)@10
    u0_m0_wo0_wi0_r0_delayr28 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr27_q, xout => u0_m0_wo0_wi0_r0_delayr28_q, ena => xIn_v(0), clk => clk, aclr => areset );

    -- d_u0_m0_wo0_wi0_r0_delayr28_q_12(DELAY,176)@10 + 2
    d_u0_m0_wo0_wi0_r0_delayr28_q_12 : dspba_delay
    GENERIC MAP ( width => 13, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr28_q, xout => d_u0_m0_wo0_wi0_r0_delayr28_q_12_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr29(DELAY,51)@12
    u0_m0_wo0_wi0_r0_delayr29 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => d_u0_m0_wo0_wi0_r0_delayr28_q_12_q, xout => u0_m0_wo0_wi0_r0_delayr29_q, ena => d_u0_m0_wo0_compute_q_12_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr30(DELAY,52)@12
    u0_m0_wo0_wi0_r0_delayr30 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr29_q, xout => u0_m0_wo0_wi0_r0_delayr30_q, ena => d_u0_m0_wo0_compute_q_12_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr31(DELAY,53)@12
    u0_m0_wo0_wi0_r0_delayr31 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr30_q, xout => u0_m0_wo0_wi0_r0_delayr31_q, ena => d_u0_m0_wo0_compute_q_12_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr32(DELAY,54)@12
    u0_m0_wo0_wi0_r0_delayr32 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr31_q, xout => u0_m0_wo0_wi0_r0_delayr32_q, ena => d_u0_m0_wo0_compute_q_12_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr33(DELAY,55)@12
    u0_m0_wo0_wi0_r0_delayr33 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr32_q, xout => u0_m0_wo0_wi0_r0_delayr33_q, ena => d_u0_m0_wo0_compute_q_12_q(0), clk => clk, aclr => areset );

    -- d_u0_m0_wo0_bank_delayr2_q_12(DELAY,179)@10 + 2
    d_u0_m0_wo0_bank_delayr2_q_12 : dspba_delay
    GENERIC MAP ( width => 2, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => bank_u0_m0_wi0_wo0_merged_bit_select_b, xout => d_u0_m0_wo0_bank_delayr2_q_12_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr34(DELAY,56)@12
    u0_m0_wo0_wi0_r0_delayr34 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr33_q, xout => u0_m0_wo0_wi0_r0_delayr34_q, ena => d_u0_m0_wo0_compute_q_12_q(0), clk => clk, aclr => areset );

    -- d_u0_m0_wo0_bank_delayr1_q_12(DELAY,178)@10 + 2
    d_u0_m0_wo0_bank_delayr1_q_12 : dspba_delay
    GENERIC MAP ( width => 2, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => bank_u0_m0_wi0_wo0_merged_bit_select_b, xout => d_u0_m0_wo0_bank_delayr1_q_12_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr35(DELAY,57)@12
    u0_m0_wo0_wi0_r0_delayr35 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr34_q, xout => u0_m0_wo0_wi0_r0_delayr35_q, ena => d_u0_m0_wo0_compute_q_12_q(0), clk => clk, aclr => areset );

    -- d_u0_m0_wo0_bank_phasedelay0_q_12(DELAY,177)@10 + 2
    d_u0_m0_wo0_bank_phasedelay0_q_12 : dspba_delay
    GENERIC MAP ( width => 2, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => bank_u0_m0_wi0_wo0_merged_bit_select_b, xout => d_u0_m0_wo0_bank_phasedelay0_q_12_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_delayr36(DELAY,58)@12
    u0_m0_wo0_wi0_r0_delayr36 : dspba_delay
    GENERIC MAP ( width => 13, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_wi0_r0_delayr35_q, xout => u0_m0_wo0_wi0_r0_delayr36_q, ena => d_u0_m0_wo0_compute_q_12_q(0), clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_madd4_9_cma(CHAINMULTADD,163)@12 + 2
    u0_m0_wo0_mtree_madd4_9_cma_reset <= areset;
    u0_m0_wo0_mtree_madd4_9_cma_ena0 <= '1';
    u0_m0_wo0_mtree_madd4_9_cma_ena1 <= u0_m0_wo0_mtree_madd4_9_cma_ena0;
    -- altera synthesis_off
    u0_m0_wo0_mtree_madd4_9_cma_k0 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-13,12),
        2 => TO_SIGNED(155,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_9_cma_k1 <= (
        0 => TO_SIGNED(6,12),
        1 => TO_SIGNED(-15,12),
        2 => TO_SIGNED(169,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_9_cma_k2 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-12,12),
        2 => TO_SIGNED(211,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_9_cma_k3 <= (
        0 => TO_SIGNED(-12,12),
        1 => TO_SIGNED(0,12),
        2 => TO_SIGNED(279,12),
        others => (others => '0'));
    -- altera synthesis_on
    u0_m0_wo0_mtree_madd4_9_cma_r(0) <= u0_m0_wo0_mtree_madd4_9_cma_k0(TO_INTEGER(u0_m0_wo0_mtree_madd4_9_cma_c0(0)));
    u0_m0_wo0_mtree_madd4_9_cma_r(1) <= u0_m0_wo0_mtree_madd4_9_cma_k1(TO_INTEGER(u0_m0_wo0_mtree_madd4_9_cma_c0(1)));
    u0_m0_wo0_mtree_madd4_9_cma_r(2) <= u0_m0_wo0_mtree_madd4_9_cma_k2(TO_INTEGER(u0_m0_wo0_mtree_madd4_9_cma_c0(2)));
    u0_m0_wo0_mtree_madd4_9_cma_r(3) <= u0_m0_wo0_mtree_madd4_9_cma_k3(TO_INTEGER(u0_m0_wo0_mtree_madd4_9_cma_c0(3)));
    u0_m0_wo0_mtree_madd4_9_cma_p(0) <= u0_m0_wo0_mtree_madd4_9_cma_a0(0) * u0_m0_wo0_mtree_madd4_9_cma_r(0);
    u0_m0_wo0_mtree_madd4_9_cma_p(1) <= u0_m0_wo0_mtree_madd4_9_cma_a0(1) * u0_m0_wo0_mtree_madd4_9_cma_r(1);
    u0_m0_wo0_mtree_madd4_9_cma_p(2) <= u0_m0_wo0_mtree_madd4_9_cma_a0(2) * u0_m0_wo0_mtree_madd4_9_cma_r(2);
    u0_m0_wo0_mtree_madd4_9_cma_p(3) <= u0_m0_wo0_mtree_madd4_9_cma_a0(3) * u0_m0_wo0_mtree_madd4_9_cma_r(3);
    u0_m0_wo0_mtree_madd4_9_cma_u(0) <= RESIZE(u0_m0_wo0_mtree_madd4_9_cma_p(0),27);
    u0_m0_wo0_mtree_madd4_9_cma_u(1) <= RESIZE(u0_m0_wo0_mtree_madd4_9_cma_p(1),27);
    u0_m0_wo0_mtree_madd4_9_cma_u(2) <= RESIZE(u0_m0_wo0_mtree_madd4_9_cma_p(2),27);
    u0_m0_wo0_mtree_madd4_9_cma_u(3) <= RESIZE(u0_m0_wo0_mtree_madd4_9_cma_p(3),27);
    u0_m0_wo0_mtree_madd4_9_cma_w(0) <= u0_m0_wo0_mtree_madd4_9_cma_u(0) + u0_m0_wo0_mtree_madd4_9_cma_u(1);
    u0_m0_wo0_mtree_madd4_9_cma_w(1) <= u0_m0_wo0_mtree_madd4_9_cma_u(2) + u0_m0_wo0_mtree_madd4_9_cma_u(3);
    u0_m0_wo0_mtree_madd4_9_cma_x(0) <= u0_m0_wo0_mtree_madd4_9_cma_w(0) + u0_m0_wo0_mtree_madd4_9_cma_w(1);
    u0_m0_wo0_mtree_madd4_9_cma_y(0) <= u0_m0_wo0_mtree_madd4_9_cma_x(0);
    u0_m0_wo0_mtree_madd4_9_cma_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_madd4_9_cma_a0 <= (others => (others => '0'));
            u0_m0_wo0_mtree_madd4_9_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_madd4_9_cma_ena0 = '1') THEN
                u0_m0_wo0_mtree_madd4_9_cma_a0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr36_q),13);
                u0_m0_wo0_mtree_madd4_9_cma_a0(1) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr35_q),13);
                u0_m0_wo0_mtree_madd4_9_cma_a0(2) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr34_q),13);
                u0_m0_wo0_mtree_madd4_9_cma_a0(3) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr33_q),13);
                u0_m0_wo0_mtree_madd4_9_cma_c0(0) <= RESIZE(UNSIGNED(d_u0_m0_wo0_bank_phasedelay0_q_12_q),3);
                u0_m0_wo0_mtree_madd4_9_cma_c0(1) <= RESIZE(UNSIGNED(d_u0_m0_wo0_bank_delayr1_q_12_q),3);
                u0_m0_wo0_mtree_madd4_9_cma_c0(2) <= RESIZE(UNSIGNED(d_u0_m0_wo0_bank_delayr2_q_12_q),3);
                u0_m0_wo0_mtree_madd4_9_cma_c0(3) <= RESIZE(UNSIGNED(d_u0_m0_wo0_bank_delayr3_q_12_q),3);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_madd4_9_cma_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_madd4_9_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_madd4_9_cma_ena1 = '1') THEN
                u0_m0_wo0_mtree_madd4_9_cma_s(0) <= u0_m0_wo0_mtree_madd4_9_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_madd4_9_cma_delay : dspba_delay
    GENERIC MAP ( width => 27, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_mtree_madd4_9_cma_s(0)(26 downto 0)), xout => u0_m0_wo0_mtree_madd4_9_cma_qq, clk => clk, aclr => areset );
    u0_m0_wo0_mtree_madd4_9_cma_q <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_madd4_9_cma_qq(26 downto 0));

    -- d_u0_m0_wo0_bank_delayr7_q_12(DELAY,184)@10 + 2
    d_u0_m0_wo0_bank_delayr7_q_12 : dspba_delay
    GENERIC MAP ( width => 2, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => bank_u0_m0_wi0_wo0_merged_bit_select_b, xout => d_u0_m0_wo0_bank_delayr7_q_12_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_bank_delayr6_q_12(DELAY,183)@10 + 2
    d_u0_m0_wo0_bank_delayr6_q_12 : dspba_delay
    GENERIC MAP ( width => 2, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => bank_u0_m0_wi0_wo0_merged_bit_select_b, xout => d_u0_m0_wo0_bank_delayr6_q_12_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_bank_delayr5_q_12(DELAY,182)@10 + 2
    d_u0_m0_wo0_bank_delayr5_q_12 : dspba_delay
    GENERIC MAP ( width => 2, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => bank_u0_m0_wi0_wo0_merged_bit_select_b, xout => d_u0_m0_wo0_bank_delayr5_q_12_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_bank_delayr4_q_12(DELAY,181)@10 + 2
    d_u0_m0_wo0_bank_delayr4_q_12 : dspba_delay
    GENERIC MAP ( width => 2, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => bank_u0_m0_wi0_wo0_merged_bit_select_b, xout => d_u0_m0_wo0_bank_delayr4_q_12_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_mtree_madd4_8_cma(CHAINMULTADD,164)@12 + 2
    u0_m0_wo0_mtree_madd4_8_cma_reset <= areset;
    u0_m0_wo0_mtree_madd4_8_cma_ena0 <= '1';
    u0_m0_wo0_mtree_madd4_8_cma_ena1 <= u0_m0_wo0_mtree_madd4_8_cma_ena0;
    -- altera synthesis_off
    u0_m0_wo0_mtree_madd4_8_cma_k0 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(25,12),
        2 => TO_SIGNED(371,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_8_cma_k1 <= (
        0 => TO_SIGNED(24,12),
        1 => TO_SIGNED(58,12),
        2 => TO_SIGNED(486,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_8_cma_k2 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(80,12),
        2 => TO_SIGNED(619,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_8_cma_k3 <= (
        0 => TO_SIGNED(-45,12),
        1 => TO_SIGNED(66,12),
        2 => TO_SIGNED(767,12),
        others => (others => '0'));
    -- altera synthesis_on
    u0_m0_wo0_mtree_madd4_8_cma_r(0) <= u0_m0_wo0_mtree_madd4_8_cma_k0(TO_INTEGER(u0_m0_wo0_mtree_madd4_8_cma_c0(0)));
    u0_m0_wo0_mtree_madd4_8_cma_r(1) <= u0_m0_wo0_mtree_madd4_8_cma_k1(TO_INTEGER(u0_m0_wo0_mtree_madd4_8_cma_c0(1)));
    u0_m0_wo0_mtree_madd4_8_cma_r(2) <= u0_m0_wo0_mtree_madd4_8_cma_k2(TO_INTEGER(u0_m0_wo0_mtree_madd4_8_cma_c0(2)));
    u0_m0_wo0_mtree_madd4_8_cma_r(3) <= u0_m0_wo0_mtree_madd4_8_cma_k3(TO_INTEGER(u0_m0_wo0_mtree_madd4_8_cma_c0(3)));
    u0_m0_wo0_mtree_madd4_8_cma_p(0) <= u0_m0_wo0_mtree_madd4_8_cma_a0(0) * u0_m0_wo0_mtree_madd4_8_cma_r(0);
    u0_m0_wo0_mtree_madd4_8_cma_p(1) <= u0_m0_wo0_mtree_madd4_8_cma_a0(1) * u0_m0_wo0_mtree_madd4_8_cma_r(1);
    u0_m0_wo0_mtree_madd4_8_cma_p(2) <= u0_m0_wo0_mtree_madd4_8_cma_a0(2) * u0_m0_wo0_mtree_madd4_8_cma_r(2);
    u0_m0_wo0_mtree_madd4_8_cma_p(3) <= u0_m0_wo0_mtree_madd4_8_cma_a0(3) * u0_m0_wo0_mtree_madd4_8_cma_r(3);
    u0_m0_wo0_mtree_madd4_8_cma_u(0) <= RESIZE(u0_m0_wo0_mtree_madd4_8_cma_p(0),27);
    u0_m0_wo0_mtree_madd4_8_cma_u(1) <= RESIZE(u0_m0_wo0_mtree_madd4_8_cma_p(1),27);
    u0_m0_wo0_mtree_madd4_8_cma_u(2) <= RESIZE(u0_m0_wo0_mtree_madd4_8_cma_p(2),27);
    u0_m0_wo0_mtree_madd4_8_cma_u(3) <= RESIZE(u0_m0_wo0_mtree_madd4_8_cma_p(3),27);
    u0_m0_wo0_mtree_madd4_8_cma_w(0) <= u0_m0_wo0_mtree_madd4_8_cma_u(0) + u0_m0_wo0_mtree_madd4_8_cma_u(1);
    u0_m0_wo0_mtree_madd4_8_cma_w(1) <= u0_m0_wo0_mtree_madd4_8_cma_u(2) + u0_m0_wo0_mtree_madd4_8_cma_u(3);
    u0_m0_wo0_mtree_madd4_8_cma_x(0) <= u0_m0_wo0_mtree_madd4_8_cma_w(0) + u0_m0_wo0_mtree_madd4_8_cma_w(1);
    u0_m0_wo0_mtree_madd4_8_cma_y(0) <= u0_m0_wo0_mtree_madd4_8_cma_x(0);
    u0_m0_wo0_mtree_madd4_8_cma_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_madd4_8_cma_a0 <= (others => (others => '0'));
            u0_m0_wo0_mtree_madd4_8_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_madd4_8_cma_ena0 = '1') THEN
                u0_m0_wo0_mtree_madd4_8_cma_a0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr32_q),13);
                u0_m0_wo0_mtree_madd4_8_cma_a0(1) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr31_q),13);
                u0_m0_wo0_mtree_madd4_8_cma_a0(2) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr30_q),13);
                u0_m0_wo0_mtree_madd4_8_cma_a0(3) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr29_q),13);
                u0_m0_wo0_mtree_madd4_8_cma_c0(0) <= RESIZE(UNSIGNED(d_u0_m0_wo0_bank_delayr4_q_12_q),3);
                u0_m0_wo0_mtree_madd4_8_cma_c0(1) <= RESIZE(UNSIGNED(d_u0_m0_wo0_bank_delayr5_q_12_q),3);
                u0_m0_wo0_mtree_madd4_8_cma_c0(2) <= RESIZE(UNSIGNED(d_u0_m0_wo0_bank_delayr6_q_12_q),3);
                u0_m0_wo0_mtree_madd4_8_cma_c0(3) <= RESIZE(UNSIGNED(d_u0_m0_wo0_bank_delayr7_q_12_q),3);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_madd4_8_cma_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_madd4_8_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_madd4_8_cma_ena1 = '1') THEN
                u0_m0_wo0_mtree_madd4_8_cma_s(0) <= u0_m0_wo0_mtree_madd4_8_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_madd4_8_cma_delay : dspba_delay
    GENERIC MAP ( width => 27, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_mtree_madd4_8_cma_s(0)(26 downto 0)), xout => u0_m0_wo0_mtree_madd4_8_cma_qq, clk => clk, aclr => areset );
    u0_m0_wo0_mtree_madd4_8_cma_q <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_madd4_8_cma_qq(26 downto 0));

    -- u0_m0_wo0_mtree_add0_4(ADD,151)@14 + 1
    u0_m0_wo0_mtree_add0_4_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 27 => u0_m0_wo0_mtree_madd4_8_cma_q(26)) & u0_m0_wo0_mtree_madd4_8_cma_q));
    u0_m0_wo0_mtree_add0_4_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 27 => u0_m0_wo0_mtree_madd4_9_cma_q(26)) & u0_m0_wo0_mtree_madd4_9_cma_q));
    u0_m0_wo0_mtree_add0_4_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_4_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_4_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_4_a) + SIGNED(u0_m0_wo0_mtree_add0_4_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_4_q <= u0_m0_wo0_mtree_add0_4_o(27 downto 0);

    -- u0_m0_wo0_mtree_madd4_7_cma(CHAINMULTADD,165)@10 + 2
    u0_m0_wo0_mtree_madd4_7_cma_reset <= areset;
    u0_m0_wo0_mtree_madd4_7_cma_ena0 <= '1';
    u0_m0_wo0_mtree_madd4_7_cma_ena1 <= u0_m0_wo0_mtree_madd4_7_cma_ena0;
    -- altera synthesis_off
    u0_m0_wo0_mtree_madd4_7_cma_k0 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(0,12),
        2 => TO_SIGNED(926,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_7_cma_k1 <= (
        0 => TO_SIGNED(78,12),
        1 => TO_SIGNED(-114,12),
        2 => TO_SIGNED(1090,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_7_cma_k2 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-240,12),
        2 => TO_SIGNED(1255,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_7_cma_k3 <= (
        0 => TO_SIGNED(-129,12),
        1 => TO_SIGNED(-308,12),
        2 => TO_SIGNED(1415,12),
        others => (others => '0'));
    -- altera synthesis_on
    u0_m0_wo0_mtree_madd4_7_cma_r(0) <= u0_m0_wo0_mtree_madd4_7_cma_k0(TO_INTEGER(u0_m0_wo0_mtree_madd4_7_cma_c0(0)));
    u0_m0_wo0_mtree_madd4_7_cma_r(1) <= u0_m0_wo0_mtree_madd4_7_cma_k1(TO_INTEGER(u0_m0_wo0_mtree_madd4_7_cma_c0(1)));
    u0_m0_wo0_mtree_madd4_7_cma_r(2) <= u0_m0_wo0_mtree_madd4_7_cma_k2(TO_INTEGER(u0_m0_wo0_mtree_madd4_7_cma_c0(2)));
    u0_m0_wo0_mtree_madd4_7_cma_r(3) <= u0_m0_wo0_mtree_madd4_7_cma_k3(TO_INTEGER(u0_m0_wo0_mtree_madd4_7_cma_c0(3)));
    u0_m0_wo0_mtree_madd4_7_cma_p(0) <= u0_m0_wo0_mtree_madd4_7_cma_a0(0) * u0_m0_wo0_mtree_madd4_7_cma_r(0);
    u0_m0_wo0_mtree_madd4_7_cma_p(1) <= u0_m0_wo0_mtree_madd4_7_cma_a0(1) * u0_m0_wo0_mtree_madd4_7_cma_r(1);
    u0_m0_wo0_mtree_madd4_7_cma_p(2) <= u0_m0_wo0_mtree_madd4_7_cma_a0(2) * u0_m0_wo0_mtree_madd4_7_cma_r(2);
    u0_m0_wo0_mtree_madd4_7_cma_p(3) <= u0_m0_wo0_mtree_madd4_7_cma_a0(3) * u0_m0_wo0_mtree_madd4_7_cma_r(3);
    u0_m0_wo0_mtree_madd4_7_cma_u(0) <= RESIZE(u0_m0_wo0_mtree_madd4_7_cma_p(0),27);
    u0_m0_wo0_mtree_madd4_7_cma_u(1) <= RESIZE(u0_m0_wo0_mtree_madd4_7_cma_p(1),27);
    u0_m0_wo0_mtree_madd4_7_cma_u(2) <= RESIZE(u0_m0_wo0_mtree_madd4_7_cma_p(2),27);
    u0_m0_wo0_mtree_madd4_7_cma_u(3) <= RESIZE(u0_m0_wo0_mtree_madd4_7_cma_p(3),27);
    u0_m0_wo0_mtree_madd4_7_cma_w(0) <= u0_m0_wo0_mtree_madd4_7_cma_u(0) + u0_m0_wo0_mtree_madd4_7_cma_u(1);
    u0_m0_wo0_mtree_madd4_7_cma_w(1) <= u0_m0_wo0_mtree_madd4_7_cma_u(2) + u0_m0_wo0_mtree_madd4_7_cma_u(3);
    u0_m0_wo0_mtree_madd4_7_cma_x(0) <= u0_m0_wo0_mtree_madd4_7_cma_w(0) + u0_m0_wo0_mtree_madd4_7_cma_w(1);
    u0_m0_wo0_mtree_madd4_7_cma_y(0) <= u0_m0_wo0_mtree_madd4_7_cma_x(0);
    u0_m0_wo0_mtree_madd4_7_cma_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_madd4_7_cma_a0 <= (others => (others => '0'));
            u0_m0_wo0_mtree_madd4_7_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_madd4_7_cma_ena0 = '1') THEN
                u0_m0_wo0_mtree_madd4_7_cma_a0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr28_q),13);
                u0_m0_wo0_mtree_madd4_7_cma_a0(1) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr27_q),13);
                u0_m0_wo0_mtree_madd4_7_cma_a0(2) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr26_q),13);
                u0_m0_wo0_mtree_madd4_7_cma_a0(3) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr25_q),13);
                u0_m0_wo0_mtree_madd4_7_cma_c0(0) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_7_cma_c0(1) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_7_cma_c0(2) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_7_cma_c0(3) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_madd4_7_cma_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_madd4_7_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_madd4_7_cma_ena1 = '1') THEN
                u0_m0_wo0_mtree_madd4_7_cma_s(0) <= u0_m0_wo0_mtree_madd4_7_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_madd4_7_cma_delay : dspba_delay
    GENERIC MAP ( width => 27, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_mtree_madd4_7_cma_s(0)(26 downto 0)), xout => u0_m0_wo0_mtree_madd4_7_cma_qq, clk => clk, aclr => areset );
    u0_m0_wo0_mtree_madd4_7_cma_q <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_madd4_7_cma_qq(26 downto 0));

    -- u0_m0_wo0_mtree_madd4_6_cma(CHAINMULTADD,166)@10 + 2
    u0_m0_wo0_mtree_madd4_6_cma_reset <= areset;
    u0_m0_wo0_mtree_madd4_6_cma_ena0 <= '1';
    u0_m0_wo0_mtree_madd4_6_cma_ena1 <= u0_m0_wo0_mtree_madd4_6_cma_ena0;
    -- altera synthesis_off
    u0_m0_wo0_mtree_madd4_6_cma_k0 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-245,12),
        2 => TO_SIGNED(1566,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_6_cma_k1 <= (
        0 => TO_SIGNED(217,12),
        1 => TO_SIGNED(0,12),
        2 => TO_SIGNED(1703,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_6_cma_k2 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(427,12),
        2 => TO_SIGNED(1821,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_6_cma_k3 <= (
        0 => TO_SIGNED(-407,12),
        1 => TO_SIGNED(969,12),
        2 => TO_SIGNED(1918,12),
        others => (others => '0'));
    -- altera synthesis_on
    u0_m0_wo0_mtree_madd4_6_cma_r(0) <= u0_m0_wo0_mtree_madd4_6_cma_k0(TO_INTEGER(u0_m0_wo0_mtree_madd4_6_cma_c0(0)));
    u0_m0_wo0_mtree_madd4_6_cma_r(1) <= u0_m0_wo0_mtree_madd4_6_cma_k1(TO_INTEGER(u0_m0_wo0_mtree_madd4_6_cma_c0(1)));
    u0_m0_wo0_mtree_madd4_6_cma_r(2) <= u0_m0_wo0_mtree_madd4_6_cma_k2(TO_INTEGER(u0_m0_wo0_mtree_madd4_6_cma_c0(2)));
    u0_m0_wo0_mtree_madd4_6_cma_r(3) <= u0_m0_wo0_mtree_madd4_6_cma_k3(TO_INTEGER(u0_m0_wo0_mtree_madd4_6_cma_c0(3)));
    u0_m0_wo0_mtree_madd4_6_cma_p(0) <= u0_m0_wo0_mtree_madd4_6_cma_a0(0) * u0_m0_wo0_mtree_madd4_6_cma_r(0);
    u0_m0_wo0_mtree_madd4_6_cma_p(1) <= u0_m0_wo0_mtree_madd4_6_cma_a0(1) * u0_m0_wo0_mtree_madd4_6_cma_r(1);
    u0_m0_wo0_mtree_madd4_6_cma_p(2) <= u0_m0_wo0_mtree_madd4_6_cma_a0(2) * u0_m0_wo0_mtree_madd4_6_cma_r(2);
    u0_m0_wo0_mtree_madd4_6_cma_p(3) <= u0_m0_wo0_mtree_madd4_6_cma_a0(3) * u0_m0_wo0_mtree_madd4_6_cma_r(3);
    u0_m0_wo0_mtree_madd4_6_cma_u(0) <= RESIZE(u0_m0_wo0_mtree_madd4_6_cma_p(0),27);
    u0_m0_wo0_mtree_madd4_6_cma_u(1) <= RESIZE(u0_m0_wo0_mtree_madd4_6_cma_p(1),27);
    u0_m0_wo0_mtree_madd4_6_cma_u(2) <= RESIZE(u0_m0_wo0_mtree_madd4_6_cma_p(2),27);
    u0_m0_wo0_mtree_madd4_6_cma_u(3) <= RESIZE(u0_m0_wo0_mtree_madd4_6_cma_p(3),27);
    u0_m0_wo0_mtree_madd4_6_cma_w(0) <= u0_m0_wo0_mtree_madd4_6_cma_u(0) + u0_m0_wo0_mtree_madd4_6_cma_u(1);
    u0_m0_wo0_mtree_madd4_6_cma_w(1) <= u0_m0_wo0_mtree_madd4_6_cma_u(2) + u0_m0_wo0_mtree_madd4_6_cma_u(3);
    u0_m0_wo0_mtree_madd4_6_cma_x(0) <= u0_m0_wo0_mtree_madd4_6_cma_w(0) + u0_m0_wo0_mtree_madd4_6_cma_w(1);
    u0_m0_wo0_mtree_madd4_6_cma_y(0) <= u0_m0_wo0_mtree_madd4_6_cma_x(0);
    u0_m0_wo0_mtree_madd4_6_cma_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_madd4_6_cma_a0 <= (others => (others => '0'));
            u0_m0_wo0_mtree_madd4_6_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_madd4_6_cma_ena0 = '1') THEN
                u0_m0_wo0_mtree_madd4_6_cma_a0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr24_q),13);
                u0_m0_wo0_mtree_madd4_6_cma_a0(1) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr23_q),13);
                u0_m0_wo0_mtree_madd4_6_cma_a0(2) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr22_q),13);
                u0_m0_wo0_mtree_madd4_6_cma_a0(3) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr21_q),13);
                u0_m0_wo0_mtree_madd4_6_cma_c0(0) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_6_cma_c0(1) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_6_cma_c0(2) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_6_cma_c0(3) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_madd4_6_cma_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_madd4_6_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_madd4_6_cma_ena1 = '1') THEN
                u0_m0_wo0_mtree_madd4_6_cma_s(0) <= u0_m0_wo0_mtree_madd4_6_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_madd4_6_cma_delay : dspba_delay
    GENERIC MAP ( width => 27, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_mtree_madd4_6_cma_s(0)(26 downto 0)), xout => u0_m0_wo0_mtree_madd4_6_cma_qq, clk => clk, aclr => areset );
    u0_m0_wo0_mtree_madd4_6_cma_q <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_madd4_6_cma_qq(26 downto 0));

    -- u0_m0_wo0_mtree_add0_3(ADD,150)@12 + 1
    u0_m0_wo0_mtree_add0_3_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 27 => u0_m0_wo0_mtree_madd4_6_cma_q(26)) & u0_m0_wo0_mtree_madd4_6_cma_q));
    u0_m0_wo0_mtree_add0_3_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 27 => u0_m0_wo0_mtree_madd4_7_cma_q(26)) & u0_m0_wo0_mtree_madd4_7_cma_q));
    u0_m0_wo0_mtree_add0_3_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_3_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_3_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_3_a) + SIGNED(u0_m0_wo0_mtree_add0_3_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_3_q <= u0_m0_wo0_mtree_add0_3_o(27 downto 0);

    -- u0_m0_wo0_mtree_madd4_5_cma(CHAINMULTADD,167)@10 + 2
    u0_m0_wo0_mtree_madd4_5_cma_reset <= areset;
    u0_m0_wo0_mtree_madd4_5_cma_ena0 <= '1';
    u0_m0_wo0_mtree_madd4_5_cma_ena1 <= u0_m0_wo0_mtree_madd4_5_cma_ena0;
    -- altera synthesis_off
    u0_m0_wo0_mtree_madd4_5_cma_k0 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(1506,12),
        2 => TO_SIGNED(1988,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_5_cma_k1 <= (
        0 => TO_SIGNED(1294,12),
        1 => TO_SIGNED(1901,12),
        2 => TO_SIGNED(2032,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_5_cma_k2 <= (
        0 => TO_SIGNED(2046,12),
        1 => TO_SIGNED(2047,12),
        2 => TO_SIGNED(2047,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_5_cma_k3 <= (
        0 => TO_SIGNED(1294,12),
        1 => TO_SIGNED(1901,12),
        2 => TO_SIGNED(2032,12),
        others => (others => '0'));
    -- altera synthesis_on
    u0_m0_wo0_mtree_madd4_5_cma_r(0) <= u0_m0_wo0_mtree_madd4_5_cma_k0(TO_INTEGER(u0_m0_wo0_mtree_madd4_5_cma_c0(0)));
    u0_m0_wo0_mtree_madd4_5_cma_r(1) <= u0_m0_wo0_mtree_madd4_5_cma_k1(TO_INTEGER(u0_m0_wo0_mtree_madd4_5_cma_c0(1)));
    u0_m0_wo0_mtree_madd4_5_cma_r(2) <= u0_m0_wo0_mtree_madd4_5_cma_k2(TO_INTEGER(u0_m0_wo0_mtree_madd4_5_cma_c0(2)));
    u0_m0_wo0_mtree_madd4_5_cma_r(3) <= u0_m0_wo0_mtree_madd4_5_cma_k3(TO_INTEGER(u0_m0_wo0_mtree_madd4_5_cma_c0(3)));
    u0_m0_wo0_mtree_madd4_5_cma_p(0) <= u0_m0_wo0_mtree_madd4_5_cma_a0(0) * u0_m0_wo0_mtree_madd4_5_cma_r(0);
    u0_m0_wo0_mtree_madd4_5_cma_p(1) <= u0_m0_wo0_mtree_madd4_5_cma_a0(1) * u0_m0_wo0_mtree_madd4_5_cma_r(1);
    u0_m0_wo0_mtree_madd4_5_cma_p(2) <= u0_m0_wo0_mtree_madd4_5_cma_a0(2) * u0_m0_wo0_mtree_madd4_5_cma_r(2);
    u0_m0_wo0_mtree_madd4_5_cma_p(3) <= u0_m0_wo0_mtree_madd4_5_cma_a0(3) * u0_m0_wo0_mtree_madd4_5_cma_r(3);
    u0_m0_wo0_mtree_madd4_5_cma_u(0) <= RESIZE(u0_m0_wo0_mtree_madd4_5_cma_p(0),27);
    u0_m0_wo0_mtree_madd4_5_cma_u(1) <= RESIZE(u0_m0_wo0_mtree_madd4_5_cma_p(1),27);
    u0_m0_wo0_mtree_madd4_5_cma_u(2) <= RESIZE(u0_m0_wo0_mtree_madd4_5_cma_p(2),27);
    u0_m0_wo0_mtree_madd4_5_cma_u(3) <= RESIZE(u0_m0_wo0_mtree_madd4_5_cma_p(3),27);
    u0_m0_wo0_mtree_madd4_5_cma_w(0) <= u0_m0_wo0_mtree_madd4_5_cma_u(0) + u0_m0_wo0_mtree_madd4_5_cma_u(1);
    u0_m0_wo0_mtree_madd4_5_cma_w(1) <= u0_m0_wo0_mtree_madd4_5_cma_u(2) + u0_m0_wo0_mtree_madd4_5_cma_u(3);
    u0_m0_wo0_mtree_madd4_5_cma_x(0) <= u0_m0_wo0_mtree_madd4_5_cma_w(0) + u0_m0_wo0_mtree_madd4_5_cma_w(1);
    u0_m0_wo0_mtree_madd4_5_cma_y(0) <= u0_m0_wo0_mtree_madd4_5_cma_x(0);
    u0_m0_wo0_mtree_madd4_5_cma_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_madd4_5_cma_a0 <= (others => (others => '0'));
            u0_m0_wo0_mtree_madd4_5_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_madd4_5_cma_ena0 = '1') THEN
                u0_m0_wo0_mtree_madd4_5_cma_a0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr20_q),13);
                u0_m0_wo0_mtree_madd4_5_cma_a0(1) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr19_q),13);
                u0_m0_wo0_mtree_madd4_5_cma_a0(2) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr18_q),13);
                u0_m0_wo0_mtree_madd4_5_cma_a0(3) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr17_q),13);
                u0_m0_wo0_mtree_madd4_5_cma_c0(0) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_5_cma_c0(1) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_5_cma_c0(2) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_5_cma_c0(3) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_madd4_5_cma_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_madd4_5_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_madd4_5_cma_ena1 = '1') THEN
                u0_m0_wo0_mtree_madd4_5_cma_s(0) <= u0_m0_wo0_mtree_madd4_5_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_madd4_5_cma_delay : dspba_delay
    GENERIC MAP ( width => 27, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_mtree_madd4_5_cma_s(0)(26 downto 0)), xout => u0_m0_wo0_mtree_madd4_5_cma_qq, clk => clk, aclr => areset );
    u0_m0_wo0_mtree_madd4_5_cma_q <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_madd4_5_cma_qq(26 downto 0));

    -- u0_m0_wo0_mtree_madd4_4_cma(CHAINMULTADD,168)@10 + 2
    u0_m0_wo0_mtree_madd4_4_cma_reset <= areset;
    u0_m0_wo0_mtree_madd4_4_cma_ena0 <= '1';
    u0_m0_wo0_mtree_madd4_4_cma_ena1 <= u0_m0_wo0_mtree_madd4_4_cma_ena0;
    -- altera synthesis_off
    u0_m0_wo0_mtree_madd4_4_cma_k0 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(1506,12),
        2 => TO_SIGNED(1988,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_4_cma_k1 <= (
        0 => TO_SIGNED(-407,12),
        1 => TO_SIGNED(969,12),
        2 => TO_SIGNED(1918,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_4_cma_k2 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(427,12),
        2 => TO_SIGNED(1821,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_4_cma_k3 <= (
        0 => TO_SIGNED(217,12),
        1 => TO_SIGNED(0,12),
        2 => TO_SIGNED(1703,12),
        others => (others => '0'));
    -- altera synthesis_on
    u0_m0_wo0_mtree_madd4_4_cma_r(0) <= u0_m0_wo0_mtree_madd4_4_cma_k0(TO_INTEGER(u0_m0_wo0_mtree_madd4_4_cma_c0(0)));
    u0_m0_wo0_mtree_madd4_4_cma_r(1) <= u0_m0_wo0_mtree_madd4_4_cma_k1(TO_INTEGER(u0_m0_wo0_mtree_madd4_4_cma_c0(1)));
    u0_m0_wo0_mtree_madd4_4_cma_r(2) <= u0_m0_wo0_mtree_madd4_4_cma_k2(TO_INTEGER(u0_m0_wo0_mtree_madd4_4_cma_c0(2)));
    u0_m0_wo0_mtree_madd4_4_cma_r(3) <= u0_m0_wo0_mtree_madd4_4_cma_k3(TO_INTEGER(u0_m0_wo0_mtree_madd4_4_cma_c0(3)));
    u0_m0_wo0_mtree_madd4_4_cma_p(0) <= u0_m0_wo0_mtree_madd4_4_cma_a0(0) * u0_m0_wo0_mtree_madd4_4_cma_r(0);
    u0_m0_wo0_mtree_madd4_4_cma_p(1) <= u0_m0_wo0_mtree_madd4_4_cma_a0(1) * u0_m0_wo0_mtree_madd4_4_cma_r(1);
    u0_m0_wo0_mtree_madd4_4_cma_p(2) <= u0_m0_wo0_mtree_madd4_4_cma_a0(2) * u0_m0_wo0_mtree_madd4_4_cma_r(2);
    u0_m0_wo0_mtree_madd4_4_cma_p(3) <= u0_m0_wo0_mtree_madd4_4_cma_a0(3) * u0_m0_wo0_mtree_madd4_4_cma_r(3);
    u0_m0_wo0_mtree_madd4_4_cma_u(0) <= RESIZE(u0_m0_wo0_mtree_madd4_4_cma_p(0),27);
    u0_m0_wo0_mtree_madd4_4_cma_u(1) <= RESIZE(u0_m0_wo0_mtree_madd4_4_cma_p(1),27);
    u0_m0_wo0_mtree_madd4_4_cma_u(2) <= RESIZE(u0_m0_wo0_mtree_madd4_4_cma_p(2),27);
    u0_m0_wo0_mtree_madd4_4_cma_u(3) <= RESIZE(u0_m0_wo0_mtree_madd4_4_cma_p(3),27);
    u0_m0_wo0_mtree_madd4_4_cma_w(0) <= u0_m0_wo0_mtree_madd4_4_cma_u(0) + u0_m0_wo0_mtree_madd4_4_cma_u(1);
    u0_m0_wo0_mtree_madd4_4_cma_w(1) <= u0_m0_wo0_mtree_madd4_4_cma_u(2) + u0_m0_wo0_mtree_madd4_4_cma_u(3);
    u0_m0_wo0_mtree_madd4_4_cma_x(0) <= u0_m0_wo0_mtree_madd4_4_cma_w(0) + u0_m0_wo0_mtree_madd4_4_cma_w(1);
    u0_m0_wo0_mtree_madd4_4_cma_y(0) <= u0_m0_wo0_mtree_madd4_4_cma_x(0);
    u0_m0_wo0_mtree_madd4_4_cma_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_madd4_4_cma_a0 <= (others => (others => '0'));
            u0_m0_wo0_mtree_madd4_4_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_madd4_4_cma_ena0 = '1') THEN
                u0_m0_wo0_mtree_madd4_4_cma_a0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr16_q),13);
                u0_m0_wo0_mtree_madd4_4_cma_a0(1) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr15_q),13);
                u0_m0_wo0_mtree_madd4_4_cma_a0(2) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr14_q),13);
                u0_m0_wo0_mtree_madd4_4_cma_a0(3) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr13_q),13);
                u0_m0_wo0_mtree_madd4_4_cma_c0(0) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_4_cma_c0(1) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_4_cma_c0(2) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_4_cma_c0(3) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_madd4_4_cma_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_madd4_4_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_madd4_4_cma_ena1 = '1') THEN
                u0_m0_wo0_mtree_madd4_4_cma_s(0) <= u0_m0_wo0_mtree_madd4_4_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_madd4_4_cma_delay : dspba_delay
    GENERIC MAP ( width => 27, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_mtree_madd4_4_cma_s(0)(26 downto 0)), xout => u0_m0_wo0_mtree_madd4_4_cma_qq, clk => clk, aclr => areset );
    u0_m0_wo0_mtree_madd4_4_cma_q <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_madd4_4_cma_qq(26 downto 0));

    -- u0_m0_wo0_mtree_add0_2(ADD,149)@12 + 1
    u0_m0_wo0_mtree_add0_2_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 27 => u0_m0_wo0_mtree_madd4_4_cma_q(26)) & u0_m0_wo0_mtree_madd4_4_cma_q));
    u0_m0_wo0_mtree_add0_2_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 27 => u0_m0_wo0_mtree_madd4_5_cma_q(26)) & u0_m0_wo0_mtree_madd4_5_cma_q));
    u0_m0_wo0_mtree_add0_2_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_2_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_2_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_2_a) + SIGNED(u0_m0_wo0_mtree_add0_2_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_2_q <= u0_m0_wo0_mtree_add0_2_o(27 downto 0);

    -- u0_m0_wo0_mtree_add1_1(ADD,153)@13 + 1
    u0_m0_wo0_mtree_add1_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_add0_2_q(27)) & u0_m0_wo0_mtree_add0_2_q));
    u0_m0_wo0_mtree_add1_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_add0_3_q(27)) & u0_m0_wo0_mtree_add0_3_q));
    u0_m0_wo0_mtree_add1_1_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add1_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add1_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add1_1_a) + SIGNED(u0_m0_wo0_mtree_add1_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add1_1_q <= u0_m0_wo0_mtree_add1_1_o(28 downto 0);

    -- u0_m0_wo0_mtree_madd4_3_cma(CHAINMULTADD,169)@10 + 2
    u0_m0_wo0_mtree_madd4_3_cma_reset <= areset;
    u0_m0_wo0_mtree_madd4_3_cma_ena0 <= '1';
    u0_m0_wo0_mtree_madd4_3_cma_ena1 <= u0_m0_wo0_mtree_madd4_3_cma_ena0;
    -- altera synthesis_off
    u0_m0_wo0_mtree_madd4_3_cma_k0 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-245,12),
        2 => TO_SIGNED(1566,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_3_cma_k1 <= (
        0 => TO_SIGNED(-129,12),
        1 => TO_SIGNED(-308,12),
        2 => TO_SIGNED(1415,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_3_cma_k2 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-240,12),
        2 => TO_SIGNED(1255,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_3_cma_k3 <= (
        0 => TO_SIGNED(78,12),
        1 => TO_SIGNED(-114,12),
        2 => TO_SIGNED(1090,12),
        others => (others => '0'));
    -- altera synthesis_on
    u0_m0_wo0_mtree_madd4_3_cma_r(0) <= u0_m0_wo0_mtree_madd4_3_cma_k0(TO_INTEGER(u0_m0_wo0_mtree_madd4_3_cma_c0(0)));
    u0_m0_wo0_mtree_madd4_3_cma_r(1) <= u0_m0_wo0_mtree_madd4_3_cma_k1(TO_INTEGER(u0_m0_wo0_mtree_madd4_3_cma_c0(1)));
    u0_m0_wo0_mtree_madd4_3_cma_r(2) <= u0_m0_wo0_mtree_madd4_3_cma_k2(TO_INTEGER(u0_m0_wo0_mtree_madd4_3_cma_c0(2)));
    u0_m0_wo0_mtree_madd4_3_cma_r(3) <= u0_m0_wo0_mtree_madd4_3_cma_k3(TO_INTEGER(u0_m0_wo0_mtree_madd4_3_cma_c0(3)));
    u0_m0_wo0_mtree_madd4_3_cma_p(0) <= u0_m0_wo0_mtree_madd4_3_cma_a0(0) * u0_m0_wo0_mtree_madd4_3_cma_r(0);
    u0_m0_wo0_mtree_madd4_3_cma_p(1) <= u0_m0_wo0_mtree_madd4_3_cma_a0(1) * u0_m0_wo0_mtree_madd4_3_cma_r(1);
    u0_m0_wo0_mtree_madd4_3_cma_p(2) <= u0_m0_wo0_mtree_madd4_3_cma_a0(2) * u0_m0_wo0_mtree_madd4_3_cma_r(2);
    u0_m0_wo0_mtree_madd4_3_cma_p(3) <= u0_m0_wo0_mtree_madd4_3_cma_a0(3) * u0_m0_wo0_mtree_madd4_3_cma_r(3);
    u0_m0_wo0_mtree_madd4_3_cma_u(0) <= RESIZE(u0_m0_wo0_mtree_madd4_3_cma_p(0),27);
    u0_m0_wo0_mtree_madd4_3_cma_u(1) <= RESIZE(u0_m0_wo0_mtree_madd4_3_cma_p(1),27);
    u0_m0_wo0_mtree_madd4_3_cma_u(2) <= RESIZE(u0_m0_wo0_mtree_madd4_3_cma_p(2),27);
    u0_m0_wo0_mtree_madd4_3_cma_u(3) <= RESIZE(u0_m0_wo0_mtree_madd4_3_cma_p(3),27);
    u0_m0_wo0_mtree_madd4_3_cma_w(0) <= u0_m0_wo0_mtree_madd4_3_cma_u(0) + u0_m0_wo0_mtree_madd4_3_cma_u(1);
    u0_m0_wo0_mtree_madd4_3_cma_w(1) <= u0_m0_wo0_mtree_madd4_3_cma_u(2) + u0_m0_wo0_mtree_madd4_3_cma_u(3);
    u0_m0_wo0_mtree_madd4_3_cma_x(0) <= u0_m0_wo0_mtree_madd4_3_cma_w(0) + u0_m0_wo0_mtree_madd4_3_cma_w(1);
    u0_m0_wo0_mtree_madd4_3_cma_y(0) <= u0_m0_wo0_mtree_madd4_3_cma_x(0);
    u0_m0_wo0_mtree_madd4_3_cma_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_madd4_3_cma_a0 <= (others => (others => '0'));
            u0_m0_wo0_mtree_madd4_3_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_madd4_3_cma_ena0 = '1') THEN
                u0_m0_wo0_mtree_madd4_3_cma_a0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr12_q),13);
                u0_m0_wo0_mtree_madd4_3_cma_a0(1) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr11_q),13);
                u0_m0_wo0_mtree_madd4_3_cma_a0(2) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr10_q),13);
                u0_m0_wo0_mtree_madd4_3_cma_a0(3) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr9_q),13);
                u0_m0_wo0_mtree_madd4_3_cma_c0(0) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_3_cma_c0(1) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_3_cma_c0(2) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_3_cma_c0(3) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_madd4_3_cma_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_madd4_3_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_madd4_3_cma_ena1 = '1') THEN
                u0_m0_wo0_mtree_madd4_3_cma_s(0) <= u0_m0_wo0_mtree_madd4_3_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_madd4_3_cma_delay : dspba_delay
    GENERIC MAP ( width => 27, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_mtree_madd4_3_cma_s(0)(26 downto 0)), xout => u0_m0_wo0_mtree_madd4_3_cma_qq, clk => clk, aclr => areset );
    u0_m0_wo0_mtree_madd4_3_cma_q <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_madd4_3_cma_qq(26 downto 0));

    -- u0_m0_wo0_mtree_madd4_2_cma(CHAINMULTADD,170)@10 + 2
    u0_m0_wo0_mtree_madd4_2_cma_reset <= areset;
    u0_m0_wo0_mtree_madd4_2_cma_ena0 <= '1';
    u0_m0_wo0_mtree_madd4_2_cma_ena1 <= u0_m0_wo0_mtree_madd4_2_cma_ena0;
    -- altera synthesis_off
    u0_m0_wo0_mtree_madd4_2_cma_k0 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(0,12),
        2 => TO_SIGNED(926,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_2_cma_k1 <= (
        0 => TO_SIGNED(-45,12),
        1 => TO_SIGNED(66,12),
        2 => TO_SIGNED(767,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_2_cma_k2 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(80,12),
        2 => TO_SIGNED(619,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_2_cma_k3 <= (
        0 => TO_SIGNED(24,12),
        1 => TO_SIGNED(58,12),
        2 => TO_SIGNED(486,12),
        others => (others => '0'));
    -- altera synthesis_on
    u0_m0_wo0_mtree_madd4_2_cma_r(0) <= u0_m0_wo0_mtree_madd4_2_cma_k0(TO_INTEGER(u0_m0_wo0_mtree_madd4_2_cma_c0(0)));
    u0_m0_wo0_mtree_madd4_2_cma_r(1) <= u0_m0_wo0_mtree_madd4_2_cma_k1(TO_INTEGER(u0_m0_wo0_mtree_madd4_2_cma_c0(1)));
    u0_m0_wo0_mtree_madd4_2_cma_r(2) <= u0_m0_wo0_mtree_madd4_2_cma_k2(TO_INTEGER(u0_m0_wo0_mtree_madd4_2_cma_c0(2)));
    u0_m0_wo0_mtree_madd4_2_cma_r(3) <= u0_m0_wo0_mtree_madd4_2_cma_k3(TO_INTEGER(u0_m0_wo0_mtree_madd4_2_cma_c0(3)));
    u0_m0_wo0_mtree_madd4_2_cma_p(0) <= u0_m0_wo0_mtree_madd4_2_cma_a0(0) * u0_m0_wo0_mtree_madd4_2_cma_r(0);
    u0_m0_wo0_mtree_madd4_2_cma_p(1) <= u0_m0_wo0_mtree_madd4_2_cma_a0(1) * u0_m0_wo0_mtree_madd4_2_cma_r(1);
    u0_m0_wo0_mtree_madd4_2_cma_p(2) <= u0_m0_wo0_mtree_madd4_2_cma_a0(2) * u0_m0_wo0_mtree_madd4_2_cma_r(2);
    u0_m0_wo0_mtree_madd4_2_cma_p(3) <= u0_m0_wo0_mtree_madd4_2_cma_a0(3) * u0_m0_wo0_mtree_madd4_2_cma_r(3);
    u0_m0_wo0_mtree_madd4_2_cma_u(0) <= RESIZE(u0_m0_wo0_mtree_madd4_2_cma_p(0),27);
    u0_m0_wo0_mtree_madd4_2_cma_u(1) <= RESIZE(u0_m0_wo0_mtree_madd4_2_cma_p(1),27);
    u0_m0_wo0_mtree_madd4_2_cma_u(2) <= RESIZE(u0_m0_wo0_mtree_madd4_2_cma_p(2),27);
    u0_m0_wo0_mtree_madd4_2_cma_u(3) <= RESIZE(u0_m0_wo0_mtree_madd4_2_cma_p(3),27);
    u0_m0_wo0_mtree_madd4_2_cma_w(0) <= u0_m0_wo0_mtree_madd4_2_cma_u(0) + u0_m0_wo0_mtree_madd4_2_cma_u(1);
    u0_m0_wo0_mtree_madd4_2_cma_w(1) <= u0_m0_wo0_mtree_madd4_2_cma_u(2) + u0_m0_wo0_mtree_madd4_2_cma_u(3);
    u0_m0_wo0_mtree_madd4_2_cma_x(0) <= u0_m0_wo0_mtree_madd4_2_cma_w(0) + u0_m0_wo0_mtree_madd4_2_cma_w(1);
    u0_m0_wo0_mtree_madd4_2_cma_y(0) <= u0_m0_wo0_mtree_madd4_2_cma_x(0);
    u0_m0_wo0_mtree_madd4_2_cma_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_madd4_2_cma_a0 <= (others => (others => '0'));
            u0_m0_wo0_mtree_madd4_2_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_madd4_2_cma_ena0 = '1') THEN
                u0_m0_wo0_mtree_madd4_2_cma_a0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr8_q),13);
                u0_m0_wo0_mtree_madd4_2_cma_a0(1) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr7_q),13);
                u0_m0_wo0_mtree_madd4_2_cma_a0(2) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr6_q),13);
                u0_m0_wo0_mtree_madd4_2_cma_a0(3) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr5_q),13);
                u0_m0_wo0_mtree_madd4_2_cma_c0(0) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_2_cma_c0(1) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_2_cma_c0(2) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_2_cma_c0(3) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_madd4_2_cma_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_madd4_2_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_madd4_2_cma_ena1 = '1') THEN
                u0_m0_wo0_mtree_madd4_2_cma_s(0) <= u0_m0_wo0_mtree_madd4_2_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_madd4_2_cma_delay : dspba_delay
    GENERIC MAP ( width => 27, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_mtree_madd4_2_cma_s(0)(26 downto 0)), xout => u0_m0_wo0_mtree_madd4_2_cma_qq, clk => clk, aclr => areset );
    u0_m0_wo0_mtree_madd4_2_cma_q <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_madd4_2_cma_qq(26 downto 0));

    -- u0_m0_wo0_mtree_add0_1(ADD,148)@12 + 1
    u0_m0_wo0_mtree_add0_1_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 27 => u0_m0_wo0_mtree_madd4_2_cma_q(26)) & u0_m0_wo0_mtree_madd4_2_cma_q));
    u0_m0_wo0_mtree_add0_1_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 27 => u0_m0_wo0_mtree_madd4_3_cma_q(26)) & u0_m0_wo0_mtree_madd4_3_cma_q));
    u0_m0_wo0_mtree_add0_1_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_1_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_1_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_1_a) + SIGNED(u0_m0_wo0_mtree_add0_1_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_1_q <= u0_m0_wo0_mtree_add0_1_o(27 downto 0);

    -- u0_m0_wo0_mtree_madd4_1_cma(CHAINMULTADD,171)@10 + 2
    u0_m0_wo0_mtree_madd4_1_cma_reset <= areset;
    u0_m0_wo0_mtree_madd4_1_cma_ena0 <= '1';
    u0_m0_wo0_mtree_madd4_1_cma_ena1 <= u0_m0_wo0_mtree_madd4_1_cma_ena0;
    -- altera synthesis_off
    u0_m0_wo0_mtree_madd4_1_cma_k0 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(25,12),
        2 => TO_SIGNED(371,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_1_cma_k1 <= (
        0 => TO_SIGNED(-12,12),
        1 => TO_SIGNED(0,12),
        2 => TO_SIGNED(279,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_1_cma_k2 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-12,12),
        2 => TO_SIGNED(211,12),
        others => (others => '0'));
    u0_m0_wo0_mtree_madd4_1_cma_k3 <= (
        0 => TO_SIGNED(6,12),
        1 => TO_SIGNED(-15,12),
        2 => TO_SIGNED(169,12),
        others => (others => '0'));
    -- altera synthesis_on
    u0_m0_wo0_mtree_madd4_1_cma_r(0) <= u0_m0_wo0_mtree_madd4_1_cma_k0(TO_INTEGER(u0_m0_wo0_mtree_madd4_1_cma_c0(0)));
    u0_m0_wo0_mtree_madd4_1_cma_r(1) <= u0_m0_wo0_mtree_madd4_1_cma_k1(TO_INTEGER(u0_m0_wo0_mtree_madd4_1_cma_c0(1)));
    u0_m0_wo0_mtree_madd4_1_cma_r(2) <= u0_m0_wo0_mtree_madd4_1_cma_k2(TO_INTEGER(u0_m0_wo0_mtree_madd4_1_cma_c0(2)));
    u0_m0_wo0_mtree_madd4_1_cma_r(3) <= u0_m0_wo0_mtree_madd4_1_cma_k3(TO_INTEGER(u0_m0_wo0_mtree_madd4_1_cma_c0(3)));
    u0_m0_wo0_mtree_madd4_1_cma_p(0) <= u0_m0_wo0_mtree_madd4_1_cma_a0(0) * u0_m0_wo0_mtree_madd4_1_cma_r(0);
    u0_m0_wo0_mtree_madd4_1_cma_p(1) <= u0_m0_wo0_mtree_madd4_1_cma_a0(1) * u0_m0_wo0_mtree_madd4_1_cma_r(1);
    u0_m0_wo0_mtree_madd4_1_cma_p(2) <= u0_m0_wo0_mtree_madd4_1_cma_a0(2) * u0_m0_wo0_mtree_madd4_1_cma_r(2);
    u0_m0_wo0_mtree_madd4_1_cma_p(3) <= u0_m0_wo0_mtree_madd4_1_cma_a0(3) * u0_m0_wo0_mtree_madd4_1_cma_r(3);
    u0_m0_wo0_mtree_madd4_1_cma_u(0) <= RESIZE(u0_m0_wo0_mtree_madd4_1_cma_p(0),27);
    u0_m0_wo0_mtree_madd4_1_cma_u(1) <= RESIZE(u0_m0_wo0_mtree_madd4_1_cma_p(1),27);
    u0_m0_wo0_mtree_madd4_1_cma_u(2) <= RESIZE(u0_m0_wo0_mtree_madd4_1_cma_p(2),27);
    u0_m0_wo0_mtree_madd4_1_cma_u(3) <= RESIZE(u0_m0_wo0_mtree_madd4_1_cma_p(3),27);
    u0_m0_wo0_mtree_madd4_1_cma_w(0) <= u0_m0_wo0_mtree_madd4_1_cma_u(0) + u0_m0_wo0_mtree_madd4_1_cma_u(1);
    u0_m0_wo0_mtree_madd4_1_cma_w(1) <= u0_m0_wo0_mtree_madd4_1_cma_u(2) + u0_m0_wo0_mtree_madd4_1_cma_u(3);
    u0_m0_wo0_mtree_madd4_1_cma_x(0) <= u0_m0_wo0_mtree_madd4_1_cma_w(0) + u0_m0_wo0_mtree_madd4_1_cma_w(1);
    u0_m0_wo0_mtree_madd4_1_cma_y(0) <= u0_m0_wo0_mtree_madd4_1_cma_x(0);
    u0_m0_wo0_mtree_madd4_1_cma_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_madd4_1_cma_a0 <= (others => (others => '0'));
            u0_m0_wo0_mtree_madd4_1_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_madd4_1_cma_ena0 = '1') THEN
                u0_m0_wo0_mtree_madd4_1_cma_a0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr4_q),13);
                u0_m0_wo0_mtree_madd4_1_cma_a0(1) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr3_q),13);
                u0_m0_wo0_mtree_madd4_1_cma_a0(2) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr2_q),13);
                u0_m0_wo0_mtree_madd4_1_cma_a0(3) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_delayr1_q),13);
                u0_m0_wo0_mtree_madd4_1_cma_c0(0) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_1_cma_c0(1) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_1_cma_c0(2) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
                u0_m0_wo0_mtree_madd4_1_cma_c0(3) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_madd4_1_cma_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_madd4_1_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_madd4_1_cma_ena1 = '1') THEN
                u0_m0_wo0_mtree_madd4_1_cma_s(0) <= u0_m0_wo0_mtree_madd4_1_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_madd4_1_cma_delay : dspba_delay
    GENERIC MAP ( width => 27, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_mtree_madd4_1_cma_s(0)(26 downto 0)), xout => u0_m0_wo0_mtree_madd4_1_cma_qq, clk => clk, aclr => areset );
    u0_m0_wo0_mtree_madd4_1_cma_q <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_madd4_1_cma_qq(26 downto 0));

    -- u0_m0_wo0_mtree_mult1_0_cma(CHAINMULTADD,162)@10 + 2
    u0_m0_wo0_mtree_mult1_0_cma_reset <= areset;
    u0_m0_wo0_mtree_mult1_0_cma_ena0 <= '1';
    u0_m0_wo0_mtree_mult1_0_cma_ena1 <= u0_m0_wo0_mtree_mult1_0_cma_ena0;
    -- altera synthesis_off
    u0_m0_wo0_mtree_mult1_0_cma_k0 <= (
        0 => TO_SIGNED(0,12),
        1 => TO_SIGNED(-13,12),
        2 => TO_SIGNED(155,12),
        others => (others => '0'));
    -- altera synthesis_on
    u0_m0_wo0_mtree_mult1_0_cma_r(0) <= u0_m0_wo0_mtree_mult1_0_cma_k0(TO_INTEGER(u0_m0_wo0_mtree_mult1_0_cma_c0(0)));
    u0_m0_wo0_mtree_mult1_0_cma_p(0) <= u0_m0_wo0_mtree_mult1_0_cma_a0(0) * u0_m0_wo0_mtree_mult1_0_cma_r(0);
    u0_m0_wo0_mtree_mult1_0_cma_u(0) <= RESIZE(u0_m0_wo0_mtree_mult1_0_cma_p(0),25);
    u0_m0_wo0_mtree_mult1_0_cma_w(0) <= u0_m0_wo0_mtree_mult1_0_cma_u(0);
    u0_m0_wo0_mtree_mult1_0_cma_x(0) <= u0_m0_wo0_mtree_mult1_0_cma_w(0);
    u0_m0_wo0_mtree_mult1_0_cma_y(0) <= u0_m0_wo0_mtree_mult1_0_cma_x(0);
    u0_m0_wo0_mtree_mult1_0_cma_chainmultadd_input: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_0_cma_a0 <= (others => (others => '0'));
            u0_m0_wo0_mtree_mult1_0_cma_c0 <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_mult1_0_cma_ena0 = '1') THEN
                u0_m0_wo0_mtree_mult1_0_cma_a0(0) <= RESIZE(SIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_c),13);
                u0_m0_wo0_mtree_mult1_0_cma_c0(0) <= RESIZE(UNSIGNED(bank_u0_m0_wi0_wo0_merged_bit_select_b),3);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_0_cma_chainmultadd_output: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_0_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_mtree_mult1_0_cma_ena1 = '1') THEN
                u0_m0_wo0_mtree_mult1_0_cma_s(0) <= u0_m0_wo0_mtree_mult1_0_cma_y(0);
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_0_cma_delay : dspba_delay
    GENERIC MAP ( width => 25, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_mtree_mult1_0_cma_s(0)(24 downto 0)), xout => u0_m0_wo0_mtree_mult1_0_cma_qq, clk => clk, aclr => areset );
    u0_m0_wo0_mtree_mult1_0_cma_q <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_mult1_0_cma_qq(24 downto 0));

    -- u0_m0_wo0_mtree_add0_0(ADD,147)@12 + 1
    u0_m0_wo0_mtree_add0_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 25 => u0_m0_wo0_mtree_mult1_0_cma_q(24)) & u0_m0_wo0_mtree_mult1_0_cma_q));
    u0_m0_wo0_mtree_add0_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((27 downto 27 => u0_m0_wo0_mtree_madd4_1_cma_q(26)) & u0_m0_wo0_mtree_madd4_1_cma_q));
    u0_m0_wo0_mtree_add0_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add0_0_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add0_0_a) + SIGNED(u0_m0_wo0_mtree_add0_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add0_0_q <= u0_m0_wo0_mtree_add0_0_o(27 downto 0);

    -- u0_m0_wo0_mtree_add1_0(ADD,152)@13 + 1
    u0_m0_wo0_mtree_add1_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_add0_0_q(27)) & u0_m0_wo0_mtree_add0_0_q));
    u0_m0_wo0_mtree_add1_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((28 downto 28 => u0_m0_wo0_mtree_add0_1_q(27)) & u0_m0_wo0_mtree_add0_1_q));
    u0_m0_wo0_mtree_add1_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add1_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add1_0_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add1_0_a) + SIGNED(u0_m0_wo0_mtree_add1_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add1_0_q <= u0_m0_wo0_mtree_add1_0_o(28 downto 0);

    -- u0_m0_wo0_mtree_add2_0(ADD,154)@14 + 1
    u0_m0_wo0_mtree_add2_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => u0_m0_wo0_mtree_add1_0_q(28)) & u0_m0_wo0_mtree_add1_0_q));
    u0_m0_wo0_mtree_add2_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((29 downto 29 => u0_m0_wo0_mtree_add1_1_q(28)) & u0_m0_wo0_mtree_add1_1_q));
    u0_m0_wo0_mtree_add2_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add2_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add2_0_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add2_0_a) + SIGNED(u0_m0_wo0_mtree_add2_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add2_0_q <= u0_m0_wo0_mtree_add2_0_o(29 downto 0);

    -- u0_m0_wo0_mtree_add3_0(ADD,155)@15 + 1
    u0_m0_wo0_mtree_add3_0_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 30 => u0_m0_wo0_mtree_add2_0_q(29)) & u0_m0_wo0_mtree_add2_0_q));
    u0_m0_wo0_mtree_add3_0_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((30 downto 28 => u0_m0_wo0_mtree_add0_4_q(27)) & u0_m0_wo0_mtree_add0_4_q));
    u0_m0_wo0_mtree_add3_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_add3_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_add3_0_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_mtree_add3_0_a) + SIGNED(u0_m0_wo0_mtree_add3_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_add3_0_q <= u0_m0_wo0_mtree_add3_0_o(30 downto 0);

    -- GND(CONSTANT,0)@0
    GND_q <= "0";

    -- d_u0_m0_wo0_compute_q_15(DELAY,175)@12 + 3
    d_u0_m0_wo0_compute_q_15 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => d_u0_m0_wo0_compute_q_12_q, xout => d_u0_m0_wo0_compute_q_15_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_oseq_gated_reg(REG,156)@15 + 1
    u0_m0_wo0_oseq_gated_reg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= STD_LOGIC_VECTOR(d_u0_m0_wo0_compute_q_15_q);
        END IF;
    END PROCESS;

    -- out0_m0_wo0_lineup_select_delay_0(DELAY,158)@16
    out0_m0_wo0_lineup_select_delay_0_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_gated_reg_q);

    -- out0_m0_wo0_assign_id3(DELAY,160)@16
    out0_m0_wo0_assign_id3_q <= STD_LOGIC_VECTOR(out0_m0_wo0_lineup_select_delay_0_q);

    -- xOut(PORTOUT,161)@16 + 1
    xOut_v <= out0_m0_wo0_assign_id3_q;
    xOut_c <= STD_LOGIC_VECTOR("0000000" & GND_q);
    xOut_0 <= u0_m0_wo0_mtree_add3_0_q;

END normal;
