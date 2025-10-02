%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Filename            : lut_sin_gen.m
%   
%   Athor               : Guillermo H. Bustos
%                         Phd Student - Trovintek - Famaf
%                         Ingeniero Electronico UTN FRC
%
%   Date last modified  : 25.08.2018  
%
%   Description         : Se muestrea una funcion, y se genera el archivo
%                         necesario para llenar el contenido de la LUT en
%                         el codigo VHDL que la requiera. la misma es de
%                         4096 muestras.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;

%Parametros de la funcion
np=4096;
A=2047;
t=linspace(0,1-1/np,np);%generates N points between X1 and X2.
%Funcion
sin = A + A * sin(2*pi*t);
sin_table = (round(sin));

%Ploteo
figure
plot(t,sin_table,'o');
title('2-D Line Plot');
xlabel('t');
ylabel('sin(2pi*t)');
%%%%%%%%%%%%%%%%%%%%%%
%Convertir a Hexadecimal, los valores de Cuantizados
%Declaremos un Data Conteiner "cell"
CellHex = cell(1,np,1);

%Lo Pasamos a Hexadecimal
for i = 1:np
    CellHex{i}=dec2hex(sin_table(i));
end

%Agregamos los Caracteres faltantes para el codigo en VHDL. Recorriendo
%cada celda del arreglo
for i = 1:np
    CellHex{i}=sprintf(' X"%s",',CellHex{i});
end

%Generar un archivo de salida.
fileID = fopen('C:\Users\aleri\Desktop\A_DIXITAL\1_FPGA_Cyclone_IV\10-Matlab_FPGA\lut_sin_gen\lut_guille.txt','w');

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

