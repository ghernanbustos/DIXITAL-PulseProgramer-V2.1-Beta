--------------------------------------------------------------------------------
--	  Autor: 			  Extraido del libro Circuit Design with VHDL Volnei A. Pedroni
--   Modificado:		  Guillermo H. Bustos
--   FileName:         barrel_shift64.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-Bit Version 13.1.0 Build 162 10/23/2013 SJ Web Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 18/10/2016 Guillermo H. Bustos
--
--	  Brief: Se extiende el numero de bits de datos a 80 
--				Se modifica el corrimiento hasta 64 bits
--				Corrimiento hacia la Izquierda, desde  MSB <-- LSM (Chekeado)
--				Stages = log2(num bit a correr); Numero de bit a correr requiere de tantas Stages como indica la formula
--------------------------------------------------------------------------------

---------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
---------------------------------------------
 ENTITY barrel_shift64 IS
	PORT ( 	inp: 		IN 	STD_LOGIC_VECTOR (79 DOWNTO 0);
				shift: 	IN 	STD_LOGIC_VECTOR (6 DOWNTO 0);
				outp: 	OUT 	STD_LOGIC_VECTOR (79 DOWNTO 0));
 END barrel_shift64;
 ---------------------------------------------
 ARCHITECTURE behavior OF barrel_shift64 IS
 BEGIN
	PROCESS (inp, shift)
		VARIABLE temp1: STD_LOGIC_VECTOR (79 DOWNTO 0);
		VARIABLE temp2: STD_LOGIC_VECTOR (79 DOWNTO 0);
		VARIABLE temp3: STD_LOGIC_VECTOR (79 DOWNTO 0);
		VARIABLE temp4: STD_LOGIC_VECTOR (79 DOWNTO 0);
		VARIABLE temp5: STD_LOGIC_VECTOR (79 DOWNTO 0);
		VARIABLE temp6: STD_LOGIC_VECTOR (79 DOWNTO 0);
		
	BEGIN
	---- 1st stage ----- 1 cero
		IF (shift(0)='0') THEN
			temp1 := inp;
		ELSE
			temp1(0) := '0';
			FOR i IN 1 TO inp'HIGH LOOP --'HIGH retorna el valor mas alto del indice del 
				temp1(i) := inp(i-1);	 -- arreglo. 'HIGH = 7
			 END LOOP;
		END IF;
	 ---- 2nd stage ----- 2 ceros
	 IF (shift(1)='0') THEN
			temp2 := temp1;
		 ELSE
			 FOR i IN 0 TO 1 LOOP
				temp2(i) := '0'; 
				END LOOP;
			 FOR i IN 2 TO inp'HIGH LOOP
				temp2(i) := temp1(i-2);
		 END LOOP;
	 END IF;
	 ---- 3rd stage ----- 4 ceros
		 IF (shift(2)='0') THEN
		 temp3 := temp2;
		 ELSE
			FOR i IN 0 TO 3 LOOP
				temp3(i) := '0';
			END LOOP;
			FOR i IN 4 TO inp'HIGH LOOP
				temp3(i) := temp2(i-4);
			END LOOP;
		 END IF;
	 ---- 4rd stage ----- 8 ceros
		 IF (shift(3)='0') THEN
		temp4 := temp3;
		 ELSE
			FOR i IN 0 TO 7 LOOP
				temp4(i) := '0';
			END LOOP;
			FOR i IN 8 TO inp'HIGH LOOP
				temp4(i) := temp3(i-8);
			END LOOP;
		 END IF;
		 
	 ---- 5rd stage ----- 16 ceros
		 IF (shift(4)='0') THEN
		 temp5 := temp4;
		 ELSE
			FOR i IN 0 TO 15 LOOP
				temp5(i) := '0';
			END LOOP;
			FOR i IN 16 TO inp'HIGH LOOP
				temp5(i) := temp4(i-16);
			END LOOP;
		 END IF;
	 ---- 6rd stage ----- 32 ceros
		 IF (shift(5)='0') THEN
		 temp6 := temp5;
		 ELSE
			FOR i IN 0 TO 31 LOOP
				temp6(i) := '0';
			END LOOP;
			FOR i IN 32 TO inp'HIGH LOOP
				temp6(i) := temp5(i-32);
			END LOOP;
		 END IF;
	 ---- 7rd stage ----- 64 ceros
		 IF (shift(6)='0') THEN
		 outp <= temp6;
		 ELSE
			FOR i IN 0 TO 63 LOOP
				outp(i) <= '0';
			END LOOP;
			FOR i IN 64 TO inp'HIGH LOOP
				outp(i) <= temp6(i-64);
			END LOOP;
		 END IF;
	END PROCESS;
 END behavior;
---------------------------------------------