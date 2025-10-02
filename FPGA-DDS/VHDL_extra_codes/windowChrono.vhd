--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         windowChrono.vhd
--   DepENDencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version -- 09/2023 Guillermo H. Bustos
--
--	  Brief: 
--		Set a window lenght controlled by the counter
--		Set a window lenght controlled by the counter
-- 	Needs a reset signal to set count value to zero aswell the flag
--		Its necessary to let the finish flag out ON until a reset is apply because
--			this signal has to be sampled or read by fsm clock to swtich fsm state in
-- 		the conditional statement
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- for the signed, unsigned types and arithmetic ops

ENTITY windowChrono is
  port (
		clk_count 		: in 	std_logic; -- Clock in 50Mhz
		nRst_count 		: in 	std_logic;
		en_count   		: in  std_logic;
		en_preload		: in  std_logic;
		preload_count	: in  std_logic_vector(31 downto 0);
		-- 
		window			: out std_logic;
		--
		windowEndFlag		: out std_logic
  );
END windowChrono;

ARCHITECTURE behavioral of windowChrono is
	signal count : std_logic_vector(31 downto 0) := (others => '0');
BEGIN
--	PROCESS(clk_count, en_count,nRst_count,en_preload) -- sensitive list
	PROCESS(clk_count, nRst_count) -- sensitive list
	BEGIN
		IF (nRst_count = '0') THEN -- asynchronous reset
			count <= (OTHERS => '0');
			window <= '0';
			windowEndFlag <= '0';
			-------------------------
			ELSIF rising_edge(clk_count ) THEN -- edge activation
			IF (en_count = '1') THEN
				IF ( en_preload = '1') THEN
					count <= preload_count; -- pre load count ONE CYCLE CLOCK
				ELSE
					IF (count = x"FFFFFFFF") then -- Max count waits for reset
						-- count <= (others => '0');
							window 	<= '0';
							windowEndFlag <= '1';
					ELSE
						count 		<= std_logic_vector(unsigned(count) + 1);
						window 		<= '1';
						windowEndFlag 	<= '0';
					END IF;
				END IF;
			END IF;
		END IF;
	END PROCESS;
END behavioral;



--PROC_COUNTER : process (clk)
--begin
--  if rising_edge(clk) then
--    if count = 1023 then
--      output <= '1';
--      count  <= 0;
--    else
--      output <= '0';
--      count  <= count + 1;
--    end if;
--  end if;
--end process;