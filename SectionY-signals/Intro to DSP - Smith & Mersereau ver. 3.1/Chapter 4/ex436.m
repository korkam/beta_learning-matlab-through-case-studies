% Exercise 4.3.6. Interpolation.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Create a 64-point Chirp Signal.
n = 0:63;
ch = sin(0.4*n + 0.01*n.^2);

figure('Name','Exercise 4.3.6. Interpolation');
subplot(3,2,1);
stem(n,ch,'b.');
title('Chirp Signal ch[n]');
grid on;
axis tight;

%% Step (a). 
%Computation of an approximation of the DTFT{CH(jù)}:
[w CH] = my_DTFT(ch,n);

% Plot the magnitude of CH(jù):
subplot(3,2,2);
plot(w,abs(CH),'b');
title('|CH(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' });
xlabel('\omega (rad/sample)');
axis tight;
grid on;

%% Step (b). Upsample and interpolate the chirp signal by a factor L = 3.
L = 3;
y = my_upsample(ch,L);
ny = 0:length(y)-1;

subplot(3,2,3);
stem(ny,y,'r.');
title('y[n] = ch[n] \uparrow 3');
grid on;
axis tight;

% Calculate the DTFT of the upsampled signal y[n]:
[w  Y] = my_DTFT(y,ny);

% Plot the magnitude of Y(jù):
subplot(3,2,4);
plot(w,abs(Y),'r');
hold on;
set(gca,'XTick',[-pi -3*pi/4 -pi/2 -pi/3 -pi/4 0 pi/4 pi/3 pi/2 3*pi/4 pi]);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/3','-pi/4','0','pi/4','pi/3','pi/2','3pi/4','pi' });
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
ylim([0  11]);

%% Design a 65-point FIR lowpass filter with cutoff frequency pi/3.
% Use a Hamming window option.
nh = -32:32; 
wc = pi/3; % Cutoff frequency.
h = L*[sin(wc*(-32:-1))./(pi*(-32:-1)) wc/pi sin(wc*(1:32))./(pi*(1:32))]; % zero-phase low-pass FIR with cutoff at pi/3.
                                                                                                                     % and gain L.             
win = hamming(65).'; % 65-point symmetric Hamming window.

% Compute the DTFT of the tapered low-pass filter h*win:
[w  H] = my_DTFT(h.*win,nh);

% Plot the magnitude of H(jù):
subplot(3,2,4);
plot(w,abs(H)*max(abs(Y))/L,'g');
title('|Y(j\omega)| = |DTFT\{ch[n]\uparrow3\}| and low-pass filter |H(j\omega)| (green)');
grid on;

% Interpolate the upsampled sequence y[n] using the tapered low-pass filter.
[nyf yfilt] = my_conv(y,h.*win,ny,nh); 
 
subplot(3,2,5);
stem(nyf,yfilt,'m.');
title('y_{filtered}[n] = y[n]\ast(h[n]*win_{hamm}[n])');
grid on;
axis tight;

[w YFILT] = my_DTFT(yfilt,nyf);

% Plot the magnitude of YFILT(jù):
subplot(3,2,6);
plot(w,abs(YFILT),'m');
title('|Y_{filtered}(j\omega)|: spectral images removed after low-pass filtering at \pi/3');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' });
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;
