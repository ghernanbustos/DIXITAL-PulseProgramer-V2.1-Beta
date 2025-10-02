------- Mux_read_write --------
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;
-------------------------------------------
 ENTITY mux_rd_wr IS
 GENERIC(
 	data_width 		: INTEGER := 72;
	address_witdth	: INTEGER := 5
	);
 
 PORT ( 

 	address_rd	: IN STD_LOGIC_VECTOR (address_witdth-1 DOWNTO 0);
 	rden_rd		: IN STD_LOGIC;
 	wren_rd		: IN STD_LOGIC;
 	---------
	data_wr		: IN STD_LOGIC_VECTOR (data_width-1 DOWNTO 0);
 	address_wr	: IN STD_LOGIC_VECTOR (address_witdth-1 DOWNTO 0);
 	rden_wr		: IN STD_LOGIC;
 	wren_wr		: IN STD_LOGIC;
 	---------
 	sel 			: IN STD_LOGIC;
 	---------
 	data_m9k		: OUT STD_LOGIC_VECTOR (data_width-1 DOWNTO 0);
 	address_m9k	: OUT STD_LOGIC_VECTOR (address_witdth-1 DOWNTO 0);
 	rden_m9k		: OUT STD_LOGIC;
 	wren_m9k		: OUT STD_LOGIC);
	
 END mux_rd_wr;
-------------------------------------------
 ARCHITECTURE mux1 OF mux_rd_wr IS
 BEGIN
	data_m9k	<= data_wr WHEN (sel='0') ELSE
							(OTHERS => '0');
	 			
	address_m9k 	<= address_wr WHEN (sel='0') ELSE
								address_rd;

	rden_m9k 	<= rden_wr WHEN (sel='0') ELSE
								rden_rd;

	wren_m9k	<= wren_wr WHEN (sel='0') ELSE
								wren_rd;
END mux1;
-------------------------------------------