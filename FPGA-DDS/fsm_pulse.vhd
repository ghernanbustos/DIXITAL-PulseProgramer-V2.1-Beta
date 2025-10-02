--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos, ghernanbustos@gmail.com
--   FileName:         pulse_fsm.vhd
--   Design Software:  Quartus Prime Lite Edition 22.1 Std Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   	Version 0.0 10/2024 
--	
--	  Brief: 
-- 	
-- 	Pulse sequencer fsm 
--			This FSM sequence data from pulse program sequencer stored in RAM. Each fetched instruction
--			manage data from FTW, PTW, CHRONO, SINCWINDOW... to set DDS configuration during test.
--		Program mem holds 32 bit instructions word with 16LSB with two fields 
--								[op_code]+[data buffer address] = 32bits
--		op_code:
--			MSB 16bits are used for multiplexing data to accdess at differents buffers 
--		data buffer address:
--			LSB 16bits are use for data buffer access to set DDS registers 

--		ctrl_reg_buffer is to control external fsm buffer and multiplexer, not for pgr module, it is standar 
--			for all buffers ptw, init, ftw, chrono1, chrono2 and Sinc. 

--		The Address mem counter does not check max count overflow. 
--		External async. reset or EOF word stored in mem are the two conditional to stop sequencing.
--    count <= std_logic_vector(unsigned(count) + 1);

--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY fsm_pulse IS
  port (
		clk_pulse    				: 	IN  std_logic; -- clk_fsm_SingleTone 25Mhz
		rst_n_pulse 				: 	IN  std_logic; -- External switch
		start_pulse					: 	IN  std_logic; -- Push button tu start fsm
		
		buffer_fsm_endFlag		: 	IN  std_logic; 
		end_pgr						: 	IN	 std_logic_vector(31 downto 0); -- Read EOF word to end the sequence.
		
		-- Pulse progr Mem Control Signal
		rd_pulseMem					: 	OUT std_logic;  
		wr_pulseMem					: 	OUT std_logic; 
		en_pulseMem					: 	OUT std_logic;
		clc_pulseMem				: 	OUT std_logic;
		AddressMempulse			:	OUT std_logic_vector(5 downto 0);	
		
		-- dds block buffer Control	
		ctrl_reg_buffer			:	OUT std_logic_vector(7 downto 0); -- reg to control buffer block
		
		-- Debugging flags
		fsm_rdytoStart				:	OUT std_logic; -- to HPS 
		fsm_end_flag				: 	OUT std_logic
		
  );
END ENTITY fsm_pulse;
------------------------------------------------
ARCHITECTURE Behavioral OF fsm_pulse IS
  -- Signals declarations
	TYPE state_type IS (state_rst, state_1, state_2, state_3, state_4,state_5,state_6,state_7);	 
	SIGNAL state : state_type; 			
	SIGNAL countVarAddressPos	: unsigned(5 downto 0) := (others => '0');
  
BEGIN
state_transition: PROCESS (clk_pulse, rst_n_pulse) 	--sensitive list

	BEGIN
		IF (rst_n_pulse = '0') THEN   -- asynchronous reset
			state <= state_rst;					-- start_pulse works as start or reset
			countVarAddressPos <= (others => '0');
			AddressMempulse <= std_logic_vector(countVarAddressPos);
			
		ELSIF rising_edge(clk_pulse) THEN   				-- Change State
			CASE state IS
				WHEN state_rst =>
					IF (start_pulse = '1') THEN 
						state <= state_1;	
					ELSE 
						state <= state_rst;
					END IF;
					
				WHEN state_1 => -- 
					AddressMempulse <= std_logic_vector(countVarAddressPos);	-- convert to standar	
					state <= state_2;		

				WHEN state_2 => -- AddressMempulse avaible 	
					state <= state_3;	

				WHEN state_3 => -- ram data out
						state <= state_4;	
					
				WHEN state_4 => -- check EOF
					IF (end_pgr = x"FFFFFFFF") THEN -- end sequencing
						state <= state_7;	
					ELSE 
						state <= state_5;
					END IF;	
				
				WHEN state_5 => -- init buffer	
					IF (buffer_fsm_endFlag = '1') THEN 
						state <= state_6;	
					ELSE 
						state <= state_5;
					END IF;	

				WHEN state_6 =>	-- increase program pointer. and reset buffer
					state <= state_1;
					countVarAddressPos <= countVarAddressPos + 1; -- unsigned type		
					
				WHEN state_7 =>	-- end fsm and waits for manual reset
					state <= state_7;

			END CASE;
		END IF;
	END PROCESS state_transition;
  
  
Output_logic: PROCESS (state)
	BEGIN							
 		CASE state IS
			WHEN state_rst => -- Reset State | clear mem on
				rd_pulseMem			<= '0';	
				wr_pulseMem			<= '0';	
				en_pulseMem			<= '0';	
				clc_pulseMem 		<= '1';	-- clear mem

				ctrl_reg_buffer 	<= "00000000";	
				
				fsm_rdytoStart	 	<= '1';	-- flag to use with HPS
				fsm_end_flag	 	<= '0';
				
			WHEN state_1 => -- set pgr mem address
				rd_pulseMem			<= '0';	
				wr_pulseMem			<= '0';	
				en_pulseMem			<= '0';	
				clc_pulseMem 		<= '0';	

				ctrl_reg_buffer 	<= "00000000";	
				
				fsm_rdytoStart	 	<= '0';
				fsm_end_flag	 	<= '0';

			WHEN state_2 => -- RAM  Enable
				rd_pulseMem			<= '1';	
				wr_pulseMem			<= '0';	
				en_pulseMem			<= '1';	
				clc_pulseMem 		<= '0';	

				ctrl_reg_buffer 	<= "00000000";	-- fsm rst off, mux fsm block ctrls buffer, start fsm
				
				fsm_rdytoStart	 	<= '0';			
				fsm_end_flag	 	<= '0';

			WHEN state_3 => -- reads ram position
				rd_pulseMem			<= '1';	
				wr_pulseMem			<= '0';	
				en_pulseMem			<= '1';	
				clc_pulseMem 		<= '0';	

				ctrl_reg_buffer 	<= "10000000";	-- fsm rst off, mux fsm block ctrls buffer, start fsm	
				
				fsm_rdytoStart	 	<= '0';
				fsm_end_flag	 	<= '0';
				
			WHEN state_4 => --  check EOF
				rd_pulseMem			<= '1';	
				wr_pulseMem			<= '0';	
				en_pulseMem			<= '1';	
				clc_pulseMem 		<= '0';	

				ctrl_reg_buffer 	<= "10000000";	-- Rst fsm  buffer
				
				fsm_rdytoStart	 	<= '0';
				fsm_end_flag	 	<= '0';
				
			WHEN state_5 => --  init external buffer and waits for end flag
				rd_pulseMem			<= '1';	
				wr_pulseMem			<= '0';	
				en_pulseMem			<= '1';	
				clc_pulseMem 		<= '0';	

				ctrl_reg_buffer 	<= "10110000";	-- Rst fsm  buffer OFF
				
				fsm_rdytoStart	 	<= '0';
				fsm_end_flag	 	<= '0'; -- fsm end
				
			WHEN state_6 => --  increase mem pgr position and reset external buffer
				rd_pulseMem			<= '0';	
				wr_pulseMem			<= '0';	
				en_pulseMem			<= '0';	
				clc_pulseMem 		<= '0';	

				ctrl_reg_buffer 	<= "10000000";	-- Rst fsm  buffer and buffer mux set for PGR fsm.
				
				fsm_rdytoStart	 	<= '0';
				fsm_end_flag	 	<= '0'; -- fsm end

			WHEN state_7 => --  increase mem pgr position
				rd_pulseMem			<= '0';	
				wr_pulseMem			<= '0';	
				en_pulseMem			<= '0';	
				clc_pulseMem 		<= '0';	

				ctrl_reg_buffer 	<= "10000000";	-- Rst fsm  buffer
				
				fsm_rdytoStart	 	<= '0';
				fsm_end_flag	 	<= '1'; -- fsm end

		END CASE;
	END PROCESS Output_logic; 
END ARCHITECTURE Behavioral;