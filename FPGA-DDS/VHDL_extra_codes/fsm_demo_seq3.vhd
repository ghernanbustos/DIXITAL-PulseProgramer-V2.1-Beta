--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         fsm_demo_seq3.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 09/2023 Guillermo H. Bustos
--
--	  Brief: 
-- 		Sequence demo RAFA VERSION pulse to test signal in 90mhz spectrometer
--			Timers used always need 1 clock cycle to pre load counter
--			Changes: Add one more state and Blanking signal start before Window RF.
--				Blanking Window is controlled by fsm state, not by external timer

--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY fsm_demo_seq3 IS
  port (
		fsm_seq_clk     		: 	IN  std_logic; -- clock_50mhz
		fsm_seq_rst_n   		: 	IN  std_logic; 
		fsm_seq_initFsm 		: 	IN  std_logic; 
		-- In timers flags
		windowRF_EndFlag 		: 	IN  std_logic; 
--		blanking_EndFlag 		: 	IN  std_logic; 	
		seq_timer_EndFlag		: 	IN  std_logic; 		
		-- Out Data timer signals
		fsm_seq_timerNCO_en		:	OUT std_logic;
		fsm_seq_timerNCO_rst		:	OUT std_logic;	
		
		fsm_seq_timerRF_en		:	OUT std_logic;
		fsm_seq_timerRF_rst		:	OUT std_logic;
		fsm_seq_timerRF_preEn	:	OUT std_logic;
		
		fsm_seq_timerBK_en		:	OUT std_logic;
		fsm_seq_timerBK_rst		:	OUT std_logic;
		fsm_seq_timerBK_preEn	:	OUT std_logic;
		
		fsm_seq_timerMain_en		:	OUT std_logic;
		fsm_seq_timerMain_rst	:	OUT std_logic;
		fsm_seq_timerMain_preEn	:	OUT std_logic;
		
--		Out windows signals
		fsm_seq_dsoTrigger	: OUT std_logic;
		fsm_seq_windowBlank	: OUT std_logic;
		-- Debug signal
		s0							: OUT std_logic;
		s1							: OUT std_logic;
		s2							: OUT std_logic;
		s3							: OUT std_logic;
		s4							: OUT std_logic
  );
END ENTITY fsm_demo_seq3;
------------------------------------------------
ARCHITECTURE Behavioral OF fsm_demo_seq3 IS
  -- Signals declarations
	TYPE state_type IS (state_init, state_1,state_1_bis, state_2, state_3,state_4);	
	SIGNAL state   : state_type;
	
BEGIN
--------------------------------------------------------------------------
-- state_transition : this process set fsm transitions
--------------------------------------------------------------------------
state_transition: PROCESS (fsm_seq_clk, fsm_seq_rst_n, fsm_seq_initFsm) 	--sensitive list
VARIABLE count_blW 		: INTEGER RANGE 0 TO 25000; -- Blanking window counter (20nS x 25 = 500uS)
	BEGIN
		IF (fsm_seq_rst_n = '0') THEN   -- asynchronous reset
			state <= state_init;	
			count_blW := 0;
		ELSIF rising_edge(fsm_seq_clk) THEN 
			CASE state IS
				WHEN state_init =>			
					IF (fsm_seq_initFsm = '1') THEN 
						state <= state_1;	
					ELSE 
						state <= state_init; 
					END IF;
				WHEN state_1 =>  
						state <= state_1_bis;
				WHEN state_1_bis =>  
					count_blW := count_blW + 1;				-- 
					IF (count_blW=25000) THEN count_blW := 0;
						state <= state_2;
					ELSE 
						state <= state_1_bis; 
					END IF;
				WHEN state_2 =>	-- Window on - NCO on
					IF (windowRF_EndFlag = '0') THEN 
						state <= state_2;	
					ELSE 
						state <= state_3; 
					END IF;			
				WHEN state_3 =>	-- DSO trigger pulse
--					IF (blanking_EndFlag = '0') THEN 
--						state <= state_3;	
--					ELSE 			
						state <= state_4;
--					END IF;				
				WHEN state_4 =>
					IF (seq_timer_EndFlag = '0') THEN 
						state <= state_4;	
					ELSE 			
						state <= state_1;
					END IF;				
			END CASE;
		END IF;
	END PROCESS state_transition;
  
  
Output_logic: PROCESS (state) -- when state changes this process is active
	BEGIN							
 		CASE state IS
			WHEN state_init => 							--  Reset all 
				fsm_seq_timerNCO_en		 	<= '0';
				fsm_seq_timerNCO_rst		 	<= '0';
				
				fsm_seq_timerRF_en		 	<= '0';
				fsm_seq_timerRF_rst		 	<= '0';
				fsm_seq_timerRF_preEn	   <= '0';
				
				fsm_seq_timerBK_en			<= '0';
				fsm_seq_timerBK_rst			<= '0';
				fsm_seq_timerBK_preEn		<= '0';
				
				fsm_seq_timerMain_en			<= '0';
				fsm_seq_timerMain_rst		<= '0';
				fsm_seq_timerMain_preEn		<= '0';

				fsm_seq_dsoTrigger			<= '0';
				fsm_seq_windowBlank			<= '0';
				
				s0									<= '1';
				s1									<= '0';
				s2									<= '0';
				s3									<= '0';
				s4									<= '0';

			WHEN state_1	 =>		 					-- pre load timers one cycle
				fsm_seq_timerNCO_en		 	<= '0';  
				fsm_seq_timerNCO_rst		 	<= '0';
				
				fsm_seq_timerRF_en		 	<= '1';   
				fsm_seq_timerRF_rst		 	<= '1';
				fsm_seq_timerRF_preEn	   <= '1';
				
				fsm_seq_timerBK_en			<= '0';  
				fsm_seq_timerBK_rst			<= '0';
				fsm_seq_timerBK_preEn		<= '0';
				
				fsm_seq_timerMain_en			<= '1';  
				fsm_seq_timerMain_rst		<= '1';
				fsm_seq_timerMain_preEn		<= '1';

				fsm_seq_dsoTrigger			<= '0';
				fsm_seq_windowBlank			<= '0';
				
				s0									<= '0';
				s1									<= '1';
				s2									<= '0';
				s3									<= '0';
				s4									<= '0';

			WHEN state_1_bis	 =>		 					-- start main timer and blanking window
				fsm_seq_timerNCO_en		 	<= '0';  
				fsm_seq_timerNCO_rst		 	<= '0';
				
				fsm_seq_timerRF_en		 	<= '0';   
				fsm_seq_timerRF_rst		 	<= '1';
				fsm_seq_timerRF_preEn	   <= '1';
				
				fsm_seq_timerBK_en			<= '0';  
				fsm_seq_timerBK_rst			<= '0';
				fsm_seq_timerBK_preEn		<= '0';
				
				fsm_seq_timerMain_en			<= '1';  
				fsm_seq_timerMain_rst		<= '1';
				fsm_seq_timerMain_preEn		<= '1';

				fsm_seq_dsoTrigger			<= '0';
				fsm_seq_windowBlank			<= '1';
				
				s0									<= '0';
				s1									<= '1';
				s2									<= '0';
				s3									<= '0';
				s4									<= '0';

			WHEN state_2	 =>		 					-- NCO / main timer on
				fsm_seq_timerNCO_en		 	<= '1'; -- nco ON
				fsm_seq_timerNCO_rst		 	<= '1';
				
				fsm_seq_timerRF_en		 	<= '1'; -- rf window on
				fsm_seq_timerRF_rst		 	<= '1';
				fsm_seq_timerRF_preEn	   <= '0';
				
				fsm_seq_timerBK_en			<= '0'; -- Blank wind off but not reset
				fsm_seq_timerBK_rst			<= '0';
				fsm_seq_timerBK_preEn		<= '0';
				
				fsm_seq_timerMain_en			<= '1'; --main timer on
				fsm_seq_timerMain_rst		<= '1';
				fsm_seq_timerMain_preEn		<= '0';

				fsm_seq_dsoTrigger			<= '0';
				fsm_seq_windowBlank			<= '1';
				
				s0									<= '0';
				s1									<= '0';
				s2									<= '1';
				s3									<= '0';
				s4									<= '0';
				
			WHEN state_3	 =>		 			-- dso trigger / main timer on
				fsm_seq_timerNCO_en		 	<= '0'; -- nco ON
				fsm_seq_timerNCO_rst		 	<= '0';
				
				fsm_seq_timerRF_en		 	<= '0'; -- rf window on
				fsm_seq_timerRF_rst		 	<= '0';
				fsm_seq_timerRF_preEn	   <= '0';
				
				fsm_seq_timerBK_en			<= '0'; -- Blank window on but not reset
				fsm_seq_timerBK_rst			<= '0';
				fsm_seq_timerBK_preEn		<= '0';
				
				fsm_seq_timerMain_en			<= '1'; --main timer on
				fsm_seq_timerMain_rst		<= '1';
				fsm_seq_timerMain_preEn		<= '0';

				fsm_seq_dsoTrigger			<= '1'; -- Trigger
				fsm_seq_windowBlank			<= '0'; -- blanking off
				
				s0									<= '0';
				s1									<= '0';
				s2									<= '0';
				s3									<= '1';
				s4									<= '0';
				
			WHEN state_4	 =>		      -- reset all timer off
				fsm_seq_timerNCO_en		 	<= '0'; -- nco ON
				fsm_seq_timerNCO_rst		 	<= '0';
				
				fsm_seq_timerRF_en		 	<= '0'; -- rf window on
				fsm_seq_timerRF_rst		 	<= '0';
				fsm_seq_timerRF_preEn	   <= '0';
				
				fsm_seq_timerBK_en			<= '0'; -- Blank wind off but not reset
				fsm_seq_timerBK_rst			<= '0';
				fsm_seq_timerBK_preEn		<= '0';
				
				fsm_seq_timerMain_en			<= '1'; --main timer on
				fsm_seq_timerMain_rst		<= '1';
				fsm_seq_timerMain_preEn		<= '0';

				fsm_seq_dsoTrigger			<= '0';
				fsm_seq_windowBlank			<= '0';
				
				s0									<= '0';
				s1									<= '0';
				s2									<= '0';
				s3									<= '0';
				s4									<= '1';
				
		END CASE;
	END PROCESS Output_logic; -- Outputs are updated at the end of the process

END ARCHITECTURE Behavioral;