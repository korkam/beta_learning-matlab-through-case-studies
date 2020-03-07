% Exercise 5.2.7. Time Reversal.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.
clc; clear; close all;

%% Step (a). Create a 6-point chirp signal.
n = 0:5;
h = sin(0.5*n + 0.8*n.^2 + 1);

figure('Name','Exercise 5.2.7. Time Reversal');
subplot(1,2,1);
zplane(h,1);
title('Poles and Zeros of h[n]');
grid on;

% Now create the h[-n] signal and plot the zeros and poles.
hrev = fliplr(h);

subplot(1,2,2);
zplane(hrev,1);
title('Poles and Zeros of h[-n]');
grid on;

% As shown on the plots, when we renerse the time, the zeros and the poles 
% move to their reciprocal positions i.e. at 1/zero_i and 1/pole_k.

%% Step (b).
bg = 1;
ag = [1 -1/3];

figure('Name','Exercise 5.2.7. Time Reversal');
subplot(1,2,1);
zplane(bg,ag);
title('Poles and Zeros of g[n] = (1/3)^n');
grid on;

% In place of z^(-1) in G(z) substitute the z and bring the rational
% function in the usable form.
bg_rev = [0 -3];
ag_rev = [1 -3];

subplot(1,2,2);
zplane(bg_rev,ag_rev);
title('Poles and Zeros of g[-n]');
grid on;

% Note that the zero of G(z) at the origin has moved to Infinity.
