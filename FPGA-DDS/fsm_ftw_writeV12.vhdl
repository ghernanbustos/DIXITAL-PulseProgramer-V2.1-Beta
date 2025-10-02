--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         fsm_ftw_writeV12.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 03/2023 Guillermo H. Bustos
--
--	  Brief: 
--		fsm to fetch freq tuning word from memory and write DDS registers
-- 	reads 6 bytes loaded on a 32x16 RAM memory
--		FTW is 48 bits long partitioned on 8bits words loaded on RAM.
--		Every RAM word is 16 bits long composed by 8_MSB as register memory and 8 LSB FTW word
--		FSM set an offset memory value and controls memory enable and reading with 
--			DDS data write and update.
-- 	Extra 'initialStateBis' state is added to avoid reset when latching the data offset 
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY fsm_ftw_writeV12 IS
  port (
		clk_fsm_ftw     		: 	IN  std_logic; -- clk_fsm_ftw 
		rst_n_fsm_ftw   		: 	IN  std_logic; -- 
		start_fsm_ftw			: 	IN  std_logic; -- external init from fsm1
		AddressMem_offset		:	IN  std_logic_vector(5 downto 0);
		-- FPGA internal RAM control
		rd_FTWMem			: 	OUT std_logic; --  
		wr_FTWMem 			: 	OUT std_logic; --  
		en_FTWMem 			: 	OUT std_logic; -- clk_en
		clc_FTWMem			: 	OUT std_logic;
		addressMemFTW		:	OUT std_logic_vector(5 downto 0); 
		-- fsm end
		fsm_ftwEND			:	OUT std_logic;
		-- DDS Write Data Control	
		masterRst_dds 		:	OUT std_logic;	-- dds Master Rst off not used
		rd_n_dds			 	: 	OUT std_logic; -- Read off not used
		wd_n_dds			 	:	OUT std_logic;	-- write off
		FSK_BPSK_HOLD_dds	:	OUT std_logic;
		I_O_update_dds		:	OUT std_logic;
		debugFlag			: 	OUT std_logic

  );
END ENTITY fsm_ftw_writeV12;
------------------------------------------------
ARCHITECTURE Behavioral OF fsm_ftw_writeV12 IS
  -- Signals declarations
  TYPE state_type IS (initialState, initialStateBis, state_0, state_1, state_1_bis, state_2, state_3);	-- Enumerated type decl
  SIGNAL state : state_type; 											-- state_type is signal type

BEGIN
state_transition: PROCESS (clk_fsm_ftw, rst_n_fsm_ftw) 	--sensitive list
  	-- Variables declarations
	VARIABLE ftw_byte_size		: INTEGER RANGE 0 TO 6 ; -- Six 8_bits_word to complete 48 bits FTW
	VARIABLE count_AddressMem 	: INTEGER RANGE 0 TO 64;	-- 8 memories positions
	VARIABLE count_limit 		: INTEGER RANGE 0 TO 64;	-- 8 memories positions
	
	BEGIN
		IF (rst_n_fsm_ftw = '0') THEN   			-- asynchronous reset
				state <= initialState;
				ftw_byte_size		:= 6; -- Six 8_bits_word to complete 48 bits FTW
				count_AddressMem 	:= 0; -- Load base address
				addressMemFTW  	<= (OTHERS => '0');

		ELSIF rising_edge(clk_fsm_ftw) THEN -- Change State
			CASE state IS
				WHEN initialState =>
					
						IF (start_fsm_ftw = '1') THEN 
							state <= initialStateBis;	
						ELSE 
							state <= initialState; 
						END IF;
						
				WHEN initialStateBis => -- Latch Data	
						count_AddressMem 	:= to_integer(unsigned(AddressMem_offset));			
						count_limit			:= (to_integer(unsigned(AddressMem_offset)) + ftw_byte_size );-- base address + 6 words
						addressMemFTW  	<= AddressMem_offset;
						state <= state_0;	
						
				WHEN state_0 => -- Mem Enable			
						state <= state_1;
						
				WHEN state_1 => -- extra state to update addressMemFTW variable from state_0 to Memory					
						count_AddressMem := count_AddressMem + 1;
						state <= state_1_bis;
						
				WHEN state_1_bis =>
	
						addressMemFTW  <= std_logic_vector(to_unsigned(count_AddressMem, addressMemFTW'length)); -- Signal es update out of process - Set addressMem port value with offset.			
						IF (count_AddressMem = count_limit) THEN count_AddressMem := 0;
							state <= state_2;
						ELSE 
							state <= state_0; 
						END IF;	
						
				WHEN state_2 => --UD
						state <= state_3;
						
				WHEN state_3 => -- waits for reset signal
						state <= state_3;	
			END CASE;
		END IF;
	END PROCESS state_transition;
  
  
Output_logic: PROCESS (state)
	BEGIN							
 		CASE state IS
			WHEN initialState =>
					-- FPGA RESET STATE
				rd_FTWMem			<= '0';			
				wr_FTWMem			<= '0';	 			 						
				en_FTWMem			<= '0';
				clc_FTWMem			<= '1';	-- clc output mem	
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '1';				 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '0';

				fsm_ftwEND			<= '0';
				debugFlag			<= '0';
				
			WHEN initialStateBis => -- Latch offset address data
					-- FPGA internal RAM control
				rd_FTWMem			<= '0';			
				wr_FTWMem			<= '0';	 			 						
				en_FTWMem			<= '0';
				clc_FTWMem			<= '0';	-- clc output mem	
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '1';				 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '0';

				fsm_ftwEND			<= '0';
				debugFlag			<= '0';
				
			WHEN state_0 => -- RAM enable
					-- FPGA internal RAM control
				rd_FTWMem			<= '1'; 		
				wr_FTWMem			<= '0';	 							
				en_FTWMem			<= '1'; 	
				clc_FTWMem			<= '0';					
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '1';				 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '0';

				fsm_ftwEND			<= '0';
				debugFlag			<= '0';				

				
			WHEN state_1 =>		-- counter
					-- FPGA internal RAM control
				rd_FTWMem			<= '1';			
				wr_FTWMem			<= '0';	 							
				en_FTWMem			<= '1'; 
				clc_FTWMem			<= '0';		 			
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '1';  	 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '0';

				fsm_ftwEND			<= '0';
				debugFlag			<= '0';				


			WHEN state_1_bis =>		-- check counter variable
					-- FPGA internal RAM control
				rd_FTWMem			<= '1'; 			
				wr_FTWMem			<= '0';	 							
				en_FTWMem			<= '1'; 	
				clc_FTWMem			<= '0';		 			
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '0'; -- DDS Write	ON			 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '0';

				fsm_ftwEND			<= '0';
				debugFlag			<= '0';				


			WHEN state_2 => -- off mem , dds update				
					-- FPGA internal RAM control
				rd_FTWMem			<= '0';			
				wr_FTWMem			<= '0';	 						
				en_FTWMem			<= '0';	 			
				clc_FTWMem			<= '0';	
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '1';				 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '1';

				fsm_ftwEND			<= '0';
				debugFlag			<= '0';
				
			WHEN state_3 => -- flag on				
					-- FPGA internal RAM control
				rd_FTWMem			<= '0';			
				wr_FTWMem			<= '0';	 						
				en_FTWMem			<= '0';	 			
				clc_FTWMem			<= '1';	
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '1';				 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '0';

				fsm_ftwEND			<= '1';
				debugFlag			<= '1';								

		END CASE;
	END PROCESS Output_logic; -- Outputs are updated at the end of the process

END ARCHITECTURE Behavioral;