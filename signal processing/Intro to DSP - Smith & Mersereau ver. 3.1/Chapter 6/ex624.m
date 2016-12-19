% Exercise 6.2.4. Linear Convolutions via Circular Convolutions.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Step (a). Generate a 64-point square wave x[n].
n = 0:63;
block = [1 1 1 1 1 0 0 0];
x = [block block block block block block block block ];
N = length(x);

% Now define signal h[n]:
h = ones(1,16);
M = length(h);

% Compute the linear convolution of the 2 signals.
y1 = conv(x,h);

figure('Name','Exercise 6.2.4. Linear Convolutions via Circular Convolutions');
subplot(3,1,1);
stem([0:78],y1);
ylim([0 11]);
hold on;
title('Linear Convolution of x[n] with h[n]. Size: 79 points.');
grid on;

%% Step (b). Extend h[n] to 64 points using zero-padding.
% Compute the 64-point circular convolution of the 2 signals.
h1 = [h zeros(1,48)];  
y2 = cconv(x,h1,64);
n2 = n;

subplot(3,1,2);
stem(n2,y2);
xlim([0 64]);
ylim([0 11]);
title('64-point Circular Convolution of x[n] with zero-padded h[n]');
grid on;

%% Step (c). Extend both sequences to 128 points using zero-padding.
% Compute the 128-point circular convolution of the 2 signals.
x2 = [x    zeros(1,64)];
h2 = [h1 zeros(1,64)];

N2 = length(x2);  
y3 = cconv(x2,h2,N2);

subplot(3,1,3);
stem([0:N2-1],y3);
hold on;
xlim([0 N2-1]);
ylim([0 11]);
title(['  128-point Circular Convolution of zero-padded x[n] with zero-padded h[n] (blue) ';
         '79-point Circular Convolution of zero-padded x[n] with zero-padded h[n] (red dots)']);

%%  What is the smallest length of circular convolution that makes it equal to the linear convolution?
% The smallest number of points that makes the circular convolution equal to the 
% linear convolution is N + M - 1 = 79 i.e. the size of the linear convolution of the 2 signals.
% Therefore, compute the 79-point circular convolution of the 2 signals.
y4 = cconv(x2,h2,N+M-1);

subplot(3,1,3);
stem([0:N+M-2],y4,'r.');
grid on;

