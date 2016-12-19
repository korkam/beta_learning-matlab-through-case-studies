% Exercise 6.3.5.b. Two-for-One FFT.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Generate 2 real, random signals of common size:
N = 64;
x = randn(1,N);
y = randn(1,N);

% Now compute their DFT using custom function fft241.m:
[X Y] = fft241(x,y);

X1 = fft(x);
Y1 = fft(y);

% Plot the real and imaginary parts of the FFT of x[n]:
k = 0:N-1;
figure('Name',' Exercise 6.3.5.b. Two-for-One FFT');
subplot(2,1,1);
stem(k,real(X));
title('\Ree\{X[k]\} using custom function fft241() (circles) and built-in function fft() (dots)');
xlabel('Frequency Sample Number k');
axis tight;
grid on;
hold on;

subplot(2,1,2);
stem(k,imag(X),'r');
title('\Imm\{X[k]\} using custom function fft241() (circles) and built-in function fft() (dots)');
xlabel('Frequency Sample Number k');
axis tight;
grid on;
hold on;

% Now compare the results by plotting them altogether.
subplot(2,1,1);
stem(k,real(X1),'b.');
axis tight;
grid on;

subplot(2,1,2);
stem(k,imag(X1),'r.');
axis tight;
grid on;

% Plot the real and imaginary parts of the FFT of y[n]:
figure('Name',' Exercise 6.3.5.b. Two-for-One FFT');
subplot(2,1,1);
stem(k,real(Y));
title('\Ree\{Y[k]\} using custom function fft241() (circles) and built-in function fft() (dots)');
xlabel('Frequency Sample Number k');
axis tight;
grid on;
hold on;

subplot(2,1,2);
stem(k,imag(Y),'r');
title('\Imm\{Y[k]\} using custom function fft241() (circles) and built-in function fft() (dots)');
xlabel('Frequency Sample Number k');
axis tight;
grid on;
hold on;

% Now compare the results by plotting them altogether.
subplot(2,1,1);
stem(k,real(Y1),'b.');
axis tight;
grid on;

subplot(2,1,2);
stem(k,imag(Y1),'r.');
axis tight;
grid on;
