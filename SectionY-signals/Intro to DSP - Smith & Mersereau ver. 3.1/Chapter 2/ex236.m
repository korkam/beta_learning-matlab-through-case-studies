% Exercise 2.3.6. Beginning and End Points.
% This script demonstrates how to calculate the beginning and ending
% samples (or time instants) of a convolution sum.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Signals Definitions.
n1 = 0:49;
x = ones(1,50);

n2 = 31:41;
v = ones(1,11);

n3 = -51:-18;
w = ones(1,34);

[ny1 y1] = my_conv(x,v,n1,n2);

[ny2 y2] = my_conv(v,w,n2,n3);

[ny3 y3] = my_conv(x,w,n1,n3);

%% Plot the results.
figure('Name','Exercise 2.3.6. Beginning and End Points');

subplot(3,3,1);
stem(n1,x);
grid on;
title('x[n] = u[n]-u[n-50], n=0:49');

subplot(3,3,2);
stem(n2,v,'g*');
grid on;
title('v[n] = u[n-31]-u[n-42], n=31:41');

subplot(3,3,3);
stem(ny1,y1,'r.');
grid on;
title('y_1[n]=x[n]\astv[n], n=31:89');

subplot(3,3,4);
stem(n2,v);
grid on;
title('v[n] = u[n-31]-u[n-42], n=31:41');

subplot(3,3,5);
stem(n3,w,'g*');
grid on;
title('w[n] = u[n+51]-u[n+17], n=-51:-18');

subplot(3,3,6);
stem(ny2,y2,'r.');
grid on;
title('y_2[n] = v[n]\astw[n], n=-20:23');

subplot(3,3,7);
stem(n1,x);
grid on;
title('x[n], n=0:49');

subplot(3,3,8);
stem(n3,w,'g*');
grid on;
title('w[n], n=-51:-18');

subplot(3,3,9);
stem(ny3,y3,'r.');
grid on;
title('y_3[n] = x[n]\astv[n], n=-51:31');
