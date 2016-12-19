% Exercise 6.3.6. FFT for Real Input Sequences.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% a. Generate a 64-point real random signal:
N = 64;
seq = randn(1,N);

% Use the custom function to calculate the fft of the given N-point real sequence:
Xs = fftreal(seq);

% Calculate the same DFT by use of the built-in MatLab function:
Xd = fft(seq);

% Plot the real and imaginary parts of the DFT of seq[n]:
k = 0:N - 1;
figure('Name','Exercise 6.3.6. FFT for Real Input Sequences');
subplot(2,1,1);
stem(k,real(Xs));
title('\Ree\{X[k]\} computed by custom function fftreal() (circled) and by built-in fft() (dotted)');
xlabel('Sample Number k');
axis tight;
grid on;
hold on;

subplot(2,1,2);
stem(k,imag(Xs),'r');
title('\Imm\{X[k]\} computed by custom function fftreal() (circled) and by built-in fft() (dotted)');
xlabel('Sample Number k');
axis tight;
grid on;
hold on;

% Now compare the results by plotting them altogether.
subplot(2,1,1);
stem(k,real(Xd),'b.');

subplot(2,1,2);
stem(k,imag(Xd),'r.');

%% b. Use the custom function to calculate the original sequence:
seq1= ifftreal(Xs);
% seq1= ifftreal2(Xs);
 
figure('Name','Exercise 6.3.6. FFT for Real Input Sequences');
stem(k,seq,'b.');
title('Original real sequence x[n] (dotted) and as calculated by custom function ifftreal() (circled)');
xlabel('Sample Number k');
axis tight;
grid on;
hold on;
stem(k,seq1);
