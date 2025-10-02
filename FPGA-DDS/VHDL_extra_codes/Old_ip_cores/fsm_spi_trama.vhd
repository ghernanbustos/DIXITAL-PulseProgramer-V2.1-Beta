--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         fsm_spi_trama.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-Bit Version 13.1.0 Build 162 10/23/2013 SJ Web Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 05/04/2016 Guillermo H. Bustos
--
--	  Brief: Maquina de Estados para que controla el DATAPATH de la trama de datos recibida
--		      desde el microcontrolador, por medio del protocolo SPI.
--				Se agrego el state5 para controlar la memoria.
--------------------------------------------------------------------------------
	LIBRARY ieee;
	USE ieee.std_logic_1164.all;
	-----------------------------------------------------
	ENTITY fsm_spi_trama IS --dp: data path
		PORT ( 
			reset_n			:	IN 	STD_LOGIC;
			clock_50			:	IN 	STD_LOGIC;
			----------------------------------
			rrdy_spi			:	IN		STD_LOGIC; --Bandera SPI dato que llego proviene de la fpga
			last_frame		:	IN		STD_LOGIC; --Bandera indica parte de la trama MSB o LSB, proviende del uC
			ss_n_fsm			:	IN 	STD_LOGIC;
			----------------------------------			
			rx_req			:	OUT	STD_LOGIC;
			cont_en			:	OUT	STD_LOGIC;
			ff_reg_en		:	OUT	STD_LOGIC;
			buff_en  		:	OUT	STD_LOGIC;
			mem_wren  		:	OUT	STD_LOGIC;
			mem_ren  		:	OUT	STD_LOGIC;
			flag_rst_FSM	:	OUT	STD_LOGIC);
	END fsm_spi_trama;
	-----------------------------------------------------
	ARCHITECTURE comportamental OF fsm_spi_trama IS
	TYPE state_type IS (state0, state1, state2, state3, state4, state5);
	SIGNAL state: state_type; --signal modela hilos en el circuito '<=' para
									  -- asignar valores
									  -- Recordar que las signal no se actualizan hasta que se termina el process
	BEGIN
	---------- Logica del Siguiente Estado (Next State Logic) ------------------------
	 
Next_state_logic:PROCESS (reset_n, clock_50)-- se evalua el CASE y se asigna el estado correspondiente por cada CLOCK_50 
	BEGIN
		IF (reset_n='0') THEN
			state <= state0;
		ELSIF (clock_50'EVENT AND clock_50='1') THEN
			CASE state IS
				WHEN state0 =>
					IF (rrdy_spi = '0') THEN -- No esta al vicio esta sentencia?
						state <= state0;
					ELSIF ( (rrdy_spi AND ss_n_fsm )= '1') THEN
					state <= state1;
					END IF;
				WHEN state1 =>				
						state <= state2;
				WHEN state2 =>
					IF (last_frame = '1') THEN
						state <= state3;
					ELSIF last_frame = '0' THEN
						state <= state4;
					END IF;
				WHEN state3 =>
						state <= state0;
				WHEN state4 =>
						state <= state5;
				WHEN state5 =>
					IF (reset_n = '0') THEN
						state <= state0;
					ELSIF (reset_n = '1') THEN
						state <= state5;
					END IF;
				WHEN OTHERS => 
					state <= state0;
			END CASE;		
		END IF;
	END PROCESS Next_state_logic;
	
Output_logic:PROCESS (state)-- se evalua el CASE y se asigna el estado correspondiente por cada CLOCK_50 
	BEGIN								 -- codigo SECUENCIAL estamos en presencia de un PROCESS

 		CASE state IS
			WHEN state0 =>
				rx_req		 <= '0';
				ff_reg_en	 <= '0'; -- := asignacion de variables, se actualizan inmediatamente, para salir
				cont_en		 <= '0'; -- del process debo asignar la variable a una señal (cable)	
				buff_en      <= '0';
				mem_wren	    <= '0';
				mem_ren	    <= '0';	
				flag_rst_FSM <= '0';
			WHEN state1 =>				
				rx_req		 <= '1';				
				ff_reg_en	 <= '0'; 
				cont_en		 <= '0';
				buff_en      <= '0'; 
				mem_wren	    <= '0';
				mem_ren	    <= '0';
				flag_rst_FSM <= '0';
			WHEN state2 =>
				rx_req		 <= '0';				
				ff_reg_en 	 <= '1'; 
				cont_en		 <= '0';
				buff_en      <= '0';
				mem_wren	    <= '0';
				mem_ren	    <= '0';
				flag_rst_FSM <= '0';
			WHEN state3 =>
				rx_req		 <= '0';				
				ff_reg_en	 <= '0'; 
				cont_en		 <= '1'; 
				buff_en	    <= '0';
				mem_wren	    <= '0';
				mem_ren	    <= '0';
				flag_rst_FSM <= '0';
			WHEN state4 =>
				rx_req		 <= '0';				
				ff_reg_en	 <= '0'; 
				cont_en		 <= '0';
				buff_en	    <= '1'; 
			   mem_wren	    <= '1';
				mem_ren	    <= '0';
				flag_rst_FSM <= '0';
			WHEN state5 =>
				rx_req		 <= '0';				
				ff_reg_en	 <= '0'; 
				cont_en		 <= '0';
				buff_en	    <= '1'; -- para tomar los datos de la Address proveniente de la trama
			   mem_wren	    <= '0';
				mem_ren	    <= '1';
				flag_rst_FSM <= '1';


	END CASE;
	END PROCESS Output_logic;
	
	END comportamental;
