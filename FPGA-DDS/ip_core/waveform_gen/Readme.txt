The ip core files used in project are located in DIXITAL_NMR_PulseSeq\FPGA-DDS.
both files: sincos_lut.vhd and waveform_gen.vhd were modified and adpated to the 
application. In this case, a new LUT about Sinc function were generated and added
as well as an extra signal flag to trigger and FSM every time a data is output in the
LUT.