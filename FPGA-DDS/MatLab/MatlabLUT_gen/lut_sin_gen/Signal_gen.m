%   Creado por: 
%       Guillermo Bustos 24/09/2018
%   Practico: "Generar Funciones para el Analisis Estadistico"
%       Redes Neuronales 2019 - Facultad de Matematica Astronomia y
%                               Fisica
% ========================================================================= 
% Tome los datos de una señal (que se la damos nosotros) y extraiga los 
% máximos y mínimos de dicha señal, luego con esos puntos extremos que 
% calcule el valor medio y las desviaciones de las amplitudes y de los 
% tiempos entre extremos (aplicar la técnica SSC)
% ========================================================================= 
% https://www.mathworks.com/help/signal/examples/signal-generation-and-visualization.html
%--------------------------------------------------------------------------

clear all,clc, close all;

tc = gauspuls('cutoff',50e3,0.1,[],-60);

t = -tc : 1e-6 : tc;
%yi = round(gauspuls(t,50e3,0.6));
yi = gauspuls(t,50e3,0.6);

figure
    subplot(2,1,1)
        plot(t,yi,'k','LineWidth',1.5)
        title('Subplot 1: ')
        axis([-4e-5 4e-5 -1.2 1.2])
        grid on
    subplot(2,1,2)
        plot(t,yi,'go','LineWidth',1.5)
        title('Subplot 2: ')
        axis([-4e-5 4e-5 -1.2 1.2])
        grid on