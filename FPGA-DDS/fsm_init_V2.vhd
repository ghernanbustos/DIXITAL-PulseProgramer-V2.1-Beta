--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos, ghernanbustos@gmail.com
--   FileName:         fsm_init_SingleToneV2.vhd
--   Design Software:  Quartus Prime Lite Edition 22.1 Std Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   	Version 2.0 11/2024 
--	
--	  Brief: 
-- 	
-- 	Fetch 8 DDS control words from a pre loaded buffer memory 
--							 CtrlWord [8 bits address + 8 Bits DDS Configuration]
-- 
--
-- 	AD9854 module Reset protocol:
--			A dealy is generated with fsm at state_1, 10 cycles = 200nS for a 50Mhz fsm_clock.
--			At first reset at list 10 cycles of the dds internal clock with master reset high are needs, 
--			DDS clock with clock multiplier reset values leads to 80Mhz so 125ns are the minimum time to ensure 
--			system reset.
-- 		An update signal occurs every time Internal Update Clock does an overflow, this signal is used to 
--			set the new values of registers (FETCHED from a pre loaded buffer) setting an external UD signal to 
--			be used with other modules.
--			Finally: Master Reset signal is high for a while, then new configuration for the control registers are
--						loaded and waits for the UD singal to applied the changes letting the UD SIGNAL as external.
--			CHECK AD9854 DATASHEET TO UNDERSTAND THE TIMMING NEEDED DURING THE PROCESS. 

--			state_3 and state_4 can be merge in one state.

--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY fsm_init_V2 IS
  port (
		clk_fsm_SingleTone     	: 	IN  std_logic; -- clk_fsm_SingleTone 25Mhz
		rst_n_fsm_SingleTone   	: 	IN  std_logic; -- External switch
		start_fsm_SingleTone		: 	IN  std_logic; -- Push button tu start fsm
		AddressMem_offset			:	IN  std_logic_vector(5 downto 0);
		-- Mem Control Signal
		rd_InitMem					: 	OUT std_logic;  
		wr_InitMem					: 	OUT std_logic; 
		en_InitMem					: 	OUT std_logic;
		clc_InitMem					: 	OUT std_logic;
		AddressMemInit				:	OUT std_logic_vector(5 downto 0);	
		-- Debugging flags
		fsm_initEND					:	OUT std_logic;

		-- DDS Write Data Control	
		masterRst	 				:	OUT std_logic;	-- dds Master Rst on
		rd_n			 				: 	OUT std_logic; -- Read off
		wd_n			 				:	OUT std_logic;	-- write off
		FSK_BPSK_HOLD				:	OUT std_logic;
		I_O_update					:	OUT std_logic;
		
		debugFlag					: 	OUT std_logic
		
  );
END ENTITY fsm_init_V2;
------------------------------------------------
ARCHITECTURE Behavioral OF fsm_init_V2 IS
  -- Signals declarations
  TYPE state_type IS (initialState, initialState_bis, state_1, state_2, state_3, state_4, state_5, state_6);	 
  SIGNAL state : state_type; 					 
  
BEGIN
state_transition: 
	PROCESS (clk_fsm_SingleTone, rst_n_fsm_SingleTone) 	--sensitive list
  	-- Variables declarations
	
	VARIABLE count_MtrRst 		: INTEGER RANGE 0 TO 20; -- about 140 nS with DDS Reset ON
	VARIABLE count_AddressMem 	: INTEGER RANGE 0 TO 64;	-- 8 memories positions
	VARIABLE count_limit 		: INTEGER RANGE 0 TO 64;	-- 8 memories positions
	VARIABLE count_delay 		: INTEGER RANGE 0 TO 100; -- about 140 nS with DDS Reset ON
	VARIABLE init_byte_size		: INTEGER RANGE 0 TO 10;
	
	BEGIN
		IF (rst_n_fsm_SingleTone = '0') THEN   -- asynchronous reset
				state <= initialState;					-- start_fsm_SingleTone works as start or reset
				count_MtrRst	  := 0;
				count_delay		  := 0;
				count_AddressMem := 0;
				count_limit		  := 0; -- set the offset count_limit
				init_byte_size	  := 8; -- eight 8 bit words


			ELSIF rising_edge(clk_fsm_SingleTone) THEN   				-- Change State
			CASE state IS
				WHEN initialState =>
					--count_AddressMem 	:= to_integer(unsigned(AddressMem_offset)); 
					--count_limit			:= (to_integer(unsigned(AddressMem_offset)) + init_byte_size );
					--AddressMemInit 	<= std_logic_vector(to_unsigned(count_AddressMem, AddressMemInit'length));
					--AddressMemInit 	<= AddressMem_offset;
		 
					IF (start_fsm_SingleTone = '1') THEN -- take in account_MtrRst to set edge detection
						state <= initialState_bis;	
					ELSE 
						state <= initialState;
					END IF;
					
				WHEN initialState_bis => -- latch offset address
					count_limit			:= (to_integer(unsigned(AddressMem_offset)) + init_byte_size );
					count_AddressMem 	:= to_integer(unsigned(AddressMem_offset));
					AddressMemInit 	<= AddressMem_offset;
					
					state <= state_1; 
					
				WHEN state_1 =>	-- Master Reset Time ON > 10 dds_clk system cycles / check reset config to know the minimum required time for rst			
					count_MtrRst := count_MtrRst + 1;				-- 
					IF (count_MtrRst=20) THEN count_MtrRst := 0;
						state <= state_2;
					ELSE 
						state <= state_1; 
					END IF;
					
					
	-- Load register configuration from PRE LOADED BUFFER--------------------------
				WHEN state_2 =>	-- Mem enable			
					state <= state_3; 
					
				WHEN state_3 =>	-- Data in the mem output								
					count_AddressMem := count_AddressMem + 1;
					state <= state_4;
					
				WHEN state_4 => -- write dds
					AddressMemInit <= std_logic_vector(to_unsigned(count_AddressMem, AddressMemInit'length));	
					IF (count_AddressMem = count_limit) THEN count_AddressMem := 0;
						state <= state_5;
					ELSE 
						state <= state_2; 
					END IF;
					
				WHEN state_5 => -- 1.8us delay time expecting internal UD signal to set dds configuration		
					count_delay := count_delay + 1;				-- 
					IF (count_delay=100) THEN count_delay := 0;
						state <= state_6;
					ELSE 
						state <= state_5; 
					END IF;				
					
				WHEN state_6 =>					 
					state <= state_6;  -- Set Ends flags and waits for reset
					
			END CASE;
		END IF;
	END PROCESS state_transition;
  
  
Output_logic: PROCESS (state)
	BEGIN							
 		CASE state IS
			WHEN initialState => -- Reset State
				-- FPGA internal RAM control
				rd_InitMem		<= '0';	
				wr_InitMem		<= '0';	
				en_InitMem		<= '0';	
				clc_InitMem 	<= '1'; -- CLC MEM
				-- DDS Write Data Control	
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '1';	
				FSK_BPSK_HOLD	<= 'Z';	
				I_O_update		<= 'Z';
				fsm_initEND		<= '0';
				debugFlag		<= '0';
				
			WHEN initialState_bis => -- Reset State
				-- FPGA internal RAM control
				rd_InitMem		<= '0';	
				wr_InitMem		<= '0';	
				en_InitMem		<= '0';	
				clc_InitMem 	<= '1'; -- CLC MEM
				-- DDS Write Data Control	
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '1';	
				FSK_BPSK_HOLD	<= 'Z';	
				I_O_update		<= 'Z';
				fsm_initEND		<= '0';
				debugFlag		<= '0';
				
			WHEN state_1 => -- Master RST on 6 cycles of clock_50 (120nS), and 10 DDS internal System Clock (3.3nS if 300Mhz) are needed
			-- FPGA internal RAM control
				rd_InitMem		<= '0';	
				wr_InitMem		<= '0';	
				en_InitMem		<= '0';
				clc_InitMem 	<= '0';
			-- DDS Write Data Control	
				masterRst	 	<= '1';	-- dds Master Rst on 
				rd_n			 	<= '1';  
				wd_n			 	<= '1';	
				FSK_BPSK_HOLD	<= 'Z';	
				I_O_update		<= 'Z';
				fsm_initEND		<= '0';
				debugFlag		<= '0';
				

-- ----------------------------------------------------------------
			WHEN state_2 => -- mem en and rd on and set mem address
			-- FPGA internal RAM control
				rd_InitMem		<= '1';	
				wr_InitMem		<= '0';	
				en_InitMem		<= '1';
				clc_InitMem 	<= '0';
				-- DDS Write Data Control
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '1';	-- write off
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= 'Z';
				fsm_initEND		<= '0';
				debugFlag		<= '0';	
	
			WHEN state_3 => -- mem on - counter ++
				rd_InitMem		<= '1';	
				wr_InitMem		<= '0';	
				en_InitMem		<= '1';
				clc_InitMem 	<= '0';
				-- DDS Write Data Control
				masterRst	 	<= '0';	-- dds Master 
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '1';	
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= 'Z';
				fsm_initEND		<= '0';
				debugFlag		<= '0';
				
			WHEN state_4 => -- mem en and rd on | dds writes
				rd_InitMem		<= '1';	
				wr_InitMem		<= '0';	
				en_InitMem		<= '1';
				clc_InitMem 	<= '0';
				-- DDS Write Data Control
				masterRst	 	<= '0';	-- dds Master 
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '0';	-- write ON
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= 'Z';
				fsm_initEND		<= '0';
				debugFlag		<= '0';				

			WHEN state_5 => -- Dealy expecting UD signal from internal UD Clock
				rd_InitMem		<= '0';	
				wr_InitMem		<= '0';	
				en_InitMem		<= '0';
				clc_InitMem 	<= '0';
				-- DDS Write Data Control
				masterRst	 	<= '0';	 
				rd_n			 	<= '1';   
				wd_n			 	<= '1';	 
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= 'Z'; -- Set in High impedance instead 1 or 0
				fsm_initEND		<= '0';
				debugFlag		<= '0';			
				
			WHEN state_6 => -- No UD signal to DDS.
				rd_InitMem		<= '0';	
				wr_InitMem		<= '0';	
				en_InitMem		<= '0';
				clc_InitMem 	<= '1'; --CLC MEM
				-- DDS Write Data Control
				masterRst	 	<= '0';	 
				rd_n			 	<= '1';   
				wd_n			 	<= '1';	 
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= 'Z';-- Set in High impedance instead 1 or 0
				fsm_initEND		<= '1';
				debugFlag		<= '1';
				

		END CASE;
	END PROCESS Output_logic; -- Outputs are updated at the end of the process

END ARCHITECTURE Behavioral;