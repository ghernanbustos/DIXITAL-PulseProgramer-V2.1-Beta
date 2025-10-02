transcript on
if ![file isdirectory ddsAD9854_iputf_libs] {
	file mkdir ddsAD9854_iputf_libs
}

if ![file isdirectory vhdl_libs] {
	file mkdir vhdl_libs
}

vlib vhdl_libs/altera
vmap altera ./vhdl_libs/altera
vcom -93 -work altera {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/altera_syn_attributes.vhd}
vcom -93 -work altera {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/altera_standard_functions.vhd}
vcom -93 -work altera {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/alt_dspbuilder_package.vhd}
vcom -93 -work altera {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/altera_europa_support_lib.vhd}
vcom -93 -work altera {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/altera_primitives_components.vhd}
vcom -93 -work altera {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/altera_primitives.vhd}

vlib vhdl_libs/lpm
vmap lpm ./vhdl_libs/lpm
vcom -93 -work lpm {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/220pack.vhd}
vcom -93 -work lpm {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/220model.vhd}

vlib vhdl_libs/sgate
vmap sgate ./vhdl_libs/sgate
vcom -93 -work sgate {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/sgate_pack.vhd}
vcom -93 -work sgate {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/sgate.vhd}

vlib vhdl_libs/altera_mf
vmap altera_mf ./vhdl_libs/altera_mf
vcom -93 -work altera_mf {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/altera_mf_components.vhd}
vcom -93 -work altera_mf {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/altera_mf.vhd}

vlib vhdl_libs/altera_lnsim
vmap altera_lnsim ./vhdl_libs/altera_lnsim
vlog -sv -work altera_lnsim {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/mentor/altera_lnsim_for_vhdl.sv}
vcom -93 -work altera_lnsim {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/altera_lnsim_components.vhd}

vlib vhdl_libs/cyclonev
vmap cyclonev ./vhdl_libs/cyclonev
vlog -vlog01compat -work cyclonev {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/mentor/cyclonev_atoms_ncrypt.v}
vcom -93 -work cyclonev {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/cyclonev_atoms.vhd}
vcom -93 -work cyclonev {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/cyclonev_components.vhd}

vlib vhdl_libs/cyclonev_hssi
vmap cyclonev_hssi ./vhdl_libs/cyclonev_hssi
vcom -93 -work cyclonev_hssi {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/cyclonev_hssi_components.vhd}
vlog -vlog01compat -work cyclonev_hssi {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/mentor/cyclonev_hssi_atoms_ncrypt.v}
vcom -93 -work cyclonev_hssi {c:/intelfpga_lite/22.1std/quartus/eda/sim_lib/cyclonev_hssi_atoms.vhd}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/pll_sim/pll.vho"                                                                    
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/pll1_sim/pll1.vho"                                                                  
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim/dspba_library_package.vhd"                              
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim/dspba_library.vhd"                                      
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim/auk_dspip_math_pkg_hpfir.vhd"                           
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim/auk_dspip_lib_pkg_hpfir.vhd"                            
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"        
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"              
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"            
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim/auk_dspip_roundsat_hpfir.vhd"                           
vlog "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim/altera_avalon_sc_fifo.v"                                
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim/fir_sinc_rtl_core.vhd"                                  
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim/fir_sinc_ast.vhd"                                       
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim/fir_sinc.vhd"                                           
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim/fir_sinc_tb.vhd"                                        
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim_sim/dspba_library_package.vhd"                          
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim_sim/dspba_library.vhd"                                  
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim_sim/auk_dspip_math_pkg_hpfir.vhd"                       
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim_sim/auk_dspip_lib_pkg_hpfir.vhd"                        
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"    
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"          
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"        
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim_sim/auk_dspip_roundsat_hpfir.vhd"                       
vlog "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim_sim/altera_avalon_sc_fifo.v"                            
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim_sim/fir_sinc_sim_rtl_core.vhd"                          
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim_sim/fir_sinc_sim_ast.vhd"                               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim_sim/fir_sinc_sim.vhd"                                   
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip/fir_sinc_sim_sim/fir_sinc_sim_tb.vhd"                                
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_2/fir_2_sim/dspba_library_package.vhd"                               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_2/fir_2_sim/dspba_library.vhd"                                       
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_2/fir_2_sim/auk_dspip_math_pkg_hpfir.vhd"                            
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_2/fir_2_sim/auk_dspip_lib_pkg_hpfir.vhd"                             
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_2/fir_2_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"         
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_2/fir_2_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_2/fir_2_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"             
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_2/fir_2_sim/auk_dspip_roundsat_hpfir.vhd"                            
vlog "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_2/fir_2_sim/altera_avalon_sc_fifo.v"                                 
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_2/fir_2_sim/fir_2_rtl_core.vhd"                                      
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_2/fir_2_sim/fir_2_ast.vhd"                                           
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_2/fir_2_sim/fir_2.vhd"                                               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_2/fir_2_sim/fir_2_tb.vhd"                                            
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_3/fir_3_sim/dspba_library_package.vhd"                               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_3/fir_3_sim/dspba_library.vhd"                                       
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_3/fir_3_sim/auk_dspip_math_pkg_hpfir.vhd"                            
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_3/fir_3_sim/auk_dspip_lib_pkg_hpfir.vhd"                             
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_3/fir_3_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"         
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_3/fir_3_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_3/fir_3_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"             
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_3/fir_3_sim/auk_dspip_roundsat_hpfir.vhd"                            
vlog "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_3/fir_3_sim/altera_avalon_sc_fifo.v"                                 
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_3/fir_3_sim/fir_3_rtl_core.vhd"                                      
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_3/fir_3_sim/fir_3_ast.vhd"                                           
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_3/fir_3_sim/fir_3.vhd"                                               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_3/fir_3_sim/fir_3_tb.vhd"                                            
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_4/fir_4_sim/dspba_library_package.vhd"                               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_4/fir_4_sim/dspba_library.vhd"                                       
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_4/fir_4_sim/auk_dspip_math_pkg_hpfir.vhd"                            
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_4/fir_4_sim/auk_dspip_lib_pkg_hpfir.vhd"                             
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_4/fir_4_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"         
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_4/fir_4_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_4/fir_4_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"             
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_4/fir_4_sim/auk_dspip_roundsat_hpfir.vhd"                            
vlog "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_4/fir_4_sim/altera_avalon_sc_fifo.v"                                 
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_4/fir_4_sim/fir_4_rtl_core.vhd"                                      
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_4/fir_4_sim/fir_4_ast.vhd"                                           
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_4/fir_4_sim/fir_4.vhd"                                               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_4/fir_4_sim/fir_4_tb.vhd"                                            
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_5/fir_5_sim/dspba_library_package.vhd"                               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_5/fir_5_sim/dspba_library.vhd"                                       
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_5/fir_5_sim/auk_dspip_math_pkg_hpfir.vhd"                            
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_5/fir_5_sim/auk_dspip_lib_pkg_hpfir.vhd"                             
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_5/fir_5_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"         
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_5/fir_5_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_5/fir_5_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"             
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_5/fir_5_sim/auk_dspip_roundsat_hpfir.vhd"                            
vlog "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_5/fir_5_sim/altera_avalon_sc_fifo.v"                                 
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_5/fir_5_sim/fir_5_rtl_core.vhd"                                      
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_5/fir_5_sim/fir_5_ast.vhd"                                           
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_5/fir_5_sim/fir_5.vhd"                                               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_5/fir_5_sim/fir_5_tb.vhd"                                            
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_6/fir_6_sim/dspba_library_package.vhd"                               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_6/fir_6_sim/dspba_library.vhd"                                       
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_6/fir_6_sim/auk_dspip_math_pkg_hpfir.vhd"                            
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_6/fir_6_sim/auk_dspip_lib_pkg_hpfir.vhd"                             
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_6/fir_6_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"         
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_6/fir_6_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_6/fir_6_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"             
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_6/fir_6_sim/auk_dspip_roundsat_hpfir.vhd"                            
vlog "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_6/fir_6_sim/altera_avalon_sc_fifo.v"                                 
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_6/fir_6_sim/fir_6_rtl_core.vhd"                                      
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_6/fir_6_sim/fir_6_ast.vhd"                                           
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_6/fir_6_sim/fir_6.vhd"                                               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_6/fir_6_sim/fir_6_tb.vhd"                                            
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_7/fir_7_sim/dspba_library_package.vhd"                               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_7/fir_7_sim/dspba_library.vhd"                                       
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_7/fir_7_sim/auk_dspip_math_pkg_hpfir.vhd"                            
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_7/fir_7_sim/auk_dspip_lib_pkg_hpfir.vhd"                             
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_7/fir_7_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"         
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_7/fir_7_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_7/fir_7_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"             
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_7/fir_7_sim/auk_dspip_roundsat_hpfir.vhd"                            
vlog "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_7/fir_7_sim/altera_avalon_sc_fifo.v"                                 
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_7/fir_7_sim/fir_7_rtl_core.vhd"                                      
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_7/fir_7_sim/fir_7_ast.vhd"                                           
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_7/fir_7_sim/fir_7.vhd"                                               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_7/fir_7_sim/fir_7_tb.vhd"                                            
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_8/fir_8_sim/dspba_library_package.vhd"                               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_8/fir_8_sim/dspba_library.vhd"                                       
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_8/fir_8_sim/auk_dspip_math_pkg_hpfir.vhd"                            
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_8/fir_8_sim/auk_dspip_lib_pkg_hpfir.vhd"                             
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_8/fir_8_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"         
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_8/fir_8_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_8/fir_8_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"             
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_8/fir_8_sim/auk_dspip_roundsat_hpfir.vhd"                            
vlog "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_8/fir_8_sim/altera_avalon_sc_fifo.v"                                 
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_8/fir_8_sim/fir_8_rtl_core.vhd"                                      
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_8/fir_8_sim/fir_8_ast.vhd"                                           
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_8/fir_8_sim/fir_8.vhd"                                               
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_8/fir_8_sim/fir_8_tb.vhd"                                            
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_bank/fir_ip_bank_sim/dspba_library_package.vhd"                      
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_bank/fir_ip_bank_sim/dspba_library.vhd"                              
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_bank/fir_ip_bank_sim/auk_dspip_math_pkg_hpfir.vhd"                   
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_bank/fir_ip_bank_sim/auk_dspip_lib_pkg_hpfir.vhd"                    
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_bank/fir_ip_bank_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_bank/fir_ip_bank_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"      
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_bank/fir_ip_bank_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"    
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_bank/fir_ip_bank_sim/auk_dspip_roundsat_hpfir.vhd"                   
vlog "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_bank/fir_ip_bank_sim/altera_avalon_sc_fifo.v"                        
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_bank/fir_ip_bank_sim/fir_ip_bank_rtl_core.vhd"                       
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_bank/fir_ip_bank_sim/fir_ip_bank_ast.vhd"                            
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_bank/fir_ip_bank_sim/fir_ip_bank.vhd"                                
vcom "C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/ip_core/fir_ip_bank/fir_ip_bank_sim/fir_ip_bank_tb.vhd"                             

vcom -93 -work work {C:/Users/guill/OneDrive/Escritorio/DIXITAL_NMR_PulseSeq/FPGA-DDS/chrono.vhd}

