% Exercise 6.5.4. The Discrete Hartley Tranform.
% You need M to be odd for this routine to work properly.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace initialization.

clc; clear; close all;

%% Signal Definitions.

N = 256;
x = randn(1,N);

% Period = 65;
% n = 0:(Period-1)/2;
% A = 1;
% half_block = 2*A*n/(Period-1); 
% second_half = fliplr(half_block(2:end));
% block = [half_block second_half];
% x = [block block block];
% N = size(x,2);

%% a. Calculate the DHT using the custom  function my_DHT():
X = my_DHT3(x);
X1 = fft(x);

% Compare the result of the custom function with the definition of the DHT:
X2 = real(X1) - imag(X1);

figure('Name','Exercise 6.5.4. The Discrete Hartley Tranform');
subplot(2,1,1);
stem(X);
hold on;
title('DHT of x[n] computed by custom function my\_DHT() (blue circles) and a direct computation of DHT (red dots)');
stem(X2,'r.');
grid on;
axis tight;

% Now take the inverse DHT transform to restore sequence x[n]:
x1 = 1/N*my_DHT3(X);

subplot(2,1,2);
stem(x);
hold on;
title('Original random sequence x[n] (blue circles), and inverse DHT as computed by 1/N*my\_DHT(X[k]) (green dots)');
stem(x1,'g.');
grid on;
axis tight;

%% Linear Convolution using the DHT.
% Create a low-pass filter with cut-off frequency pi/6.
M = 127;
h = [ sin(pi/6.*(-(M-1)/2:-1))./(pi.*(-(M-1)/2:-1)) 1/6 sin(pi/6.*(1:(M-1)/2))./(pi.*(1:(M-1)/2)) ]; % lenght(h) = M.
% time_ind = -(N+M)/2+1:(N+M)/2-1;               % These are the time indices where signals coexist.

y = conv_DHT(x,h);

figure('Name','Exercise 6.5.4. The Discrete Hartley Tranform');
stem(y)
hold on;
stem(conv(x,h),'r.');
title('Linear Convolution via DHT (blue circles) vs MatLab built-in conv(x,h) (red dots)');
grid on;
axis tight;
