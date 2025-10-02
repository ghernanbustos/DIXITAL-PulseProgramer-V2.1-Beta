--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         fsm1_starup.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 03/2023 Guillermo H. Bustos
--
--	  Brief: 
--		Data path to initiate AD9854 stage
--		Master Reset needs to be 10 internal clock cycles to initialize the registers
--			Check Internal DDS Frecuency if 300Mhz or 150Mhz (preescaler) to avoid issues
--			reseting the module.
--			Some FSM states can be deleted, check this in future enhancement stages
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

ENTITY fsm1_startup IS
  port (
		clk_fsm1     	: 	IN  std_logic; -- clk_fsm1 25Mhz
		rst_n_fsm1   	: 	IN  std_logic; -- External switch
		start_fsm1		: 	IN  std_logic; -- Push button tu start fsm
		-- Mux Control
		out_mux  		: 	OUT std_logic; -- MUX switch to next fsm data	
		-- Debugging flags
		s0,s1,s2,s3,s4	:	OUT std_logic;	
		-- DDS Write Data Control	
		masterRst	 	:	OUT std_logic;	-- dds Master Rst on
		rd_n			 	: 	OUT std_logic; -- Read off
		wd_n			 	:	OUT std_logic;	-- write off
		FSK_BPSK_HOLD	:	OUT std_logic;
		I_O_update		:	OUT std_logic;
		-- DDS data init
		address			:	OUT std_logic_vector(5 downto 0); -- leftmost bit being the MSB
		data				:	OUT std_logic_vector(7 downto 0)
  );
END ENTITY fsm1_startup;
------------------------------------------------
ARCHITECTURE Behavioral OF fsm1_startup IS
  -- Signals declarations
  TYPE state_type IS (state_0, state_1, state_2, state_3, state_4);	-- Enumerated type decl
  SIGNAL state : state_type; 														-- state_type is signal type
  CONSTANT initialValReg 	: std_logic_vector(5 downto 0) := "000000";
  CONSTANT initialValData 	: std_logic_vector(7 downto 0) := X"00";   
  CONSTANT addressReg 		: std_logic_vector(5 downto 0) := "011111"; 	
  CONSTANT dataReg 			: std_logic_vector(7 downto 0) := X"00"; 		
  
BEGIN
state_transition: PROCESS (clk_fsm1, rst_n_fsm1, start_fsm1) 	--sensitive list
  	-- Variables declarations
	VARIABLE count : INTEGER RANGE 0 TO 6; 				-- Clock delay
	BEGIN
		IF (rst_n_fsm1 = '0') THEN   							-- asynchronous reset
			state <= state_0;						 				-- start_fsm1 works as start or reset
		ELSIF (clk_fsm1'EVENT AND clk_fsm1 ='1') THEN   				-- Change State
			CASE state IS
				WHEN state_0 =>
					IF (start_fsm1 = '1') THEN -- take in account to set edge detection
						state <= state_1;	-- if start_fsm1 = 0 , remains in state_0
					ELSE 
						state <= state_0;
					END IF;
			
				WHEN state_1 =>					-- Master Reset State need 10 internal clock Cycles
				count := count + 1;				-- 
					IF (count=6) THEN count := 0;
						state <= state_2;
					ELSE 
						state <= state_1; 
						END IF;
	
				WHEN state_2 =>					-- Set Reg Word
					state <= state_3;  

				WHEN state_3 =>					-- Write Reg
					state <= state_4; 

				WHEN state_4 =>					-- Mux '1'
					IF  (rst_n_fsm1 = '0') THEN
						state <= state_0;
					ELSE
						state <= state_4; 						
 			  		END IF;
			END CASE;
		END IF;
	END PROCESS state_transition;
  
  
Output_logic: PROCESS (state)
	BEGIN							
 		CASE state IS
			WHEN state_0 =>
				out_mux			<= '0'; 
				masterRst	 	<= '0';	-- dds Master Rst off
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '1';	-- write off
				FSK_BPSK_HOLD	<= 'Z';	-- check if Z or X (unknown)
				I_O_update		<= 'Z';
				address			<= initialValReg; --"000000"
				data				<= initialValData; --"000000"
				s0	<= '1';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				
			WHEN state_1 =>
				out_mux			<= '0'; 
				masterRst	 	<= '1';	-- dds Master Rst on 
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '1';	-- write off
				FSK_BPSK_HOLD	<= 'Z';	-- check if Z or X (unknown)
				I_O_update		<= 'Z';
				address			<= initialValReg; --"000000"
				data				<= initialValData; --"000000"
				s0	<= '0';
				s1	<= '1';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';

			WHEN state_2 =>				
				out_mux			<= '0'; 
				masterRst	 	<= '0';	-- dds Master 
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '1';	-- write off
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= 'Z';
				address			<= addressReg; 		-- XX01_1111
				data				<= initialValData; 	--	"000000"
				s0	<= '0';
				s1	<= '0';				
				s2	<= '1';
				s3	<= '0';
				s4	<= '0';
	
			WHEN state_3 =>
				out_mux			<= '0'; 
				masterRst	 	<= '0';	-- dds Master 
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '0';	-- write ON
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= 'Z';
				address			<= addressReg; -- XX01_1111
				data				<= dataReg;		--"000000"
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '1';
				s4	<= '0';
				
			WHEN state_4 =>
				out_mux			<= '1'; 	--MUX ON
				masterRst	 	<= '0';	-- dds Master Rst off
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '1';	-- write Off
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= 'Z';
				address			<= initialValReg; -- XX01_1111
				data				<= dataReg;			--"000000"
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '1';

		END CASE;
	END PROCESS Output_logic; -- Outputs are updated at the end of the process

END ARCHITECTURE Behavioral;