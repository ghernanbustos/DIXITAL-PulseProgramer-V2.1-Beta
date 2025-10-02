function [numSamples] = nco_function(pulseWidth,ncoFreq_sys)
% This function calcs the number of samples used to synthesize a function
% with NCO embedded in FPGA. Check ncoFreq_sys set in FPGA module. In our
% application was 3Mhz. If more samples per signal period is needed rise 
% ncoFreq_sys in NCO module but be aware to not cause timing violating
% NCO formula:                      |
%   phase_incr = (f_out * 2^32)     | leads to numSamples = Tsignal/Tsys
%                     fsys          |
% returns rounded value of samples per signal period.
% The max window width value is T_nco_sys * 2^12 ;  in this case the NCO
% outputs all LUT samples.

Tsys = 1/ncoFreq_sys; % dT delta window segment
numSamples_bis = pulseWidth / Tsys;
numSamples = round(numSamples_bis);

end

