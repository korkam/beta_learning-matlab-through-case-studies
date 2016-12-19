% Exercise 3.1.7. The Modulation Property.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Signal Definition.
n = -7:7;
ee = [  3.263941e-5  -6.037312e-4  2.971067e-3  -9.563761e-3  2.457258e-2  -5.702938e-2  1.466156e-1  0 ... 
          -1.466156e-1    5.702938e-2 -2.457258e-2   9.563761e-3 -2.971067e-3   6.037312e-4   -3.263941e-5 ];
      
 %% Step (a). Display the 15-point signal ee[n]. 
 figure('Name','Exercise 3.1.7. The Modulation Property');
 subplot(1,2,1);
 stem(n,ee);
 title('Signal ee[n] is real and odd');
 grid on;
 axis tight;
 
% Computation of an approximation of the DTFT of ee[n]:
[w EE] = my_DTFT(ee,n);

% Plot the magnitude and the phase of the DTFT of ee[n]:
subplot(2,2,2);
plot(w,abs(EE));
title('|EE(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

subplot(2,2,4);
plot(w,angle(EE),'r');
title('{\angle}EE(j\omega)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

%% Create the signal y2[n]=exp(j*pi*n/4)*ee[n] and plot the magnitude and phase of its DTFT.
% First create this signals:
y2 = exp(1i*pi*n/4).*ee;

% Plot the real and imaginary parts of y2[n]:
figure('Name','Exercise 3.1.7. The Modulation Property');
subplot(2,2,1);
stem(n,real(y2));
title('{\Ree}\{{\ity_2}[n]\} = \Ree\{ee[n]e^{j\pin/4}\}');
axis tight;
grid on;

subplot(2,2,3);
stem(n,imag(y2),'rx');
title('{\Imm}\{{\ity_2}[n]\} = \Imm\{ee[n]e^{j\pin/4}\}');
axis tight;
grid on;

% Computation of an approximation of the DTFT of y2[n]:
[w Y2] = my_DTFT(y2,n);

% Plot the magnitude and phase of the DTFT of y2[n]:
subplot(2,2,2);
plot(w,abs(Y2));
title('|Y_2(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

subplot(2,2,4);
plot(w,angle(Y2),'r');
title('{\angle}Y_2(j\omega)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on; 
