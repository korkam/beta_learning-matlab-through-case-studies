% Exercise 6.5.1. The Zero-Phase DFT.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace initialization.

clc; clear; close all;

%% a. Use the function zero_phase_dft() to compute the DFT's of a 15-point 
% zero-phase, noncausal lowpass and highpass filters.

% Create a low-pass filter with cut-off frequency pi/6 first and then convert it to it's high-pass conjugate.
% Rectangular windows are used.
M = 63; % This is the total size of the sequence.
w0 = pi/3; % Cutoff frequency selection. 
h_low   = [ sin(w0.*(-(M-1)/2:-1))./(pi.*(-(M-1)/2:-1)) w0/pi sin(w0.*(1:(M-1)/2))./(pi.*(1:(M-1)/2)) ];
h_high = firlp2hp(h_low);

H_low  = my_DFT(h_low);
H_high = my_DFT(h_high);

[h1_low     H1_low ] = zero_phase_dft(h_low);
[h1_high   H1_high] = zero_phase_dft(h_high);

%% Plot the sequences and their phases:
figure('Name','Exercise 6.5.1. The Zero-Phase DFT');
n0 = -(M-1)/2:(M-1)/2;
subplot(4,2,1);
stem(n0,h_low,'.');
title('h_{low}[n]  (noncausal)');
xlabel('Sample Number n');
axis tight;
grid on;

n1 = 0:M-1;
subplot(4,2,3);
stem(n1,h1_low,'g.');
title('h_{low}^{~~~}[n] (causal)');
xlabel('Sample Number n');
axis tight;
grid on;

subplot(4,2,5);
stem(n0,h_high,'.');
title('h_{high}[n] (noncausal)');
xlabel('Sample Number n');
axis tight;
grid on;

subplot(4,2,7);
stem(n1,h1_high,'g.');
title('h_{high}^{~~~}[n] (causal)');
xlabel('Sample Number n');
axis tight;
grid on;

k = 0:M-1;
subplot(4,2,2);
stem(k,mod(unwrap(angle(H_low)),2*pi),'.');
title('\angleH_{low}[k]');
xlabel('Frequency Sample Number k');
axis tight;
grid on;

subplot(4,2,4);
stem(k,mod(unwrap(angle(H1_low)),2*pi),'.');
title('\angleH_{low}^{~~~}[k]  is zero in passband');
xlabel('Frequency Sample Number k');
axis tight;
grid on;

subplot(4,2,6);
stem(k,mod(unwrap(angle(H_high)),2*pi),'.');
title('\angleH_{high}[k]');
xlabel('Frequency Sample Number k');
axis tight;
grid on;

subplot(4,2,8);
stem(k,mod(unwrap(angle(H1_high)),2*pi),'g.');
title('\angleH_{high}^{~~~}[k] is zero in passband');
xlabel('Frequency Sample Number k');
axis tight;
grid on;

%% Plot its frequency response.
[w H1] = my_DTFT2(h_low,n0,[0 pi]);

% Plot the real and imaginary parts of the 2 zero-phase transforms.
figure('Name','Exercise 6.5.1. The Zero-Phase DFT');
subplot(2,2,1);
plot(w,20*log10(abs(H1)));
set(gca,'XTick',0:pi/6:pi);
set(gca,'XTickLabel',{'0','pi/6','pi/3','pi/2','2pi/3','5pi/6','pi' })
xlim([0 pi]);
ylim([-70 5]);
ylabel('(dB)');
xlabel('\omega (rad/sample)');
grid on;
title('20log(|H_{low}(j\omega)|)');

subplot(2,2,3);
plot(w,unwrap(angle(H1)));
set(gca,'XTick',0:pi/6:pi);
set(gca,'XTickLabel',{'0','pi/6','pi/3','pi/2','2pi/3','5pi/6','pi' })
xlabel('\omega (rad/sample)');
xlim([0 pi]);
grid on;
title('\angleH_{low}(j\omega) is zero in passband');

k = 0:M-1;
subplot(2,2,2);
stem(k,real(H1_low),'.');
title('\Ree\{H_{low}[k]\}');
xlabel('Sample Number k');
axis tight;
grid on;
hold on;

subplot(2,2,4);
stem(k,imag(H1_low),'r.');
title('\Imm\{H_{low}[k]\}');
xlabel('Sample Number k');
axis tight;
grid on;
hold on;

figure('Name','Exercise 6.5.1. The Zero-Phase DFT');

%% Calculate and Plot its frequency response.
[w H2] = my_DTFT2(h_high,n0,[0 pi]);

subplot(2,2,1);
plot(w,20*log10(abs(H2)));
set(gca,'XTick',0:pi/6:pi);
set(gca,'XTickLabel',{'0','pi/6','pi/3','pi/2','2pi/3','5pi/6','pi' })
xlim([0 pi]);
ylim([-70 5]);
ylabel('(dB)');
xlabel('\omega (rad/sample)');
grid on;
title('20log(|H_{high}(j\omega)|)');
% It is a high-pass filter.

subplot(2,2,3);
plot(w,unwrap(angle(H2)));
set(gca,'XTick',0:pi/6:pi);
set(gca,'XTickLabel',{'0','pi/6','pi/3','pi/2','2pi/3','5pi/6','pi' })
xlabel('\omega (rad/sample)');
xlim([0 pi]);
grid on;
title('\angleH_{high}(j\omega) is zero in passband');

k = 0:M-1;
subplot(2,2,2);
stem(k,real(H1_high),'.');
title('\Ree\{H_{high}[k]\}');
xlabel('Sample Number k');
axis tight;
grid on;
hold on;

subplot(2,2,4);
stem(k,imag(H1_high),'r.');
title('\Imm\{H_{high}[k]\}');
xlabel('Sample Number k');
axis tight;
grid on;
hold on;

%% b. Zeropad a 15-point symmetric sequence and then take its FFT to approximate the DTFT.
M1 = 512;
[y  Y] = zero_phase_dtft(h_low,M1);

figure('Name','Exercise 6.5.1. The Zero-Phase DTFT');
w1 = 0:2*pi/M1:pi-pi/M1;
% Plot its magnitude
subplot(2,2,1);
plot(w1,20*log10(abs(Y)));
set(gca,'XTick',0:pi/6:pi);
set(gca,'XTickLabel',{'0','pi/6','pi/3','pi/2','2pi/3','5pi/6','pi' })
xlabel('\omega (rad/sample)');
xlim([0 pi]);
ylim([-70 5]);
ylabel('(dB)');
grid on;
title('20log(|Y(j\omega)|)');
% It is a low-pass filter.

subplot(2,2,3);
plot(w1,unwrap(angle(Y)));
set(gca,'XTick',0:pi/6:pi);
set(gca,'XTickLabel',{'0','pi/6','pi/3','pi/2','2pi/3','5pi/6','pi' })
xlabel('\omega (rad/sample)');
xlim([0 pi]);
grid on;
title('\angleY(j\omega) is zero in passband');

subplot(2,2,2);
plot(w1,real(Y));
set(gca,'XTick',0:pi/6:pi);
set(gca,'XTickLabel',{'0','pi/6','pi/3','pi/2','2pi/3','5pi/6','pi' })
xlabel('\omega (rad/sample)');
xlim([0 pi]);
grid on;
title('\Ree\{Y(j\omega)\}');

subplot(2,2,4);
plot(w1,imag(Y));
set(gca,'XTick',0:pi/6:pi);
set(gca,'XTickLabel',{'0','pi/6','pi/3','pi/2','2pi/3','5pi/6','pi' })
xlabel('\omega (rad/sample)');
xlim([0 pi]);
grid on;
title('\Imm\{Y(j\omega)\}');
