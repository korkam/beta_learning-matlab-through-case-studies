% Exercise 5.1.3. Producing Pole/Zero Plots.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Step (a).
b = [1  3  3  1];  % Numerator Coefficients.
a = [1 .5 .3 .1];  % Denominator Coefficients.

% Produce and display the Poles/Zeros plot.
figure('Name','Exercise 5.1.3. Producing Pole/Zero Plots'); 
zplane(b,a);
grid on;

% Produce and display the frequency response.
figure('Name','Exercise 5.1.3. Producing Pole/Zero Plots'); 
freqz(b,a);
% or better: 
% fvtool(b,a);

%% Step (b).
% Find the numerical values of poles and zeros
[z p k] = tf2zpk(b,a) %#ok<*NOPTS>
