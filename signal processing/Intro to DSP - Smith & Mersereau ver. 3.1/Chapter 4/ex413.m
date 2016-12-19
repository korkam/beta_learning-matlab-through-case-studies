% Exercise 4.1.3. Ideal Reconstruction (Frequency Domain).

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear;  close all;

%% Step (a). Generate 5 periods of a triangular wave y[n] with a period of 20 beginning at n = 0.
n = 0:99;
Period = 20;
A = 1;
half_triangle = 2*A*(0:Period/2)/Period;
        triangle = [ half_triangle  fliplr(half_triangle(2:end-1))];
y = [ triangle triangle triangle triangle triangle];

figure('Name','Exercise 4.1.3. Ideal reconstruction (Frequency Domain)');
subplot(2,1,1);
stem(n,y,'b.');
title('y[n]');
grid on;

% Calculate the DTFT of y[n].
[w  Y] = my_DTFT(y,n);

% Plot the DTFT magnitude of y[n].
subplot(2,1,2);
plot(w,abs(Y),'r');
hold on;
title('|{\itY}(j\omega)|');
set(gca,'XTick',[-pi:pi/4:-pi/4 -pi/10 0 pi/10 pi/4:pi/4:pi]);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','-pi/10','0','pi/10','pi/4','pi/2','3pi/4','pi' });
xlabel('Digital Frequency \omega (rad/sample)');
axis tight;
grid on;

%% Step (b). Convert the samples of the triangular waveform y[n] to impulses spaced T = 5 msecs apart.
% Create another sequence to simulate the impluse train.
% Between each sample of y[n] we will insert 4 zeros in order to create the 'analog' impluse train yc(t):
% This is equivalent to upsampling y[n] by a factor of 5. 
% This means that we took the decision to represent the continuous time interval of T = 5 msecs with 5 samples.
% This means that the true sampling period of the impulse train xs[n] is 1 msec or Ts/5.

% Upsample the triangular waveform y[n] by a factor of 5:
N = 5;
yc = my_upsample(y,N);
L = length(yc);

Ts = 5e-3; % The Nominal Sampling Period is 5 msecs.
Fs = 1/Ts;

t = (0:L-1)*Ts/5; % Continuous (analog) time axis.
figure('Name','Exercise 4.1.3. Ideal reconstruction (Frequency Domain)');
subplot(2,1,1);
plot(t,yc);
title('Implulse Train {\ity_c}(t). Each weighted impulse is 5 milliseconds apart.');
xlabel('time (sec)');
axis tight;
grid on;

% Calculate and Plot the continuous FT magnitude of yc(t).
[Omega Yc] = my_CTFT(yc,Ts/5,'rad/sec');
subplot(2,1,2);
plot(Omega,abs(Yc),'r');
hold on;
grid on;
title('|Y_c(\Omega)| (red) and max(|Y_c(\Omega)|)*|HH(\Omega)| (green)');
axis tight;

%% Step (c). Use the low-pass filter hh. Note: filter hh is actually an IIR digital filter.
% the testbook's command "x afilter" uses this digital filter to simulate the needed analog filter ha(t).
% Here we perform all the operations in the digital domain.
hh_b = [0.007170507 -0.01914651 0.03186915 -0.03505794 0.03186915 -0.01914651 0.007170507];
hh_a = [1 -4.716277 9.676021 -10.97638 7.236803 -2.623675 0.4082634];

% Calculate and plot its frequency response:
HH = freqz(hh_b,hh_a,w);

% figure('Name','Exercise 4.1.3. Ideal reconstruction (Frequency Domain)');
% plot(w,20*log10(abs(HH)));
% set(gca,'XTick',-pi:pi/4:pi);
% set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' });
% xlabel('Digital Frequency \omega (rad)');
% axis tight;
% ylim([-100 5]);
% ylabel('(dB)');
% grid on;
% title('20log(|{\itHH}(j\omega)|)');

Omega1 = 5*w/Ts;  % Analog Frequency denormalization.
subplot(2,1,2);
plot(Omega1,max(abs(Yc))*abs(HH),'g');
axis tight;
xlabel('Analogue Frequency \Omega (rad/sec)');
ylim([-1 55]);

%% Pass the impulse train yc(t) through the low-pass filter to get the original analog signal ya(t).
Gain = 5;  % For an explanation of this, see the description of an interpolator at page 99.
ya = Gain*filter(hh_b,hh_a,yc);

figure('Name','Exercise 4.1.3. Ideal reconstruction (Frequency Domain)');
subplot(2,1,1);
plot(t,ya);
ylim([-0.1 1.1]);
title('{\ity_a}(t)');
grid on;

% Calculate and Plot the magnitude F{ya(t)}.
[Omega  Ya] = my_CTFT(ya/Gain,Ts/5,'rad/sec');

subplot(2,1,2);
plot(Omega(1396:2702),abs(Ya(1396:2702)),'r');
title('|Y_a(\Omega)|');
xlabel('Analogue Frequency \Omega (rad/sec)');
axis tight;
grid on;
