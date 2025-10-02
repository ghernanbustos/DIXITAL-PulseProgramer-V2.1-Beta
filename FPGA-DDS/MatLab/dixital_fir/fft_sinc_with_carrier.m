%   Author:     Guillermo Bustos 24/09/2018
%   Project:    DIXITAL - FAMAF - PHD THESIS 
%       
% ========================================================================= 
% Plot a RF Sinc Pulse and its FFT
% The Script above simulates NCO embedded on FPGA with a Sinc function
% loaded in the Look-Up Table.
% Hamming Windowing is applied if is chose
% ========================================================================= 
% Zero Padding:
% https://dsp.stackexchange.com/questions/741/why-should-i-zero-pad-a-signal-before-taking-the-discrete-fourier-transform
% =========================================================================
clear all;
close all;

%------------ INPUT PARAMETERS Pulse Width and NCO base frequency ---------
window_width    = 100e-6; % 100us RF pulse width
nco_freq        = 3e6;
% n_samples       = nco_function(window_width,nco_freq);
n_samples = 2000;
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
   
% -------------------- Time Scale Domain ----------------------------------
%  ------------------------------------------------------------------------
% window_width = 100e-6; % 100us

Fs = 1 / (window_width/n_samples); % sampling freq | NCO base freq
Ts = window_width / n_samples; % sampling freq | NCO base freq
% Rule: How many period in half window, and get one period value
sin_period = ((window_width/2)/sin_n_period);
sinc_freq = (1/(sin_period));% get the Sinc freq to fit at the window width
x_t_window = linspace(0, window_width, n_samples);

y_w =  sinc( ( (2*pi*sinc_freq * x_t_window)-((4*sin_n_period*pi)/2) )./ (pi)); % Eliminate pi term in matlab sinc function

% ADD OFFSET AND ELIMINATE NEGATIVE LOBULES - MODULE SINC IS THE SAME AS
% SINC PLUS OFFSET - NO NEGATIVE VALUES
% y_w = y_w + 0.35;

if window_sw == 1 
    y_w = y_w.*hamming(n_samples)';
end
y_mod_w = abs(y_w);

%  ------------------------------------------------------------------------
%  Coding Fase
phase_code_vect = zeros(1, length(y_w));
    for nSample = 1: length(y_w)
        if y_w(nSample) <= 0
             phase_code_vect(nSample) = -1; % Negative Lobule
        else
            phase_code_vect(nSample) = 1; % Positive Lobule
        end
    end
%  ------------------------------------------------------------------------

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
 
 % ------------------- Plot SINC FFT ---------------------------------------

n = length(y_w);
n = 10*n; % multiplied by arbitrary number
% to pad the signal so can speed up the computation of the FFT when the signal length is not an exact power of 2.
p = nextpow2(n); 
n = 2^p; % set n power of two elements 
X = fft(y_w,n); % pads with extra ceros
fft_resolution = (0:n-1)*(Fs/n);     % FFT resolution
fft_signal = abs(X);    %power

%-- Plot sHIFT FFT 
Y = fftshift(X);
Fshift = (-n/2:n/2-1)*(Fs/n); % zero-centered frequency range
% Fshift = (0:n-1)*(Fs/n); % zero-centered frequency range
fft_mod_shift = abs(Y);     % zero-centered power
ang = angle(Y);
figure
subplot(2,1,1);  
   plot(fft_resolution,fft_signal);
   title('Sinc FFT');
   xlabel('freq');
   ylabel('FFT');
   grid on
subplot(2,1,2); 
   plot(Fshift,fft_mod_shift)
   title('Sinc FFT');
   xlabel('(freq)');
   ylabel('|FFT|');
   grid on
sgtitle('Freq. Domain Sinc Envelope');
% ------------------- Plot |SINC| FFT -------------------------------------

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
sgtitle('Freq. Domain |Sinc| Envelope');
 

%------------------------ CARRIER SIGNAL ----------------------------------
%  ------------------------------------------------------------------------

y_mod_carrier = y_mod_w .*cos(2*pi*1e6*x_t_window); % Sinc AM
% y_mod_carrier = y_w .* cos(2*pi*1e6*x_t_window);

%           PHASE CORRECTION
% Multiplied each element by the phase code + or -
y_mod_carrier_bis = y_mod_carrier .* phase_code_vect;

    figure
    subplot(2,1,1); 
       plot(x_t_window,y_mod_carrier);
       title('No Phase Correction');
       xlabel('time(s)');
       grid on
     subplot(2,1,2); 
       plot(x_t_window,y_mod_carrier_bis);
       title('Phase Correction');
       xlabel('time(s)');
       grid on

    % Plot Both signal at same plot
    figure
       plot(x_t_window,y_mod_carrier);
       hold on
       plot(x_t_window,y_mod_carrier_bis);
       xlabel('time(s)');
       legend('Carrier AM |Sinc|',' Carrier AM Phase Correction ')
       grid on
 


% ----- Plot FFT Modulated Carrier NO PHASE SHIFT

n = length(y_mod_carrier);
n = 10*n; % 
p = nextpow2(n)
n = 2^p; % % set n power of two elements 
X_mod = fft(y_mod_carrier,n);
f = (0:n-1)*(Fs/n);     %frequency range
% fft_signalmodule = abs(X_mod);    %power

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
    sgtitle('|Sinc| Freq. Domain No phase Shift');

% ------ Plot Carrier FFT - PHASE SHIFT 

n = length(y_mod_carrier_bis);
n = 10*n; % 
p = nextpow2(n)
n = 2^p; % % set n power of two elements 
X_mod = fft(y_mod_carrier_bis,n);
f = (0:n-1)*(Fs/n);     %frequency range
% fft_signalmodule = abs(X_mod);    %power

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
    sgtitle('|Sinc| Freq. Domain with phase Shift');