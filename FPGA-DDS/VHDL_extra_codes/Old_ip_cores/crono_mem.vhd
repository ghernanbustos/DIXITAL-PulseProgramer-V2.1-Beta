--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         crono_mem.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-Bit Version 13.1.0 Build 162 10/23/2013 SJ Web Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 05/04/2016 Guillermo H. Bustos
--
--	  Brief: Contador con carga paralela
--				Diseñado para primero accionar load, una vez registrado la precarga  mediante una 
--				deteccion por flanco, despues accionar 
--					el en_cont, para comenzar con la cuenta del cronometro.
--				Se disponen de dos RESETs, rst_n que va a un reset general del sistema, y un rst1 que
-- 	 			permite un reset desde algun estado de la FSM.
--				Modifcar o agregar algo que detecte el rango maximo del integer, HIGH'
--				Modifcar el tipo de dato INTEGER, pasar a utilizar un STD_LOGIC_VECTOR para que de esta manera 
--				Revisar que es SIGNED INTEGER, modificar a UNSIGNED INTEGER.. ver bien esto, o sino usar STD_LOGIC_VECTOR pero puede
--					que no pueda realizar operaciones aritmeticas con un STD_LOGIC
--				Tener en cuenta que "temp" es una variable del tipo Entero con signo, cuidado con la conversion de STD_LOGIC_VECTOR --> iNTEGER

--------------------------------------------------------------------------------
-------------File timer_cont.vhd --------------
LIBRARY ieee;
use ieee.std_logic_1164.all;    -- standard unresolved logic UX01ZWLH-
use ieee.numeric_std.all;       -- Paquete Standard IEEE
										  -- No tiene definida operaciones para STD_LOGIC_VECTOR
 ENTITY timer_cont2 IS
	GENERIC (n : INTEGER := 32);
	PORT (clk 				: 	IN 	STD_LOGIC;
			rst_n, rst1 	: 	IN 	STD_LOGIC;
			en_cont,load	: 	IN 	STD_LOGIC;	
			initial_value 	: 	IN 	STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
			cont_out			:	OUT 	STD_LOGIC_VECTOR(n-1 DOWNTO 0));
 END timer_cont2;

ARCHITECTURE counter OF timer_cont2 IS
-- SIGNAL
BEGIN	
	PROCESS(clk,rst_n,en_cont,rst1,load)-- Cada clock se activa un process	
		VARIABLE temp : INTEGER range 0 to 2147483647; -- Hablamos de un Entero SIGNADO
	BEGIN
		IF (rst_n = '0' OR rst1 = '1') THEN -- Con los if anidados hay una lista de prioridades
			temp := 0;
		ELSIF (clk'EVENT AND clk='1' ) THEN	-- Detecta flanco las flags deben estar en alto previo al flanco	
			IF (load = '1') THEN	
				temp := 	to_integer(signed(initial_value)); -- initial_value en esta asignacion no hay un corrimiento? 
			ELSIF  en_cont = '1' THEN    							 -- temp := 	to_integer(signed(initial_value));
				IF temp = 2147483647 THEN 
					temp := 2147483647;-- me enclava la cuenta hasta recibir un rst1
				ELSE 
					temp := temp + 1;
				END IF;
			END IF;
		END IF;
		
	cont_out	 <= std_logic_vector(to_signed(temp, n));-- n es el numero absoluto de bits

	END PROCESS;				
 END counter;

------------------File and_overflow.vhd------------
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
---------------------------
ENTITY and_overflow2 IS
GENERIC (n : INTEGER := 32);
	PORT (x_n	 			: IN STD_LOGIC_VECTOR(n-1 downto 0);
			overflow_and 	: OUT STD_LOGIC);
END and_overflow2;
---------------------------
ARCHITECTURE dataflow OF and_overflow2 IS
	SIGNAL tmp : STD_LOGIC_VECTOR(n-1 downto 0);
BEGIN

	tmp <= "01111111111111111111111111111111"; --Este valor, es el correspondiente a 2147483647 para la cuenta maxima del INTEGER (+)32 bits
															 --No se puede poner (OTHERS => '1') para el caso en el que uso una variable integer.
															 --ya que no me puedo asegurar que sean todos 1 para el maximo valor, debido a que tiene + - y 0
															 --el MSB esta en 0 indicando que es un valor positivo, es por ello que la AND nunca
															 --podra entregarme un 1 de overflow.
															 
	overflow_and <= '1' WHEN x_n = tmp ELSE '0';
	
END dataflow;

---------------------------------------------
-----------------File main.vhd --------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY crono_mem IS
	GENERIC (n : INTEGER := 32);-- Valor de precarga
	PORT(	clk_timer 						: 	IN 	STD_LOGIC;
			rst_n_timer, rst1_timer		: 	IN 	STD_LOGIC;
			en_cont_timer, load_iv		: 	IN 	STD_LOGIC; 
			initial_value	 				: 	IN 	STD_LOGIC_VECTOR(n-1 DOWNTO 0);  
			cout								: 	OUT 	STD_LOGIC);
END crono_mem;

ARCHITECTURE behavior OF crono_mem IS
	---------------
	COMPONENT timer_cont2 IS
		PORT (clk 				: 	IN 	STD_LOGIC;
				rst_n, rst1 	: 	IN 	STD_LOGIC;
				en_cont,load	: 	IN 	STD_LOGIC;	
				initial_value 	: 	IN 	STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
				cont_out			:	OUT 	STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT; 
	
	COMPONENT and_overflow2 IS
			PORT (x_n	 			: IN STD_LOGIC_VECTOR(n-1 downto 0);
					overflow_and 	: OUT STD_LOGIC);
	END COMPONENT;
  	---------------
	SIGNAL W_debug : STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	
BEGIN 				-- Puerto del Comp -- Puerto del Bloque
	U1: timer_cont2 	PORT MAP (	clk  => clk_timer,
											rst_n => rst_n_timer, 
											rst1 => rst1_timer,
											en_cont  => en_cont_timer, 
											load => load_iv,
											initial_value(n-1 downto 0) => initial_value(n-1 downto 0),
											cont_out(n-1 DOWNTO 0)	=> W_debug(n-1 DOWNTO 0)) ;																					
																																
	U2: and_overflow2	PORT MAP (	x_n => W_debug(n-1 DOWNTO 0), 
											overflow_and => cout);
	
END behavior; 






