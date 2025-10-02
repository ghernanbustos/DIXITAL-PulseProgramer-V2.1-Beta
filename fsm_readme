# FSM views

# Entity: ftw_fsm_writeV1_1 
- **File**: ftw_fsm_writeV1_1.vhdl

## Diagram
![Diagram](./Images/ftw_fsm_writeV1_1.svg "Diagram")
## Ports

| Port name         | Direction | Type                         | Description |
| ----------------- | --------- | ---------------------------- | ----------- |
| clk_fsm2          | in        | std_logic                    |             |
| rst_n_fsm2        | in        | std_logic                    |             |
| start_fsm2        | in        | std_logic                    |             |
| rd_FTWMem         | out       | std_logic                    |             |
| wr_FTWMem         | out       | std_logic                    |             |
| en_FTWMem         | out       | std_logic                    |             |
| addressFTWMem     | out       | std_logic_vector(4 downto 0) |             |
| fsm_ftwEND        | out       | std_logic                    |             |
| s0                | out       | std_logic                    |             |
| s1                | out       | std_logic                    |             |
| s2                | out       | std_logic                    |             |
| s3                | out       | std_logic                    |             |
| s4                | out       | std_logic                    |             |
| s5                | out       | std_logic                    |             |
| masterRst_dds     | out       | std_logic                    |             |
| rd_n_dds          | out       | std_logic                    |             |
| wd_n_dds          | out       | std_logic                    |             |
| FSK_BPSK_HOLD_dds | out       | std_logic                    |             |
| I_O_update_dds    | out       | std_logic                    |             |

## Signals

| Name  | Type       | Description |
| ----- | ---------- | ----------- |
| state | state_type |             |

## Types

| Name       | Type                                                                                                                                                                                                                                                                                         | Description |
| ---------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| state_type | (state_muxInit,<br><span style="padding-left:20px"> state_0,<br><span style="padding-left:20px"> state_1,<br><span style="padding-left:20px"> state_2,<br><span style="padding-left:20px"> state_3,<br><span style="padding-left:20px"> state_4,<br><span style="padding-left:20px">state_5) |             |

## Processes
- state_transition: ( clk_fsm2, rst_n_fsm2, start_fsm2 )
- Output_logic: ( state )

## State machines
![Diagram_state_machine_0]( ./Images/fsm_ftw_fsm_writeV1_1_00.svg "Diagram")

# Entity: fsm_rf_window 
- **File**: fsm_rf_window.vhd

## Diagram
![Diagram](./Images/fsm_rf_window.svg "Diagram")
## Ports

| Port name         | Direction | Type      | Description |
| ----------------- | --------- | --------- | ----------- |
| rf_window_clk     | in        | std_logic |             |
| rf_window_rst_n   | in        | std_logic |             |
| rf_window_initFsm | in        | std_logic |             |
| rf_window_out     | out       | std_logic |             |
| rf_window_flag    | out       | std_logic |             |

## Signals

| Name  | Type       | Description |
| ----- | ---------- | ----------- |
| state | state_type |             |

## Types

| Name       | Type                                                                                                   | Description |
| ---------- | ------------------------------------------------------------------------------------------------------ | ----------- |
| state_type | (state_init,<br><span style="padding-left:20px"> state_1,<br><span style="padding-left:20px"> state_2) |             |

## Processes
- state_transition: ( rf_window_clk, rf_window_rst_n, rf_window_initFsm )
- Output_logic: ( state )

## State machines

![Diagram_state_machine_0](  ./Images/fsm_fsm_rf_window_00.svg "Diagram")
