-- Flip Flop fsm_ff

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY ff_osk IS
  port (
		ff_clk     			: 	IN  	std_logic; -- ff_clk 
		ff_rst_n  			:  IN		std_logic;
		ff_outFlag			:  OUT	std_logic -- the two msb are unused
  );
END ENTITY ff_osk;
------------------------------------------------
ARCHITECTURE Behavioral OF ff_osk IS	
BEGIN
	FF_d: PROCESS (ff_clk) 	--sensitive list
		BEGIN
			IF (ff_rst_n = '0') THEN   			-- asynchronous reset
				ff_outFlag <= '0';	
			ELSIF rising_edge(ff_clk) THEN -- Change State
				ff_outFlag <= '1';
			END IF;
	END PROCESS FF_d;
END Behavioral;