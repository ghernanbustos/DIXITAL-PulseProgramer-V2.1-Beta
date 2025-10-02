--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         fsm_demo_seq.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 09/2023 Guillermo H. Bustos
--
--	  Brief: 
-- 		Sequence demo pulse to test signal in 90mhz spectrometer

--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY fsm_demo_seq IS
  port (
		fsm_seq_clk     		: 	IN  std_logic; -- clock_50mhz
		fsm_seq_rst_n   		: 	IN  std_logic; 
		fsm_seq_initFsm 		: 	IN  std_logic; 
		window_rf_flag 		: 	IN  std_logic; 		
		seq_timer_overflow	: 	IN  std_logic; 		
		-- Out Data
		fsm_seq_ncoEn 			:	OUT std_logic;	 
		fsm_seq_ncoRst			: 	OUT std_logic; 
		fsm_seq_wind_fsmEn	:	OUT std_logic;	 
		fsm_seq_wind_fsmRst	:	OUT std_logic;
		fsm_seq_timer_en		:	OUT std_logic;
		fsm_seq_timer_rst		:	OUT std_logic;
		fsm_seq_timer_preEn	:	OUT std_logic
  );
END ENTITY fsm_demo_seq;
------------------------------------------------
ARCHITECTURE Behavioral OF fsm_demo_seq IS
  -- Signals declarations
	TYPE state_type IS (state_init, state_1, state_2, state_3,state_4);	
	SIGNAL state   : state_type;
	
BEGIN
--------------------------------------------------------------------------
-- state_transition : this process set fsm transitions
--------------------------------------------------------------------------
state_transition: PROCESS (fsm_seq_clk, fsm_seq_rst_n, fsm_seq_initFsm) 	--sensitive list
	BEGIN
		IF (fsm_seq_rst_n = '0') THEN   -- asynchronous reset
			state <= state_init;	
		ELSIF rising_edge(fsm_seq_clk) THEN 
			CASE state IS
				WHEN state_init =>			
					IF (fsm_seq_initFsm = '1') THEN 
						state <= state_1;	
					ELSE 
						state <= state_init; 
					END IF;
				WHEN state_1 =>  
						state <= state_2;
				WHEN state_2 =>	
					IF (window_rf_flag = '0') THEN 
						state <= state_2;	
					ELSE 
						state <= state_3; 
					END IF;			
				WHEN state_3 =>	
					IF (seq_timer_overflow = '0') THEN 
						state <= state_3;	
					ELSE 			
						state <= state_4;
					END IF;
				WHEN state_4 =>			 
						state <= state_1;
			END CASE;
		END IF;
	END PROCESS state_transition;
  
  
Output_logic: PROCESS (state) -- when state changes this process is active
	BEGIN							
 		CASE state IS
			WHEN state_init => --  Reset all , initial satate
				fsm_seq_ncoEn 			<= '0';	 	
				fsm_seq_ncoRst			<= '0';	 	
				fsm_seq_wind_fsmEn	<= '0';	 	
				fsm_seq_wind_fsmRst	<= '0';	 	
				fsm_seq_timer_en		<= '0';	 	
				fsm_seq_timer_rst		<= '0';	
				fsm_seq_timer_preEn  <= '1'; -- pre load 

			WHEN state_1	 =>		 
				fsm_seq_ncoEn 			<= '0';	 	
				fsm_seq_ncoRst			<= '1';	 	
				fsm_seq_wind_fsmEn	<= '1';	 	
				fsm_seq_wind_fsmRst	<= '1';	 	
				fsm_seq_timer_en		<= '1';	-- timer start 	
				fsm_seq_timer_rst		<= '1';
				fsm_seq_timer_preEn  <= '0';	

			WHEN state_2	 =>		 
				fsm_seq_ncoEn 			<= '1';	-- nco start 	
				fsm_seq_ncoRst			<= '1';	 	
				fsm_seq_wind_fsmEn	<= '1';	-- rf wind start 	
				fsm_seq_wind_fsmRst	<= '1';	 	
				fsm_seq_timer_en		<= '1';	-- keep timer on	
				fsm_seq_timer_rst		<= '1';
				fsm_seq_timer_preEn  <= '0';	
				
			WHEN state_3	 =>		 			-- Reset NCO and rf window
				fsm_seq_ncoEn 			<= '0';	-- disable nco 	
				fsm_seq_ncoRst			<= '0';	-- reset nco	
				fsm_seq_wind_fsmEn	<= '0';	-- disable window	
				fsm_seq_wind_fsmRst	<= '0';	-- reset window fsm
				fsm_seq_timer_en		<= '1';	-- keep timer on		 	
				fsm_seq_timer_rst		<= '1';	
				fsm_seq_timer_preEn  <= '0';

				WHEN state_4	 =>		      -- reset all timer off
				fsm_seq_ncoEn 			<= '0';	 	
				fsm_seq_ncoRst			<= '0';	 	
				fsm_seq_wind_fsmEn	<= '0';	 	
				fsm_seq_wind_fsmRst	<= '0';	 	
				fsm_seq_timer_en		<= '0';	 	
				fsm_seq_timer_rst		<= '0';	
				fsm_seq_timer_preEn  <= '0';
				
		END CASE;
	END PROCESS Output_logic; -- Outputs are updated at the end of the process

END ARCHITECTURE Behavioral;