library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY fsm_pwt_test IS
  port (
		clk_fsm     		: 	IN  std_logic; -- clk_fsm 50Mhz
		rst_n_fsm   		: 	IN  std_logic; -- External switch
		start_fsmTest		: 	IN  std_logic; -- Push button tu start fsm
				
		-- DDS Write Data Control	
		masterRst	 		:	OUT std_logic;	-- dds Master Rst on
		rd_n			 		: 	OUT std_logic; -- Read off
		wd_n			 		:	OUT std_logic;	-- write off
		FSK_BPSK_HOLD		:	OUT std_logic;
		I_O_update			:	OUT std_logic;
		-- Phase Data
		dds_phase			:	OUT std_logic_vector(15 downto 0);
		-- Output Signal to trigger Dso and measure phase shift
		phaseShiftActive	:	OUT std_logic

  );
END ENTITY fsm_pwt_test;
------------------------------------------------
ARCHITECTURE Behavioral OF fsm_pwt_test IS
  -- Signals declarations
  TYPE state_type IS (state_reset, state_1, state_2,state_3,state_4,state_5);
  SIGNAL state : state_type; 														 
  CONSTANT phaseMsb  	: std_logic_vector(15 downto 0) := X"0020"; -- 0020
  CONSTANT phaseLsb  	: std_logic_vector(15 downto 0) := X"0100"; -- 0100
BEGIN
state_transition: PROCESS (clk_fsm, rst_n_fsm, start_fsmTest) 	 
  	-- Variables declarations
	VARIABLE count : INTEGER RANGE 0 TO 1; 				--  
	BEGIN
		IF (rst_n_fsm = '0') THEN   							--  
			state <= state_reset;
			count := 0;			
		ELSIF (clk_fsm'EVENT AND clk_fsm ='1') THEN   				 
			CASE state IS
				WHEN state_reset =>
					IF (start_fsmTest = '1') THEN  
						state <= state_1;	--  
					ELSE 
						state <= state_reset;
					END IF;
				WHEN state_1 =>		-- Enble mem			 
					state <= state_2;  
				WHEN state_2 =>		-- Enble mem			 
					state <= state_3;
				WHEN state_3 =>					
					state <= state_4;
				WHEN state_4 =>					 
					state <= state_5;
				WHEN state_5 =>					  
					state <= state_5;					
			END CASE;
		END IF;
	END PROCESS state_transition;
  
  
Output_logic: PROCESS (state)
	BEGIN							
 		CASE state IS
			WHEN state_reset => -- Initial state/reset state
				--dds control
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '1';	
				FSK_BPSK_HOLD	<= 'Z';	
				I_O_update		<= '0';
				--
				dds_phase		<= X"0000";
				phaseShiftActive <= '0';
			WHEN state_1 => 
				--dds control				
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '1';	
				FSK_BPSK_HOLD	<= 'Z';	
				I_O_update		<= '0';
				--
				dds_phase		<= phaseMsb;
				phaseShiftActive <= '0';
			WHEN state_2 => 
				--dds control				
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '0';	-- write reg
				FSK_BPSK_HOLD	<= 'Z';	
				I_O_update		<= '0';
				dds_phase		<= phaseMsb;
				phaseShiftActive <= '0';
			WHEN state_3 => 	
				--dds control				
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '1';	-- write reg
				FSK_BPSK_HOLD	<= 'Z';	
				I_O_update		<= '0';
				dds_phase		<= phaseLsb;
				phaseShiftActive <= '0';
			WHEN state_4 =>  -- PhaseShift triggered with IO_update signal
				--dds control				
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '0';	
				FSK_BPSK_HOLD	<= 'Z';	
				I_O_update		<= '1';	-- upadte data	
				dds_phase		<= X"0000";--X"0000";
				phaseShiftActive <= '1';
			WHEN state_5 => 
				--dds control				
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '1';	
				FSK_BPSK_HOLD	<= 'Z';	
				I_O_update		<= '0';	-- upadte data	
				dds_phase		<= X"0000";--X"0000";
				phaseShiftActive <= '0';
		END CASE;
	END PROCESS Output_logic; -- Outputs are updated at the end of the process

END ARCHITECTURE Behavioral;