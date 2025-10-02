set_global_assignment -entity "PLLV2" -library "lib_PLLV2" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "PLLV2" -library "lib_PLLV2" -name IP_TOOL_VERSION "22.1"
set_global_assignment -entity "PLLV2" -library "lib_PLLV2" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_PLLV2" -name SPD_FILE [file join $::quartus(sip_path) "PLLV2.spd"]

set_global_assignment -library "lib_PLLV2" -name MISC_FILE [file join $::quartus(sip_path) "PLLV2_sim/PLLV2.vho"]
