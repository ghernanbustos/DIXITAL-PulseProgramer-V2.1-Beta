--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         cont_shift64.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-Bit Version 13.1.0 Build 162 10/23/2013 SJ Web Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 11/2016 Guillermo H. Bustos
--
--	  Brief: Contador para secuenciar hasta 6 frames de 16 bits
--				Flag de ultimo frame.
--          use ieee.std_logic_arith.all; NO USAR YA QUE NO ES UN ESTANDAR DE IEEE
--				Corregir el Codigo de la OR
---------------------------------------------------------------------------------

-------------File cont_shift2.vhd --------------
LIBRARY ieee;
use ieee.std_logic_1164.all;    -- standard unresolved logic UX01ZWLH-
use ieee.numeric_std.all;       -- Paquete Standard IEEE

 ENTITY cont_shift2 IS
	PORT (clk 		: IN STD_LOGIC;
			rst_n		: IN STD_LOGIC;
			en_cont 	: IN STD_LOGIC;
			cont_out	: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));--OUT INTEGER RANGE 0 TO 64);
 END cont_shift2;

ARCHITECTURE counter OF cont_shift2 IS
BEGIN
	PROCESS(clk,rst_n,en_cont)
		VARIABLE temp : INTEGER RANGE 0 TO 64; --STD_LOGIC_VECTOR(6 DOWNTO 0);--
	BEGIN
		IF (rst_n='0') THEN 
			temp := 64;
		ELSIF (en_cont = '1') AND (clk'EVENT AND clk='1') THEN
			temp := temp - 16;
				IF (temp=112) THEN temp := 64; --Cuando el valor sea 112 quiere decir que 
				END IF;								 --el valor de la cuenta es inferior a Cero
														 --En realidad nunca se daria esta situacion ya que el contador se reinicia a cero por 
														-- el reset_n que me termina volviendo la maquina de estado a S0 y el cont_shift64=64
		END IF;
			cont_out <= std_logic_vector(to_unsigned(temp, 7)); -- Para no perder el valor de la variable debo asignarla a un puerto 
	END PROCESS;				
 END counter;
---------------------------------------------

--------------File or_7in.vhd----------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY or_7iin is
	PORT (or7_in      : IN  STD_LOGIC_VECTOR(6 downto 0); 
			flag_or		: out STD_LOGIC);
END or_7iin;

ARCHITECTURE gates4 OF or_7iin IS
BEGIN

flag_or <=  ((or7_in(0) or or7_in(1))  or  (or7_in(2) or or7_in(3))) or (or7_in(4) or (or7_in(5) or or7_in(6)));

END gates4;

--LIBRARY IEEE;
--USE ieee.std_logic_1164.all;
--
--ENTITY or_n IS
--GENERIC (n : INTEGER := 4);
--PORT (	or7_in 	: IN STD_LOGIC_VECTOR(n-1 TO 0);
--			flag_or 	: OUT STD_LOGIC);
--END or_n;
--
--ARCHITECTURE dataflow OF andn IS
--SIGNAL tmp : STD_LOGIC_VECTOR(n-1 TO 0);
--BEGIN
--	tmp <= (OTHERS => '1');-- tmp esta en 1 todas sus entradas
--	f <= '1' WHEN x = tmp ELSE '0';-- la unica posibilidad de que la salida sea 1 es cuando sus entradas esten todas en 1
--END dataflow;
-------------File main.vhd --------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY cont_shift64 IS
	PORT(	clk1 				: IN STD_LOGIC;
			rst1_n			: IN STD_LOGIC;
			en_cont1			: IN STD_LOGIC;
			cont_out1		: OUT STD_LOGIC_VECTOR(6 downto 0);
			flag_or_out1	: OUT STD_LOGIC);
END cont_shift64;

ARCHITECTURE behavior OF cont_shift64 IS
	---------------
	COMPONENT cont_shift2 IS
		PORT (clk 		: IN STD_LOGIC; 
				rst_n		: IN STD_LOGIC;
			   en_cont 	: IN STD_LOGIC; 
				cont_out	: OUT STD_LOGIC_VECTOR(6 downto 0)); 
	END COMPONENT; 
	
	COMPONENT or_7iin IS
		PORT (or7_in  : IN STD_LOGIC_VECTOR(6 downto 0);
				flag_or : out STD_LOGIC);
	END COMPONENT;
  	---------------
	SIGNAL W : STD_LOGIC_VECTOR (6 DOWNTO 0);
BEGIN 
	U1: cont_shift2 	PORT MAP (clk  => clk1, rst_n => rst1_n, en_cont  => en_cont1, 
										 cont_out(6 downto 0) => W(6 downto 0)) ;																					
																																
	U2: or_7iin			PORT MAP ( or7_in => W(6 DOWNTO 0), 
											flag_or => flag_or_out1);
	cont_out1 <= W(6 downto 0);
END behavior; 
 
 