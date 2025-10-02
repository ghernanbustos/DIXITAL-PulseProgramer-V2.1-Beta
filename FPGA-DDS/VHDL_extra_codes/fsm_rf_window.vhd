--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         fsm_rf_window.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 09/2023 Guillermo H. Bustos
--
--	  Brief: 
-- 		Rf pulse window , set the windows to allow rf signal be inyected to the sample
--			This window depends on square output signal from NCO to be synchronized both, 
--				window and nco signal length.
--			Be aware about the clock signal used to sequence the fsm
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY fsm_rf_window IS
  port (
		rf_window_clk     		: 	IN  std_logic; -- clock_50mhz
		rf_window_rst_n   		: 	IN  std_logic; 
		rf_window_initFsm 		: 	IN  std_logic; 		
		-- Out Data
		rf_window_out				:	OUT std_logic;	-- Rf out pulse window
		rf_window_flag				:	OUT std_logic 
  );
END ENTITY fsm_rf_window;
------------------------------------------------
ARCHITECTURE Behavioral OF fsm_rf_window IS
  -- Signals declarations
	TYPE state_type IS (state_init, state_1, state_2);	
	SIGNAL state   : state_type;
	
BEGIN
--------------------------------------------------------------------------
-- state_transition : this process set fsm transitions
--------------------------------------------------------------------------
state_transition: PROCESS (rf_window_clk, rf_window_rst_n, rf_window_initFsm) 	--sensitive list
	BEGIN
		IF (rf_window_rst_n = '0') THEN   -- asynchronous reset
			state <= state_init;	
		ELSIF rising_edge(rf_window_clk) THEN 
			CASE state IS
				WHEN state_init =>			
					IF (rf_window_initFsm = '1') THEN 
						state <= state_1;	
					ELSE 
						state <= state_init; 
					END IF;
				WHEN state_1 =>  
						state <= state_2;
				WHEN state_2 =>	-- steady until external reset signal is set
						state <= state_2;			
			END CASE;
		END IF;
	END PROCESS state_transition;
  
Output_logic: PROCESS (state) -- when state changes this process is active
	BEGIN							
 		CASE state IS
			WHEN state_init => 	--  Reset all , initial satate
				rf_window_out 			<= '0';	 	
				rf_window_flag			<= '0';	 	

			WHEN state_1	 => 	-- on rf window
				rf_window_out 			<= '1';	 	
				rf_window_flag			<= '0';	 	

			WHEN state_2	 =>	-- off rf window set off flag on
				rf_window_out 			<= '0';	 	
				rf_window_flag			<= '1';	 	
		END CASE;
	END PROCESS Output_logic; -- Outputs are updated at the end of the process

END ARCHITECTURE Behavioral;