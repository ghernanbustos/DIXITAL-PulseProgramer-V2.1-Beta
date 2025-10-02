%   Author:     Guillermo Bustos 24/09/2018
%   Project:    DIXITAL - FAMAF - PHD THESIS 
%       
% ========================================================================= 
% Build a Windowed Sinc Kernel
% The Script above simulates NCO embedded on FPGA with a Sinc function
% loaded in the Look-Up Table.
% ========================================================================= 
% Testing
clear all;
close all;
% Original Sinc Window Full Samples
n_samples = 4097; % odd for Sinc symmetry
x_rad = linspace(0, 6*pi, n_samples);% all in radians n_samples = sample time
y = sinc( (x_rad - 3*pi )./ pi); % Eliminate pi term in matlab sinc function
   y_mod = abs(y);

% PLOT 
figure
subplot(2,1,1);  
   plot(x_rad,y,'o')
   title('2-D Sinc shifted 3pi) Plot');
   xlabel('(rad/s)');
   ylabel('sinc(t)');
   grid on
subplot(2,1,2); 
   plot(x_rad,y_mod,'o')
   title('2-D Module Sinc shifted 3pi Plot');
   xlabel('(rad/s)');
   ylabel('|sinc(t)|');
   grid on
 
   
% ========================================================================= 
% Set Time scale to fit with Rect Window
%  How to set variable time in plot to fit Sinc graph to window width.
%   Sin function has zeros at 0, pi, 2pi, 3pi and so on. Window width
%   includes up to five sinc lobules. Half window width is equivalent to
%   1.5 sin period, full windows width is equivalent to double 1.5 Sin period.
%   Thats the value needed to set Sinc frequency to fit at the window.
% 
%   Sinc function is plotted with 2^12 samples according with NCO LUT size
%   but remember that the number of nco samples is in function of the fsys.
%   For this application fsys = 3Mhz to avoid data time violating in DDS9854
%   In this plot there are 4096 samples which means 
%                   f_sys =  1/(window_width/4096)
% ========================================================================= 
window_width = 0.0001; % 100us

% How many sin period are need to get two and a half lobules in sinc sides
% the answer is one perio and a half. So get the window width and divide by
% three, the sin period is the 2 of the three parts.
sin_period = (2*(window_width/3));% get the sin period
% Now get the sinc frequency to get up to 5 lobules (in this case the plot 
% is shifted to the left to start from zero. Double the frecuency to get
% the hole sinc fitted in the window.
sinc_freq = 2*(1/(sin_period));% get the Sinc freq to fit at the window width

x_t_window = linspace(0, window_width, n_samples);
y_w = sinc( ( (2*pi*sinc_freq * x_t_window) - 3*pi )./ (pi)); % Eliminate pi term in matlab sinc function
   y_mod_w = abs(y);
 
% PLOT 
figure
subplot(2,1,1);  
   plot(x_t_window,y_w,'o')
   title('2-D Sinc shifted 3pi) Plot');
   xlabel('t');
   ylabel('sinc(t)');
   grid on
subplot(2,1,2); 
   plot(x_t_window,y_mod_w,'o')
   title('2-D Module Sinc shifted 3pi Plot');
   xlabel('t');
   ylabel('|sinc(t)|');
   grid on
   
% ========================================================================= 
% Simulate the output DDS samples in fuction of the fsys. The max number of
% samples per window width depends on fsys.
% Down Sampling
%   ratio = 4097 / num samples
%   This code section reproduce the NCO embedded in FPGA sampled signal
%   output. numSamples = f (window_width, ncoFreq_sys)
% ========================================================================= 
ncoFreq_sys= 3e6;
set_num        = round( n_samples ./ nco_function(window_width,ncoFreq_sys));% Down sample rate

x_t_down       = downsample(x_t_window,set_num);%  
y_t_down       = downsample(y_w,set_num);%
y_mod_down     = downsample(y_mod_w,set_num);%

figure
subplot(3,1,1);  
   plot(x_t_down,y_t_down,'-o');
   title('2-D Down Sampled Sinc Plot');
   xlabel('t');
   ylabel('sinc(t)');
   grid on
subplot(3,1,2); 
   stem(x_t_down,y_mod_down);
   title('2-D Down Sampled Module Sinc Plot');
   xlabel('t');
   ylabel('sinc(t)');
   grid on   
subplot(3,1,3); 
   stairs(x_t_down,y_mod_down);
   title('2-D Down Sampled Module Sinc Plot');
   xlabel('t');
   ylabel('sinc(t)');
   grid on 
   
   
% ========================================================================= 
% Carrier Signal synthetized by DDS AD9854
% NCO formula:                      
%   phase_incr = (f_out * 2^48)/fsys 
%   fsys = 300Mhz, REFCLK Multiplier register configured x15 and Board XTAL 
%                   20Mhz.
% ========================================================================= 

% Original Sin
n_samples_sin   = 900001; % odd for Sin symmetry
freq_carrier = 90e6; % 90Mhz
x_carrier_rad   = linspace(0, 2*pi, n_samples_sin);% all in radians n_samples = sample time
x_carrier_t = linspace(0, window_width, n_samples_sin);% all in radians n_samples = sample time
y = 0.5 + 0.5 * sin(x_carrier_rad .* freq_carrier .* x_carrier_t); % Eliminate pi term in matlab sinc function

% Sinc enveloping
sin_period = (2*(window_width/3));% get the sin period
sinc_freq = 2*(1/(sin_period));% get the Sinc freq to fit at the window width
x_t = linspace(0, window_width, n_samples_sin);
y_bis = sinc( ( (2*pi*sinc_freq * x_t) - 3*pi )./ (pi)); % Eliminate pi term in matlab sinc function
   y_mod = abs(y_bis);

sinc_envelope = y_mod .* y;

% PLOT 
figure
subplot(3,1,1);  
   plot(x_carrier_t,y,'-o');
   title('Sin - 900001 samples Plot');
   xlabel('t');
   ylabel('sin(t)');
   grid on
subplot(3,1,2); 
   plot(x_t,y);
   title('Sin - 900001 samples Plot');
   xlabel('t');
   ylabel('sinc(t)');
   grid on   
subplot(3,1,3); 
   plot(x_t,sinc_envelope);
   title('Sin - 900001 samples Plot');
   xlabel('t');
   ylabel('sinc(t)');
   grid on 
