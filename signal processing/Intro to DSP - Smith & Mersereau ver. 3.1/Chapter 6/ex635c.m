% Exercise 6.3.5.c. Two-for-One IFFT.
% Continuation of Exercise 6.3.5. 

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

% Part b. of this exercise has to run first in order to generate
% the complex sequences X and Y.
ex635b;

close all;

[x1 y1] = ifft241(X,Y);

% Plot the 2 real sequences x[n] and y[n]:
n = 0:N-1;
figure('Name','Exercise 6.3.5.c Two-for-One IFFT');
subplot(2,1,1);
stem(n,x1);
title('x[n] by custom function ifft241() (circles) and original signal (dots)');
xlabel('Sample Number n');
axis tight;
grid on;
hold on;

subplot(2,1,2);
stem(n,y1,'r');
title('y[n] by custom function ifft241() (circles) and original signal (dots)');
xlabel('Sample Number n');
axis tight;
grid on;
hold on;

% Now compare the results by plotting them altogether.
% Random signals x[n] and y[n] are products of ex635b.m
subplot(2,1,1);
stem(n,x,'b.');
axis tight;
grid on;

subplot(2,1,2);
stem(n,y,'r.');
axis tight;
grid on;
