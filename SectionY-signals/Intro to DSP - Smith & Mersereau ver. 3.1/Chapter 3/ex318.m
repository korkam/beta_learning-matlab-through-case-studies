% Exercise 3.1.8. The Convolution Property.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Signal Definitions.
n = -7:7; % signal ee starts at n=-7.
ee = [  3.263941e-5  -6.037312e-4  2.971067e-3  -9.563761e-3  2.457258e-2  -5.702938e-2  1.466156e-1  0 ... 
          -1.466156e-1    5.702938e-2 -2.457258e-2   9.563761e-3 -2.971067e-3   6.037312e-4   -3.263941e-5 ];

n1 = 0:8; % signal ff starts at n=0.
ff = [0.029515 0.08774473 0.1672274 0.2398594 0.2715347 0.2398594 0.1672274 0.08774473 0.029515];

%% Step (a).  Calculate and Plot the magnitude and phase of EE(jù), FF(jù) and EE(jù)*FF(jù)

% Computation of an approximation of the DTFT of ee[n]:
[w EE] = my_DTFT(ee,n);

% Plot the magnitude and the phase of the EE(jù):
figure('Name','Exercise 3.1.8. The Convolution Property');
subplot(4,2,1);
plot(w,abs(EE));
title('|EE(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
axis tight;
xlim([-pi pi]);
grid on;

subplot(4,2,2);
plot(w,unwrap(angle(EE)),'r');
title('{\angle}EE(j\omega)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

% Computation of an approximation of FF(jù):
[w FF] = my_DTFT(ff,n1);

% Plot the magnitude and the phase of FF(jù):
subplot(4,2,3);
plot(w,abs(FF),'b');
title('|FF(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
axis tight;
xlim([-pi pi]);
grid on;

subplot(4,2,4);
plot(w,unwrap(angle(FF)),'r');
title('{\angle}FF(j\omega)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
axis tight;
xlim([-pi pi]);
grid on;

% Calculate the product of EE(jù)*FF(jù) and plot its magnitude and phase:
EEFF = EE.*FF;

subplot(4,2,5);
plot(w,abs(EEFF));
title('|EE(j\omega)*FF(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
axis tight;
xlim([-pi pi]);
grid on;

subplot(4,2,6);
plot(w,unwrap(angle(EEFF)),'r');
title('{\angle}EE(j\omega)*FF(j\omega)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
axis tight;
xlim([-pi pi]);
grid on;

subplot(4,2,7);
plot(w,real(EEFF));
title('\Ree\{EE(j\omega)*FF(j\omega)\}');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
axis tight;
xlim([-pi pi]);
grid on;

subplot(4,2,8);
plot(w,imag(EEFF),'r');
title('\Imm\{EE(j\omega)*FF(j\omega)\}');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
axis tight;
xlim([-pi pi]);
grid on;

%% Step (b). Compute the convolution signal y[n] = ee[n]*ff[n].

y = conv(ee,ff); % This has the size of n+m-1 = 23.
                           % This signal durates from n=-7 to n=15.

% Computation of an approximation of FF(jù):
n2 = -7:15;
[w Y] = my_DTFT(y,n2);

% Plot the magnitude and the phase of the convolution Y(jù):
figure('Name','Exercise 3.1.8. The Convolution Property');
subplot(2,2,1);
plot(w,abs(Y));
title('|Y(j\omega)| = |DTFT\{ee[n]\astff[n]\}|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
axis tight;
xlim([-pi pi]);
grid on;

subplot(2,2,2);
plot(w,angle(Y),'r');
title('{\angle}Y(j\omega)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
axis tight;
xlim([-pi pi]);
grid on;

subplot(2,2,3);
plot(w,real(Y));
title('\Ree\{Y(j\omega)\}');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
axis tight;
xlim([-pi pi]);
grid on;

subplot(2,2,4);
plot(w,imag(Y),'r');
title('\Imm\{Y(j\omega)\}');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
axis tight;
xlim([-pi pi]);
grid on;