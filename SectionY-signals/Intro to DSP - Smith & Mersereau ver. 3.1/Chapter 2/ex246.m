% Exercise 2.4.6. Autocorrelation.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% a. Signal Definitions.
N = 240;
n = 0:N-1;
x = 1/2*sin(pi/12*n) + sin(pi/24*n);
y = x + 3*(rand(1,N) - 1/2);

figure('Name','Exercise 2.4.6. Autocorrelation');
subplot(2,2,1);
stem(n,x,'b.');
grid on;
axis tight;
title('x[n] = 1/2*sin(\pin/12) + sin(\pin/24)');

subplot(2,2,2);
stem(n,y,'r.');
grid on;
axis tight;
title('y[n] = x[n] + 3*(rand[n]-1/2)');

%% b.
m = -N+1:N-1;
subplot(2,2,3);
% Calculate the autocorrelation function as convolution:
% Acorr[n] = x[n]*x[-n].
stem(m,conv(x,fliplr(x)),'.');
% stem(m,xcorr(x));
grid on;
axis tight;
title('Autocorrelation Function A_x[n]');

%% c.
subplot(2,2,4);
% Calculate the autocorrelation function as convolution:
% Acorr[n] = y[n]*y[-n].
stem(m,conv(y,fliplr(y)),'g.');
% stem(m,xcorr(y));
grid on;
axis tight;
title('Autocorrelation Function A_y[n]');
