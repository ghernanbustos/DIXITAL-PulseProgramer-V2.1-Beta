--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         ftw_fsm_write.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 03/2023 Guillermo H. Bustos
--
--	  Brief: 
--		Data path to write AD9854 register
--		master reset and read port are not used in dds reg config.
--		Some FSM states can be deleted, check this in future enhancement stages. Three states are used
--			each signal state change. For example, to set "wr" signal, s1 = initial value, s2 = change signal state
--			s3 = set initial value
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY ftw_fsm_write IS
  port (
		clk_fsm2     		: 	IN  std_logic; -- clk_fsm2 
		rst_n_fsm2   		: 	IN  std_logic; -- 
		start_fsm2			: 	IN  std_logic; -- external init from fsm1
		-- FPGA internal RAM control
		rd_regMem			: 	OUT std_logic; --  
		wr_regMem 			: 	OUT std_logic; --  
		en_regMem 			: 	OUT std_logic; -- clk_en
		--
		rd_ftwMem			: 	OUT std_logic; --  
		wr_ftwMem 			: 	OUT std_logic; --  
		en_ftwMem			: 	OUT std_logic; -- clk_en
		addressMemData		:	OUT std_logic_vector(4 downto 0); 
		addressMemReg		:	OUT std_logic_vector(4 downto 0); 
		-- Mux fsm Control
		fsm_ftwEND			:	OUT std_logic;
		-- Debugging flags
		s0,s1,s2,s3,s4,s5	:	OUT std_logic;
		-- DDS Write Data Control	
		masterRst_dds 		:	OUT std_logic;	-- dds Master Rst off not used
		rd_n_dds			 	: 	OUT std_logic; -- Read off not used
		wd_n_dds			 	:	OUT std_logic;	-- write off
		FSK_BPSK_HOLD_dds	:	OUT std_logic;
		I_O_update_dds		:	OUT std_logic
  );
END ENTITY ftw_fsm_write;
------------------------------------------------
ARCHITECTURE Behavioral OF ftw_fsm_write IS
  -- Signals declarations
  TYPE state_type IS (state_muxInit, state_0, state_1, state_2, state_3, state_4,state_5);	-- Enumerated type decl
  SIGNAL state : state_type; 											-- state_type is signal type

BEGIN
state_transition: PROCESS (clk_fsm2, rst_n_fsm2, start_fsm2) 	--sensitive list
  	-- Variables declarations
	VARIABLE count : INTEGER RANGE 0 TO 6; -- 6-1 = 6 words, 8 bits each one to complete 48 bit FTW
	BEGIN
		IF (rst_n_fsm2 = '0') THEN   			-- asynchronous reset
			state <= state_muxInit;	
			count := 0;
			addressMemData <= std_logic_vector(to_unsigned(count, addressMemData'length));
			addressMemReg  <= std_logic_vector(to_unsigned(count, addressMemReg'length));	
		ELSIF (clk_fsm2'EVENT AND clk_fsm2='1') THEN -- Change State
			CASE state IS
				WHEN state_muxInit =>			-- M10K disable
					IF (start_fsm2 = '0') THEN 
						state <= state_muxInit;	
					ELSE 
						state <= state_0; 
					END IF;
				WHEN state_0 =>					-- M10K enable
						state <= state_1;
				WHEN state_1 =>					-- M10K enable
						state <= state_2;
				WHEN state_2 =>					-- 
						state <= state_3;
				WHEN state_3 =>
					count := count + 1;
					addressMemData <= std_logic_vector(to_unsigned(count, addressMemData'length));
					addressMemReg  <= std_logic_vector(to_unsigned(count, addressMemReg'length));	
						IF (count=6) THEN 
							count := 0;
							state <= state_4;
						ELSE 
							state <= state_1; 
						END IF;	
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
			WHEN state_muxInit =>
					-- FPGA internal RAM control
				rd_regMem			<= '0';			
				wr_regMem			<= '0';	 			
				rd_ftwMem			<= '0';				
				wr_ftwMem			<= '0';	 			
				en_ftwMem			<= '0';				
				en_regMem			<= '0';	 			
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '1';				 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '0';
				-- Debug states
				s0						<= '1';
				s1						<= '0';
				s2						<= '0';
				s3						<= '0';
				s4						<= '0';
				s5						<= '0';
				fsm_ftwEND			<= '0';
				
			WHEN state_0 =>
					-- FPGA internal RAM control
				rd_regMem			<= '1'; -- M10K rd enable			
				wr_regMem			<= '0';	 			
				rd_ftwMem			<= '1'; -- M10K rd enable					
				wr_ftwMem			<= '0';	 			
				en_ftwMem			<= '1'; -- M10K enable					
				en_regMem			<= '1'; -- M10K enable	 			
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '1';				 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '0';
				-- Debug states
				s0						<= '1';
				s1						<= '0';
				s2						<= '0';
				s3						<= '0';
				s4						<= '0';
				s5						<= '0';
				fsm_ftwEND			<= '0';
				
			WHEN state_1 =>		-- M10K enable
					-- FPGA internal RAM control
				rd_regMem			<= '1'; -- M10K rd enable			
				wr_regMem			<= '0';	 			
				rd_ftwMem			<= '1'; -- M10K rd enable					
				wr_ftwMem			<= '0';	 			
				en_ftwMem			<= '1'; -- M10K enable					
				en_regMem			<= '1'; -- M10K enable		 			
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '1'; -- DDS Write	OFF				 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '0';
				-- Debug states
				s0						<= '0';
				s1						<= '1';
				s2						<= '0';
				s3						<= '0';
				s4						<= '0';
				s5						<= '0';
				fsm_ftwEND			<= '0';

			WHEN state_2 => -- dds write				
					-- FPGA internal RAM control
				rd_regMem			<= '1'; -- M10K rd enable			
				wr_regMem			<= '0';	 			
				rd_ftwMem			<= '1'; -- M10K rd enable					
				wr_ftwMem			<= '0';	 			
				en_ftwMem			<= '1'; -- M10K enable					
				en_regMem			<= '1'; -- M10K enable		 			
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '0'; -- DDS Write	ON			 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '0';
				-- Debug states
				s0						<= '0';
				s1						<= '0';
				s2						<= '1';
				s3						<= '0';
				s4						<= '0';
				s5						<= '0';
				fsm_ftwEND			<= '0';
				
			WHEN state_3 => -- dds write				
					-- FPGA internal RAM control
				rd_regMem			<= '1'; -- M10K rd enable			
				wr_regMem			<= '0';	 			
				rd_ftwMem			<= '1'; -- M10K rd enable					
				wr_ftwMem			<= '0';	 			
				en_ftwMem			<= '1'; -- M10K enable					
				en_regMem			<= '1'; -- M10K enable		 			
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '1'; -- DDS Write	OFF			 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '0';
				-- Debug states
				s0						<= '0';
				s1						<= '0';
				s2						<= '0';
				s3						<= '1';
				s4						<= '0';
				s5						<= '0';
				fsm_ftwEND			<= '0';
				
			WHEN state_4 =>
					-- FPGA internal RAM control
				rd_regMem			<= '0';			
				wr_regMem			<= '0';	 			
				rd_ftwMem			<= '0';				
				wr_ftwMem			<= '0';	 			
				en_ftwMem			<= '0';				
				en_regMem			<= '0';	 			
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '1';				 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '1';
				-- Debug states
				s0						<= '0';
				s1						<= '0';
				s2						<= '0';
				s3						<= '0';
				s4						<= '1';
				s5						<= '0';
				fsm_ftwEND			<= '0';

			WHEN state_5 =>
					-- FPGA internal RAM control
				rd_regMem			<= '0';			
				wr_regMem			<= '0';	 			
				rd_ftwMem			<= '0';				
				wr_ftwMem			<= '0';	 			
				en_ftwMem			<= '0';				
				en_regMem			<= '0';	 			
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '1';				 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '0';
				-- Debug states
				s0						<= '0';
				s1						<= '0';
				s2						<= '0';
				s3						<= '0';
				s4						<= '0';
				s5						<= '1';
				fsm_ftwEND			<= '1';

		END CASE;
	END PROCESS Output_logic; -- Outputs are updated at the end of the process

END ARCHITECTURE Behavioral;