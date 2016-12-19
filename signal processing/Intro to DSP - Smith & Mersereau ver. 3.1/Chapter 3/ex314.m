% Exercise 3.1.4. Hermitian Symmetry.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Step (a) - Signal Definition: 
n = 0:4;
cc = [-2 -1 0 1 2];

% Calculate its DTFT:
[w CC] = my_DTFT(cc,n);

%% Sketch the real (even symmetry) and imaginary (odd symmetry) parts of the DTFT of x[n]:
figure('Name','Exercise 3.1.4. Hermitian Symmetry');
subplot(2,2,1);
plot(w,real(CC));
title('{\Ree}\{CC(j\omega)\} is Even');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

subplot(2,2,3);
plot(w,imag(CC),'r');
title('{\Imm}\{CC(j\omega)\} is Odd');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

%% Plot the magnitude (even symmetry) and phase (odd symmetry) parts of the DTFT of x[n]:
subplot(2,2,2);
plot(w,abs(CC));
title('|CC(j\omega)| is Even');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

subplot(2,2,4);
plot(w,angle(CC),'r');
title('\angleCC(j\omega) is Odd');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

%% Step (b).
n1 = 0:3;
dd = [4+2*1i  2+3*1i  3+4*1i  1+5*1i];

% Calculate its DTFT:
[w DD] = my_DTFT(dd,n1);

% Sketch the real and imaginary parts of the DTFT of x[n]:
figure('Name','Exercise 3.1.4. Hermitian Symmetry');
subplot(2,2,1);
plot(w,real(DD));
title('{\Ree}\{DD(j\omega)\} is neither Even nor Odd');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

subplot(2,2,3);
plot(w,imag(DD),'r');
title('{\Imm}\{DD(j\omega)\} is neither Even nor Odd');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

%% Plot the magnitude and phase parts of the DTFT of x[n]:
subplot(2,2,2);
plot(w,abs(DD));
title('|DD(j\omega)| is neither Even nor Odd');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

subplot(2,2,4);
plot(w,angle(DD),'r');
title('\angleDD(j\omega) is neither Even nor Odd');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;
