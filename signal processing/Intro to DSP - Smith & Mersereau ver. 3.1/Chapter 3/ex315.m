% Exercise 3.1.5. Periodicity of the Discrete-Time Fourier Transform.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Signal Definition.
n = 0:4;
aa = [.3 -.2 .4 .5 -.3];

% NSamples = 256;
%w = -4*pi:8*pi/NSamples:4*pi;
%AA = freqz(aa,1,w);

% or, using our custom function:
[w AA] = my_DTFT2(aa,n,[-4*pi 4*pi]);

%% Plot the magnitude (even symmetry) and phase (odd symmetry) parts of the DTFT of aa[n]
     % for several periods in order to show the periodicity.
figure('Name',' Exercise 3.1.5. Periodicity of the Discrete-Time Fourier Transform');
% Maximize this figure for best results.
subplot(2,1,1);
plot(w,abs(AA));
hold on;
line([-pi -pi], [0 1.5],'Color','g','LineWidth',4,'EraseMode','xor');
line([pi pi], [0 1.5],'Color','g','LineWidth',4,'EraseMode','xor');
title('|AA(j\omega)|');
set(gca,'XTick',-4*pi:pi/2:4*pi);
set(gca,'XTickLabel',{'-4pi','-7pi/2','-3pi','-5pi/2','-2pi','-3pi/2','-pi','-pi/2','0','pi/2','pi','3pi/2','2pi','5pi/2','3pi','7pi/2','4pi'})
xlim([-4*pi 4*pi]);
xlabel('Digital Frequency \omega (rad/sample)');
grid on;

subplot(2,1,2);
plot(w,angle(AA),'r');
hold on;
line([-pi -pi], [-4  4],'Color','g','LineWidth',4,'EraseMode','xor');
line([pi    pi], [-4  4],'Color','g','LineWidth',4,'EraseMode','xor');
title('\angleAA(j\omega)');
set(gca,'XTick',-4*pi:pi/2:4*pi);
set(gca,'XTickLabel',{'-4pi','-7pi/2','-3pi','-5pi/2','-2pi','-3pi/2','-pi','-pi/2','0','pi/2','pi','3pi/2','2pi','5pi/2','3pi','7pi/2','4pi'})
xlim([-4*pi 4*pi]);
xlabel('Digital Frequency \omega (rad/sample)');
grid on;
