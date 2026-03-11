% MATLAB Upsampling Example
% Author: Senior Programming Expert

% Original discrete-time signal
x = [1 2 3 4];   % Example sequence
L = 9;           % Upsampling factor

% --- Method 1: Basic upsampling (zero insertion) ---
y_basic = upsample(x, L);

% --- Method 2: Upsampling with interpolation filtering ---
% interp() applies zero insertion + lowpass filter to smooth the signal
y_interp = interp(x, L);

% Display results
disp('Original signal:');
disp(x);

disp(['Upsampled by factor ', num2str(L), ' (zero insertion only):']);
disp(y_basic);

disp(['Upsampled by factor ', num2str(L), ' with interpolation filtering:']);
disp(y_interp);

% --- Plot for visualization ---
figure;
subplot(3,1,1);
stem(x, 'filled');
title('Original Signal');
xlabel('n'); ylabel('Amplitude');

subplot(3,1,2);
stem(y_basic, 'filled');
title(['Upsampled by ', num2str(L), ' (Zero Insertion)']);
xlabel('n'); ylabel('Amplitude');

subplot(3,1,3);
stem(y_interp, 'filled');
title(['Upsampled by ', num2str(L), ' with Interpolation Filtering']);
xlabel('n'); ylabel('Amplitude');