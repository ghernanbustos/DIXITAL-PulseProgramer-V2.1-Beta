--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         ff_bank.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-Bit Version 13.1.0 Build 162 10/23/2013 SJ Web Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 05/2016 Guillermo H. Bustos
--
--	  Brief: Revisado del libro E.O.Hwang Digital Logic With VHDL pag262
--				Banco de FF-D con reset asincronico y Enable incorporado.
--
--

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
--------------------------------
ENTITY ff_bank IS
	GENERIC(d1_width : INTEGER := 80);
   PORT(
			clk,rst_n,ff_en    : IN     STD_LOGIC; 
			d		       		 : IN     STD_LOGIC_VECTOR(d1_width-1 DOWNTO 0);  
			q			    		 : OUT    STD_LOGIC_VECTOR(d1_width-1 DOWNTO 0));  
END ff_bank;
--------------------------------
ARCHITECTURE logic OF ff_bank IS  
BEGIN
PROCESS(clk,rst_n)
BEGIN
	FOR i IN 0 TO d1_width-1 LOOP 
	
			IF rst_n = '0' THEN --reset asincronico
				q(i) <= '0';
			ELSIF (clk'EVENT and clk = '1') THEN
				IF ff_en = '1' THEN
					q(i) <= d(i);
				END IF;
			END IF;	
			
	END LOOP;
END PROCESS;

END logic;