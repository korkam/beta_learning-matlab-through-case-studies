% Exercise 5.1.8. Finding System Functions from Poles and Zeros.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Steps (a) and (b).
zer = [-0.2 -0.3 -0.4 -0.8]';
pol = [ 0.5  0.4  0.3   0.2]';

[b,a] = zp2tf(zer,pol,1) %#ok<*NOPTS>
% System function H(z) = B(z)/A(z)  polynomial coefficients:
% b = [1  1.7 0.98  0.232  0.0192];
% a = [1 -1.4 0.71 -0.154 0.0120];
figure('Name','Exercise 5.1.8. Finding System Functions from Poles and Zeros');
subplot(1,2,1);
zplane(b,a);
ylim([-1.25 1.25]);
xlim([-1.25 1.25]);

%% Step (c). Find and plot the implulse response.
delta = [1 zeros(1,31)];
h = filter(b,a,delta); % Calculate the first 32 points of h[n].

subplot(1,2,2);
stem(0:31,h);
grid on;
title('Impulse Response h[n]');
axis tight;
