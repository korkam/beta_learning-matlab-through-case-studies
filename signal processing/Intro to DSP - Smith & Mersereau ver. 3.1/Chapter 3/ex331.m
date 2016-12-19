% Exercise 3.3.1. Zero-Phase.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Create a 13-point zeros-phase sequence e[n].
% Plot the sequence and its DTFT.
e = [ 0:5 6 5:-1:0];
f  = [ 0:5 7 5:-1:0]; % f[n] = e[n] + ä[n].

[w  E] = my_DTFT(e,-6:6); %#ok<*ASGLU>
[w  F] = my_DTFT(f,-6:6);

n1 = -6:6;
figure('Name','Exercise 3.3.1. Zero-Phase');
subplot(1,2,1);
stem(n1,e,'b');
xlim([-6 6]);
grid on;
hold on;
stem(n1,f,'r*');
title('Zero-phase sequences e[n] (blue) and f[n] = e[n] + \delta[n] (red)');

subplot(2,2,2);
plot(w,abs(E));
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;
title('|{\itE}(j\omega)| (blue) and |{\itF}(j\omega)| (red)');
hold on;
plot(w,abs(F),'r');

subplot(2,2,4)
plot(w,angle(E));
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;
hold on;
title('\angle{\itE}(j\omega) (blue) and \angle{\itF}(j\omega) (red) are zero');
plot(w,angle(F),'r');
