% Define the parameters
A = 1; % Amplitude
f = 1; % Frequency in Hz
phi = pi/4; % Phase in radians
t = 0:0.01:2*pi; % Time vector

% Calculate the sine wave
y = A * sin(2 * pi * f * t + phi);

% Plot the sine wave
figure;
subplot(2,1,1);
plot(t, y);
title('Sine Wave');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Plot the phase
subplot(2,1,2);
plot(t, phi * ones(size(t)));
title('Phase of the Sine Wave');
xlabel('Time (s)');
ylabel('Phase (radians)');
grid on;