LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY andn IS
GENERIC (n : INTEGER := 72);
PORT (	x 	: 	IN STD_LOGIC_VECTOR(n-1 downto 0);
			f 	: 	OUT STD_LOGIC);
END andn;

ARCHITECTURE dataflow OF andn IS
SIGNAL tmp : STD_LOGIC_VECTOR(n-1 downto 0);
BEGIN
	tmp <= (OTHERS => '1');-- tmp esta en 1 todas sus entradas
	f <= '1' WHEN x = tmp ELSE '0';-- la unica posibilidad de que la salida sea 1 es cuando sus entradas esten todas en 1
END dataflow;
