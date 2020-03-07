% Exercise 6.3.1. Radix-2 FFT.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% a. Generate x[n]:
N = 64; % Number of Samples.
n = 0:N-1;
% x = [ones(1,9)  zeros(1,55)];
x = randn(1,64) + 1i*randn(1,64);

% Compute its 64-point DFT:
X = my_DFT(x);

% Plot the real and imaginary parts of the DFT of x[n]:
k = 0:N-1;
figure('Name','Exercise 6.3.1. Radix-2 FFT');
subplot(2,1,1);
stem(k,real(X));
title('\Ree\{X[k]\}');
xlabel('Sample Number k');
axis tight;
grid on;
hold on;

subplot(2,1,2);
stem(k,imag(X),'r');
title('\Imm\{X[k]\}');
xlabel('Sample Number k');
axis tight;
grid on;
hold on;

%% b. Use the Radix-2 FFT formula to compute the DFT of the given signal.

X1 = radix2fft(x);

% Now compare the results by plotting them altogether.
subplot(2,1,1);
stem(k,real(X1),'b.');
title('\Ree\{X[k]\} using myDFT() (circles) and radix2fft() (dots)');
xlabel('Sample Number k');
axis tight;
grid on;

subplot(2,1,2);
stem(k,imag(X1),'r.');
title('\Imm\{X[k]\}  using myDFT() (circles) and radix2fft() (dots)');
xlabel('Sample Number k');
axis tight;
grid on;
