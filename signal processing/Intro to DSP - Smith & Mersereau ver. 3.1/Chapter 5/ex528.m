% Exercise 5.2.8. Modulation.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.
clc; clear; close all;

%% Step (a). Create a 6-point signal.
n = 0:5;
x = (5/4).^n;

figure('Name','Exercise 5.2.8. Modulation');
subplot(2,2,1);
zplane(x,1);
title('Poles and Zeros of x[n]');
grid on;

% Now create the signals x1[n], x2[n] and x3[n].
x1   = exp(1i*pi/2.*n).*x;
x2  = exp(1i*pi*n).*x;
x3 = exp(-1i*pi/2.*n).*x;

subplot(2,2,2);
zplane(x1,1);
title('Poles and Zeros of x_1[n] = e^{j\pin/2}x[n]');
grid on;

subplot(2,2,3);
zplane(x2,1);
title('Poles and Zeros of x_2[n] = e^{j\pin}x[n]');
grid on;

subplot(2,2,4);
zplane(x3,1);
title('Poles and Zeros of x_3[n] = e^{-j\pin/2}x[n]');
grid on;

%% Step (b).
figure('Name','Exercise 5.2.8. Modulation');
subplot(2,2,1);
zplane(x,1);
title('Poles and Zeros of x[n]');
grid on;

% Now create the other signals and plot the zeros and poles.
y1   = ((1/2).^n).*x;
y2  = ((1/2*exp(1i*pi)).^n).*x;
y3 = (2.^n).*x;

subplot(2,2,2);
zplane(y1,1);
title('Poles and Zeros of y_1[n] = (1/2)^nx[n]');
grid on;

subplot(2,2,3);
zplane(y2,1);
title('Poles and Zeros of y_2[n] = (1/2e^{j\pi})^nx[n]');
grid on;

subplot(2,2,4);
zplane(y3,1);
title('Poles and Zeros of y_3[n] = 2^nx[n]');
grid on;
