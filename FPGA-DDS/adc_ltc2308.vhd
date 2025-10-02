--------------------------------------------------------------------------------
--	  Autor: 			  Guillermo H. Bustos, ghernanbustos@gmail.com
--   FileName:         adc_ltc2308.vhd
--   Design Software:  Quartus Prime Lite Edition 22.1 Std Edition
--	  Working place:    Universidad Nacional de Cordoba - FAMAF - LARTE
--   Project: 			  Dixital 
--	  Company: 			  Trovintek
--   Version History
--   	Version 0.0 10/2025 
--	
--	  Brief: 
-- 	Modified version from:
--				https://github.com/artbyte32/LTC2308.git 

--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY adc_ltc2308 IS
  port (
		clk_ltc    					: 	IN  std_logic; -- max freq = 40Mhz
		rst_n_ltc	 				: 	IN  std_logic; -- External switch
		init_conv					: 	IN  std_logic; -- inits ltc fsm
		SDI							:	IN  std_logic;
		--
		SDO							: 	OUT std_logic;
		adc_conv						:  OUT std_logic;
 		end_conv_flag				:	OUT std_logic;
		data_out						: 	OUT std_logic_vector(11 downto 0)
		
  );
END ENTITY adc_ltc2308;
------------------------------------------------
ARCHITECTURE Behavioral OF adc_ltc2308 IS
  -- Signals declarations
	TYPE state_type IS (state_rst, state_1, state_2, state_3);	 
	SIGNAL state : state_type; 			
	signal done : std_logic  := '0';
	signal config_bits	: std_logic_vector(17 downto 0) 	  := "100010000000000000";
	signal i					: integer range 0 to 81; -- to be used in different process
	signal sampled_data	: std_logic_vector(11 downto 0) := (others => '0');
	
  
BEGIN


state_transition: PROCESS (clk_ltc, rst_n_ltc) 	--sensitive list
	BEGIN
		IF (rst_n_ltc = '0') THEN   -- asynchronous reset
			state 			<= state_rst;					-- start_pulse works as start or reset
			config_bits 	<= "100010000000000000";	-- to ensure initialization value
			i					<= 0;
			--sampled_data 	<= "000000000000";
			
		ELSIF rising_edge(clk_ltc) THEN   				-- Change State
			CASE state IS
				WHEN state_rst =>
					IF (init_conv = '1') THEN 
						state <= state_1;	
					ELSE 
						state <= state_rst;
					END IF;
					
				WHEN state_1 => -- CONV signal high 1.3 - 1.6 uS
					i <= i + 1;
					if i = 60 then
						state <= state_2;
					else 
						state <= state_1;
					end if;	

				
				WHEN state_2 => -- AddressMempulse avaible 	
					i <= i + 1;
						if (i >= 62) and (i <= 79) then
							case i is
								when 62 => 
									SDO <= config_bits(17);
								when 63 => 
									SDO <= config_bits(16);
								when 64 => 
									SDO <= config_bits(15);
								when 65 => 
									SDO <= config_bits(14);
								when 66 => 
									SDO <= config_bits(13);
								when 67 => 
									SDO <= config_bits(12);
								when 68 => 
									SDO <= config_bits(11);
								when 69 => 
									SDO <= config_bits(10);
								when 70 => 
									SDO <= config_bits(9);
								when 71 => 
									SDO <= config_bits(8);
								when 72 => 
									SDO <= config_bits(7);
								when 73 => 
									SDO <= config_bits(6);
								when 74 => 
									SDO <= config_bits(5);
								when 75 => 
									SDO <= config_bits(4);
								when 76 => 
									SDO <= config_bits(3);
								when 77 => 
									SDO <= config_bits(2);
								when 78 => 
									SDO <= config_bits(1);
								when 79 => 
									SDO <= config_bits(0);
								when others => 
									SDO <= '0';
							end case;
							state <= state_2;	
						else
							state <= state_3;	
						end if;
						
						
				WHEN state_3 => -- ram data out
						state <= state_3;	
			END CASE;
		END IF;
	END PROCESS state_transition;
  
  
Output_logic: PROCESS (state)
	BEGIN							
 		CASE state IS
			WHEN state_rst => -- Reset State | clear mem on
				adc_conv			<= '0';	
				end_conv_flag  <= '0';	
				
			WHEN state_1 => -- 
				adc_conv			<= '1';	
				end_conv_flag  <= '0';	

			WHEN state_2 => --
				adc_conv			<= '0';	
				end_conv_flag  <= '0';	

			WHEN state_3 => -- 
				adc_conv			<= '0';	
				end_conv_flag  <= '1';	
		END CASE;
	END PROCESS Output_logic; 

data_in: process(clk_ltc) is
	begin
		if falling_edge(clk_ltc) then
			case i is
				when 63 => 
					sampled_data(11) 	<= SDI;
				when 64 => 
					sampled_data(10) 	<= SDI;
				when 65 => 
					sampled_data(9) 	<= SDI;
				when 66 => 
					sampled_data(8) 	<= SDI;
				when 67 => 
					sampled_data(7) 	<= SDI;
				when 68 => 
					sampled_data(6) 	<= SDI;
				when 69 => 
					sampled_data(5) 	<= SDI;
				when 70 => 
					sampled_data(4) 	<= SDI;
				when 71 => 
					sampled_data(3) 	<= SDI;
				when 72 => 
					sampled_data(2) 	<= SDI;
				when 73 => 
					sampled_data(1) 	<= SDI;
				when 74 => 
					sampled_data(0) 	<= SDI;
				when others => 
					done <= '0';
			end case;
		end if;
end process;	

-- DATA SAMPLED OUT

data_out <= sampled_data;
	
	
END ARCHITECTURE Behavioral;