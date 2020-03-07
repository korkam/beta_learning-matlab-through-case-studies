% Exercise 2.4.9. Gaussian Random Sequences.
% This exercise demonstrates how to generate Gaussian and Rayleigh
% distributed random sequences by use of a Uniformly distributed random
% sequence.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear close all;

%% Signals Definition.

NumOfSamples = 16*1024;
g1 = zeros(NumOfSamples,1);
g2 = zeros(NumOfSamples,1);
maxlag = 500; % Maximum Time Lag to Compute and Display.
bins = 100;
sigma = 1; % This is the standard deviation of the produced Gaussian sequence.

%% Step (a).
% Create a Uniform random sequence, and use it to produce a Rayleigh-distributed random sequence.
x1 = rand(NumOfSamples,1);
r = sqrt(2.*sigma^2.*log(1./x1));

%% Create the 2 uncorrelated Gaussian random sequences g1 and g2 by use of x1.
for n = 1:NumOfSamples - 1
     g1(n) = r(n)*cos(2*pi*x1(n+1));
     g2(n) = r(n)*sin(2*pi*x1(n+1));
end

%% Step (b)
% Scale the sequences g1, g2 and r and plot their histograms.
A1 = max(g1);
A2 = max(g2);
B   = max(r);

G1 = 500/A1*g1;
G2 = 500/A2*g2;
R   = 1000/B*r;

figure('Name','Exercise 2.4.9. Gaussian Random Sequences');
subplot(2,2,1);
hist(G1,bins);
title('Histogram of Gaussian-distributed sequence g_1[n]');
xlim([-500 500]);
grid on;

subplot(2,2,2);
hist(G2,bins);
title('Histogram of Gaussian-distributed sequence g_2[n]');
xlim([-500 500]);
grid on;

subplot(2,1,2);
hist(R,bins);
title('Histogram of Rayleigh-distributed sequence r[n]');
xlim([0 1000]);
grid on;
%% Step (c). Demonstrate that g1[n] and g2[n] are uncorrelated.
% Compute their Cross-Correlation and plot the result.

[rg1g2 lags] = xcorr(g1,g2,maxlag);
Rg1g2 = rg1g2/NumOfSamples; % Normalization necessary to produce accurate results.

figure('Name','Exercise 2.4.9. Gaussian Random Sequences');
stem(lags,Rg1g2,'b');
title('\Phi_{g_1}_{g_2}[n] = CrossCorr\{g1[n],g2[n]\}');
grid on;
