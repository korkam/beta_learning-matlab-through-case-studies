% Exercise 5.1.9. The DTFT of an IIR System.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% 
b = [1 1 1 1 1 1];  % numerator sequence.
a = [1 -0.9];          % denominator sequence.

% Computation of an approximation of the DTFT of numerator b[n] and denominator a[n] :
[~,  A] = my_DTFT(a,0:1); 
 
[w  B] = my_DTFT(b,0:5);

%% Steb (b). Plot the magnitude of the numerator, the denominator and the ratio:
figure('Name','Exercise 5.1.9. The DTFT of an IIR System');
subplot(2,2,1);
plot(w,abs(B));
title('|B(j\omega)| = |1 + z^{-1} + z^{-2} + z^{-3} + z^{-4} + z^{-5}|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

subplot(2,2,3);
plot(w,abs(A));
title('|A(j\omega)| = |1 - 0.9z^{-1}|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

subplot(2,2,2);
plot(w,abs(B./A),'Linewidth',4);
hold on;
title('|B(j\omega)/A(j\omega)| (blue line) and |H(j\omega)| (green line) ');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

H = freqz(b,a,w);
subplot(2,2,2);
plot(w,abs(H),'g','Linewidth',2);

e1 = B./A - H;

subplot(2,2,4);
plot(w,abs(e1),'r.');
title('|Error_1(j\omega)| = |B(j\omega)/A(j\omega) - H(j\omega)| ');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

%% Step (c). Generate the first 128 points of the impulse response.
figure('Name','Exercise 5.1.9. The DTFT of an IIR System');
subplot(2,1,1);
plot(w,abs(H),'g','Linewidth',4);
hold on;

delta = [1 zeros(1,127)]; 
h = filter(b,a,delta);  % Calculate the first 128 samples of the impulse response.
n = 0:127;

% Computation of the DTFT of  the truncated h[n]:
[w  Ht] = my_DTFT(h,n); 

subplot(2,1,1);
plot(w,abs(Ht),'r','Linewidth',2);
title('|H(j\omega)| (green line) and |DTFT\{h(0:127)\}| (red line) ');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

e2 = Ht - H;

subplot(2,1,2);
plot(w,abs(e2),'r.');
title('|Error_2(j\omega)| = |DTFT\{h(0:127)\} - H(j\omega)| ');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

