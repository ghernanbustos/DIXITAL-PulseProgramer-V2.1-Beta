--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         fsm_m9k_rd.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-Bit Version 13.1.0 Build 162 10/23/2013 SJ Web Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 05/04/2016 Guillermo H. Bustos
--
--	  Brief: Maquina de Estados  que controla el DATAPATH de la lectura de datos de la RAM 
--				del programador de pulsos.
--				Hasta que no se resetea la maquina de estados, la misma entra en un bucle infinito recorriendo
--					la RAM.
--------------------------------------------------------------------------------

	LIBRARY ieee;
	USE ieee.std_logic_1164.all;
	-----------------------------------------------------
	ENTITY fsm_m9k_rd IS --dp: data path
		PORT ( 
			reset_n			:	IN 	STD_LOGIC;
			clock_50			:	IN 	STD_LOGIC;
			----------------------------------
			start_ensayo	:	IN		STD_LOGIC;--cout 
			overflow			:	IN		STD_LOGIC;  
			----------------------------------			
			rden				:	OUT	STD_LOGIC;--mem
			wren				:	OUT	STD_LOGIC;--mem
			load_iv			:	OUT 	STD_LOGIC;
			rst1_timer		:	OUT 	STD_LOGIC;
			en_cont_timer	:	OUT	STD_LOGIC;
			en_address 		:	OUT	STD_LOGIC;
			en_waveform_g	:	OUT	STD_LOGIC);
	END fsm_m9k_rd;
	-----------------------------------------------------
	ARCHITECTURE comportamental OF fsm_m9k_rd IS
	
	TYPE state_type IS (state0, state1,state2,state3,state4,state5);
	SIGNAL state: state_type; 
	
	BEGIN
	---------- Logica del Siguiente Estado (Next State Logic) ------------------------
	 
Next_state_logic:PROCESS (reset_n, clock_50,start_ensayo,overflow)-- se evalua el CASE y se asigna el estado correspondiente por cada CLOCK_50 
	BEGIN
		IF (reset_n='0') THEN
			state <= state0;
		ELSIF (clock_50'EVENT AND clock_50='1') THEN
				CASE state IS
					WHEN state0 =>
						IF  (start_ensayo = '1') THEN
							state <= state1;
						END IF;
					WHEN state1 =>				
							state <= state2;
					WHEN state2 =>	
 							state <= state3;
 					WHEN state3 =>	
						IF (overflow = '1') THEN
							state <= state4;
						END IF;	
					WHEN state4 =>				--estado agregado por si necesito mas delay
							state <= state5;
					WHEN state5 =>				--estado agregado por si necesito mas delay
							state <= state1;
					WHEN OTHERS => 
						state <= state0;
				END CASE;		
		END IF;
	END PROCESS Next_state_logic;
	
Output_logic:PROCESS (state)
	BEGIN							
 		CASE state IS
			WHEN state0 =>
				rden			 	<= '0';
				wren			 	<= '0';  
				load_iv			<= '0';
				rst1_timer		<= '0';
				en_cont_timer	<= '0';  	
				en_address    	<= '0';
				en_waveform_g  <= '0';
			WHEN state1 =>				
				rden			 	<= '1';
				wren			 	<= '0';  
				load_iv			<= '0';
				rst1_timer		<= '1';--Ver de borrar
				en_cont_timer	<= '0';  	
				en_address    	<= '0';  
				en_waveform_g  <= '1';			
			WHEN state2 =>
				rden			 	<= '1';
				wren			 	<= '0';  
				load_iv			<= '1';
				rst1_timer		<= '0';
				en_cont_timer	<= '0';  	
				en_address    	<= '0'; 
				en_waveform_g  <= '1';	
			WHEN state3 =>
				rden			 	<= '1';
				wren			 	<= '0';  
				load_iv			<= '0';
				rst1_timer		<= '0';
				en_cont_timer	<= '1';  	
				en_address    	<= '0'; 
				en_waveform_g  <= '1';	
			WHEN state4 =>					
				rden			 	<= '1';
				wren			 	<= '0';  
				load_iv			<= '0';
				rst1_timer		<= '0';
				en_cont_timer	<= '0';  	
				en_address    	<= '1';
				en_waveform_g  <= '1';	
			WHEN state5 =>				
				rden			 	<= '1';
				wren			 	<= '0';  
				load_iv			<= '0';
				rst1_timer		<= '0';--volver a 1
				en_cont_timer	<= '0';  	
				en_address    	<= '0';--Estaba en 1
				en_waveform_g  <= '1';	
	END CASE;
	END PROCESS Output_logic;
	
	
	END comportamental;