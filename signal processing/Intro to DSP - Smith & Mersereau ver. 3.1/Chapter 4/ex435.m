% Exercise 4.3.5. Decimation and Aliasing.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Signal Definition.
gg = [ 0.00307787 0.001838499 0.0009756996 0.02195124 0.06561216 ...
           0.09 0.06561216 0.02195124 0.0009756996 0.001838499 0.00307787];

ngg = 0:10; % signal gg[n] runs from n = 0 to 10;

%% Step (a). 
% Computation of an approximation of GG(jù):
[w GG] = my_DTFT(gg,ngg);

% Plot the magnitude and the phase of GG(jù):
figure('Name','Exercise 4.3.5. Decimation and Aliasing');
subplot(2,2,1);
plot(w,abs(GG),'b');
title('|GG(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
ylim([0 .3]);
grid on;

% Downsample gg[n] by a factor N = 3.
N = 3;
gg_d = my_downsample(gg,N);

n1 = 0:length(gg_d)-1; % decimated signal gg_d[n] runs from n1 = 0 to 3.
[wn GGD] = my_DTFT2(gg_d,n1,[-2*pi 2*pi]); 

% Plot the magnitude of GGD(jù):
subplot(2,2,3);
plot(wn,abs(GGD),'b');
hold on;
title('|DTFT\{gg[n]\downarrow3\}| aliasing due to downsampling w/o low-pass prefiltering');
set(gca,'XTick',-2*pi:pi/2:2*pi);
set(gca,'XTickLabel',{'-2pi','-3pi/2','-pi','-pi/2','0', 'pi/2','pi','3pi/2','2pi' });
xlabel('\omega (rad/sample)');
grid on;

% Also plot the adding spectral components (replicas) using (4.10).
GGreplica = 1/N*GG; 

% We must calculate the correct frequency range for each replica.
w0 = wn;                 % this corresponds to r=0 in (4.10);
w1 = wn + 2*pi;      % this corresponds to r=1 in (4.10);
w2 = wn -  2*pi;      % this corresponds to r=2 in (4.10);

 plot(w0, abs(GGreplica),'r');
 plot(w1, abs(GGreplica),'k');
 plot(w2, abs(GGreplica),'m');
 xlim([-2*pi 2*pi]);
 xlabel('\omega (rad/sample)');
  
%% Step (b). Design a 201-point FIR lowpass filter with cutoff frequency pi/3.
% Use a Hamming window option.
nh = -100:100;
N1 = 3.15;
h = [ sin(pi/N1*(-100:-1))./(pi*(-100:-1)) 1/N1 sin(pi/N1*(1:100))./(pi*(1:100))]; % low-pass FIR with cutoff at pi/N.
win = hamming(201).'; % 201-point symmetric Hamming window.

[n2 gg_filt] = my_conv(gg,h.*win,ngg,nh); % Filter the sequence gg[n] using the tapered low-pass filter.

% Calculate the DTFT of the pre-filtered signal: 
[w GG_FILT] = my_DTFT(gg_filt,n2); %#ok<*ASGLU>

% Downsample the filtered sequence gg_filt[n] by a factor N = 3.
gg_filt_d = my_downsample(gg_filt,N);

n3 = 0:length(gg_filt_d)-1;
[w GG_FILT_D] = my_DTFT(gg_filt_d,n3);

%% Plot the magnitude of GG_FILT(jù):
subplot(2,2,2);
plot(w,abs(GG_FILT),'b');
hold on;
line([-pi/N -pi/N],  [0 max(abs(GG_FILT))],'Color','g');
line([ pi/N   pi/N], [0 max(abs(GG_FILT))],'Color','g');
line([ -pi/N  pi/N], [max(abs(GG_FILT)) max(abs(GG_FILT))],'Color','g');
title('|GG_{FILTERED}(j\omega)|');
set(gca,'XTick',[-pi -3*pi/4 -pi/2 -pi/3 -pi/4 0 pi/4 pi/3 pi/2 3*pi/4 pi]);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/3','-pi/4','0','pi/4','pi/3','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
axis tight;
ylim([0 0.3]);
grid on;

subplot(2,2,4);
plot(w,abs(GG_FILT_D),'c');
title('|DTFT\{gg_{filt}[n]\downarrow 3\}| aliasing not present after low-pass prefiltering at \pi/3');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
ylim([0 0.1]);
xlim([-pi  pi]);
xlabel('\omega (rad/sample)');
grid on;
