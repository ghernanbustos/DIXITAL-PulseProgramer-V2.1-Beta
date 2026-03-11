% Author: Engineer Guillermo H. Bustos.
% Date:    March 2026

% This script generates a Look‑Up Table (LUT) from a sinc signal.
% The resulting .txt file is used as the source for a VHDL NCO LUT in the 
% project. Since the sinc signal is stored in module form, an additional 
% phase bit is included to represent negative waveform values. When the NCO 
% LUT outputs a negative value, this phase bit is used to drive the AD9854 
% BPSK control port, enabling fast phase switching.

%    Fs = 4096;                   % samples per second
%    dt = 1/Fs;                   % seconds per sample
%    StopTime = 0.25;             % seconds
%     t = (0:dt:StopTime-dt)';     % seconds

clear all; close all;

% Var declarations
resol = 4096;
CellHex_phaseBit = cell(1,resol,1);

% Cuantizacion de la Sinc y Valor absoluto
x = linspace(0,6,resol);% 4096 point between 0 and 6
y = sinc(x-3); % shifted
   y_mod = abs(y);
   
% PLOT up to two sinc lobules
% figure 
%    plot(x,y_mod,'o')
%    title('2-D Sinc(t-3) Plot');
%    xlabel('t');
%    ylabel('sinc(t)');
%    grid on

% Cuantizacion de la Sinc y Valor absoluto
   sinc_table_mod = (round(y_mod * (resol-1))); %Ensure amplitude Range between 0-4095
% Plot downsampled signal
sampleNum   = 100; % one hundred samples per cycle
delta_t     = round(resol/sampleNum); %41
a_downSamplArray    = downsample(sinc_table_mod,delta_t);
t_downSamplArray    = downsample(x,delta_t);
subplot(2,1,1);
   plot(x,sinc_table_mod,'o')
   title('2-D Amplitude Quatized |Sinc| Plot');
   xlabel('n');
   ylabel('sinc(t)');
   grid on
subplot(2,1,2); 
   plot(t_downSamplArray,a_downSamplArray,'o')
   title('2-D Down Sampled 100 samples - Quatized |Sinc| Plot');
   xlabel('n');
   ylabel('sinc(n)');
   grid on

%%%%%%%%%%%%%%%%%%%%%% ADD extra bit for phase shift %%%%%%%%%%%%%%%%%%%%%%
% To Binary for Concatenate phase shift MSB bit
for i = 1:resol
    if (y(i) < 0 )                              % original to detect negative data point
       aux1_bin = dec2bin(sinc_table_mod(i),12);% dec2hex(D,minDigits)
       aux2_bin = dec2bin(1);                    % To set bit phase shift in DDS
       % Concatenate and convert to Hex
       result_str = [aux2_bin aux1_bin]; % binary format (char array)
       result_str = bin2dec(result_str);
       CellHex_phaseBit{i}=dec2hex(result_str, 4); % dec2hex(D,minDigits)
    else
       aux1_bin = dec2bin(sinc_table_mod(i),12); % dec2hex(D,minDigits)
       aux2_bin = dec2bin(0);                    % To set bit phase shift in DDS
       % Concatenate and convert to Hex
       result_str = [aux2_bin aux1_bin]; % binary format (char array)
       result_str = bin2dec(result_str);
       CellHex_phaseBit{i}=dec2hex(result_str, 4); % dec2hex(D,minDigits)
    end
end



% Adds extra character for VHDL code format
for i = 1:resol
    CellHex_phaseBit{i}=sprintf(' X"%s",',CellHex_phaseBit{i});
end

%Generar un archivo de salida.
fileID = fopen('C:\Users\guill\OneDrive\Escritorio\DIXITAL-PulseProgramer-V2.1-Beta\FPGA-DDS\MatLab\MatlabLUT_gen\lutSinc_PhaseBit.txt','w');

k = 1;
for i = 1:512 
    for j = 1:8
        fprintf(fileID,'%s',CellHex_phaseBit{k});
        k=k+1;
           
    end   
    fprintf(fileID,'\n');
end
fclose(fileID);


