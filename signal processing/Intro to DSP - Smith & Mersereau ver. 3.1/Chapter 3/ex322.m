% Exercise 3.2.2. Time-Domain Filter Characteristics.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.
n = -16:16;
NSamples = 1024;
w = 0:pi/NSamples:pi;

%% Step (a). Design four FIR 33-point lowpass filters with cutoff frequencies ð/2, ð/4, ð/6 and ð/8.
% h1[n].
b1 = [ sin(pi/2.*(-16:-1))./(pi.*(-16:-1)) 1/2 sin(pi/2.*(1:16))./(pi.*(1:16)) ];
a1 = 1;

figure('Name','Exercise 3.2.2. Time-Domain Filter Characteristics');
subplot(4,3,1);
stem(n,b1,'b.');
title('{\ith_1}[n]');
grid on;
axis tight;

H1 = freqz(b1,a1,w);
subplot(4,3,2);
plot(w,20*log10(abs(H1)));
set(gca,'XTick',0:pi/4:pi);
set(gca,'XTickLabel',{'0','pi/4','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
xlim([0 pi]);
ylim([-60 5]);
ylabel('(dB)');
grid on;
title('20log(|{\itH_1}(j\omega)|)');


%% h2[n].
b2 = [ sin(pi/4.*(-16:-1))./(pi.*(-16:-1)) 1/4 sin(pi/4.*(1:16))./(pi.*(1:16)) ];
a2 = 1;

subplot(4,3,4);
stem(n,b2,'b.');
grid on;
axis tight;
title('{\ith_2}[n]');

subplot(4,3,5);
H2 = freqz(b2,a2,w);
plot(w,20*log10(abs(H2)));
set(gca,'XTick',0:pi/4:pi);
set(gca,'XTickLabel',{'0','pi/4','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
xlim([0 pi]);
ylim([-60 5]);
ylabel('(dB)');
grid on;
title('20log(|{\itH_2}(j\omega)|)');

%% h3[n].
b3 = [ sin(pi/6.*(-16:-1))./(pi.*(-16:-1)) 1/6 sin(pi/6.*(1:16))./(pi.*(1:16)) ];
a3 = 1;

subplot(4,3,7);
stem(n,b3,'b.');
grid on;
axis tight;
title('{\ith_3}[n]');

subplot(4,3,8);
H3 = freqz(b3,a3,w);
plot(w,20*log10(abs(H3)));
set(gca,'XTick',[0 pi/6 pi/4 pi/2 3*pi/4 pi]);
set(gca,'XTickLabel',{'0','pi/6','pi/4','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
xlim([0 pi]);
ylim([-60 5]);
ylabel('(dB)');
grid on;
title('20log(|{\itH_3}(j\omega)|)');

%% h4[n].
b4 = [ sin(pi/8.*(-16:-1))./(pi.*(-16:-1)) 1/8 sin(pi/8.*(1:16))./(pi.*(1:16)) ];
a4 = 1;

subplot(4,3,10);
stem(n,b4,'b.');
grid on;
axis tight;
title('{\ith_4}[n]');

subplot(4,3,11);
H4 = freqz(b4,a4,w);
plot(w,20*log10(abs(H4)));
set(gca,'XTick',[0 pi/8 pi/4 pi/2 3*pi/4 pi]);
set(gca,'XTickLabel',{'0','pi/8','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([0 pi]);
ylim([-60 5]);
ylabel('(dB)');
grid on;
title('20log(|{\itH_4}(j\omega)|)');

%% Step (b). Plot the step responses of these filters.
u = ones(100,1); % approximation of a unit step.

y1 = filter(b1,a1,u);
y2 = filter(b2,a2,u);
y3 = filter(b3,a3,u);
y4 = filter(b4,a4,u);

subplot(4,3,3);
stem(y1(1:50),'r.');
title('y_1[n] = h_1[n]\astu[n]');
ylim([-.15 1.15]);
grid on;
axis tight;

subplot(4,3,6);
stem(y2(1:50),'r.');
title('y_2[n] = h_2[n]\astu[n]');
ylim([-.15 1.15]);
grid on;
axis tight;

subplot(4,3,9);
stem(y3(1:50),'r.');
title('y_3[n] = h_3[n]\astu[n]');
ylim([-.15 1.15]);
grid on;
axis tight;

subplot(4,3,12);
stem(y4(1:50),'r.');
title('y_4[n] = h_4[n]\astu[n]');
ylim([-.15 1.15]);
grid on;
axis tight;
