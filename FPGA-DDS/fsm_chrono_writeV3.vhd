--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         fsm_chrono_writeV3.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 03/2023 Guillermo H. Bustos
--
--	  Brief:
--		FSM controls two external blocks, chrono module and ram module. Fetch pre loaded data from ram to set
--			precount value in chrono module, and then enable to start counting. 
--		fsm remains in last state until external asynchronous reset is set. to avoid re-init if all finish when
-- 		start signal remaining high. Avoid undesired initialization after execution ending.
-- 	state_A es extra for right pre-load data in chrono.
-- 	FSM set end flags at last state, in case of chrono, C polling routine in HPS remains 
-- 		steady expecting hight state, this cause firmware not continuous excecution until 
--			chrono ends. Take it in account when using polling to read flags. 
-- 	Chrono needs 3 clocks to start counting, first to set prescaler value, second to assign
--			this value to the counting variable and third to start counting with WindowOutput High.
-- 	nco_rst_n used for reset NCO before windows rf is on. This is only used when chrono is sync 
-- 		with NCO Sinc pulse.
-- 	sincModulation signal to enable sinc module with chrono window rf comes from PGR word in pulse sequencer buffer,
--			to let user configuration enable or not sinc modulation with chrono window rf.
--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY fsm_chrono_writeV3 IS
  port (
		clk_fsm_chrono    	: 	IN  std_logic; -- clk_fsm_chrono 50Mhz
		rst_n_fsm_chrono  	: 	IN  std_logic;
		start_fsm_chrono		: 	IN  std_logic; -- set on with wrapper CtrlRegister
		AddressMem_offset		:	IN  std_logic_vector(5 downto 0);
		-- From Chrono
		overflowFlag			: 	IN  std_logic; -- chrono ends  overflow flag.
		-- sinc modulation switch
		sincModulation_on		: 	IN  std_logic; 
		-- FSM RAM control
		rd_CHRMem				: 	OUT std_logic; 
		wr_CHRMem 				: 	OUT std_logic; 
		en_CHRMem 				: 	OUT std_logic; 
		clc_CHRMem				: 	OUT std_logic;
		addressChronoMem		:	OUT std_logic_vector(5 downto 0); 
		-- fsm end
		fsm_chronoEND			:	OUT std_logic;
		-- Chrono control
		nRst_chrono 			: 	OUT  std_logic;
		en_chrono   			: 	OUT  std_logic;
		setPrecount_chrono	: 	OUT  std_logic;
		--
		nco_aclr_mem			:	OUT  std_logic;
		nco_rst_n				: 	OUT  std_logic -- to control NCO when rfwindow controls it
		
		
  );
END ENTITY fsm_chrono_writeV3;
------------------------------------------------


ARCHITECTURE Behavioral OF fsm_chrono_writeV3 IS
  -- Signals declarations -- state_1_bis extra state to help prescaler signal be registered
--  TYPE state_type IS (initialState, state_0, state_1, state_2, state_3, state_4, state_5, state_6, state_7); 
	TYPE state_type IS (initialState, state_0, state_1, state_3, state_4, state_4_bis, state_7); 
  SIGNAL state : state_type; 														 
  
BEGIN
state_transition: PROCESS (clk_fsm_chrono, rst_n_fsm_chrono) 	 
	BEGIN
		IF (rst_n_fsm_chrono = '0') THEN   							
			state <= initialState;	
			addressChronoMem <= "000000"; -- ensure zero in rst state
			
		ELSIF rising_edge(clk_fsm_chrono) THEN 
			CASE state IS
				WHEN initialState => -- register offset mem input
					IF (start_fsm_chrono = '1') THEN 
						state <= state_0;	
					ELSE 
						state <= initialState; 
					END IF;
	
				WHEN state_0 =>		-- Reg address offset (avaible in next clock cycle)
					addressChronoMem <= AddressMem_offset;
					state <= state_1; 	
					
				WHEN state_1 =>		-- Offset value in the RAM address input port	 
					state <= state_3; 	

					
				WHEN state_3 =>		-- Set prescaler value
					IF (sincModulation_on = '1') THEN
						state <= state_4_bis;
					ELSE 
						state <= state_4; -- 
					END IF;					
					
				WHEN state_4 =>		-- Start counting No Sinc modulation enable/
					IF (overflowFlag = '1') THEN
						state <= state_7;
					ELSE 
						state <= state_4; -- 
					END IF;
					
				WHEN state_4_bis =>		-- Start counting Sinc modulation enable
					IF (overflowFlag = '1') THEN
						state <= state_7;
					ELSE 
						state <= state_4_bis; -- 
					END IF;
		
				WHEN state_7 =>		--  chrono off
					state <= state_7;			
			END CASE;
		END IF;
	END PROCESS state_transition;
  
  
Output_logic: PROCESS (state)
	BEGIN							
 		CASE state IS
			WHEN initialState => -- RAM clear/ LOAD OFFSET
				-- FSM RAM control
				rd_CHRMem				<= '0';
				wr_CHRMem 				<= '0';
				en_CHRMem 				<= '0';
				clc_CHRMem				<= '1'; -- check this port
				-- chrono
				nRst_chrono 			<= '0'; --rst off
				en_chrono   			<= '0';
				setPrecount_chrono	<= '0';
				-- endflag
				fsm_chronoEND			<= '0';
				--
				nco_rst_n				<= '0';
				nco_aclr_mem			<= '0';

			WHEN state_0 => -- Latch data
				rd_CHRMem				<= '0';
				wr_CHRMem 				<= '0';
				en_CHRMem 				<= '0';
				clc_CHRMem				<= '0';
				-- chrono
				nRst_chrono 			<= '1'; 
				en_chrono   			<= '0'; -- chrono reset
				setPrecount_chrono	<= '0';
				-- endflag
				fsm_chronoEND			<= '0';
				--
				nco_rst_n				<= '0';
				nco_aclr_mem			<= '0';
				
			WHEN state_1 => -- En RAM / RAM address avaible
				-- ram control
				rd_CHRMem				<= '1';
				wr_CHRMem 				<= '0';
				en_CHRMem 				<= '1';
				clc_CHRMem				<= '0';
				-- chrono
				nRst_chrono 			<= '1'; -- chrono reset OFF
				en_chrono   			<= '0';
				setPrecount_chrono	<= '0'; -- preload on once
				-- endflag
				fsm_chronoEND			<= '0';	
				--
				nco_rst_n				<= '0';
				nco_aclr_mem			<= '0';
				
			WHEN state_3 => -- Set prescaler
				-- ram control
				rd_CHRMem				<= '1';
				wr_CHRMem 				<= '0';
				en_CHRMem 				<= '1';
				clc_CHRMem				<= '0';
				-- chrono
				nRst_chrono 			<= '1'; -- chrono reset OFF
				en_chrono   			<= '0';
				setPrecount_chrono	<= '1'; -- preload on once
				-- endflag
				fsm_chronoEND			<= '0';
				--
				nco_rst_n				<= '0';
				nco_aclr_mem			<= '0';	
				
			WHEN state_4 => -- Chrono on / prescaler off/ NCO rst off
				-- ram control
				rd_CHRMem				<= '1';
				wr_CHRMem 				<= '0';
				en_CHRMem 				<= '1';
				clc_CHRMem				<= '0';
				-- chrono
				nRst_chrono 			<= '1'; --rst chrono
				en_chrono   			<= '1';
				setPrecount_chrono	<= '0';
				-- endflag
				fsm_chronoEND			<= '0'; --fsm ends flag
				--
				nco_rst_n				<= '0';
				nco_aclr_mem			<= '1'; -- erase sinc buffer mem output to avoid phase incr data in NCO

			WHEN state_4_bis => -- Chrono on / prescaler off/ NCO rst off / Sinc modulation 
				-- ram control
				rd_CHRMem				<= '1';
				wr_CHRMem 				<= '0';
				en_CHRMem 				<= '1';
				clc_CHRMem				<= '0';
				-- chrono
				nRst_chrono 			<= '1'; --rst chrono
				en_chrono   			<= '1';
				setPrecount_chrono	<= '0';
				-- endflag
				fsm_chronoEND			<= '0'; --fsm ends flag
				--
				nco_rst_n				<= '1'; -- Enables Sinc modulation
				nco_aclr_mem			<= '0';
				
			WHEN state_7 => -- End chrono
				-- ram control
				rd_CHRMem				<= '1';
				wr_CHRMem 				<= '0';
				en_CHRMem 				<= '1';
				clc_CHRMem				<= '0';
				-- chrono
				nRst_chrono 			<= '0'; --rst chrono
				en_chrono   			<= '0';
				setPrecount_chrono	<= '0';
				-- endflag
				fsm_chronoEND			<= '1'; --fsm ends flag
				--
				nco_rst_n				<= '0';
				nco_aclr_mem			<= '0';
					
		END CASE;
	END PROCESS Output_logic; -- Outputs are updated at the end of the process

END ARCHITECTURE Behavioral;