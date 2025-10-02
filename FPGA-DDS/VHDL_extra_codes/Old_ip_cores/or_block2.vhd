LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY or_block2 IS
GENERIC(d1_width : INTEGER := 80);
  PORT(
   d_or1         : IN     STD_LOGIC_VECTOR(d1_width - 1 DOWNTO 0);
	d_or2         : IN     STD_LOGIC_VECTOR(d1_width - 1 DOWNTO 0);
   d_out         : OUT    STD_LOGIC_VECTOR(d1_width - 1 DOWNTO 0));  
END or_block2;

ARCHITECTURE logic OF or_block2 IS
BEGIN

d_out <= d_or1 OR d_or2 ;

END logic;


--d_out <= (d_or1 OR "00000000000000000000000000000000") OR d_or2;