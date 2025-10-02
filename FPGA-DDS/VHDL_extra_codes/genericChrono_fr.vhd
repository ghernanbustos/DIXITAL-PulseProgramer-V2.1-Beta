--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         genericChrono_fr.vhd
--   DepENDencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version -- 09/2023 Guillermo H. Bustos
--
--	  Brief: 
--		One clock cycle to set preload value. control that en_preload is set only 
--			during one cycle.
--		This counter is a free run with flag at overflow. The counter var is set
-- 		to zero after overflow.
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- for the signed, unsigned types and arithmetic ops

ENTITY genericChrono_fr is
  port (
		clk_count 		: in 	std_logic; -- Clock in 50Mhz
		nRst_count 		: in 	std_logic;
		en_count   		: in  std_logic;
		en_preload		: in  std_logic;
		preload_count	: in  std_logic_vector(31 downto 0);
		-- 
		count_overflow	: out std_logic;
		--
		count_overflow_db	: out std_logic
  );
END genericChrono_fr;

ARCHITECTURE behavioral of genericChrono_fr is
	signal count : std_logic_vector(31 downto 0) := (others => '0');
BEGIN
	PROCESS(clk_count, en_count,nRst_count,en_preload) -- sensitive list
	BEGIN
		IF (nRst_count = '0') THEN -- asynchronous reset
			count <= (OTHERS => '0');
			count_overflow <= '0';
			count_overflow_db <= '0';
			-------------------------
		ELSIF (rising_edge(clk_count ) and en_count = '1') THEN -- edge activation
			IF ( en_preload = '1') THEN
				count <= preload_count; -- pre load count ONE CYCLE CLOCK
			ELSE
				IF (count = x"FFFFFFFF") then -- Max count
					count_overflow <= '1';
					count <= (others => '0'); -- set count to zero
					count_overflow_db <= '1';
				ELSE
					count <= std_logic_vector(unsigned(count) + 1);
					count_overflow <= '1';
					count_overflow_db <= '0';
				END IF;
			END IF;
		END IF;

	END PROCESS;
END behavioral;