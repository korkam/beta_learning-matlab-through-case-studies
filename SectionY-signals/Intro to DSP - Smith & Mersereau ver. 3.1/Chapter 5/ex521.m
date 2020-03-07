% Exercise 5.2.1. Finding the Inverse z-Transform.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;
syms z n;

%% Part a.
H1 = 1/(1-1/4*z^(-2));

h1 = iztrans(H1) %#ok<*NOPTS>
n1 = 0:16;
h11 = double(subs(h1,n,n1));

figure('Name','Exercise 5.2.1. Finding the Inverse z-Transform');
subplot(2,1,1);
stem(n1,h11,'*');
title('h_1[n]');
grid on;
axis tight;

%% Part b.
H2 = (z^4 + 2*z^2)/(z^4 - 1/4);

h2 = simplify(iztrans(H2))
n2 = 0:16;
h22 = double(subs(h2,n,n2));

subplot(2,1,2);
stem(n2,h22,'*');
title('h_2[n]');
grid on;
axis tight;
