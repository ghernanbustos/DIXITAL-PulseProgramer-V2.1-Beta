library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- for the signed, unsigned types and arithmetic ops

ENTITY clock_Block_1mhz is
  port (
		count_clk 		: in 	std_logic; -- Clock in 50Mhz
		count_nRst 		: in 	std_logic;
		--count_en   		: in  std_logic;
		--preload_en		: in  std_logic;
		--count_preload	: in  std_logic_vector(31 downto 0);
		-- 
		count_overflow	: out std_logic;
		--count_overflow_db	: out std_logic -- usefull to measure time among ptw 
													 --load and chrono overflow
  );
END clock_Block_1mhz;

ARCHITECTURE behavioral of clock_Block_1mhz is
	signal count : std_logic_vector(31 downto 0) := (others => '0');
BEGIN
	PROCESS(count_clk, count_nRst) -- sensitive list
	BEGIN
		IF (count_nRst = '0') THEN -- asynchronous reset
			count <= (OTHERS => '0');
			count_overflow <= '0';
			-------------------------
		ELSIF (rising_edge(count_clk )) THEN -- edge activation
			ELSE
				IF (count = x"FFFFFFFF") then -- Max count
					count_overflow <= '1';
					count <= (others => '0');
					count_overflow_db <= '1';
				ELSE
					count <= std_logic_vector(unsigned(count) + 1);
					count_overflow_db <= '0';
				END IF;
			END IF;
		END IF;

	END PROCESS;
END behavioral;