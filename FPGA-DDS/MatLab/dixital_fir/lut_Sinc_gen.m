% Generador del archivo LUT de una SINC

%    Fs = 4096;                   % samples per second
%    dt = 1/Fs;                   % seconds per sample
%    StopTime = 0.25;             % seconds
%     t = (0:dt:StopTime-dt)';     % seconds
clear all; close all;
% Cuantizacion de la Sinc y Valor absoluto
resol = 4096;
x = linspace(0,6,resol);% 4096 point between 0 and 6
y = sinc(x-3); % shifted
   y_mod = abs(y);
   
% PLOT up to two sinc lobules
figure 
   plot(x,y_mod,'o')
   title('2-D Sinc(t-3) Plot');
   xlabel('t');
   ylabel('sinc(t)');
   grid on

% Cuantizacion de la Sinc y Valor absoluto 
% check DIGITAL SIGNAL PROCESSING USING MATLAB FOR STUDENTS AND RESEARCHERS
%   for quatization error
   sinc_table = (round(y_mod * (resol-1))); %Ensure amplitude Range between 0-4095

% Plot downsampled signal

sampleNum   = 100; % one hundred samples per cycle
delta_t     = round(resol/sampleNum); %41


a_downSamplArray    = downsample(sinc_table,delta_t);
t_downSamplArray    = downsample(x,delta_t);

subplot(2,1,1);
   plot(x,sinc_table,'o')
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








%%%%%%%%%%%%%%%%%%%%%%
%Convertir a Hexadecimal, los valores de Cuantizados
%Declaremos un Data Conteiner "cell"
CellHex = cell(1,resol,1);

%Lo Pasamos a Hexadecimal
for i = 1:resol
    CellHex{i}=dec2hex(sinc_table(i),3); % dec2hex(D,minDigits)
end

%Agregamos los Caracteres faltantes para el codigo en VHDL. Recorriendo
%cada celda del arreglo
for i = 1:resol
    CellHex{i}=sprintf(' X"%s",',CellHex{i});
end

%Generar un archivo de salida.
fileID = fopen('C:\Users\guill\Desktop\A_DIXITAL\2_DE0_Nano_Soc_CycloneV\0_dixital_SoC\DDS_9854\MatlabLUT_gen\lutSinc.txt','w');

% for i = 1:4096 
%         fprintf(fileID,'%s',CellHex{i});
% end
k = 1;
for i = 1:512 
    for j = 1:8
        fprintf(fileID,'%s',CellHex{k});
        k=k+1;
           
    end   
    fprintf(fileID,'\n');
end
fclose(fileID);
