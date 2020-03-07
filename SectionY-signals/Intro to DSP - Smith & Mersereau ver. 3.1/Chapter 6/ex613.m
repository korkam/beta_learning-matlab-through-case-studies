% Exercise 6.1.3. Zero Padding.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Step (a). Design a 16-point low-pass filter h[n] with cutoff ð/2.
n=1:15;
w0 = pi/2;
h = [w0/pi sin(w0*n)./(pi.*n)];

% Computation of an approximation of the DTFT of h[n]:
[w  H] = my_DTFT(h,0:15);

% Now compute the 16-point DFT of h[n]: 
Samples = 16;
H1 = my_DFT(h); 
 
%% Plot the results.
figure('Name','Exercise 6.1.3. Zero Padding'); 
% Plot the DTFT magnitude of h[n]:
subplot(3,1,1);
plot(w,abs(H));
title('|H(j\omega)| = |DTFT\{h[n]\}|');
hold on;
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('Digital Frequncy \omega (rad/sample)');
xlim([-pi pi]);
ylim([0 1]);
grid on;

% Plot the DFT magnitude of h[n]:
k = 0:Samples - 1;
subplot(3,1,2);
stem(k,abs(H1),'.');
title('|H_1[k]|  = |DFT\{h[n]\}|');
xlabel('Frequency Sample Number k');
ylim([0 1]);
grid on;

subplot(3,1,3);
plot(w(1025:end),abs(H(1025:end)));
title(['|H(j\omega)| and |H_1[k]|, \Delta\omega = ',num2str(2*pi/Samples),' rad/sample' ]);
hold on;
set(gca,'XTick',0:pi/4:pi);
set(gca,'XTickLabel',{'0','pi/4','pi/2','3pi/4','pi' })
xlim([0 pi]);
ylim([0 1]);
grid on;

% The DFT is a sampled version of DTFT at the frequencies wi = 2*pi*k/N.

wi = 2*pi*k/Samples;  % Generate the frequencies where the DTFT is sampled.

subplot(3,1,3);
stem(wi,abs(H1),'rx');
xlabel('Digital Frequency \omega (rad/sample)');

%% Step (b). Embed this sequence h[n] into a 64-point sequence y[n].
Samples = 64;
y = [h zeros(1,48)];

% Now compute the 64-point DFT of h[n]: 
H2 = my_DFT(y); 
 
% Plot the results.
figure('Name','Exercise 6.1.3. Zero Padding');
% Plot the DTFT magnitude of h[n]:
subplot(3,1,1);
plot(w,abs(H));
title('|H(j\omega)| = |DTFT\{h[n]\}|');
hold on;
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('Digital Frequency \omega (rad/sample)');
xlim([-pi pi]);
ylim([0 1]);
grid on;

% Plot the DFT magnitude of y[n]:
k = 0:Samples - 1;
subplot(3,1,2);
stem(k,abs(H2),'.');
title('|H_2[k]|  = |DFT\{[h zeros(1,48)]\}|');
xlabel('Frequency Sample Number k');
ylim([0 1]);
xlim([0 max(k)]);
grid on;

subplot(3,1,3);
plot(w(1025:end),abs(H(1025:end)));
title(['|H(j\omega)| and |H_2[k]|, \Delta\omega = ',num2str(2*pi/Samples),' rad/sample' ]);
hold on;
set(gca,'XTick',0:pi/4:pi);
set(gca,'XTickLabel',{'0','pi/4','pi/2','3pi/4','pi' })
xlim([0 pi]);
ylim([0 1]);
grid on;

% The DFT is a sampled version of DTFT at the frequencies wi = 2*pi*k/N.

wi = 2*pi*k/Samples;  % Generate the frequencies where the DTFT is sampled.
                                      % Apparently due to increased N (samples) the resolution
                                      % of DFT increases. 

subplot(3,1,3);
stem(wi,abs(H2),'rx');
xlabel('Digital Frequency \omega (rad/sample)');

%% Step (c). Embed this sequence h[n] into a 256-point sequence y[n].
Samples = 256;
y2 = [h zeros(1,240)];

% Now compute the 256-point DFT of y2[n]: 
H3 = my_DFT(y2); 

% Plot the results.
figure('Name','Exercise 6.1.3. Zero Padding');
% Plot the DTFT magnitude of h[n]:
subplot(3,1,1);
plot(w,abs(H));
title('|H(j\omega)| = |DTFT\{h[n]\}|');
hold on;
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('Digital Frequency \omega (rad/sample)');
xlim([-pi pi]);
ylim([0 1]);
grid on;

% Plot the DFT magnitude of y2[n]:
k = 0:Samples - 1;
subplot(3,1,2);
stem(k,abs(H3),'.');
title('|H_3[k]|  = |DFT\{[h zeros(1,240)]\}|');
xlabel('Frequency Sample Number k');
ylim([0 1]);
xlim([0 max(k)]);
grid on;

subplot(3,1,3);
plot(w(1025:end),abs(H(1025:end)));
title(['|H(j\omega)| and |H_3[k]|, \Delta\omega = ',num2str(2*pi/Samples),' rad/sample' ]);
hold on;
set(gca,'XTick',0:pi/4:pi);
set(gca,'XTickLabel',{'0','pi/4','pi/2','3pi/4','pi' })
xlim([0 pi]);
ylim([0 1]);
grid on;

% The DFT is a sampled version of DTFT at the frequencies wi = 2*pi*k/N.
wi = 2*pi*k/Samples;  % Generate the frequencies where the DTFT is sampled.
                                      % Apparently due to increased N (samples) the resolution
                                      % of DFT increases. 

subplot(3,1,3);
stem(wi,abs(H3),'rx');
xlabel('Digital Frequency \omega (rad/sample)');
