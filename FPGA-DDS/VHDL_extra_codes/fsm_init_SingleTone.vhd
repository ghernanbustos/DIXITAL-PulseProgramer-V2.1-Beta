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
-- 	System Clock set on 180Mhz (9x internal multiplier and 20Mhz pcb ref clock)
--		Data path to initialize AD9854 in Single Tone Mode
--		Master Reset needs to be 10 internal clock cycles to initialize the registers
--			Check Internal DDS Frecuency Check PPL active and multiplier. PLL OFF
-- 	Check if less states in fsm are needed.
-- 	First version of initialization module, its not a clear code, improve using a 
-- 		sequential memory with configuration words
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

ENTITY fsm_init_SingleTone IS
  port (
		clk_fsm1     	: 	IN  std_logic; -- clk_fsm1 25Mhz
		rst_n_fsm1   	: 	IN  std_logic; -- External switch
		start_fsm1		: 	IN  std_logic; -- Push button tu start fsm
		-- Mux Control
		out_mux  		: 	OUT std_logic; -- MUX switch to next fsm data	
		fsm_initEND		:	OUT std_logic;
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
END ENTITY fsm_init_SingleTone;
------------------------------------------------
ARCHITECTURE Behavioral OF fsm_init_SingleTone IS
  -- Signals declarations
  TYPE state_type IS (state_0, state_1, state_2, state_3, state_4,
							 state_5, state_6, state_7, state_8, state_9,
							 state_10, state_11, state_12, state_13, 
							 state1_I_msb, state2_I_msb, state3_I_msb,
							 state4_I_lsb, state5_I_lsb, state6_I_lsb,
							 state1_Q_msb, state2_Q_msb, state3_Q_msb,
							 state4_Q_lsb, state5_Q_lsb, state6_Q_lsb,
							 state_14    , state_15    ,state_16);	-- Enumerated type decl
  
  SIGNAL state : state_type; 														-- state_type is signal type
  
 -- Dir Control Register Word
  CONSTANT dir_PD_Reg  	: std_logic_vector(5 downto 0) := "011101";-- PowerDown Reg Dir 	 
  CONSTANT dir_Pll_Reg	: std_logic_vector(5 downto 0) := "011110";-- PLL Mult Reg Dir 
  CONSTANT dir_Mode_Reg	: std_logic_vector(5 downto 0) := "011111";-- Mode func Reg Dir
  CONSTANT dir_OSK_Reg  : std_logic_vector(5 downto 0) := "010000";-- Inv Sinc Output Shaped Key Reg Dir 
 -- Data Control Register Word
  CONSTANT data_PD_Reg 	: std_logic_vector(7 downto 0) := X"00";  -- PD all off
  CONSTANT data_Pll_Reg	: std_logic_vector(7 downto 0) := X"49";  -- PLL Mult 12- Sys Clock 180Mhz
  CONSTANT data_Mode_Reg: std_logic_vector(7 downto 0) := X"00";  -- Single Tone  
  CONSTANT data_OSK_Reg	: std_logic_vector(7 downto 0) := X"60";  -- OSK EN on, need set dac amplitud  
 -- DAC ampl control
 -- I Chanell
  CONSTANT dir_IOSK_msb_Reg  	: std_logic_vector(5 downto 0) := "100001";-- 
  CONSTANT dir_IOSK_lsb_Reg  	: std_logic_vector(5 downto 0) := "100010";-- 
  CONSTANT data_IOSK_msb_Reg  : std_logic_vector(7 downto 0) := X"0F";-- 
  CONSTANT data_IOSK_lsb_Reg  : std_logic_vector(7 downto 0) := X"FF";--  
 -- Q Chanell   
  CONSTANT dir_QOSK_msb_Reg  	: std_logic_vector(5 downto 0) := "100011";-- 
  CONSTANT dir_QOSK_lsb_Reg  	: std_logic_vector(5 downto 0) := "100100";-- 
  CONSTANT data_QOSK_msb_Reg  : std_logic_vector(7 downto 0) := X"0F";-- 
  CONSTANT data_QOSK_lsb_Reg  : std_logic_vector(7 downto 0) := X"FF";-- 
  

  
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
	-- FROM HERE -----------------------------------
				WHEN state_2 =>					-- Set Word PD
					state <= state_3;  

				WHEN state_3 =>					-- 
					state <= state_4; 

				WHEN state_4 =>					-- 
					state <= state_5; 

				WHEN state_5 =>					-- Set Word PLL
					state <= state_6; 		
					
				WHEN state_6 =>					-- 
					state <= state_7; 

				WHEN state_7 =>					-- 
					state <= state_8;

				WHEN state_8 =>					-- Set Word Inv Sinc - OSK
					state <= state_9;		
		
				WHEN state_9 =>					
					state <= state_10;			
					
				WHEN state_10 =>					
					state <= state_11;

				WHEN state_11 =>					-- Set Word Mode	
					state <= state_12;	

				WHEN state_12 =>					
					state <= state_13;	

				WHEN state_13 =>					
					state <= state1_I_msb;	

				WHEN state1_I_msb =>					-- -- Set DAC Amplitude Word 	
					state <= state2_I_msb;	
					
				WHEN state2_I_msb =>					-- 
					state <= state3_I_msb;
					
				WHEN state3_I_msb =>					-- 
					state <= state4_I_lsb;	
					
				WHEN state4_I_lsb =>					-- 
					state <= state5_I_lsb;
					
				WHEN state5_I_lsb =>					-- 
					state <= state6_I_lsb;	
					
				WHEN state6_I_lsb =>					--
					state <= state1_Q_msb;
					
				WHEN state1_Q_msb =>					-- 
					state <= state2_Q_msb;

				WHEN state2_Q_msb =>					-- 
					state <= state3_Q_msb;	
					
				WHEN state3_Q_msb =>					--
					state <= state4_Q_lsb;
					
				WHEN state4_Q_lsb =>					-- 
					state <= state5_Q_lsb;	

				WHEN state5_Q_lsb =>					-- 
					state <= state6_Q_lsb;	
					
				WHEN state6_Q_lsb =>					--
					state <= state_14;
					
				WHEN state_14 =>					-- 
					state <= state_15;	
				
				WHEN state_15 =>					-- 
					state <= state_16;	
					
				WHEN state_16 =>					-- 
					state <= state_16;	
					
			END CASE;
		END IF;
	END PROCESS state_transition;
  
  
Output_logic: PROCESS (state)
	BEGIN							
 		CASE state IS
			WHEN state_0 => -- Initial state
				out_mux			<= '0'; 
				masterRst	 	<= '0';	-- dds Master Rst off
				rd_n			 	<= '1';  
				wd_n			 	<= '1';	
				FSK_BPSK_HOLD	<= 'Z';	
				I_O_update		<= '0';
				address			<= "000000"; --"000000"
				data				<= "00000000"; --"000000"
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
				
			WHEN state_1 => -- Master RST delayed 
				out_mux			<= '0'; 
				masterRst	 	<= '1';	-- dds Master Rst on 
				rd_n			 	<= '1';  
				wd_n			 	<= '1';	
				FSK_BPSK_HOLD	<= 'Z';	
				I_O_update		<= '0';
				address			<= "000000"; --"000000"
				data				<= "00000000"; --"000000"
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
-- ----------------------------------------------------------------
			WHEN state_2 =>				
				out_mux			<= '0'; 
				masterRst	 	<= '0';	-- dds Master 
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '1';	-- write off
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_PD_Reg; 		
				data				<= data_PD_Reg; 	
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
	
			WHEN state_3 =>
				out_mux			<= '0'; 
				masterRst	 	<= '0';	-- dds Master 
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '0';	-- write ON
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_PD_Reg; -- XX01_1111
				data				<= data_PD_Reg;		--"000000"
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';

			WHEN state_4 =>				
				out_mux			<= '0'; 
				masterRst	 	<= '0';	-- dds Master 
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '1';	-- write off
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_PD_Reg; 		-- XX01_1111
				data				<= data_PD_Reg; 	--	"000000"
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
	
			WHEN state_5 =>
				out_mux			<= '0'; 
				masterRst	 	<= '0';	-- dds Master 
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '1';	-- write 
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_Pll_Reg; -- XX01_1111
				data				<= data_Pll_Reg;		--"000000"
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
		      fsm_initEND		<= '0';		

			WHEN state_6 =>				
				out_mux			<= '0'; 
				masterRst	 	<= '0';	-- dds Master 
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '0';	-- write off
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_Pll_Reg; 		-- XX01_1111
				data				<= data_Pll_Reg; 	--	"000000"
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
	
			WHEN state_7 =>
				out_mux			<= '0'; 
				masterRst	 	<= '0';	-- dds Master 
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '1';	-- write ON
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_Pll_Reg; 
				data				<= data_Pll_Reg;		
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';	
			   fsm_initEND		<= '0';	

			WHEN state_8 =>	
				out_mux			<= '0'; 	--MUX ON
				masterRst	 	<= '0';	-- dds Master Rst off
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '1';	-- write Off
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_OSK_Reg; 
				data				<= data_OSK_Reg;		
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';		
				fsm_initEND		<= '0';

			WHEN state_9 =>
				out_mux			<= '0'; 	--MUX ON
				masterRst	 	<= '0';	-- dds Master Rst off
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '0';	-- write on
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_OSK_Reg; 
				data				<= data_OSK_Reg;		
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';

			WHEN state_10 =>
				out_mux			<= '0'; 	--MUX ON
				masterRst	 	<= '0';	-- dds Master Rst off
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '1';	-- write Off
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_OSK_Reg;
				data				<= data_OSK_Reg;	
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';

			WHEN state_11 =>
				out_mux			<= '0'; 
				masterRst	 	<= '0';	-- dds Master 
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '1';	-- write off
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_Mode_Reg; 		
				data				<= data_Mode_Reg; 	
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
				
			WHEN state_12 =>
				out_mux			<= '0'; 
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '0';	-- write ON
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_Mode_Reg; 
				data				<= data_Mode_Reg;		
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
				
			WHEN state_13 =>
				out_mux			<= '0'; 	
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '1';	
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_Mode_Reg; 
				data				<= data_Mode_Reg;		
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
---------------I signal ---------------------------
			WHEN state1_I_msb =>
				out_mux			<= '0'; 
				masterRst	 	<= '0';	-- dds Master 
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '1';	-- write off
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_IOSK_msb_Reg; 		
				data				<= data_IOSK_msb_Reg; 	
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
				
			WHEN state2_I_msb =>
				out_mux			<= '0'; 
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '0';	-- write ON
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_IOSK_msb_Reg; 		
				data				<= data_IOSK_msb_Reg; 		
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
				
			WHEN state3_I_msb =>
				out_mux			<= '0'; 	
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '1';	
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_IOSK_msb_Reg; 		
				data				<= data_IOSK_msb_Reg; 		
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
			WHEN state4_I_lsb =>
				out_mux			<= '0'; 
				masterRst	 	<= '0';	-- dds Master 
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '1';	-- write off
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_IOSK_lsb_Reg; 		
				data				<= data_IOSK_lsb_Reg; 	
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
				
			WHEN state5_I_lsb =>
				out_mux			<= '0'; 
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '0';	-- write ON
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_IOSK_lsb_Reg; 		
				data				<= data_IOSK_lsb_Reg; 	
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
				
			WHEN state6_I_lsb =>
				out_mux			<= '0'; 	
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '1';	
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_IOSK_lsb_Reg; 		
				data				<= data_IOSK_lsb_Reg; 	
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
--------------Q signal -------------------------------
			WHEN state1_Q_msb =>
				out_mux			<= '0'; 
				masterRst	 	<= '0';	-- dds Master 
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '1';	-- write off
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_QOSK_msb_Reg; 		
				data				<= data_QOSK_msb_Reg; 	
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
				
			WHEN state2_Q_msb =>
				out_mux			<= '0'; 
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '0';	-- write ON
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_QOSK_msb_Reg; 		
				data				<= data_QOSK_msb_Reg; 	
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
				
			WHEN state3_Q_msb =>
				out_mux			<= '0'; 	
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '1';	
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_QOSK_msb_Reg; 		
				data				<= data_QOSK_msb_Reg; 
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
			WHEN state4_Q_lsb =>
				out_mux			<= '0'; 
				masterRst	 	<= '0';	-- dds Master 
				rd_n			 	<= '1';  -- Read off
				wd_n			 	<= '1';	-- write off
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_QOSK_lsb_Reg; 		
				data				<= data_QOSK_lsb_Reg; 	
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
				
			WHEN state5_Q_lsb =>
				out_mux			<= '0'; 
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '0';	-- write ON
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_QOSK_lsb_Reg; 		
				data				<= data_QOSK_lsb_Reg; 	
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
				
			WHEN state6_Q_lsb =>
				out_mux			<= '0'; 	
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '1';	
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= dir_QOSK_lsb_Reg; 		
				data				<= data_QOSK_lsb_Reg; 	
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
				fsm_initEND		<= '0';
------------------------------------------------------					
			WHEN state_14 => 				-- IO update ON
				out_mux			<= '0'; 	
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '1';	
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '1';
				address			<= "000000"; 
				data				<= "00000000";		
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';
			   fsm_initEND		<= '0';
			WHEN state_15 => 				-- IO update OFF
				out_mux			<= '0'; 	
				masterRst	 	<= '0';	
				rd_n			 	<= '1';  
				wd_n			 	<= '1';	
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= "000000"; 
				data				<= "00000000";		
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '0';	
				fsm_initEND		<= '0';
				
			WHEN state_16 =>				-- MUX ON
				out_mux			<= '1'; 	 
				masterRst	 	<= '0';	 
				rd_n			 	<= '1';   
				wd_n			 	<= '1';	 
				FSK_BPSK_HOLD	<= 'Z';
				I_O_update		<= '0';
				address			<= "000000"; 
				data				<= "00000000";			
				s0	<= '0';
				s1	<= '0';				
				s2	<= '0';
				s3	<= '0';
				s4	<= '1';
				fsm_initEND		<= '1';

		END CASE;
	END PROCESS Output_logic; -- Outputs are updated at the end of the process

END ARCHITECTURE Behavioral;