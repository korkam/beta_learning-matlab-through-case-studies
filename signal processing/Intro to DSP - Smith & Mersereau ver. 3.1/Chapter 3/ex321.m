% Exercise 3.2.1. Digital Filters.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.
clc; clear; close all;

%% Filter Definitions.
NSamples = 1024;
w = 0:pi/NSamples:pi;

% h1[n] is a FIR filter.
b1 = [ 0.036 -0.036 -0.29 0.56 -0.29 -0.036 +0.036];
a1 = 1;

% Plot its frequency response.
% All the frequency responses may be calculated using my_DTFT() as well.
figure('Name','Exercise 3.2.1. Digital Filters');
H1 = freqz(b1,a1,w);
subplot(3,1,1);
plot(w,20*log10(abs(H1)));
set(gca,'XTick',0:pi/4:pi);
set(gca,'XTickLabel',{'0','pi/4','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
xlim([0 pi]);
ylim([-80 5]);
ylabel('(dB)');
grid on;
title('20log(|{\itH_1}(j\omega)|)');
% It is a high-pass filter.

% h2[n] is a FIR filter.
b2 = [ -0.09 0.12 0.5 0.5 0.12 -0.09];
a2 = 1;
% Plot its frequency response.
H2 = freqz(b2,a2,w);
subplot(3,1,2);
plot(w,20*log10(abs(H2)));
set(gca,'XTick',0:pi/4:pi);
set(gca,'XTickLabel',{'0','pi/4','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
xlim([0 pi]);
ylim([-80 5]);
ylabel('(dB)');
grid on;
title('20log(|{\itH_2}(j\omega)|)');
% It is a low-pass filter.

% h3[n] is an IIR filter.
b3 = [0.11 0.27 0.37 0.27 0.11];
a3 = [1 -0.57 0.88 -0.26 0.09];
% Plot its frequency response.
H3 = freqz(b3,a3,w);
subplot(3,1,3);
plot(w,20*log10(abs(H3)));
set(gca,'XTick',0:pi/4:pi);
set(gca,'XTickLabel',{'0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([0 pi]);
ylim([-80 5]);
ylabel('(dB)');
grid on;
title('20log(|{\itY}(j\omega)|)');
% It is a low-pass filter.
