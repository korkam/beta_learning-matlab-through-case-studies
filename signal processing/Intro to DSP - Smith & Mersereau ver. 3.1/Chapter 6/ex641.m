% Exercise 6.4.1. Evaluating Linear Convolutions Using the DFT.
% When the length of the DFT's used are at least as long as the
% linear convolution of the two sequences, the circular convolution and
% the linear convolution are the same. However, this method is not efficient
% when one sequence is much longer than the other.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Create the 2 random complex sequences to be convolved.
N = 32; M = 128;
x = randn(1,N)  + 1i*randn(1,N);
y = randn(1,M) + 1i*randn(1,M);

z = fastconv2(x,y); % The function fastconv2.m takes care of the zero-padding as well.
z1 = conv(x,y);

% Compare the results by plotting the real and imaginary parts of the convolutions.
n = 0:N+M-2;

figure('Name','Exercise 6.4.1. Evaluating Linear Convolutions Using the DFT');
subplot(2,1,1);
stem(n,real(z));
hold on;
stem(n,real(z1),'r.');
axis tight;
grid on;
title('\Ree[conv(x,y)] by built-in function conv() (red dots) and by custom function fastconv2() (blue circles)');

subplot(2,1,2);
stem(n,imag(z));
hold on;
stem(n,imag(z1),'r.');
axis tight;
grid on;
title('\Imm[conv(x,y)] by built-in function conv() (red dots) and by custom function fastconv2() (blue circles)');
