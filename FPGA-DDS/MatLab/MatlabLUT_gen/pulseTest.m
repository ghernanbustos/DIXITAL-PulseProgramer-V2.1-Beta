%  Test pulse

clear all;
close all;
%Parametros de la funcion
np=4095;
 
t=linspace(-4095,+4095,80191);
t = round(t); %round to the closest integer
%Funcion
 %y = rectpuls(t);
y = rectpuls(t-1000,1000);
%Ploteo
figure
% plot(t, y ,'o');
plot(t, y); 
title('2-D Line Plot');
xlabel('t');
ylabel('pulse');
xlim([-5000 +5000])
ylim([-2 +2])