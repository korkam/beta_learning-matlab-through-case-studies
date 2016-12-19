% Exercise 5.2.2. More Inverse z-Tranforms.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;
syms z n;

%% Step (a).
H1 = (1 + 2*z^(-1) + 2*z^(-2) + 2*z^(-3))/(1 + 0.5*z^(-1));

h1 = simplify(iztrans(H1,z,n)) %#ok<*NOPTS>
n1 = 0:20;
h11 = double(subs(h1,n,n1));

comp1 = (-1/2).^n1;   % Basic component for the computations below:
delta = [1 zeros(1,20)];

% Impulse response  calculated analytically:
% h1[n] = ä[n] + 2ä[n-2] + 3/2[(-1/2)^(n-1)]u[n-1] + [(-1/2)^(n-3)]u[n-3]
h12 = delta + 2*shiftright(delta,2) + 3/2*shiftright(comp1,1) + shiftright(comp1,3);

figure('Name','Exercise 5.2.2. More Inverse z-Transforms');
subplot(2,1,1);
stem(n1,h11);
hold on;
stem(n1,h12,'r*');
title('h_1[n] calculated analytically (red) and by built-in function iztrans() (blue)');
grid on;
axis tight;

%% Step (b).
H2 = (1 + 2*z^(-1) + 0.5*z^(-2) + 0.4*z^(-3)) / (1 + 0.5*z^(-1) + 0.1*z^(-2));

h2 = simplify(iztrans(H2,z,n))
n2 = 0:20;
h21 = double(subs(h2,n,n2));

% Impulse response  calculated analytically:
% h2[n] = ä[n] + 4ä[n-1] - 3[r1*p1^(n-1) + r2*p2^(n-1)]*u[n-1]
r1 = 0.4167 - 1i*0.8391; r2 = 0.4167 + 1i*0.8391;
p1 = -0.25 + 1i*0.1936;  p2 = -0.25 - 1i*0.1936;

comp21 = p1.^n1; comp22 = p2.^n1;
h22 = delta + 4*shiftright(delta,1) - 3*(r1*shiftright(comp21,1) + r2*shiftright(comp22,1));

subplot(2,1,2);
stem(n2,h21');
hold on;
stem(n1,h22,'r*');
title('h_2[n] calculated analytically (red) and by built-in function iztrans() (blue)');
grid on;
axis tight;
