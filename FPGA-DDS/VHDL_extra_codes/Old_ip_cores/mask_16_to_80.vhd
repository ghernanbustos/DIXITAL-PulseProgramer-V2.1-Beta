--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         mask_16_to_80.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-Bit Version 13.1.0 Build 162 10/23/2013 SJ Web Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version 1.0 11/2016 Guillermo H. Bustos
--
--	  Brief: Realiza una mascara a la trama de 16 bit recibida desde el SPI hacia una trama de 
--				80 bits, que sera la longitud final de la misma.
--				Ver si no se puede implementar de otra manera la cantidad de 0 que estoy colocando
--					ya que si delcaro como un puerto, inevitablemente me arrojara un error de que no se lo va a poder
--						asignar por exceso en el numero de puertos fisicos.

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY mask_16_to_80 IS
GENERIC( n : INTEGER := 80);
  PORT(
    d_or         : IN     STD_LOGIC_VECTOR(15 DOWNTO 0);  
    d_out        : OUT    STD_LOGIC_VECTOR(n-1 DOWNTO 0));  
END mask_16_to_80;

ARCHITECTURE logic OF mask_16_to_80 IS
Signal temp : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
BEGIN
temp <= (others => '0');
d_out <= temp OR d_or;
--d_out <= "00000000000000000000000000000000000000000000000000000000000000000000000000000000" OR d_or;

END logic;



