% Exercise 4.1.4. Commercial D/A Converters.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Signal Definition.
N = 200; % This number of samples corresponds to 1 full second of time.
n = 0:N;
x = sin(2*pi*n/16 + pi/10);

figure('Name','Exercise 4.1.4. Comercial D/A Converters');
subplot(2,1,1);
stem(n,x,'b.');
title('x[n] = sin(\pin/8 + \pi/10)');
grid on;

% Calculate the DTFT of x[n].
[w  X] = my_DTFT(x,n);

% Plot the DTFT magnitude of x[n].
subplot(2,1,2);
plot(w,abs(X),'r');
hold on;
title('|{\itX}(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' });
xlim([-pi pi]);
xlabel('Digital Frequency \omega (rad/sample)');
axis tight;
grid on;

%% Step (a). Convert the samples of the waveform x[n] to impulses spaced T = 5 msecs apart.
% Create another sequence to simulate the impluse train.
% Between each sample of y[n] we will insert 4 zeros in order to creat the 'analog' impluse train yc(t).
% This means that we took the decision to represent the continuous time interval of T = 5 msecs with 5 samples.
% This means that the true sampling period of the impulse train xs[n] is 1msec.

N = 5; % Upsampling factor.
xs = my_upsample(x,N);
L = length(xs);

t = (0:L-1)*1e-3; % Continuous (analog) time axis.
figure('Name','Exercise 4.1.4. Comercial D/A Converters');
subplot(2,1,1);
plot(t,xs);
title('Implulse Train {\itx_s}(t). Each weighted impulse is 5 milliseconds apart.');
xlabel('time (sec)');
axis tight;
grid on;

% Calculate the FT of xs(t).
Ts = 0.005; % The Sampling Period is 5 msecs.
Fs = 1/Ts;

subplot(2,1,2);
[Omega Xs] = my_CTFT(xs,Ts/5,'rad/sec');
plot(Omega,abs(Xs),'r');
xlabel('Analogue Frequency \Omega (rad/sec)');
grid on;
axis tight;
title('|{\itX_s}(\Omega)|');

 %%
ha = ones(1,5); % This simulates the impulse response of the D/A converter ha(t).
                             % We choose a block of 5 ones since we have chozen the time interval of
                             % T = 5 msec to be represented by 5 samples in 'analog' time.
xhat = conv(xs,ha);

figure('Name','Exercise 4.1.4. Comercial D/A Converters');
subplot(2,1,1);
plot(t,xhat(1:length(xs)));
title('D/A Output x_h_a_t(t)');
xlabel('time (sec)');
axis tight;
grid on;

subplot(2,1,2);
[Omega Xhat] = my_CTFT(xhat,Ts/5,'rad/sec');
plot(Omega,abs(Xhat),'r');
hold on;
title('|{\itX_h_a_t}(\Omega)| (red) and max(|{\itX_h_a_t}(\Omega)|)*|{\itHH}(\Omega|)| (green)');
xlabel('Analogue Frequency \Omega (rad/sec)');
grid on;
axis tight;

%% Step (c). Use the low-pass filter hh.
hh_b = [0.007170507 -0.01914651 0.03186915 -0.03505794 0.03186915 -0.01914651 0.007170507];
hh_a = [1 -4.716277 9.676021 -10.97638 7.236803 -2.623675 0.4082634];

% Plot its frequency response.
NSamples = 2048;
w = -pi:pi/NSamples:pi;
HH = freqz(hh_b,hh_a,w);

% figure(3);
% plot(w,20*log10(abs(HH)));
% set(gca,'XTick',-pi:pi/4:pi);
% set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' });
% xlim([-pi pi]);
% xlabel('Frequency (rad)');
% ylim([-100 5]);
% ylabel('(dB)');
% grid on;
% title('20log(|{\itHH}(j\omega)|)');

Omega1 = 5*w/Ts;  % Convert to analog frequency with appropriate scaling.
subplot(2,1,2);
plot(Omega1,max(abs(Xhat))*abs(HH),'g');
axis tight;

%% Step (c). Pass the impulse train xhat(t) through the low-pass filter to get the original analog signal ya(t).
xa = filter(hh_b,hh_a,xhat);

figure('Name','Exercise 4.1.4. Comercial D/A Converters');
subplot(2,1,1);
plot(t,xa(1:L));
title('{\itx_a}(t) = sin(25\pit+\pi/10)');
xlabel('time (sec)');
axis tight;
ylim([-1 1.025]);
grid on;

subplot(2,1,2);
[Omega Xa] = my_CTFT(xa,Ts/5,'rad/sec');
plot(Omega(2792:5402),abs(Xa(2792:5402)),'r');
title('|{\itX_a}(\Omega)|');
xlabel('Analogue Frequency \Omega (rad/sec)');
grid on;
axis tight;
