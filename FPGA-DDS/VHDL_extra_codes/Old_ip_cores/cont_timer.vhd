--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         timer_cont.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-Bit Version 13.1.0 Build 162 10/23/2013 SJ Web Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 11/2016 Guillermo H. Bustos
--
--	  Brief: 	Limitado a 32 bits de entrada
--					Contador cuya funcion sera la de recibir un valor de precarga incial tal que en funcion del clock y
--						y la cantidad de cuentas necesarias para producirse el overflow provocara con el mismo un incremento de un 
--						segundo contador que comanda el address de la memoria a recorrer en forma secuencial.
--				
--					Tener en cuenta los delays que pueden provocar desde el contador hasta la compuerta overflow
--
--					Paquete ieee.numeric_std Es standard IEEE pero cuidado que no tiene definida la operaciones 
-- 					matematica para STD_LOGIC y STD_LOGIC_VECTOR.
--						Info: http://www.c7t-hdl.com/Docs/C7T_NT6_ieee_paquetes.pdf
--		
--					La asignacion de los puertos al instanciar un component, la hago siempre viendo desde el puerto del 
--						modulo componente a conectar hacia la señal que quiera conectar pin_on_module => signal_name
--
--  Corregir:	Revisar bien y verificar el uso de un solo GENERIC para implementar en los diferentes puertos tanto
--						de la and como del contador.
--					Tener en cuenta el valor maximo representable por un tipo de dato Integer = (2^32)/2 = 2147483647
--						ya que el Contador puede arrojar un error:
--										 Warning (10639): VHDL warning at cont_timer.vhd(47): constant value overflow

---------------------------------------------------------------------------------


-----------------------------------------------
-------------File timer_cont.vhd --------------
LIBRARY ieee;
use ieee.std_logic_1164.all;    -- standard unresolved logic UX01ZWLH-
use ieee.numeric_std.all;       -- Paquete Standard IEEE
										  -- No tiene definida operaciones para STD_LOGIC_VECTOR
 ENTITY timer_cont IS
	GENERIC (n : INTEGER := 32);
	PORT (clk 				: 	IN 	STD_LOGIC;
			rst_n				: 	IN 	STD_LOGIC;
			en_cont 			: 	IN 	STD_LOGIC;	--Habilita la precarga del acumulador
			initial_value 	: 	IN 	STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
			debug				:	OUT 	STD_LOGIC_VECTOR(n-1 DOWNTO 0));
 END timer_cont;

ARCHITECTURE counter OF timer_cont IS
	--Declaro Señales		
	SIGNAL temp : integer range 0 to 2147483647; --Recordar que es el (modulo-1)
	--
BEGIN
	PROCESS(clk,rst_n,en_cont,temp)
	--Declaro Variables
	BEGIN		
		IF (rst_n = '0') THEN 
			temp <= 0;
		ELSIF (clk'EVENT AND clk='1') THEN
			if(en_cont = '1') THEN --Solo hace la carga del prescaler
				temp <= to_integer(unsigned(initial_value)); --paso de STD_LOGIC_VECTOR a Integer
			ELSE	
				temp <= temp + 1;
			end if;
		end if;
	debug	 <= std_logic_vector(to_unsigned(temp, n));
	END PROCESS;				
 END counter;
---------------------------------------------

-------------------------------------------------
----------------File and_overflow.vhd------------
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
---------------------------
ENTITY and_overflow IS
	GENERIC (n : INTEGER := 32);
	PORT (x_n	 			: IN STD_LOGIC_VECTOR(n-1 downto 0);
			overflow_and 	: OUT STD_LOGIC);
END and_overflow;
---------------------------
ARCHITECTURE dataflow OF and_overflow IS
	SIGNAL tmp : STD_LOGIC_VECTOR(n-1 downto 0);
BEGIN

	tmp <= (OTHERS => '1');
	
	overflow_and <= '1' WHEN x_n = tmp ELSE '0';
	
END dataflow;
---------------------------------------------
---------------------------------------------
---------------------------------------------
---------------File main.vhd --------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY cont_timer IS
	GENERIC (n : INTEGER := 32);
	PORT(	clk_timer 		: 	IN 	STD_LOGIC;
			rst_n_timer		: 	IN 	STD_LOGIC;
			en_cont_timer	: 	IN 	STD_LOGIC;--Habilita carga del prescaler
			initial_value 	: 	IN 	STD_LOGIC_VECTOR(n-1 DOWNTO 0); --Valor del Prescaler
			overflow			: 	OUT 	STD_LOGIC);
END cont_timer;

ARCHITECTURE behavior OF cont_timer IS
	---------------
	COMPONENT timer_cont IS
--		GENERIC (n : INTEGER := 4);
		PORT (clk 				: 	IN 	STD_LOGIC;
				rst_n				: 	IN 	STD_LOGIC;
				en_cont 			: 	IN 	STD_LOGIC;	
				initial_value 	: 	IN 	STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
				debug				:	OUT 	STD_LOGIC_VECTOR(n-1 DOWNTO 0));
	END COMPONENT; 
	
	COMPONENT and_overflow IS
--		GENERIC (n : INTEGER := 4);
			PORT (x_n	 			: IN STD_LOGIC_VECTOR(n-1 downto 0);
					overflow_and 	: OUT STD_LOGIC);
	END COMPONENT;
  	---------------
	
	SIGNAL W_debug : STD_LOGIC_VECTOR (n-1 DOWNTO 0);
BEGIN 
	U1: timer_cont 	PORT MAP (	clk  => clk_timer,
											rst_n => rst_n_timer, 
											en_cont  => en_cont_timer, 
											initial_value(n-1 downto 0) => initial_value(n-1 downto 0),
											debug(n-1 DOWNTO 0)	=> W_debug(n-1 DOWNTO 0)) ;																					
																																
	U2: and_overflow	PORT MAP (	x_n => W_debug(n-1 DOWNTO 0), 
											overflow_and => overflow);
	
END behavior; 

