--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         fsm_modulation_write.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 03/2024 Guillermo H. Bustos
--
--	  Brief: 
--		FSM Master to controls RAM Buffer and OSK fsm.
--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY fsm_modulation_write IS
  port (
		clk_fsm_mod    	: 	IN  std_logic; -- clk_fsm_mod 50Mhz
		rst_n_fsm_mod  	: 	IN  std_logic;
		init_fsm_mod		: 	IN  std_logic; -- set on with wrapper CtrlRegister
		AddressMem_offset	:	IN  std_logic_vector(5 downto 0);
		-- FSM RAM control
		rd_PTWMem			: 	OUT std_logic; 
		wr_PTWMem 			: 	OUT std_logic; 
		en_PTWMem 			: 	OUT std_logic; 
		clc_PTWMem			: 	OUT std_logic;
		addressModMem		:	OUT std_logic_vector(5 downto 0); 
		-- fsm end
		fsm_modEND			:	OUT std_logic;
		-- Init NCO 
		initNCO				:	OUT std_logic; -- NCO runs at 3mhz, set this signal enough to be sampled
		-- Module reset
		rst_n_nco			:	OUT std_logic; 
		rst_n_osk_fsm		:	OUT std_logic -- OSK fsm is the module in charge of sending data to dds I and Q channel
  );
END ENTITY fsm_modulation_write;
------------------------------------------------


ARCHITECTURE Behavioral OF fsm_modulation_write IS
  -- Signals declarations
  TYPE state_type IS (initialState, initialStateBis, state_0, state_1, state_2, state_3);
  SIGNAL state : state_type; 														 
  
BEGIN
state_transition: PROCESS (clk_fsm_mod, rst_n_fsm_mod) 	 
	BEGIN
		IF (rst_n_fsm_mod = '0') THEN   							--  
			state <= initialState;
			addressModMem <= (OTHERS => '0');
			
		ELSIF rising_edge(clk_fsm_mod ) THEN		
			CASE state IS
				WHEN initialState =>
					IF (init_fsm_mod = '1') THEN 
						state <= initialStateBis;	
					ELSE 
						state <= initialState; 
					END IF;
					
				WHEN initialStateBis => -- Latch offset Address
					addressModMem <= AddressMem_offset;
					state <= state_0;
					
				WHEN state_0 =>		
					state <= state_1; 	
					
				WHEN state_1 =>				 
					state <= state_2;
					
				WHEN state_2 =>				 
					state <= state_3;
					
				WHEN state_3 =>				 
					state <= state_3;				
			END CASE;
		END IF;
	END PROCESS state_transition;
  
  
Output_logic: PROCESS (state)
	BEGIN							
 		CASE state IS
			WHEN initialState => -- reset state/ FSM latch offset
				-- FSM RAM control
				rd_PTWMem				<= '0';
				wr_PTWMem 				<= '0';
				en_PTWMem 				<= '0';
				clc_PTWMem				<= '0';
				-- endflag
				fsm_modEND				<= '0'; -- ctrlRegister read flag
				-- Init NCO 
				initNCO					<= '0';
				-- Module reset
				rst_n_nco				<= '0'; -- NCO and OSK fsm off
				rst_n_osk_fsm			<= '0';

			WHEN initialStateBis => -- LATCH MEM OFFSET
				-- FSM RAM control
				rd_PTWMem				<= '0';
				wr_PTWMem 				<= '0';
				en_PTWMem 				<= '0';
				clc_PTWMem				<= '0';
				-- endflag
				fsm_modEND				<= '0'; -- ctrlRegister read flag
				-- Init NCO 
				initNCO					<= '0';
				-- Module reset
				rst_n_nco				<= '0'; -- NCO and OSK fsm off
				rst_n_osk_fsm			<= '0';
				
			WHEN state_0 => -- RAM enable / offset set / nco off
				rd_PTWMem				<= '1';
				wr_PTWMem 				<= '0';
				en_PTWMem 				<= '1';
				clc_PTWMem				<= '0';
				-- endflag
				fsm_modEND				<= '0'; -- for HPS reading
				-- Init NCO 
				initNCO					<= '0';
				-- Module reset
				rst_n_nco				<= '0';
				rst_n_osk_fsm			<= '0';

			WHEN state_1 => -- RAM data out
				rd_PTWMem				<= '1';
				wr_PTWMem 				<= '0';
				en_PTWMem 				<= '1';
				clc_PTWMem				<= '0';
				-- endflag
				fsm_modEND				<= '0'; -- for HPS reading
				-- Init NCO 
				initNCO					<= '0';
				-- Module reset
				rst_n_nco				<= '0';
				rst_n_osk_fsm			<= '0';
				
			WHEN state_2 => -- NCO reset off
				rd_PTWMem				<= '1';
				wr_PTWMem 				<= '0';
				en_PTWMem 				<= '1';
				clc_PTWMem				<= '0';
				-- endflag
				fsm_modEND				<= '0'; -- for HPS reading
				-- Init NCO 
				initNCO					<= '0';
				-- Module reset
				rst_n_nco				<= '1'; -- RST OFF
				rst_n_osk_fsm			<= '1';

			WHEN state_3 => -- NCO active until external reset
				-- ram control
				rd_PTWMem				<= '1';
				wr_PTWMem 				<= '0';
				en_PTWMem 				<= '1';
				clc_PTWMem				<= '0';
				-- endflag
				fsm_modEND				<= '1'; -- end flag 
				-- Init NCO 
				initNCO					<= '1'; -- NCO on
				-- Module reset
				rst_n_nco				<= '1';
				rst_n_osk_fsm			<= '1';		

		END CASE;
	END PROCESS Output_logic; -- Outputs are updated at the end of the process

END ARCHITECTURE Behavioral;