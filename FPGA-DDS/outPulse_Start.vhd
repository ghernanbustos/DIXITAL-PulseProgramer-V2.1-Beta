library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY outPulse_Start IS
  port (
		clk_in   		: 	IN  std_logic; 
		push_Button		: 	IN  std_logic;  
		--	
		outPulse			:	OUT std_logic
  );
END ENTITY outPulse_Start;
------------------------------------------------
ARCHITECTURE Behavioral OF outPulse_Start IS

  TYPE state_type IS (state_reset, state_1);
  SIGNAL state : state_type; 														 

BEGIN
state_transition: PROCESS (clk_in, push_Button) 	 
  	-- Variables declarations

	BEGIN
		IF (rst_n_fsm = '0') THEN   							--  
			state <= state_reset;	
		ELSIF (clk_in'EVENT AND clk_in ='1') THEN   				 
			CASE state IS
				WHEN state_reset =>
					IF (start_fsmTest = '1') THEN  
						state <= state_1;	--  
					ELSE 
						state <= state_reset;
					END IF;
				WHEN state_1 =>		-- Enble mem			 
					state <= state_2;  
			
			END CASE;
		END IF;
	END PROCESS state_transition;
  
  
Output_logic: PROCESS (state)
	BEGIN							
 		CASE state IS
			WHEN state_reset => 
				masterRst	 	<= '0';	
			WHEN state_1 => 
				masterRst	 	<= '0';	
		END CASE;
	END PROCESS Output_logic;  

END ARCHITECTURE Behavioral;