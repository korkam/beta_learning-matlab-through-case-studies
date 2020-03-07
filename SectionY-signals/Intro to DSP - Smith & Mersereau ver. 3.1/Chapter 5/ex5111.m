% Exercise 5.1.11. An All-Pole System. H(z) = 1/A(z).

%   Copyright 2012-2016, Ilias S. Konsoulas.
%% Workspace Initialization.

clc; clear; close all;

%% Polynomial Definitions.

a = [1 0.8 0.4 0.2 ];

%% Step (a).
figure('Name','Exercise 5.1.11. An All-Pole System');
zplane(1,a);
title('Poles and zeros of H(z)');

NSamples = 256;
w = -pi:pi/NSamples:pi;

H = freqz(1,a,w);
A = freqz(a,1,w);

figure('Name','Exercise 5.1.11. An All-Pole System');
subplot(2,1,1);
plot(w,abs(H));
title('|H(j\omega)|=1/|A(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' });
xlim([-pi pi]);
axis tight;
grid on;

subplot(2,1,2);
plot(w,abs(A));
title('|A(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' });
xlim([-pi pi]);
axis tight;
grid on;

%% Step (b).
% õ[n] = x[n] - 0.8õ[n-1] - 0.4õ[n-2] - 0.2õ[n-3].

%% Step (c).
% Inverse System difference equation: 
% y[n] = õ[n] + 0.8õ[n-1] + 0.4õ[n-2] + 0.2õ[n-3].

n = 0:127; a1 = 0.05; a2 = 0.001; phi = 1;
x = sin(a1*n + a2*n.^2 + phi);

v = filter(1,a,x);
y = filter(a,1,v);

figure('Name','Exercise 5.1.11. An All-Pole System');
subplot(2,1,1);
stem(n,x);
hold on;
title('Input Signal x[n] (blue) and Input Signal Estimate y[n] (red)');
axis tight;
grid on;

subplot(2,1,2);
stem(n,v);
title('Intermediate Signal \upsilon[n]');
axis tight;
grid on;

subplot(2,1,1);
stem(n,y,'r*');
