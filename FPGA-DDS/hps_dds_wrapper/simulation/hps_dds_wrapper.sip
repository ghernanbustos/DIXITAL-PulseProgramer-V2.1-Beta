set_global_assignment -entity "hps_dds_wrapper" -library "lib_hps_dds_wrapper" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "hps_dds_wrapper" -library "lib_hps_dds_wrapper" -name IP_TOOL_VERSION "22.1"
set_global_assignment -entity "hps_dds_wrapper" -library "lib_hps_dds_wrapper" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_hps_dds_wrapper" -name SPD_FILE [file join $::quartus(sip_path) "../hps_dds_wrapper.spd"]
set_global_assignment -library "lib_hps_dds_wrapper" -name MISC_FILE [file join $::quartus(sip_path) "../../hps_dds_wrapper.qsys"]

set_global_assignment -library "lib_hps_dds_wrapper" -name MISC_FILE [file join $::quartus(sip_path) "hps_dds_wrapper.vhd"]
set_global_assignment -library "lib_hps_dds_wrapper" -name MISC_FILE [file join $::quartus(sip_path) "submodules/hps_dds_wrapper_hps_0.v"]
