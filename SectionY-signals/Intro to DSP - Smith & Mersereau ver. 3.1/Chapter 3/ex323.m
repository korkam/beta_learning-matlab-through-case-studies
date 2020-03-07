% Exercise 3.2.3. Filter Design.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.
NSamples = 1024;
w = 0:pi/NSamples:pi;
w0 = pi/3; % Cutoff frequency.

%% Step (a). Design a 32-point and a 64-point lowpass FIR filters with cutoff frequency ð/3.
% h1[n].
b1 = [ sin(w0.*(-16:-1))./(pi.*(-16:-1)) 1/3 sin(w0.*(1:15))./(pi.*(1:15)) ].';
a1 = 1;

% h2[n]
b2 = [ sin(w0.*(-32:-1))./(pi.*(-32:-1)) 1/3 sin(w0.*(1:31))./(pi.*(1:31)) ].';
a2 = 1;

win21 = hann(32);
win22 = hann(64);

win31 = hamming(32);
win32 = hamming(64);

% All the frequency responses may be calculated using my_DTFT.m as well.
figure('Name',' Exercise 3.2.3. Filter Design');
H1 = freqz(b1,a1,w);
subplot(3,2,1);
plot(w,20*log10(abs(H1)));
set(gca,'XTick',[0 pi/3 pi/2 3*pi/4 pi]);
set(gca,'XTickLabel',{'0','pi/3','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
xlim([0 pi]);
ylim([-60 5]);
ylabel('(dB)');
grid on;
title('20log(|{\itH_1}(j\omega)|) with 32-point rectangular window applied');

H11 = freqz(b1.*win21,a1,w);
subplot(3,2,3);
plot(w,20*log10(abs(H11)));
set(gca,'XTick',[0 pi/3 pi/2 3*pi/4 pi]);
set(gca,'XTickLabel',{'0','pi/3','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
xlim([0 pi]);
ylim([-100 5]);
ylabel('(dB)');
grid on;
title('20log(|{\itH_1}(j\omega)|) with 32-point Hanning window applied');

H12 = freqz(b1.*win31,a1,w);
subplot(3,2,5);
plot(w,20*log10(abs(H12)));
set(gca,'XTick',[0 pi/3 pi/2 3*pi/4 pi]);
set(gca,'XTickLabel',{'0','pi/3','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([0 pi]);
ylim([-80 5]);
ylabel('(dB)');
grid on;
title('20log(|{\itH_1}(j\omega)|) with 32-point Hamming window applied');

H2 = freqz(b2,a2,w);
subplot(3,2,2);
plot(w,20*log10(abs(H2)));
set(gca,'XTick',[0 pi/3 pi/2 3*pi/4 pi]);
set(gca,'XTickLabel',{'0','pi/3','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
xlim([0 pi]);
ylim([-60 5]);
ylabel('(dB)');
grid on;
title('20log(|{\itH_2}(j\omega)|) with 64-point rectangular window applied');

H21 = freqz(b2.*win22,a1,w);
subplot(3,2,4);
plot(w,20*log10(abs(H21)));
set(gca,'XTick',[0 pi/3 pi/2 3*pi/4 pi]);
set(gca,'XTickLabel',{'0','pi/3','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
xlim([0 pi]);
ylim([-100 5]);
ylabel('(dB)');
grid on;
title('20log(|{\itH_2}(j\omega)|) with 64-point Hanning window applied');

H22 = freqz(b2.*win32,a1,w);
subplot(3,2,6);
plot(w,20*log10(abs(H22)));
set(gca,'XTick',[0 pi/3 pi/2 3*pi/4 pi]);
set(gca,'XTickLabel',{'0','pi/3','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([0 pi]);
ylim([-80 5]);
ylabel('(dB)');
grid on;
title('20log(|{\itH_2}(j\omega)|) with 64-point Hamming window applied');
