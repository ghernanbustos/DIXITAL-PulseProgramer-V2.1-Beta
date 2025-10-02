library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY chronoV3 IS
  port (
		clk_chrono 			: in 	std_logic; -- Clock in 50Mhz
		nRst_chrono 		: in 	std_logic;
		--
		en_chrono   		: in  std_logic;
		setPrecount			: in  std_logic;
		precountValue		: in  std_logic_vector(31 downto 0);
		-- 
		pulseSignal			: out std_logic; -- RF Window.
		overflowChrono		: out std_logic 	-- overflow signal

  );
END ENTITY chronoV3;
------------------------------------------------
ARCHITECTURE Behavioral OF chronoV3 IS
  -- Signals declarations
  TYPE state_type IS (initialState, state_0, state_1,state_2,state_3);	-- Enumerated type decl
  SIGNAL state : state_type; 											-- state_type is signal type

BEGIN
state_transition: PROCESS (clk_chrono, nRst_chrono) 	--sensitive list
  	-- Variables declarations
	VARIABLE count 				: INTEGER RANGE 0 TO 4294967296;
	VARIABLE count_max 			: INTEGER := 4294967296;	

	
	BEGIN
		IF (nRst_chrono = '0') THEN   			-- asynchronous reset
				state <= initialState;
				count := 0;
		ELSIF rising_edge(clk_chrono) THEN -- Change State
			CASE state IS
				WHEN initialState =>
						IF (en_chrono = '1') THEN 
							state <= state_0;	
						ELSE 
							state <= initialState; 
						END IF;
					
				WHEN state_0 => -- set preCount value
						count 	:= to_integer(unsigned(precountValue));		
						state <= state_1;
						
				WHEN state_1 => -- init counting		
						count := count + 1;
						state <= state_2;
						
				WHEN state_2 => -- ends or keeps counting
						IF (count = count_max) THEN 
							count := 0;
							state <= state_3;
						ELSE 
							state <= state_1;
							count := count + 1;	
						END IF;	
				WHEN state_3 => -- waits for reset signal
						state <= state_3;	
			END CASE;
		END IF;
	END PROCESS state_transition;
  
  
Output_logic: PROCESS (state)
	BEGIN							
 		CASE state IS
			WHEN initialState =>
					-- FPGA internal RAM control			 						
				pulseSignal			<= '0';	
				overflowChrono		<= '0';	
				
			WHEN state_0 => -- set prescaler value
				pulseSignal			<= '0';	
				overflowChrono		<= '0';				
				
			WHEN state_1 =>		-- counter
				pulseSignal			<= '1';	
				overflowChrono		<= '0';				

			WHEN state_2 => -- check count			
				pulseSignal			<= '1';	
				overflowChrono		<= '0';	
				
			WHEN state_3 => -- count ends			
				pulseSignal			<= '0';	
				overflowChrono		<= '1';							

		END CASE;
	END PROCESS Output_logic; -- Outputs are updated at the end of the process

END ARCHITECTURE Behavioral;