% Exercise 2.4.7. Cross-Correlation.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Signal Definitions.
N = 32;
n = -N:N;
x = randn(1,2*N+1);

M = 14;
h = [sin(2*pi/3.*(-7:-1))./(pi.*(-7:-1)) 2/3 sin(2*pi/3.*(1:7))./(pi.*(1:7)) ]; % time index runs from 0 to 14;
win = hamming(15);

figure('Name',' Exercise 2.4.7. Cross-Correlation');
subplot(2,1,1);
stem(0:M,h,'*');
grid on;
axis tight;
title('15-point low-pass filter h[n] shifted by 7 samples to the right');

NSamples = 1024;
w = 0:pi/NSamples:pi;
H1 = freqz(h,1,w);
subplot(2,1,2);
plot(w,20*log10(abs(H1)));
set(gca,'XTick',[0 pi/3 2*pi/3 pi]);
set(gca,'XTickLabel',{'0','pi/3','2*pi/3','pi' })
ylabel('(dB)');
grid on;
axis tight;
title('20log(|{\itH}(j\omega)|) with 15-point Hamming window');

u = conv(x,h);

figure('Name',' Exercise 2.4.7. Cross-Correlation');
subplot(2,1,1);
stem(n,x);
grid on;
hold on;
axis tight;

m = -N:N+M; % for u[n] the time index runs -N:N+M;
subplot(2,1,1);
stem(m,u,'r.'); 
grid on;
axis tight;
title('x[n] (blue) and low-pass filtered version \upsilon[n] = x[n]\asth[n] (red)');


%% a. Calculate the cross-correlation function between x[n] and u[n]:

% for u[-n] the time index runs from -(N+M):N.
Cc = conv(x,fliplr(u));

% for cross correlation of x[n] and u[n] = conv(x[n],u[-n]) the time index
% runs from -(N+M)-N to N+N.
l = -(N+M)-N:2*N;
subplot(2,1,2);
stem(l,Cc,'g*');
grid on;
axis tight;
title('\Phi_x_\upsilon[n] = CrossCorr(x[n],\upsilon[n]) = x[n]\ast\upsilon[-n]');

%% b. Quantize the sequences into binary sequences.
xb = zeros(size(x));
ub = zeros(size(u));

for i=1:length(x)
    if x(i)>=0
        xb(i) = 1;
    else
        xb(i) = -1;
    end
end

for i=1:length(u)
    if u(i)>=0
        ub(i) = 1;
    else
        ub(i) = -1;
    end
end

figure('Name',' Exercise 2.4.7. Cross-Correlation');
subplot(2,1,1);
stem(n,xb);
grid on;
hold on;
axis tight;

m = -N:N+M; % for u[n] the time index runs -N:N+M;
subplot(2,1,1);
stem(m,ub,'r.'); 
grid on;
axis tight;
title('x_b_i_n[n] (blue) and \upsilon_b_i_n[n] (red)');

% Calculate the cross-correlation function between xb[n] and ub[n]:
% for ub[-n] the time index runs from -(N+M):N.
Ccb = conv(xb,fliplr(ub));

% for cross correlation of xb[n] and ub[n] = conv(xb[n],ub[-n]) the time index
% runs from -(N+M)-N to N+N.
l = -(N+M)-N:2*N;
subplot(2,1,2);
stem(l,Ccb,'g*');
grid on;
axis tight;
title('\Phi_x_\upsilon_b_i_n[n] = CrossCorr(x_b_i_n[n],\upsilon_b_i_n[n]) = x_b_i_n[n]\ast\upsilon_b_i_n[-n]');

%% c. Calculate the cross-correlation of 2 random signals.
y = randn(1,2*N+1);

% for y[-n] the time index runs from -N:N.
Cc1 = conv(x,fliplr(y));

% for cross correlation of x[n] and y[n] the time index
% runs from -2N to 2N.
figure('Name',' Exercise 2.4.7. Cross-Correlation');
l = -2*N:2*N;
stem(l,Cc1,'g*');
grid on;
axis tight;
title('\Phi_x_y[n] = CrossCorr(x[n],y[n]) = x[n]\asty[-n]');


