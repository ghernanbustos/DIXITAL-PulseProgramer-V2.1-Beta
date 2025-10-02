
-- Author: 	Guillermo Hernan Bustos
-- email:  	ghernanbustos@gmail.com
-- Company:	Instituto de Fisica Ernesto Gaviola - FAMAF U.N.C
-- Resume:
-- 	Some peripherals are only wired to HPS
-- 	Others can be accessed by from HPS through FPGA
-- 	Pay attetion on HPS qsys configuration, have a look at DDR3 ram parameters.
-- 	Revisar que modulos son HPS y que no tienen conexionado fisico a traves de la FPGA
--  	por lo tanto no debería mapearlos desde el pin assignments.


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity de0_nano_soc_hps is
    Port (
-- CLOCKS 
		  FPGA_CLK1_50 		: in 		STD_LOGIC; -- PIN_V11
			
        HPS_KEY 		: inout 	STD_LOGIC; -- PIN_J18
        HPS_LED 		: inout 	STD_LOGIC; -- PIN_A20
--HPS 
  -- HPS DDR3
        HPS_DDR3_ADDR 		: out 	STD_LOGIC_VECTOR(14 downto 0);
        HPS_DDR3_BA 			: out 	STD_LOGIC_VECTOR(2 downto 0);
        HPS_DDR3_CAS_N 		: out 	STD_LOGIC;
        HPS_DDR3_CKE 		: out 	STD_LOGIC;
        HPS_DDR3_CS_N 		: out 	STD_LOGIC;
        HPS_DDR3_DM 			: out 	STD_LOGIC_VECTOR(3 downto 0);
        HPS_DDR3_DQ 			: inout 	STD_LOGIC_VECTOR(31 downto 0);
        HPS_DDR3_ODT 		: out 	STD_LOGIC;
        HPS_DDR3_RAS_N 		: out 	STD_LOGIC;
        HPS_DDR3_RESET_N 	: out 	STD_LOGIC;
        HPS_DDR3_RZQ 		: in 		STD_LOGIC;
        HPS_DDR3_WE_N 		: out 	STD_LOGIC;
        HPS_DDR3_CK_N 		: out 	STD_LOGIC;
        HPS_DDR3_CK_P 		: out 	STD_LOGIC;
        HPS_DDR3_DQS_N 		: inout 	STD_LOGIC_VECTOR(3 downto 0);
        HPS_DDR3_DQS_P 		: inout 	STD_LOGIC_VECTOR(3 downto 0);
-- Eth
        HPS_ENET_GTX_CLK 	: out 	STD_LOGIC;
        HPS_ENET_MDC 		: out 	STD_LOGIC;
        HPS_ENET_MDIO 		: inout 	STD_LOGIC;
        HPS_ENET_RX_CLK 	: in 		STD_LOGIC;
        HPS_ENET_RX_DATA 	: in 		STD_LOGIC_VECTOR(3 downto 0);
        HPS_ENET_RX_DV 		: in 		STD_LOGIC;
        HPS_ENET_TX_DATA 	: out 	STD_LOGIC_VECTOR(3 downto 0);
        HPS_ENET_TX_EN 		: out 	STD_LOGIC;
-- SD Card - Alternative Boot Option
        HPS_SD_CLK 			: out 	STD_LOGIC;
        HPS_SD_CMD 			: inout 	STD_LOGIC;
        HPS_SD_DATA 			: inout 	STD_LOGIC_VECTOR(3 downto 0);	  
-- UART
        HPS_UART_RX 			: in 		STD_LOGIC;
        HPS_UART_TX 			: out 	STD_LOGIC;
		  
-- hps_io_hps_io_gpio_inst_GPIOxx		  
        HPS_CONV_USB_N 		: inout 	STD_LOGIC; 
        HPS_ENET_INT_N 		: inout 	STD_LOGIC;
-- USB
			HPS_USB_CLKOUT 		: in 		STD_LOGIC;
			HPS_USB_DATA 		: inout 	STD_LOGIC_VECTOR(7 downto 0);
			HPS_USB_DIR 			: in 		STD_LOGIC; 
			HPS_USB_NXT 			: in 		STD_LOGIC;
			HPS_USB_STP 			: out 	STD_LOGIC;
			  
	-- IP Control Wrapper conduits 
			-- control register values only 8 LSB are used
			outmux_ctrlreg          : out   std_logic_vector(7 downto 0); -- export
			init_ctrlreg_out        : out   std_logic_vector(7 downto 0); -- export
			ftw_ctrlreg_out         : out   std_logic_vector(7 downto 0); -- export
			ptw_ctrlreg_out		   : out   std_logic_vector(7 downto 0); -- export			
		   chrono_ctrlreg_out      : out   std_logic_vector(7 downto 0); -- export
			modulation_ctrlreg_out  : out   std_logic_vector(7 downto 0); -- export
			debug_ctrlreg_out       : out   std_logic_vector(7 downto 0); -- export
			-- reads fsm end 
			endfsm_ctrl_flag_in     : in    std_logic_vector(7 downto 0); -- export
			debug_ctrl_in           : in    std_logic_vector(7 downto 0); -- export
			
-- IP Address Wrapper conduits 
			-- Data fetched from RAMs and send to DDS
			debug_address_in        : in    std_logic_vector(7 downto 0); -- export
			--
			init_address       		: out   std_logic_vector(7 downto 0); -- export	
			ftw_address        		: out   std_logic_vector(7 downto 0); -- export
			ptw_address        		: out   std_logic_vector(7 downto 0); -- export
			chrono_address     		: out   std_logic_vector(7 downto 0); -- export
			modulation_address 		: out   std_logic_vector(7 downto 0); -- export
	
	-- IP Data Wrapper conduits 
			-- Data fetched from RAMs and send to DDS
			init_ram_data_out       : out   std_logic_vector(31 downto 0); -- export	
			ftw_ram_data_out        : out   std_logic_vector(31 downto 0); -- export
			ptw_ram_data_out        : out   std_logic_vector(31 downto 0); -- export
			chrono_ram_data_out     : out   std_logic_vector(31 downto 0); -- export
			modulation_ram_data_out : out   std_logic_vector(31 downto 0); -- export
			debug_ram_data_out      : out   std_logic_vector(31 downto 0); -- export
			-- Data fetched from RAMs and send to HPS for debugging purpose
			rd_ramout_init_in       : in    std_logic_vector(31 downto 0); -- export
			rd_ramout_ftw_in        : in    std_logic_vector(31 downto 0); -- export
			rd_ramout_ptw_in        : in    std_logic_vector(31 downto 0); -- export
			rd_ramout_chrono_in     : in    std_logic_vector(31 downto 0); -- export
			rd_ramout_modulation_in : in    std_logic_vector(31 downto 0); -- export
			debug_data_in           : in    std_logic_vector(31 downto 0)  -- export
	 );
end entity de0_nano_soc_hps;

ARCHITECTURE behaviour of de0_nano_soc_hps is

	SIGNAL leds_state_out : std_logic_vector (31 downto 0);
	signal leds_state_read : std_logic_vector (31 downto 0);
	signal reset_reset_n : std_logic;
----- DECLARATION
    component hps_dds_wrapper is -- connect to entity ports
        port (
            clk_clk                                       : in    std_logic                     := 'X';             -- clk
            hps_0_h2f_reset_reset_n                   	 : out   std_logic;                                        -- reset_n
            reset_reset_n                                 : in    std_logic                     := 'X';             -- reset_n
				
            hps_io_hps_io_emac1_inst_TX_CLK               : out   std_logic;                                        -- hps_io_emac1_inst_TX_CLK
            hps_io_hps_io_emac1_inst_TXD0                 : out   std_logic;                                        -- hps_io_emac1_inst_TXD0
            hps_io_hps_io_emac1_inst_TXD1                 : out   std_logic;                                        -- hps_io_emac1_inst_TXD1
            hps_io_hps_io_emac1_inst_TXD2                 : out   std_logic;                                        -- hps_io_emac1_inst_TXD2
            hps_io_hps_io_emac1_inst_TXD3                 : out   std_logic;                                        -- hps_io_emac1_inst_TXD3
            hps_io_hps_io_emac1_inst_RXD0                 : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD0
            hps_io_hps_io_emac1_inst_MDIO                 : inout std_logic                     := 'X';             -- hps_io_emac1_inst_MDIO
            hps_io_hps_io_emac1_inst_MDC                  : out   std_logic;                                        -- hps_io_emac1_inst_MDC
            hps_io_hps_io_emac1_inst_RX_CTL               : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CTL
            hps_io_hps_io_emac1_inst_TX_CTL               : out   std_logic;                                        -- hps_io_emac1_inst_TX_CTL
            hps_io_hps_io_emac1_inst_RX_CLK               : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CLK
            hps_io_hps_io_emac1_inst_RXD1                 : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD1
            hps_io_hps_io_emac1_inst_RXD2                 : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD2
            hps_io_hps_io_emac1_inst_RXD3                 : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD3
				
            hps_io_hps_io_sdio_inst_CMD                   : inout std_logic                     := 'X';             -- hps_io_sdio_inst_CMD
            hps_io_hps_io_sdio_inst_D0                    : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D0
            hps_io_hps_io_sdio_inst_D1                    : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D1
            hps_io_hps_io_sdio_inst_CLK                   : out   std_logic;                                        -- hps_io_sdio_inst_CLK
            hps_io_hps_io_sdio_inst_D2                    : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D2
            hps_io_hps_io_sdio_inst_D3                    : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D3
				
            hps_io_hps_io_usb1_inst_D0                    : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D0
            hps_io_hps_io_usb1_inst_D1                    : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D1
            hps_io_hps_io_usb1_inst_D2                    : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D2
            hps_io_hps_io_usb1_inst_D3                    : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D3
            hps_io_hps_io_usb1_inst_D4                    : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D4
            hps_io_hps_io_usb1_inst_D5                    : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D5
            hps_io_hps_io_usb1_inst_D6                    : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D6
            hps_io_hps_io_usb1_inst_D7                    : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D7
            hps_io_hps_io_usb1_inst_CLK                   : in    std_logic                     := 'X';             -- hps_io_usb1_inst_CLK
            hps_io_hps_io_usb1_inst_STP                   : out   std_logic;                                        -- hps_io_usb1_inst_STP
            hps_io_hps_io_usb1_inst_DIR                   : in    std_logic                     := 'X';             -- hps_io_usb1_inst_DIR
            hps_io_hps_io_usb1_inst_NXT                   : in    std_logic                     := 'X';             -- hps_io_usb1_inst_NXT
				
            hps_io_hps_io_uart0_inst_RX                   : in    std_logic                     := 'X';             -- hps_io_uart0_inst_RX
            hps_io_hps_io_uart0_inst_TX                   : out   std_logic;                                        -- hps_io_uart0_inst_TX
				
				hps_io_hps_io_gpio_inst_GPIO09                : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO09
            hps_io_hps_io_gpio_inst_GPIO35                : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO35
            hps_io_hps_io_gpio_inst_GPIO53                : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO53
            hps_io_hps_io_gpio_inst_GPIO54                : inout std_logic                     := 'X';             -- hps_io_gpio_inst_GPIO54
						
            memory_mem_a                                  : out   std_logic_vector(14 downto 0);                    -- mem_a
            memory_mem_ba                                 : out   std_logic_vector(2 downto 0);                     -- mem_ba
            memory_mem_ck                                 : out   std_logic;                                        -- mem_ck
            memory_mem_ck_n                               : out   std_logic;                                        -- mem_ck_n
            memory_mem_cke                                : out   std_logic;                                        -- mem_cke
            memory_mem_cs_n                               : out   std_logic;                                        -- mem_cs_n
            memory_mem_ras_n                              : out   std_logic;                                        -- mem_ras_n
            memory_mem_cas_n                              : out   std_logic;                                        -- mem_cas_n
            memory_mem_we_n                               : out   std_logic;                                        -- mem_we_n
            memory_mem_reset_n                            : out   std_logic;                                        -- mem_reset_n
            memory_mem_dq                                 : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
            memory_mem_dqs                                : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
            memory_mem_dqs_n                              : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
            memory_mem_odt                                : out   std_logic;                                        -- mem_odt
            memory_mem_dm                                 : out   std_logic_vector(3 downto 0);                     -- mem_dm
            memory_oct_rzqin                              : in    std_logic                     := 'X';             -- oct_rzqin

				-- Conduits
            wrapper_ctrl_0_conduit_chrono_ctrlreg_out_export      : out   std_logic_vector(7 downto 0);                    -- export
            wrapper_ctrl_0_conduit_debug_ctrl_in_export           : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
            wrapper_ctrl_0_conduit_debug_ctrlreg_out_export       : out   std_logic_vector(7 downto 0);                    -- export
            wrapper_ctrl_0_conduit_endfsm_ctrl_flag_in_export     : in    std_logic_vector(7 downto 0) := (others => 'X'); -- export
            wrapper_ctrl_0_conduit_ftw_ctrlreg_out_export         : out   std_logic_vector(7 downto 0);                    -- export
            wrapper_ctrl_0_conduit_init_ctrlreg_out_export        : out   std_logic_vector(7 downto 0);                    -- export
            wrapper_ctrl_0_conduit_modulation_ctrlreg_out_export  : out   std_logic_vector(7 downto 0);                    -- export
            wrapper_ctrl_0_conduit_outmux_ctrlreg_export          : out   std_logic_vector(7 downto 0);                    -- export
            wrapper_ctrl_0_conduit_ptw_ctrlreg_out_export         : out   std_logic_vector(7 downto 0);                    -- export
 
            wrapper_address_0_conduit_debug_address_in_export     : in    std_logic_vector(7 downto 0)  := (others => 'X'); -- export
            wrapper_address_0_conduit_chrono_address_export       : out   std_logic_vector(7 downto 0);                     -- export
            wrapper_address_0_conduit_ftw_address_export          : out   std_logic_vector(7 downto 0);                     -- export
            wrapper_address_0_conduit_init_address_export         : out   std_logic_vector(7 downto 0);                     -- export
            wrapper_address_0_conduit_modulation_address_export   : out   std_logic_vector(7 downto 0);                     -- export
            wrapper_address_0_conduit_ptw_address_export          : out   std_logic_vector(7 downto 0);                     -- export
   
				wrapper_data_0_conduit_chrono_ram_data_out_export     : out   std_logic_vector(31 downto 0);                    -- export
            wrapper_data_0_conduit_debug_data_in_export           : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
            wrapper_data_0_conduit_debug_ram_data_out_export      : out   std_logic_vector(31 downto 0);                    -- export
            wrapper_data_0_conduit_ftw_ram_data_out_export        : out   std_logic_vector(31 downto 0);                    -- export
            wrapper_data_0_conduit_init_ram_data_out_export       : out   std_logic_vector(31 downto 0);                    -- export
            wrapper_data_0_conduit_modulation_ram_data_out_export : out   std_logic_vector(31 downto 0);                    -- export
            wrapper_data_0_conduit_ptw_ram_data_out_export        : out   std_logic_vector(31 downto 0);                    -- export
            wrapper_data_0_conduit_rd_ramout_chrono_in_export     : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
            wrapper_data_0_conduit_rd_ramout_ftw_in_export        : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
            wrapper_data_0_conduit_rd_ramout_init_in_export       : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
            wrapper_data_0_conduit_rd_ramout_modulation_in_export : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
            wrapper_data_0_conduit_rd_ramout_ptw_in_export        : in    std_logic_vector(31 downto 0) := (others => 'X')  -- export
        );
    end component hps_dds_wrapper;


	 
BEGIN
-- INSTANTIATION 
u0 : component hps_dds_wrapper
        port map (
            clk_clk                                       => FPGA_CLK1_50,                                      
            hps_0_h2f_reset_reset_n                       => reset_reset_n,                      
            reset_reset_n                                 => '1', 			-- Set reset off                                  
				
            hps_io_hps_io_emac1_inst_TX_CLK               => HPS_ENET_GTX_CLK,              
            hps_io_hps_io_emac1_inst_TXD0                 => HPS_ENET_TX_DATA(0),               
            hps_io_hps_io_emac1_inst_TXD1                 => HPS_ENET_TX_DATA(1),                
            hps_io_hps_io_emac1_inst_TXD2                 => HPS_ENET_TX_DATA(2),                 
            hps_io_hps_io_emac1_inst_TXD3                 => HPS_ENET_TX_DATA(3),              
            hps_io_hps_io_emac1_inst_MDIO                 => HPS_ENET_MDIO,               
            hps_io_hps_io_emac1_inst_MDC                  => HPS_ENET_MDC,                 
            hps_io_hps_io_emac1_inst_RX_CTL               => HPS_ENET_RX_DV,              
            hps_io_hps_io_emac1_inst_TX_CTL               => HPS_ENET_TX_EN,             
            hps_io_hps_io_emac1_inst_RX_CLK               => HPS_ENET_RX_CLK, 
            hps_io_hps_io_emac1_inst_RXD0                 => HPS_ENET_RX_DATA(0), 				
            hps_io_hps_io_emac1_inst_RXD1                 => HPS_ENET_RX_DATA(1),              
            hps_io_hps_io_emac1_inst_RXD2                 => HPS_ENET_RX_DATA(2),            
            hps_io_hps_io_emac1_inst_RXD3                 => HPS_ENET_RX_DATA(3),  
				
            hps_io_hps_io_sdio_inst_CMD                   => HPS_SD_CMD,                                  
            hps_io_hps_io_sdio_inst_CLK                   => HPS_SD_CLK, 
            hps_io_hps_io_sdio_inst_D0                    => HPS_SD_DATA(0),                   
            hps_io_hps_io_sdio_inst_D1                    => HPS_SD_DATA(1), 				
            hps_io_hps_io_sdio_inst_D2                    => HPS_SD_DATA(2),                    
            hps_io_hps_io_sdio_inst_D3                    => HPS_SD_DATA(3),                   
				
            hps_io_hps_io_usb1_inst_D0                    => HPS_USB_DATA(0),                 
            hps_io_hps_io_usb1_inst_D1                    => HPS_USB_DATA(1),                  
            hps_io_hps_io_usb1_inst_D2                    => HPS_USB_DATA(2),                  
            hps_io_hps_io_usb1_inst_D3                    => HPS_USB_DATA(3),                  
            hps_io_hps_io_usb1_inst_D4                    => HPS_USB_DATA(4),                  
            hps_io_hps_io_usb1_inst_D5                    => HPS_USB_DATA(5),                  
            hps_io_hps_io_usb1_inst_D6                    => HPS_USB_DATA(6),                   
            hps_io_hps_io_usb1_inst_D7                    => HPS_USB_DATA(7),                   
            hps_io_hps_io_usb1_inst_CLK                   => HPS_USB_CLKOUT,                  
            hps_io_hps_io_usb1_inst_STP                   => HPS_USB_STP,                 
            hps_io_hps_io_usb1_inst_DIR                   => HPS_USB_DIR,                  
            hps_io_hps_io_usb1_inst_NXT                   => HPS_USB_NXT,                   
				
            hps_io_hps_io_uart0_inst_RX                   => HPS_UART_RX,                   
            hps_io_hps_io_uart0_inst_TX                   => HPS_UART_TX,          

				hps_io_hps_io_gpio_inst_GPIO09                => HPS_CONV_USB_N,             -- hps_io_gpio_inst_GPIO09
            hps_io_hps_io_gpio_inst_GPIO35                => HPS_ENET_INT_N,             -- hps_io_gpio_inst_GPIO35	
            hps_io_hps_io_gpio_inst_GPIO53                => HPS_LED,	                 -- hps_io_gpio_inst_GPIO53
            hps_io_hps_io_gpio_inst_GPIO54                => HPS_KEY,             	 	  -- hps_io_gpio_inst_GPIO54			
						
            memory_mem_a                                  => HPS_DDR3_ADDR,                                  
            memory_mem_ba                                 => HPS_DDR3_BA,                                
            memory_mem_ck                                 => HPS_DDR3_CK_P,                                 
            memory_mem_ck_n                               => HPS_DDR3_CK_N,                               
            memory_mem_cke                                => HPS_DDR3_CKE,                                
            memory_mem_cs_n                               => HPS_DDR3_CS_N,                              
            memory_mem_ras_n                              => HPS_DDR3_RAS_N,                             
            memory_mem_cas_n                              => HPS_DDR3_CAS_N,                             
            memory_mem_we_n                               => HPS_DDR3_WE_N,                              
            memory_mem_reset_n                            => HPS_DDR3_RESET_N,                           
            memory_mem_dq                                 => HPS_DDR3_DQ,                               
            memory_mem_dqs                                => HPS_DDR3_DQS_P,                               
            memory_mem_dqs_n                              => HPS_DDR3_DQS_N,                             
            memory_mem_odt                                => HPS_DDR3_ODT,                              
            memory_mem_dm                                 => HPS_DDR3_DM,                              
            memory_oct_rzqin                              => HPS_DDR3_RZQ,   
				
				-- Ctrl Wrapper
            wrapper_ctrl_0_conduit_outmux_ctrlreg_export          => outmux_ctrlreg,          --          wrapper_ctrl_0_conduit_outmux_ctrlreg.export
				wrapper_ctrl_0_conduit_init_ctrlreg_out_export        => init_ctrlreg_out,        --        wrapper_ctrl_0_conduit_init_ctrlreg_out.export
            wrapper_ctrl_0_conduit_ftw_ctrlreg_out_export         => ftw_ctrlreg_out,         --         wrapper_ctrl_0_conduit_ftw_ctrlreg_out.export
            wrapper_ctrl_0_conduit_ptw_ctrlreg_out_export         => ptw_ctrlreg_out,         --         wrapper_ctrl_0_conduit_ptw_ctrlreg_out.export
            wrapper_ctrl_0_conduit_chrono_ctrlreg_out_export      => chrono_ctrlreg_out,      --      wrapper_ctrl_0_conduit_chrono_ctrlreg_out.export
            wrapper_ctrl_0_conduit_modulation_ctrlreg_out_export  => modulation_ctrlreg_out,  --  wrapper_ctrl_0_conduit_modulation_ctrlreg_out.export
            wrapper_ctrl_0_conduit_debug_ctrlreg_out_export       => debug_ctrlreg_out,       --       wrapper_ctrl_0_conduit_debug_ctrlreg_out.export

            wrapper_ctrl_0_conduit_endfsm_ctrl_flag_in_export     => endfsm_ctrl_flag_in,     --     wrapper_ctrl_0_conduit_endfsm_ctrl_flag_in.export
            wrapper_ctrl_0_conduit_debug_ctrl_in_export           => debug_ctrl_in,           --           wrapper_ctrl_0_conduit_debug_ctrl_in.export

				-- Address wrapper
            wrapper_address_0_conduit_debug_address_in_export     => debug_address_in,     --     wrapper_address_0_conduit_debug_address_in.export
            wrapper_address_0_conduit_chrono_address_export       => chrono_address,       --       wrapper_address_0_conduit_chrono_address.export
            wrapper_address_0_conduit_ftw_address_export          => ftw_address,          --          wrapper_address_0_conduit_ftw_address.export
            wrapper_address_0_conduit_init_address_export         => init_address,         --         wrapper_address_0_conduit_init_address.export
            wrapper_address_0_conduit_modulation_address_export   => modulation_address,   --   wrapper_address_0_conduit_modulation_address.export
            wrapper_address_0_conduit_ptw_address_export          => ptw_address,          --          wrapper_address_0_conduit_ptw_address.export
 
				-- Data Wrapper
            wrapper_data_0_conduit_init_ram_data_out_export       => init_ram_data_out,       --       wrapper_data_0_conduit_init_ram_data_out.export
            wrapper_data_0_conduit_ftw_ram_data_out_export        => ftw_ram_data_out,        --        wrapper_data_0_conduit_ftw_ram_data_out.export
            wrapper_data_0_conduit_ptw_ram_data_out_export        => ptw_ram_data_out,        --        wrapper_data_0_conduit_ptw_ram_data_out.export
            wrapper_data_0_conduit_chrono_ram_data_out_export     => chrono_ram_data_out,     --     wrapper_data_0_conduit_chrono_ram_data_out.export
            wrapper_data_0_conduit_modulation_ram_data_out_export => modulation_ram_data_out, -- wrapper_data_0_conduit_modulation_ram_data_out.export
            wrapper_data_0_conduit_debug_ram_data_out_export      => debug_ram_data_out,      --      wrapper_data_0_conduit_debug_ram_data_out.export

            wrapper_data_0_conduit_rd_ramout_init_in_export       => rd_ramout_init_in,       --       wrapper_data_0_conduit_rd_ramout_init_in.export
            wrapper_data_0_conduit_rd_ramout_ftw_in_export        => rd_ramout_ftw_in,        --        wrapper_data_0_conduit_rd_ramout_ftw_in.export
            wrapper_data_0_conduit_rd_ramout_ptw_in_export        => rd_ramout_ptw_in,         --        wrapper_data_0_conduit_rd_ramout_ptw_in.export                         
            wrapper_data_0_conduit_rd_ramout_chrono_in_export     => rd_ramout_chrono_in,     --     wrapper_data_0_conduit_rd_ramout_chrono_in.export
            wrapper_data_0_conduit_rd_ramout_modulation_in_export => rd_ramout_modulation_in, -- wrapper_data_0_conduit_rd_ramout_modulation_in.export
            wrapper_data_0_conduit_debug_data_in_export           => debug_data_in           --           wrapper_data_0_conduit_debug_data_in.export
				
        );
		  
end behaviour ;
