--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         address_cont32.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-Bit Version 13.1.0 Build 162 10/23/2013 SJ Web Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 12/2016 Guillermo H. Bustos
--
--	  Brief: Incrementa de a una unidad el valor del address a leer en la memoria M9K
---------------------------------------------------------------------------------

-------------address_cont32.vhd --------------
LIBRARY ieee;
use ieee.std_logic_1164.all;    -- standard unresolved logic UX01ZWLH-
use ieee.numeric_std.all;       -- Paquete Standard IEEE
										  -- No tiene definida operaciones para STD_LOGIC_VECTOR
 ENTITY address_cont32 IS
	GENERIC (n : INTEGER := 5);
	PORT (clk_address 		: 	IN 	STD_LOGIC;
			rst_n_address		: 	IN 	STD_LOGIC;
			en_address			: 	IN 	STD_LOGIC;	--Habilita la precarga del acumulador			
			address_out			:	OUT 	STD_LOGIC_VECTOR(n-1 DOWNTO 0));
 END address_cont32;

ARCHITECTURE counter OF address_cont32 IS
BEGIN
	PROCESS(clk_address,rst_n_address,en_address)
		VARIABLE temp : INTEGER RANGE 0 TO 32; --STD_LOGIC_VECTOR(6 DOWNTO 0);--
	BEGIN
		IF (rst_n_address='0') THEN 
			temp := 0;
		ELSIF (en_address = '1') AND (clk_address'EVENT AND clk_address='1') THEN
			temp := temp + 1;
				IF (temp = 32) THEN temp := 0; 
				END IF;								
		END IF;
			address_out	 <= std_logic_vector(to_unsigned(temp, n)); -- Para no perder el valor de la variable debo asignarla a un puerto 
	END PROCESS;
 END counter;
---------------------------------------------