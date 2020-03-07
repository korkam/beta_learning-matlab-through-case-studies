% Exercise 2.3.1. The Convolution Sum.
%   Copyright 2012 - 2016, Ilias S. Konsoulas

 clc; clear; close all;

%% Step. b. Generate to ramp functions, convolve them and display the results:
n1 = 0:14;
x1 = n1;
n2 = 0:9;
x2 = n2;

% Calculate the convolution via the custom function my_conv2.m:
[ny y] = my_conv2(x1,x2,n1,n2);

% Now calculate the convolution via the built-in function conv.m:
y1 = conv(x1,x2);

% Plot and compare the results:
figure('Name','Exercise 2.3.1. The Convolution Sum');
stem(ny,y,'r.');
hold on;
stem(ny,y1);
grid on;
title(['           Convolution between ramp functions x_1[n] and x_2[n]:             ';
       'Computed via built-in conv(x_1,x_2) (blue) and custom my\_conv(x_1,x_2) (red)']); 
