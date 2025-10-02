--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         fsm_osk_write.vhd
--   Dependencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 07/2023 Guillermo H. Bustos
--
--	  Brief: 
-- 	fetch amplitude data from an embedded NCO and set DDS amplitud registers to
--		produce an amplitude modulation.
-- 	1uS delay between samples, fsm has to solve data load in dds taking in account
--		this lag plus pipe line delays in internal dds operations.
--			(fms operation time) + (dds pipe line delays) < (1uS sample time)
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY fsm_osk_write IS
  port (
		osk_clk     		: 	IN  std_logic; -- osk_clk 
		osk_rst_n   		: 	IN  std_logic; -- 
		osk_initFsm 		: 	IN  std_logic; -- external init clock_1Mhz signal
		osk_12bitDataIn	:  IN	 std_logic_vector(11 downto 0); -- 12 Aplitude data
		-- Out Data
		osk_16bitDataOut	:  OUT	std_logic_vector(15 downto 0); -- the two msb are unused
		-- DDS Write Data Control	
		dds_masterRst 		:	OUT std_logic;	-- dds Master Rst off not used
		dds_rd_n			 	: 	OUT std_logic; -- Read off not used
		dds_wr_n			 	:	OUT std_logic;	-- write off
		dds_FSK_BPSK_HOLD	:	OUT std_logic;
		dds_I_O_update		:	OUT std_logic
  );
END ENTITY fsm_osk_write;
------------------------------------------------
ARCHITECTURE Behavioral OF fsm_osk_write IS
  -- Signals declarations
	TYPE state_type IS (state_init1, state_init0, state_latchData, state_0, state_1, state_2, state_3, state_4,state_5,state_6,state_7,state_8);	
	SIGNAL state   : state_type;
	SIGNAL 	aux16bits	   : std_logic_vector(15 downto 0);
	CONSTANT regDir8_I_msb : std_logic_vector(7 downto 0):= X"21"; -- OSK dir register
	CONSTANT regDir8_I_lsb : std_logic_vector(7 downto 0):= X"22"; 	
	CONSTANT regDir8_Q_msb : std_logic_vector(7 downto 0):= X"23"; 	
	CONSTANT regDir8_Q_lsb : std_logic_vector(7 downto 0):= X"24"; 	
	
BEGIN
--------------------------------------------------------------------------
-- state_transition : this process set fsm transitions
--------------------------------------------------------------------------
state_transition: PROCESS (osk_clk, osk_rst_n, osk_initFsm) 	--sensitive list
	BEGIN
		IF (osk_rst_n = '0') THEN   			-- asynchronous reset
			state <= state_init1;	
		ELSIF rising_edge(osk_clk) THEN -- Change State
			CASE state IS
				WHEN state_init1 =>			-- state_init1 and state_init0 prepare fsm to be triggered at next clock_1Mhz edge.
					IF (osk_initFsm = '1') THEN 
						state <= state_init1;	
					ELSE 
						state <= state_init0; 
					END IF;
				WHEN state_init0 =>			-- 
					IF (osk_initFsm = '0') THEN 
						state <= state_init0;	
					ELSE 
						state <= state_latchData; 
					END IF;
				WHEN state_latchData => -- load 12 amplitude data and format to 16bits in aux16bits
						aux16bits <= "0000" & osk_12bitDataIn;
						state <= state_0;
-- write I channel registers
				WHEN state_0 =>		   -- 16bit word [I_DirReg + 8_MSB osk_12bit word]
						osk_16bitDataOut <= regDir8_I_msb & aux16bits(15 downto 8);
						state <= state_1;			
				WHEN state_1 =>			-- Write DDS
						state <= state_2;
				WHEN state_2 =>			-- 16bit word [I_DirReg + 8_LSB osk_12bit word]
						osk_16bitDataOut <= regDir8_I_lsb & aux16bits(7 downto 0);
						state <= state_3;
				WHEN state_3 =>		  -- Write DDS
						state <= state_4;	
						
-- write Q channel registers						
				WHEN state_4 =>			-- 16bit word [Q_DirReg + 8_MSB osk_12bit word]
						osk_16bitDataOut <= regDir8_Q_msb & aux16bits(15 downto 8);				
						state <= state_5;
				WHEN state_5 =>		  -- Write DDS	
						--osk_16bitDataOut <= regDir8_Q_msb & aux16bits(15 downto 8);			
						state <= state_6;		

				WHEN state_6 =>			-- 16bit word [Q_DirReg + 8_MSB osk_12bit word]
						osk_16bitDataOut <= regDir8_Q_lsb & aux16bits(7 downto 0);				
						state <= state_7;
				WHEN state_7 =>		  -- Write DDS	
						--osk_16bitDataOut <= regDir8_Q_lsb & aux16bits(7 downto 0);			
						state <= state_8;	

-- Update DDS
				WHEN state_8 =>		  -- Write DDS	
						--osk_16bitDataOut <= regDir8_Q_lsb & aux16bits(7 downto 0);			
						state <= state_init1;	


						
			END CASE;
		END IF;
	END PROCESS state_transition;
  
  
Output_logic: PROCESS (state) -- when state changes this process is active
	BEGIN							
 		CASE state IS
			WHEN state_init1 => -- all dds control bits disabled
				-- DDS Write Data Control	
				dds_masterRst		<= '0';	 			
				dds_rd_n				<= '1';				 	 	
				dds_wr_n				<= '1';				 		
				dds_FSK_BPSK_HOLD	<= 'Z';	
				dds_I_O_update		<= '0';
			WHEN state_init0 => -- all dds control bits disabled
				-- DDS Write Data Control	
				dds_masterRst		<= '0';	 			
				dds_rd_n				<= '1';				 	 	
				dds_wr_n				<= '1';				 		
				dds_FSK_BPSK_HOLD	<= 'Z';	
				dds_I_O_update		<= '0';
				
			WHEN state_latchData =>
				-- DDS Write Data Control	
				dds_masterRst		<= '0';	 			
				dds_rd_n				<= '1';				 	 	
				dds_wr_n				<= '1';				 		
				dds_FSK_BPSK_HOLD	<= 'Z';	
				dds_I_O_update		<= '0';
			----------------------------
			----------------------------
			WHEN state_0 =>				 -- Concatenate I_MSB
				-- DDS Write Data Control	
				dds_masterRst		<= '0';	 			
				dds_rd_n				<= '1';				 	 	
				dds_wr_n				<= '1';				 		
				dds_FSK_BPSK_HOLD	<= 'Z';	
				dds_I_O_update		<= '0';
			WHEN state_1 =>		
				-- DDS Write Data Control	
				dds_masterRst		<= '0';	 			
				dds_rd_n				<= '1';				 	 	
				dds_wr_n				<= '0';-- wr on			 		
				dds_FSK_BPSK_HOLD	<= 'Z';	
				dds_I_O_update		<= '0';
			WHEN state_2 => 				 -- Concatenate I_LSB
				-- DDS Write Data Control	
				dds_masterRst		<= '0';	 			
				dds_rd_n				<= '1';				 	 	
				dds_wr_n				<= '1'; 	
				dds_FSK_BPSK_HOLD	<= 'Z';	
				dds_I_O_update		<= '0';
			WHEN state_3 => 
				-- DDS Write Data Control	
				dds_masterRst		<= '0';	 			
				dds_rd_n				<= '1';				 	 	
				dds_wr_n				<= '0';-- wr on	
				dds_FSK_BPSK_HOLD	<= 'Z';	
				dds_I_O_update		<= '0';	
			----------------------------
			----------------------------
			WHEN state_4 => 				 -- Concatenate Q_MSB
				-- DDS Write Data Control	
				dds_masterRst		<= '0';	 			
				dds_rd_n				<= '1';				 	 	
				dds_wr_n				<= '1'; 	
				dds_FSK_BPSK_HOLD	<= 'Z';	
				dds_I_O_update		<= '0'; -- partial update I CHANELL
			WHEN state_5 => 
				-- DDS Write Data Control	
				dds_masterRst		<= '0';	 			
				dds_rd_n				<= '1';				 	 	
				dds_wr_n				<= '0';-- wr on	
				dds_FSK_BPSK_HOLD	<= 'Z';	
				dds_I_O_update		<= '0';	
			WHEN state_6 => 				 -- Concatenate Q_LSB
				-- DDS Write Data Control	
				dds_masterRst		<= '0';	 			
				dds_rd_n				<= '1';				 	 	
				dds_wr_n				<= '1'; 	
				dds_FSK_BPSK_HOLD	<= 'Z';	
				dds_I_O_update		<= '0';
			WHEN state_7 => 
				-- DDS Write Data Control	
				dds_masterRst		<= '0';	 			
				dds_rd_n				<= '1';				 	 	
				dds_wr_n				<= '0';-- wr on	
				dds_FSK_BPSK_HOLD	<= 'Z';	
				dds_I_O_update		<= '0';	
			----------------------------
			WHEN state_8 => 				 -- UPDATE dds
				-- DDS Write Data Control	
				dds_masterRst		<= '0';	 			
				dds_rd_n				<= '1';				 	 	
				dds_wr_n				<= '1';
				dds_FSK_BPSK_HOLD	<= 'Z';	
				dds_I_O_update		<= '1'; 



		END CASE;
	END PROCESS Output_logic; -- Outputs are updated at the end of the process

END ARCHITECTURE Behavioral;