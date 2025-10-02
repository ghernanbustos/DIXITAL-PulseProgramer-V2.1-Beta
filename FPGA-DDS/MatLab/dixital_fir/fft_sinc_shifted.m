%   Author:     Guillermo Bustos 24/09/2018
%   Project:    DIXITAL - FAMAF - PHD THESIS 
%       
% ========================================================================= 
% Build a Windowed Sinc Kernel
% The Script above simulates NCO embedded on FPGA with a Sinc function
% loaded in the Look-Up Table.
% Hamming Windowing is applied.
% ========================================================================= 
% Zero Padding:
% https://dsp.stackexchange.com/questions/741/why-should-i-zero-pad-a-signal-before-taking-the-discrete-fourier-transform
% =========================================================================
clear all;
close all;

%------------ Input Data Pulse Width and NCO base frequency ---------------
window_width    = 100e-6; % 100us RF pulse width
nco_freq        = 3e6;
n_samples       = nco_function(window_width,nco_freq);
sin_n_period = 1.5; % Set number of period - number of lobules

% Turn Windowing on = 1.
window_sw = 0;

% ---------------------Sinc in radians Dm ---------------------------------
% x_rad = linspace(-2*sin_n_period*pi, 2*sin_n_period*pi, L);% all in radians n_samples = sample time
x_rad = linspace(0, 4*sin_n_period*pi, n_samples);
% to shift right set half of total period
y = sinc( (x_rad  - ((4*sin_n_period*pi)/2) )./ pi); % Eliminate pi term in matlab sinc function
    if window_sw == 1  
          y = y.*hamming(n_samples)'; % Hamming Windowing
    end
y_mod = abs(y);
   
% figure
% subplot(2,1,1);  
%    plot(x_rad,y,'-o');
%    title('Sinc');
%    xlabel('radians');
%    grid on
% subplot(2,1,2); 
%    plot(x_rad,y_mod);
%    title('Sinc Module');
%    xlabel('radians ');
%    grid on

% -------------------- Time Scale Domain ----------------------------------
% window_width = 100e-6; % 100us

Fs = 1 / (window_width/n_samples); % sampling freq | NCO base freq
Ts = window_width / n_samples; % sampling freq | NCO base freq
% Rule: How many period in half window, and get one period value
sin_period = ((window_width/2)/sin_n_period);
sinc_freq = (1/(sin_period));% get the Sinc freq to fit at the window width
x_t_window = linspace(0, window_width, n_samples);

y_w = sinc( ( (2*pi*sinc_freq * x_t_window)-((4*sin_n_period*pi)/2) )./ (pi)); % Eliminate pi term in matlab sinc function
if window_sw == 1 
    y_w = y_w.*hamming(n_samples)';
end
    y_mod_w = abs(y_w);

figure
subplot(3,1,1);  
   plot(x_t_window,y_w,'-o');
   title('Sinc');
   xlabel('time (s)');
   grid on
subplot(3,1,2); 
   plot(x_t_window,y_mod_w);
   title('|Sinc| Window');
   xlabel('time(s)');
   grid on
 subplot(3,1,3); 
   stairs(x_t_window,y_mod_w);
   title('|Sinc| Window');
   xlabel('time(s)');
   grid on
 sgtitle(['Sample Freq: ' num2str(Fs) ', Window Width: ' num2str(window_width) ', Sample Num: ' num2str(n_samples)]);

% ------------------- Plot FFT --------------------------------------------

n = length(y_w);
n = 10*n; % multiplied by arbitrary number
% to pad the signal so can speed up the computation of the FFT when the signal length is not an exact power of 2.
p = nextpow2(n); 
n = 2^p; % set n power of two elements 
X = fft(y_w,n); % pads with extra ceros
fft_resolution = (0:n-1)*(Fs/n);     % FFT resolution
fft_signal = abs(X);    %power

% ---------- Plot sHIFT FFT 
Y = fftshift(X);
Fshift = (-n/2:n/2-1)*(Fs/n); % zero-centered frequency range
% Fshift = (0:n-1)*(Fs/n); % zero-centered frequency range
fft_mod_shift = abs(Y);     % zero-centered power
ang = angle(Y);
figure
subplot(3,1,1);  
   plot(fft_resolution,fft_signal);
   title('Sinc FFT');
   xlabel('freq');
   ylabel('FFT');
   grid on
subplot(3,1,2); 
   plot(Fshift,fft_mod_shift)
   title('Sinc FFT');
   xlabel('(freq)');
   ylabel('|FFT|');
   grid on
subplot(3,1,3); 
   plot(Fshift,ang)
   title('Sinc FFT');
   xlabel('(freq)');
   ylabel('|FFT|');
   grid on
sgtitle('Sinc Freq. Domain');
% ------------------- Plot Module FFT -------------------------------------

n = length(y_mod_w);
n = 10*n; % 
p = nextpow2(n)
n = 2^p; % % set n power of two elements 
X_mod = fft(y_mod_w,n);
f = (0:n-1)*(Fs/n);     %frequency range
fft_signalmodule = abs(X_mod);    %power

% ---------- Plot sHIFT FFT 
Y_mod = fftshift(X_mod);
Fshift = (-n/2:n/2-1)*(Fs/n); % zero-centered frequency range
fft_shift_signalmodule = abs(Y_mod);     % zero-centered power
  
figure
subplot(2,1,1);  
   plot(f,fft_signalmodule);
   title('|Sinc| FFT');
   xlabel('freq');
   ylabel('FFT');
   grid on
subplot(2,1,2); 
   plot(Fshift,fft_shift_signalmodule)
   title('|Sinc| FFT');
   xlabel('(freq)');
   ylabel('|FFT|');
   grid on 
sgtitle('|Sinc| Freq. Domain');