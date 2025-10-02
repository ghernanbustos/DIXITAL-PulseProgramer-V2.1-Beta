%   Author:     Guillermo Bustos 24/09/2018
%   Project:    DIXITAL - FAMAF - PHD THESIS 
%       
% ========================================================================= 
% Build a Windowed Sinc Kernel
% The Script above simulates NCO embedded on FPGA with a Sinc function
% loaded in the Look-Up Table.
% ========================================================================= 



clear all;
close all;
% ---------------------PLOT in radians ------------------------------------
L = 1000; % signal lenght NCO samples
% Fs = 1000;% Sampling frequency                    
% T = 1/Fs; % Sampling Period

sin_n_period = 1.5; % sin_n_period * 2 = Num of sinc lobules

x_rad = linspace(-2*sin_n_period*pi, 2*sin_n_period*pi, L);% all in radians n_samples = sample time
y = sinc( (x_rad )./ pi); % Eliminate pi term in matlab sinc function
   y_mod = abs(y);

figure  
plot(x_rad,y,'-o');
   xlabel('rad');
grid on
% -------------------- Time Scale -----------------------------------------
window_width = 100e-6; % 100us

Fs = 1 / (window_width/L); % sampling freq

% Rule: How many period in half window, and get one period value
sin_period = ((window_width/2)/sin_n_period);
sinc_freq = (1/(sin_period));% get the Sinc freq to fit at the window width
x_t_window = linspace(-window_width/2, window_width/2, L);

y_w = sinc( ( (2*pi*sinc_freq * x_t_window) )./ (pi)); % Eliminate pi term in matlab sinc function
   y_mod_w = abs(y);
figure  
plot(x_t_window,y_w,'-o');
grid on
% ------------------- Plot FFT --------------------------------------------

n = length(y_mod_w);
X = fft(y_w);
f = (0:n-1)*(Fs/n);     %frequency range
power = abs(X).^2/n;    %power

figure 
    plot(f,power,'-o')
% ------------------- Plot Module FFT -------------------------------------

n = length(y_mod_w);
X = fft(y_w);
f = (0:n-1)*(Fs/n);     %frequency range
power = abs(X).^2/n;    %power

figure 
    plot(f,power,'-o')
% % -------------------Plot sHIFT FFT -------------------------------------
% Y = fftshift(X);
% % Fshift = (-n/2:n/2-1)*(Fs/n); % zero-centered frequency range
% Fshift = (0:n-1)*(Fs/n); % zero-centered frequency range
% powershift = abs(Y).^2/n;     % zero-centered power
% figure 
%     plot(Fshift,powershift)
% % -------------------------------------------------------------------------
% % -------------------------------------------------------------------------
% 
% 
% % Do a DownSampling which reduce Fs frequency -----------------------------
% ncoFreq_sys= 0.5e6;
% set_num        = round( n_samples ./ nco_function(window_width,ncoFreq_sys));% Down sample rate
% 
% x_t_down       = downsample(x_t_window,set_num);%  
% y_t_down       = downsample(y_w,set_num);%
% y_mod_down     = downsample(y_mod_w,set_num);%
% 
% 
% figure
% subplot(3,1,1);  
%    plot(x_t_down,y_t_down,'-o');
%    title('2-D Down Sampled Sinc Plot');
%    xlabel('t');
%    ylabel('sinc(t)');
%    grid on
% subplot(3,1,2); 
%    stem(x_t_down,y_mod_down);
%    title('2-D Down Sampled Module Sinc Plot');
%    xlabel('t');
%    ylabel('sinc(t)');
%    grid on   
% subplot(3,1,3); 
%    stairs(x_t_down,y_mod_down);
%    title('2-D Down Sampled Module Sinc Plot');
%    xlabel('t');
%    ylabel('sinc(t)');
%    grid on 
%    
% n = length(x_t_down);
% X = fft(y_mod_down);
% f = (0:n-1)*(Fs/n);     %frequency range
% 
% Fs = 1 / (window_width/n);% sample num reduced
% 
% power = abs(X).^2/n;    %power
% 
% 
% Y = fftshift(X);
% % Fshift = (-n/2:n/2-1)*(Fs/n); % zero-centered frequency range
% Fshift = (0:n-1)*(Fs/n); % zero-centered frequency range
% powershift = abs(Y).^2/n;     % zero-centered power
% 
% subplot(2,1,1); 
%    plot(f,power)
%    grid on 
% subplot(2,1,2); 
%    plot(Fshift,powershift)
%    grid on 
% 














