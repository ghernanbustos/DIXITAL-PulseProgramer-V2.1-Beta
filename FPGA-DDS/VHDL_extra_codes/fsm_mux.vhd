--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         fsm_mux.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 03/2023 Guillermo H. Bustos
--
--	  Brief: 
--		
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------
ENTITY fsm_mux IS
	PORT (	-- 2nd FSM_2 Ports
				mRst_1	: IN STD_LOGIC;
				io_ud_1	: IN STD_LOGIC;
				osk_1		: IN STD_LOGIC;
				rd1_n		: IN STD_LOGIC;
				wr1_n		: IN STD_LOGIC;
				FSK_1		: IN STD_LOGIC;
				data_1	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
				address_1: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
				
				-- 2nd FSM_2 Ports
				mRst_2	: IN STD_LOGIC;
				io_ud_2	: IN STD_LOGIC;
				osk_2		: IN STD_LOGIC;
				rd2_n		: IN STD_LOGIC;
				wr2_n		: IN STD_LOGIC;
				FSK_2		: IN STD_LOGIC;
				data_2	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
				address_2: IN STD_LOGIC_VECTOR(5 DOWNTO 0);

				-- 2nd FSM_2 Ports
				mRst_3	: IN STD_LOGIC;
				io_ud_3	: IN STD_LOGIC;
				osk_3		: IN STD_LOGIC;
				rd3_n		: IN STD_LOGIC;
				wr3_n		: IN STD_LOGIC;
				FSK_3		: IN STD_LOGIC;
				data_3	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
				address_3: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
				
				-- OUT PORTS
				mRst_x	: OUT STD_LOGIC;
				io_ud_x	: OUT STD_LOGIC;
				rdx_n		: OUT STD_LOGIC;
				wrx_n		: OUT STD_LOGIC;
				osk_x		: OUT STD_LOGIC;
				FSK_x		: OUT STD_LOGIC;
				data_x	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
				address_x: OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
				-- sel_fsm
				sel_fsm	: IN  STD_LOGIC
			);			
END fsm_mux;

ARCHITECTURE fsm_mux1 OF fsm_mux IS
BEGIN
	with sel_fsm select
	mRst_x		<=	mRst_1 		WHEN sel_fsm = '0'	
										ELSE	mRst_2;
	io_ud_x 		<=	io_ud_1 		WHEN sel_fsm = '0'  	
										ELSE	io_ud_2;
	osk_x 		<=	osk_1 		WHEN sel_fsm = '0' 	
										ELSE	osk_2;
	FSK_x 		<=	FSK_1 		WHEN sel_fsm = '0' 	
										ELSE	FSK_2;
										
	rdx_n 		<=	rd1_n 		WHEN sel_fsm = '0' 	
										ELSE	rd2_n;
	wrx_n 		<=	wr1_n 		WHEN sel_fsm = '0' 	
										ELSE	wr2_n;
										
	data_x 		<=	data_1		WHEN sel_fsm = '0' 	
										ELSE	data_2;
	address_x 	<=	address_1 	WHEN sel_fsm = '0' 	
										ELSE	address_2;
 END fsm_mux1;

 
 
 
 
 
 
 
 
--	mRst_x		<=	mRst_1 		WHEN sel_fsm = '0'	
--										ELSE	mRst_2;
--	io_ud_x 		<=	io_ud_1 		WHEN sel_fsm = '0'  	
--										ELSE	io_ud_2;
--	osk_x 		<=	osk_1 		WHEN sel_fsm = '0' 	
--										ELSE	osk_2;
--	FSK_x 		<=	FSK_1 		WHEN sel_fsm = '0' 	
--										ELSE	FSK_2;
--										
--	rdx_n 		<=	rd1_n 		WHEN sel_fsm = '0' 	
--										ELSE	rd2_n;
--	wrx_n 		<=	wr1_n 		WHEN sel_fsm = '0' 	
--										ELSE	wr2_n;
--										
--	data_x 		<=	data_1		WHEN sel_fsm = '0' 	
--										ELSE	data_2;
--	address_x 	<=	address_1 	WHEN sel_fsm = '0' 	
--										ELSE	address_2;