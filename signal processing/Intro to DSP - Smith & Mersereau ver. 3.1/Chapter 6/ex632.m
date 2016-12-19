% Exercise 6.3.2. Inverse FFT.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% c. Create an 8-point ramp sequence.

% seq = 0:8;
seq = randn(1,281) + 1i*randn(1,281);

Samples = size(seq,2);

x2 = method2_idft(seq);

x3 = method3_idft(seq);  %Try x2 = ifft(seq); Just for checking purposes.

%% Plot the results.
% Plot the real and imaginary parts of the DFT of x1[n]:
k = 0:Samples - 1;
figure('Name','Exercise 6.3.2. Inverse FFT');
subplot(2,1,1);
stem(k,real(x2));
title('\Ree\{x_2[n]\} (Method II) (circle) and \Ree\{x_3[n]\} (Method III) (dot)');
xlabel('Sample Number n');
axis tight;
grid on;
hold on;

subplot(2,1,2);
stem(k,imag(x2));
title('\Imm\{x_2[n]\} (Method II) (circle) and \Imm\{x_3[n]\} (Method III) (dot)');
xlabel('Sample Number n');
axis tight;
grid on;
hold on;

% Now compare the results by plotting them altogether.
subplot(2,1,1);
stem(k,real(x3),'r.');
xlabel('Sample Number n');
axis tight;
grid on;

subplot(2,1,2);
stem(k,imag(x3),'r.');
xlabel('Sample Number n');
axis tight;
grid on;
