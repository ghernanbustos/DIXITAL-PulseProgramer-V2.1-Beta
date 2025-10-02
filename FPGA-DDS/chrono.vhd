--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos
--   FileName:         chrono.vhd
--   DepENDencies:     none
--   Design Software:  Quartus Prime Lite Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   Version -- 03/2023 Guillermo H. Bustos
--
--	  Brief: 
--		Use One clock with setPrecount high to set preload, then starts put the signal low to start
--			counting at next clock signal. If setPrecount is high the chrono remains registering the precount all the time.
-- 	Once overflow occurs, chrono remains steady until external reset signal.
-- 	When counter reachs max count remains steady for an external reset signal to be controlled by the FSM.
--		count <= "11111110100000101000011110111111"; -- 0.5seg
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- for the signed, unsigned types and arithmetic ops

ENTITY chrono is
  port (
		clk_chrono 			: in 	std_logic; -- Clock in 50Mhz
		nRst_chrono 		: in 	std_logic;
		--
		en_chrono   		: in  std_logic;
		setPrecount			: in  std_logic;
		precountValue		: in  std_logic_vector(31 downto 0);
		-- 
		pulseSignal			: out std_logic; -- RF Window.
		overflowChrono		: out std_logic  -- overflow signal
  );
END chrono;

ARCHITECTURE behavioral of chrono is
	signal count : std_logic_vector(31 downto 0) := (others => '0');
	signal flag : std_logic  := '0';
BEGIN
	PROCESS(clk_chrono,nRst_chrono) -- sensitive list
	BEGIN
			IF (nRst_chrono = '0') THEN -- asynchronous reset
				flag 		<= '0';
			ELSIF  (rising_edge(clk_chrono ) and en_chrono = '1')  THEN -- asynchronous reset
				IF  (setPrecount = '1') THEN
					flag 		<= '1';
				else
					flag 		<= '0';
				END IF;
			END IF;
	END PROCESS;


	PROCESS(clk_chrono,nRst_chrono) -- sensitive list
	BEGIN
			IF (nRst_chrono = '0') THEN -- asynchronous reset
				count <= (OTHERS => '0');
				pulseSignal 		<= '0';
				overflowChrono 	<= '0';
				-------------------------
			ELSIF (rising_edge(clk_chrono ) and en_chrono = '1') THEN -- edge activation
				IF ( flag = '1') THEN
					count <= precountValue;
				else
					IF (count = x"FFFFFFFF") then
						overflowChrono 	<= '1'; -- overflow flag
						pulseSignal 		<= '0';
					ELSE
						count <= std_logic_vector(unsigned(count) + 1);
						overflowChrono 	<= '0';
						pulseSignal 		<= '1'; -- while counting set high (Window pulse)
					END IF;
				END IF;
			END IF;
	END PROCESS;
	
END behavioral;