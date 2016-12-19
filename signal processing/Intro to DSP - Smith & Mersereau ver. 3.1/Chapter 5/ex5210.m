% Exercise 5.2.10. Convolution.
%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Step (a).
n1 = 0:7;
x = [0.75 0.75 -1.25 -1.25 -0.75 -0.75 0.25 0.25];

n2 = 0:31;
h = (9/10).^n2;
y = fastconv2(x,h);

figure('Name','Exercise 5.2.10. Convolution');
subplot(3,1,1);
stem(n1,x);
title('x[n]');
grid on;

subplot(3,1,2);
stem(n2,h,'r.');
title('h[n] = (9/10)^nu[n]');
xlim([min(n2) max(n2)]);
grid on;

subplot(3,1,3);
stem(0:(max(n1)+max(n2)),y,'g*');
title('y[n] = x[n]\asth[n]');
axis tight;
grid on;

%% Step (b).
n3 = 0:31;
h2 = (1/2).^n3;
b = 1;           % Numerator Coefficients
a = [1 -1/2]; % Denominator Coefficients.

y2= filter(b,a,[x zeros(1,24)]);  % We need 32 samples of the output

figure('Name','Exercise 5.2.10. Convolution');
subplot(3,1,1);
stem(n1,x);
title('x[n]');
grid on;

subplot(3,1,2);
stem(n3,h2,'r.');
title('h_2[n] = (1/2)^nu[n]');
axis tight;
grid on;

subplot(3,1,3);
stem(n3,y2,'g*');
title('y_2[n] = filter(b,a,x[n])');
axis tight;
grid on;
