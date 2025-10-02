
module hps_dds_wrapper (
	address_0_adc_address_export,
	address_0_chrono2_address_export,
	address_0_chrono_address_export,
	address_0_debug_address_in_export,
	address_0_ftw_address_export,
	address_0_init_address_export,
	address_0_modulation_address_export,
	address_0_ptw_address_export,
	address_0_pulse_pgr_address_export,
	clk_clk,
	ctrl_0_adc_ctrlreg_out_export,
	ctrl_0_chrono2_ctrlreg_out_readdata,
	ctrl_0_chrono_ctrlreg_out_export,
	ctrl_0_debug_ctrl_in_export,
	ctrl_0_debug_ctrlreg_out_export,
	ctrl_0_endfsm_ctrl_flag_in_export,
	ctrl_0_ftw_ctrlreg_out_export,
	ctrl_0_init_ctrlreg_out_export,
	ctrl_0_modulation_ctrlreg_out_export,
	ctrl_0_outmux_ctrlreg_export,
	ctrl_0_ptw_ctrlreg_out_export,
	ctrl_0_pulse_pgr_ctrlreg_export,
	data_0_adc_ram_data_export,
	data_0_chrono2_ram_data_export,
	data_0_chrono_ram_data_out_export,
	data_0_debug_data_in_export,
	data_0_debug_ram_data_out_export,
	data_0_ftw_ram_data_out_export,
	data_0_init_ram_data_out_export,
	data_0_modulation_ram_data_out_export,
	data_0_ptw_ram_data_out_export,
	data_0_pulse_pgr_ram_data_export,
	data_0_rd_ramout_adc_export,
	data_0_rd_ramout_chrono2_export,
	data_0_rd_ramout_chrono_in_export,
	data_0_rd_ramout_ftw_in_export,
	data_0_rd_ramout_init_in_export,
	data_0_rd_ramout_modulation_in_export,
	data_0_rd_ramout_ptw_in_export,
	data_0_rd_ramout_pulse_pgr_export,
	hps_0_h2f_reset_reset_n,
	hps_io_hps_io_emac1_inst_TX_CLK,
	hps_io_hps_io_emac1_inst_TXD0,
	hps_io_hps_io_emac1_inst_TXD1,
	hps_io_hps_io_emac1_inst_TXD2,
	hps_io_hps_io_emac1_inst_TXD3,
	hps_io_hps_io_emac1_inst_RXD0,
	hps_io_hps_io_emac1_inst_MDIO,
	hps_io_hps_io_emac1_inst_MDC,
	hps_io_hps_io_emac1_inst_RX_CTL,
	hps_io_hps_io_emac1_inst_TX_CTL,
	hps_io_hps_io_emac1_inst_RX_CLK,
	hps_io_hps_io_emac1_inst_RXD1,
	hps_io_hps_io_emac1_inst_RXD2,
	hps_io_hps_io_emac1_inst_RXD3,
	hps_io_hps_io_sdio_inst_CMD,
	hps_io_hps_io_sdio_inst_D0,
	hps_io_hps_io_sdio_inst_D1,
	hps_io_hps_io_sdio_inst_CLK,
	hps_io_hps_io_sdio_inst_D2,
	hps_io_hps_io_sdio_inst_D3,
	hps_io_hps_io_usb1_inst_D0,
	hps_io_hps_io_usb1_inst_D1,
	hps_io_hps_io_usb1_inst_D2,
	hps_io_hps_io_usb1_inst_D3,
	hps_io_hps_io_usb1_inst_D4,
	hps_io_hps_io_usb1_inst_D5,
	hps_io_hps_io_usb1_inst_D6,
	hps_io_hps_io_usb1_inst_D7,
	hps_io_hps_io_usb1_inst_CLK,
	hps_io_hps_io_usb1_inst_STP,
	hps_io_hps_io_usb1_inst_DIR,
	hps_io_hps_io_usb1_inst_NXT,
	hps_io_hps_io_uart0_inst_RX,
	hps_io_hps_io_uart0_inst_TX,
	hps_io_hps_io_gpio_inst_GPIO09,
	hps_io_hps_io_gpio_inst_GPIO35,
	hps_io_hps_io_gpio_inst_GPIO53,
	hps_io_hps_io_gpio_inst_GPIO54,
	memory_mem_a,
	memory_mem_ba,
	memory_mem_ck,
	memory_mem_ck_n,
	memory_mem_cke,
	memory_mem_cs_n,
	memory_mem_ras_n,
	memory_mem_cas_n,
	memory_mem_we_n,
	memory_mem_reset_n,
	memory_mem_dq,
	memory_mem_dqs,
	memory_mem_dqs_n,
	memory_mem_odt,
	memory_mem_dm,
	memory_oct_rzqin,
	reset_reset_n);	

	output	[7:0]	address_0_adc_address_export;
	output	[7:0]	address_0_chrono2_address_export;
	output	[7:0]	address_0_chrono_address_export;
	input	[7:0]	address_0_debug_address_in_export;
	output	[7:0]	address_0_ftw_address_export;
	output	[7:0]	address_0_init_address_export;
	output	[7:0]	address_0_modulation_address_export;
	output	[7:0]	address_0_ptw_address_export;
	output	[7:0]	address_0_pulse_pgr_address_export;
	input		clk_clk;
	output	[7:0]	ctrl_0_adc_ctrlreg_out_export;
	output	[7:0]	ctrl_0_chrono2_ctrlreg_out_readdata;
	output	[7:0]	ctrl_0_chrono_ctrlreg_out_export;
	input	[7:0]	ctrl_0_debug_ctrl_in_export;
	output	[7:0]	ctrl_0_debug_ctrlreg_out_export;
	input	[7:0]	ctrl_0_endfsm_ctrl_flag_in_export;
	output	[7:0]	ctrl_0_ftw_ctrlreg_out_export;
	output	[7:0]	ctrl_0_init_ctrlreg_out_export;
	output	[7:0]	ctrl_0_modulation_ctrlreg_out_export;
	output	[7:0]	ctrl_0_outmux_ctrlreg_export;
	output	[7:0]	ctrl_0_ptw_ctrlreg_out_export;
	output	[7:0]	ctrl_0_pulse_pgr_ctrlreg_export;
	output	[31:0]	data_0_adc_ram_data_export;
	output	[31:0]	data_0_chrono2_ram_data_export;
	output	[31:0]	data_0_chrono_ram_data_out_export;
	input	[31:0]	data_0_debug_data_in_export;
	output	[31:0]	data_0_debug_ram_data_out_export;
	output	[31:0]	data_0_ftw_ram_data_out_export;
	output	[31:0]	data_0_init_ram_data_out_export;
	output	[31:0]	data_0_modulation_ram_data_out_export;
	output	[31:0]	data_0_ptw_ram_data_out_export;
	output	[31:0]	data_0_pulse_pgr_ram_data_export;
	input	[31:0]	data_0_rd_ramout_adc_export;
	input	[31:0]	data_0_rd_ramout_chrono2_export;
	input	[31:0]	data_0_rd_ramout_chrono_in_export;
	input	[31:0]	data_0_rd_ramout_ftw_in_export;
	input	[31:0]	data_0_rd_ramout_init_in_export;
	input	[31:0]	data_0_rd_ramout_modulation_in_export;
	input	[31:0]	data_0_rd_ramout_ptw_in_export;
	input	[31:0]	data_0_rd_ramout_pulse_pgr_export;
	output		hps_0_h2f_reset_reset_n;
	output		hps_io_hps_io_emac1_inst_TX_CLK;
	output		hps_io_hps_io_emac1_inst_TXD0;
	output		hps_io_hps_io_emac1_inst_TXD1;
	output		hps_io_hps_io_emac1_inst_TXD2;
	output		hps_io_hps_io_emac1_inst_TXD3;
	input		hps_io_hps_io_emac1_inst_RXD0;
	inout		hps_io_hps_io_emac1_inst_MDIO;
	output		hps_io_hps_io_emac1_inst_MDC;
	input		hps_io_hps_io_emac1_inst_RX_CTL;
	output		hps_io_hps_io_emac1_inst_TX_CTL;
	input		hps_io_hps_io_emac1_inst_RX_CLK;
	input		hps_io_hps_io_emac1_inst_RXD1;
	input		hps_io_hps_io_emac1_inst_RXD2;
	input		hps_io_hps_io_emac1_inst_RXD3;
	inout		hps_io_hps_io_sdio_inst_CMD;
	inout		hps_io_hps_io_sdio_inst_D0;
	inout		hps_io_hps_io_sdio_inst_D1;
	output		hps_io_hps_io_sdio_inst_CLK;
	inout		hps_io_hps_io_sdio_inst_D2;
	inout		hps_io_hps_io_sdio_inst_D3;
	inout		hps_io_hps_io_usb1_inst_D0;
	inout		hps_io_hps_io_usb1_inst_D1;
	inout		hps_io_hps_io_usb1_inst_D2;
	inout		hps_io_hps_io_usb1_inst_D3;
	inout		hps_io_hps_io_usb1_inst_D4;
	inout		hps_io_hps_io_usb1_inst_D5;
	inout		hps_io_hps_io_usb1_inst_D6;
	inout		hps_io_hps_io_usb1_inst_D7;
	input		hps_io_hps_io_usb1_inst_CLK;
	output		hps_io_hps_io_usb1_inst_STP;
	input		hps_io_hps_io_usb1_inst_DIR;
	input		hps_io_hps_io_usb1_inst_NXT;
	input		hps_io_hps_io_uart0_inst_RX;
	output		hps_io_hps_io_uart0_inst_TX;
	inout		hps_io_hps_io_gpio_inst_GPIO09;
	inout		hps_io_hps_io_gpio_inst_GPIO35;
	inout		hps_io_hps_io_gpio_inst_GPIO53;
	inout		hps_io_hps_io_gpio_inst_GPIO54;
	output	[14:0]	memory_mem_a;
	output	[2:0]	memory_mem_ba;
	output		memory_mem_ck;
	output		memory_mem_ck_n;
	output		memory_mem_cke;
	output		memory_mem_cs_n;
	output		memory_mem_ras_n;
	output		memory_mem_cas_n;
	output		memory_mem_we_n;
	output		memory_mem_reset_n;
	inout	[31:0]	memory_mem_dq;
	inout	[3:0]	memory_mem_dqs;
	inout	[3:0]	memory_mem_dqs_n;
	output		memory_mem_odt;
	output	[3:0]	memory_mem_dm;
	input		memory_oct_rzqin;
	input		reset_reset_n;
endmodule
