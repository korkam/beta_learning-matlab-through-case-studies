% Exercise 6.3.4. Decimation-in-Frequency (DIF) FFT.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% b. Generate sequences g[n] and h[n]:
N = 64;
% x = rand(1,N);
% x = randn(1,N) + 1i*randn(1,N);
x = [ones(1,9)  zeros(1,55)];
X = diffft(x);

% Plot the real and imaginary parts of the DFT of x[n]:
k = 0:N-1;
figure('Name','Exercise 6.3.4. Decimation-In-Frequency (DIF) FFT');
subplot(2,1,1);
stem(k,real(fft(x)));
% title('\Ree\{X[k]\}');
xlabel('Sample Number k');
axis tight;
grid on;
hold on;

subplot(2,1,2);
stem(k,imag(fft(x)),'r');
% title('\Imm\{X[k]\}');
xlabel('Sample Number k');
axis tight;
grid on;
hold on;

% Now compare the results by plotting them altogether.
subplot(2,1,1);
stem(k,real(X),'b.');
title('\Ree\{X[k]\} using built-in function fft() (circles) and custom function diffft() (dots)');
xlabel('Sample Number k');
axis tight;
grid on;

subplot(2,1,2);
stem(k,imag(X),'r.');
title('\Imm\{X[k]\} using built-in function fft() (circles) and custom function diffft() (dots)');
xlabel('Sample Number k');
axis tight;
grid on;
