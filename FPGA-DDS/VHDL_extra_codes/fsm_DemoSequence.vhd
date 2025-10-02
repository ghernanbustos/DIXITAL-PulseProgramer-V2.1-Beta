--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         fsm_DemoSequence.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 03/2023 Guillermo H. Bustos
--
--	  Brief: 
--		fsm to run demo test, sequence three finite state machines, the fsm 
--		remains in state3 running the demo sequence up to reset signal is set
--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

ENTITY fsm_DemoSequence IS
  port (
		clk_fsm     		: 	IN  std_logic; -- clk_fsm 50Mhz
		rst_n_fsm   		: 	IN  std_logic;  
		
		init_demo			: 	IN  std_logic;  
		fsm_initEnd   		: 	IN  std_logic;  
		fsm_fwtEnd			: 	IN  std_logic;  
		
		-- mux control
		muxSel			 	:	OUT std_logic_vector(1 downto 0);
		start_FSMinit		:	OUT std_logic; 
		start_FSMfwt		:	OUT std_logic; 
		start_FSMpwt	 	:	OUT std_logic;
		last_state_DB	 	:	OUT std_logic
  );
END ENTITY fsm_DemoSequence;
------------------------------------------------
ARCHITECTURE Behavioral OF fsm_DemoSequence IS
  -- Signals declarations
  TYPE state_type IS (state_reset, state_1, state_2,state_3,state_4);
  SIGNAL state : state_type; 														 
  
BEGIN
state_transition: PROCESS (clk_fsm, rst_n_fsm, init_demo,fsm_initEnd,fsm_fwtEnd) 	 
  	-- Variables declarations
	VARIABLE count : INTEGER RANGE 0 TO 1; 				--  
	BEGIN
		IF (rst_n_fsm = '0') THEN   							--  
			state <= state_reset;			
		ELSIF (clk_fsm'EVENT AND clk_fsm ='1') THEN   				 
			CASE state IS
				WHEN state_reset =>
					IF (init_demo= '1') THEN 
						state <= state_1;
					ELSE	
						state <= state_reset; 
					END IF;
				WHEN state_1 =>		-- Enble mem			 
					IF (fsm_initEnd='1') THEN 
						state <= state_2;
					ELSE	
						state <= state_1; 
					END IF; 
				WHEN state_2 =>		
					IF (fsm_fwtEnd='1') THEN 
						state <= state_3;
					ELSE	
						state <= state_2; 
					END IF; 
				WHEN state_3 => 
					state <= state_4;	
				WHEN state_4 => -- remains in S3 to run the demo sequence
					state <= state_4;						
			END CASE;
		END IF;
	END PROCESS state_transition;
  
  
Output_logic: PROCESS (state)
	BEGIN							
 		CASE state IS
			WHEN state_reset => -- Initial state/reset state
				-- fsm control
				muxSel			<= "00"; 	
				start_FSMinit	<= '0';	
				start_FSMfwt	<= '0';
				start_FSMpwt	<= '0';
				last_state_DB  <= '0';
			WHEN state_1 => 				-- DDS initialization
				muxSel			<= "00"; 	
				start_FSMinit	<= '1';	
				start_FSMfwt	<= '0';
				start_FSMpwt	<= '0';
				last_state_DB  <= '0';
			WHEN state_2 => 				-- set frequency word
				muxSel			<= "01"; 	
				start_FSMinit	<= '0';	
				start_FSMfwt	<= '1';
				start_FSMpwt	<= '0';
				last_state_DB  <= '0';
			WHEN state_3 => 				-- set phase word on 
				muxSel			<= "10"; 	
				start_FSMinit	<= '0';	
				start_FSMfwt	<= '0';
				start_FSMpwt	<= '1';
				last_state_DB  <= '0';
			WHEN state_4 =>				-- set NCO start
				muxSel			<= "10"; 	
				start_FSMinit	<= '0';	
				start_FSMfwt	<= '0';
				start_FSMpwt	<= '0';
				last_state_DB  <= '1';
		END CASE;
	END PROCESS Output_logic; 

END ARCHITECTURE Behavioral;