% Exercise 4.3.1. Downsampling.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Step (c). 
n=0:511;
x = cos(pi/32*n);

% Perform downsampling with a decimation factor M=3.
M = 3;
Samples = 126;

xT = x(1:Samples);
yT = my_downsample(xT,M);

n1 = 0:length(xT)-1;
n2 = 0:length(yT)-1;

% Plot the 2 signals.
figure('Name','Exercise 4.3.1. Downsampling');
subplot(2,2,1);
stem(n1, xT,'.');
title('{\itx_T}[n] = cos(\pin/32)');
axis tight;
grid on;

subplot(2,2,3);
stem(n2, yT,'r.');
title(['{\ity_T}[n] = {\itx_T}[n] \downarrow ',num2str(M)]);
axis tight;
grid on;

%% Calculate the DTFT's of the xT[n] and yT[n].
n1 = 0:length(xT)-1;
w1 = [-pi/4  pi/4];  % Frequency Range of interest.

[w  XT] = my_DTFT2(xT,n1,w1);

[w   YT]= my_DTFT2(yT,n2,w1);

%% Plot the DTFT magnitudes of xT[n] and yT[n]. Display only the frequency range of interest:
subplot(2,2,2);
plot(w,abs(XT),'r');
hold on;
line([-pi/32 -pi/32], [0 max(abs(XT))]);
line([ pi/32  pi/32], [0 max(abs(XT))]);
title('|{\itX_T}(j\omega)|');
set(gca,'XTick',-pi/4:pi/16:pi/4);
set(gca,'XTickLabel',{'-pi/4','-3pi/16','-pi/8','-pi/16','0','pi/16','pi/8','3pi/16','pi/4' });
xlim([-pi/4 pi/4]);
xlabel('\omega (rad/sample)');
axis tight;
grid on;

% The frequency of the downsampled cosine is M times the frequency of the
% original cosine. This may lead to aliasing in bandlimited signals.
subplot(2,2,4);
plot(w,abs(YT),'r');
hold on;
line([-M*pi/32 -M*pi/32], [0 max(abs(YT))]);
line([ M*pi/32  M*pi/32], [0 max(abs(YT))]);
title('|{\itY_T}(j\omega)|');
set(gca,'XTick',-pi/4:pi/16:pi/4);
set(gca,'XTickLabel',{'-pi/4','-3pi/16','-pi/8','-pi/16','0','pi/16','pi/8','3pi/16','pi/4' });
xlim([-pi/4 pi/4]);
xlabel('\omega (rad/sample)');
axis tight;
grid on;
