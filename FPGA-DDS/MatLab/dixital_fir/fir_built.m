
%   Author:     Guillermo Bustos 24/09/2018
%   Project:    DIXITAL - FAMAF - PHD THESIS 
%       
% ========================================================================= 
% Build a Filter
% First execute fft_sinc_shifted.m script
% ========================================================================= 

% ----------- LOW PASS FILTER design --------------------------------------
n = 36; % Filter Order
b = fir1(n,[0.5]);   % Window-based FIR filter design
                      % 0.02 = Aprox 30khz cutoff freq 
                      % Uses a Hamming window to design an nth-order lowpass
figure
freqz(b,1,512)        % Freq uency response of filter

% Pad with zeros y_w. Adds zeros at the beginning and the end -------------
% Arbitrary defined, but we can set a rule like half of the window size
pad1 = zeros(1,50);
pad2 = zeros(1,50);

y_w_extended = cat(2,y_w,pad1); 
y_w_extended = cat(2,pad2,y_w_extended);

y_w_mod_extended = cat(2,y_mod_w,pad1); 
y_w_mod_extended = cat(2,pad2,y_w_mod_extended);

% Now reescale x_t_window to fit in new time array size -------------------
tmax = Ts * length(y_w_extended);
x_t_extended = linspace(0, tmax, length(y_w_extended));

figure
    plot(x_t_extended,y_w_extended,'--g','LineWidth',2); % Original
    grid on
    title('Same Windowed Sinc but Zero Padding - Extended Time')
    xlabel('Time (s)')
% -------- Filter extended window Sinc
outlo_1 = filter(b,1,y_w_extended); % Sinc (Not Module)
figure
    plot(x_t_extended,y_w_extended,'g','LineWidth',2); % Original
    hold on
    plot(x_t_extended,outlo_1); % Filtered
    grid on
    title('Lowpass Filtered Signal')
    xlabel('Time (s)')
    legend('Sinc','Filtered')
    
% --------- FFT filtered signal 
n = length(outlo_1);
n = 10*n; % multiplied by arbitrary number
p = nextpow2(n); % ensure to fit n elements multiple of power of two
n = 2^p; % set n power of two elements 
X_filtered = fft(outlo_1,n);
f = (0:n-1)*(Fs/n);     %frequency range
fft_filtered = abs(X_filtered);    %power

% Plot sHIFT FFT 
Y_shift_filtered = fftshift(X_filtered);
Fshift = (-n/2:n/2-1)*(Fs/n); % zero-centered frequency range
% Fshift = (0:n-1)*(Fs/n); % zero-centered frequency range
fft_shift_filtered_module = abs(Y_shift_filtered);     % zero-centered power

figure
subplot(2,1,1);  
   plot(f,fft_filtered);
   title('FFT Filtered singal');
   xlabel('freq');
   ylabel('FFT');
   grid on
subplot(2,1,2); 
   plot(Fshift,fft_shift_filtered_module)
   title('FFT filtered signal');
   xlabel('(freq)');
   ylabel('|FFT|');
   grid on

% -------------- All Plots together 

figure
subplot(2,1,1);  
    plot(x_t_extended,y_w_extended,'--g','LineWidth',2); % Original
    hold on
    plot(x_t_extended,outlo_1); % Filtered
    title('Time Domain - LPF FIR Filter')
    xlabel('Time (s)')
    legend('Sinc','Filtered')
    grid on
subplot(2,1,2); 
    plot(Fshift,fft_mod_shift,'g')
    hold on;
    plot(Fshift,fft_shift_filtered_module)
    title('Frequency Domain');
    xlabel('(freq)');
    ylabel('|FFT|');
    legend('FFT Sinc','FFT Sinc FIR')
    grid on

% -------------------------------------------------------------------------
% -------------------------------------------------------------------------
% ----------- Same for Module Sinc ----------------------------------------

% Now reescale x_t_window to fit in new time array size -------------------
% tmax = Ts * length(y_w_extended);
% x_t_extended = linspace(0, tmax, length(y_w_extended));

figure
    plot(x_t_extended,y_w_mod_extended,'--g','LineWidth',2); % Original
    grid on
    title('Sinc in Module - Zero Padding - Extended Time')
    xlabel('Time (s)')
% -----------------------
outlo = filter(b,1,y_w_mod_extended); % Sinc (Not Module)
figure
    plot(x_t_extended,y_w_mod_extended,'g','LineWidth',2); % Original
    hold on
    plot(x_t_extended,outlo); % Filtered
    grid on
    title('Sinc in Module - Lowpass Filtered Signal')
    xlabel('Time (s)')
    legend('Sinc','Filtered')
    
% --------- FFT filtered signal 
n = length(outlo);
n = 10*n; % multiplied by arbitrary number
p = nextpow2(n); % ensure to fit n elements multiple of power of two
n = 2^p; % set n power of two elements 
X_filtered = fft(outlo,n);
f = (0:n-1)*(Fs/n);     %frequency range
fft_filtered = abs(X_filtered);    %power

% Plot sHIFT FFT 
Y_shift_filtered = fftshift(X_filtered);
Fshift = (-n/2:n/2-1)*(Fs/n); % zero-centered frequency range
% Fshift = (0:n-1)*(Fs/n); % zero-centered frequency range
fft_shift_filtered_module = abs(Y_shift_filtered);     % zero-centered power

figure
subplot(2,1,1);  
   plot(f,fft_filtered);
   title('Sinc In Module - FFT Filtered singal');
   xlabel('freq');
   ylabel('FFT');
   grid on
subplot(2,1,2); 
   plot(Fshift,fft_shift_filtered_module)
   title('Sinc In Module - FFT filtered signal');
   xlabel('(freq)');
   ylabel('|FFT|');
   grid on

% -------------- All Plots together 

figure
subplot(2,1,1);  
    plot(x_t_extended,y_w_mod_extended,'--g','LineWidth',2); % Original
    hold on
    plot(x_t_extended,outlo); % Filtered
    title('Time Domain - LPF FIR Filter')
    xlabel('Time (s)')
    legend('|Sinc|','Filtered')
    grid on
subplot(2,1,2); 
    plot(Fshift,fft_shift_signalmodule,'g') % original |Sinc| FFT
    hold on;
    plot(Fshift,fft_shift_filtered_module)  % filtered |Sinc| FFT
    title('Frequency Domain');
    xlabel('(freq)');
    ylabel('|FFT|');
    legend('FFT |Sinc|','FFT |Sinc| FIR')
    grid on







