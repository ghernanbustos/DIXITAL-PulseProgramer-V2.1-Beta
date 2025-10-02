--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         fsm_pwt_write_v2.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 03/2023 Guillermo H. Bustos
--
--	  Brief: 
--		fsm to send PTW data to dds fetched from a ram buffer memory
--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY fsm_pwt_write_v2 IS
  port (
		clk_fsm_ptw     		: 	IN  std_logic; -- 
		rst_n_fsm_ptw   		: 	IN  std_logic; -- 
		start_fsm_ptw			: 	IN  std_logic; -- external init from fsm1
		AddressMem_offset		:	IN  std_logic_vector(5 downto 0);
		-- FPGA internal RAM control
		rd_PTWMem			: 	OUT std_logic; --  
		wr_PTWMem 			: 	OUT std_logic; --  
		en_PTWMem 			: 	OUT std_logic; -- clk_en
		clc_PTWMem			: 	OUT std_logic;
		addressPTWMemtMem		:	OUT std_logic_vector(5 downto 0); 
		-- Mux fsm Control
		fsm_PTWEND			:	OUT std_logic;

		-- DDS Write Data Control	
		masterRst_dds 		:	OUT std_logic;	-- dds Master Rst off not used
		rd_n_dds			 	: 	OUT std_logic; -- Read off not used
		wd_n_dds			 	:	OUT std_logic;	-- write off
		FSK_BPSK_HOLD_dds	:	OUT std_logic;
		I_O_update_dds		:	OUT std_logic;
		debuggSignal		:  OUT std_logic	-- use for single trig. Mode in DSO to sync and check PWT changes
  );
END ENTITY fsm_pwt_write_v2;
  
ARCHITECTURE Behavioral OF fsm_pwt_write_v2 IS
  -- Signals declarations
  TYPE state_type IS (initialState, initialStateBis, state_0, state_1, state_1_bis, state_2, state_3);	-- Enumerated type decl
  SIGNAL state : state_type; 											-- state_type is signal type

BEGIN
state_transition: PROCESS (clk_fsm_ptw, rst_n_fsm_ptw, start_fsm_ptw) 	--sensitive list
  	-- Variables declarations
	--VARIABLE count : INTEGER RANGE 0 TO 6; -- 6 words, 8 bits each one to complete 48 bit FTW
	VARIABLE count_AddressMem 	: INTEGER RANGE 0 TO 64;	-- 8 memories positions
	VARIABLE count_limit 		: INTEGER RANGE 0 TO 64;	-- 8 memories positions
	
	BEGIN
		IF (rst_n_fsm_ptw = '0') THEN   			-- asynchronous reset
				state <= initialState;	
				count_AddressMem := 0;
				ptw_byte_size		:= 2;	
				addressPTWMemtMem  <= (OTHERS => '0'); -- Set addressMem port value with offset.
			
		ELSIF rising_edge(clk_fsm_ptw) THEN -- Change State
			CASE state IS
				WHEN initialState =>			
					--count_AddressMem := to_integer(unsigned(AddressMem_offset)); 
					--count_limit		  := ( to_integer(unsigned(AddressMem_offset)) + 2 ); 
					--addressPTWMemtMem  <= (OTHERS => '0'); -- Set addressMem port value with offset.
					
					IF (start_fsm_ptw = '1') THEN 
						state <= initialStateBis;	
					ELSE 
						state <= initialState; 
					END IF;

				WHEN initialStateBis => -- Latch offset address
					count_AddressMem := to_integer(unsigned(AddressMem_offset)); 
					count_limit		  := ( to_integer(unsigned(AddressMem_offset)) + ptw_byte_size ); 
					addressPTWMemtMem  <= AddressMem_offset; -- Set addressMem port value with offset.				
				
				
						state <= state_1;
					
				WHEN state_1 => -- EN Mem
						state <= state_1;
						
				WHEN state_1 => -- EN Mem
						state <= state_1_bis;
						
				WHEN state_1_bis => -- Increase mem counter position, WR dds and update address signal					
						count_AddressMem := count_AddressMem + 1;
						addressPTWMemtMem  <= std_logic_vector(to_unsigned(count_AddressMem, addressPTWMemtMem'length));
						IF (count_AddressMem = count_limit) THEN 
							count_AddressMem := 0;
							state <= state_2;
						ELSE 
							state <= state_0; 
						END IF;				
						
				WHEN state_2 => -- update dds
						state <= state_3;
						
				WHEN state_3 => -- waits for reset signal
						state <= state_3;	
						
			END CASE;
		END IF;
	END PROCESS state_transition;
  
  
Output_logic: PROCESS (state)
	BEGIN							
 		CASE state IS
			WHEN initialState => -- SET MEM OFFSET
					-- FPGA internal RAM control
				rd_PTWMem			<= '0';			
				wr_PTWMem			<= '0';	 			 						
				en_PTWMem			<= '0';
				clc_PTWMem			<= '1';		
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '1';				 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '0';

				fsm_PTWEND			<= '0';
				debuggSignal		<= '0';
				
			WHEN state_0 => -- ENABLE MEM + MEM OFFSET
					-- FPGA internal RAM control
				rd_PTWMem			<= '1'; -- M10K rd enable			
				wr_PTWMem			<= '0';	 							
				en_PTWMem			<= '1'; -- M10K enable	
				clc_PTWMem			<= '0';					
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '1';				 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '0';

				fsm_PTWEND			<= '0';
				debuggSignal		<= '0';
				
			WHEN state_1 =>		-- RAM DATA OUTPUT
					-- FPGA internal RAM control
				rd_PTWMem			<= '1'; -- M10K rd enable			
				wr_PTWMem			<= '0';	 							
				en_PTWMem			<= '1'; -- M10K enable
				clc_PTWMem			<= '0';					
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '1'; 			 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '0';

				fsm_PTWEND			<= '0';
				debuggSignal		<= '0';
			
			WHEN state_1_bis =>		-- DDS WRITE
					-- FPGA internal RAM control
				rd_PTWMem			<= '1'; -- M10K rd enable			
				wr_PTWMem			<= '0';	 							
				en_PTWMem			<= '1'; -- M10K enable
				clc_PTWMem			<= '0';					
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '0'; -- DDS Write	ON				 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '0';

				fsm_PTWEND			<= '0';
				debuggSignal		<= '0';

			WHEN state_2 => -- dds update				
					-- FPGA internal RAM control
				rd_PTWMem			<= '0'; -- M10K rd enable			
				wr_PTWMem			<= '0';	 							
				en_PTWMem			<= '0'; -- M10K enable	
				clc_PTWMem			<= '0';		 			
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '1'; -- DDS Write	OFF		 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '1';

				fsm_PTWEND			<= '0';
				debuggSignal		<= '1'; -- signal on , shoot DSO at update dds signal.
				
			WHEN state_3 => -- flag on					
					-- FPGA internal RAM control
				rd_PTWMem			<= '0'; -- M10K rd enable			
				wr_PTWMem			<= '0';	 								
				en_PTWMem			<= '0'; -- M10K enable	
				clc_PTWMem			<= '0';		 			
					-- DDS Write Data Control	
				masterRst_dds		<= '0';	 			
				rd_n_dds				<= '1';				 	 	
				wd_n_dds				<= '1'; -- DDS Write	OFF			 		
				FSK_BPSK_HOLD_dds	<= 'Z';	
				I_O_update_dds		<= '0';

				fsm_PTWEND			<= '1';
				debuggSignal		<= '0';
			

		END CASE;
	END PROCESS Output_logic; -- Outputs are updated at the end of the process

END ARCHITECTURE Behavioral;