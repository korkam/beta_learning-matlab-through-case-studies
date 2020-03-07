% Exercise 2.1.7. Characteristics of Signals.

%   Copyright 2012-2016, Ilias S. Konsoulas

clc; clear; close all;

%% a. x[n] = cos(w0*n).
n = 0:64;
% i) 
w0 = pi/8; 
% Period is calculated as:
P = 2*pi/w0;
x = cos(w0*n);

figure('Name','Exercise 2.1.7. Characteristics of Signals');
subplot(2,1,1);
stem(n,x);
hold on;
grid on;
axis tight;
title(['Signal x[n] = cos(\pin/8) is periodic with period T = ',num2str(P),' samples']);
stem(n(1:P),x(1:P),'r*');

% ii)
w01 = 1;
x1 = cos(w01*n);

subplot(2,1,2);
stem(n,x1,'.');
hold on;
grid on;
axis tight;
title('Signal x_1[n] = cos(n) is not periodic because \omega_0/2\pi = k/T, k integer, should be rational');

%% b.  x[n] = exp(j*w0*n)*u[n].
n2 = 0:39;
w02 = pi/10;
x2 = exp(1i*w02*n2);

figure('Name','Exercise 2.1.7. Characteristics of Signals');
subplot(2,2,1);
stem(n2,real(x2));
grid on
axis tight;
title('\Ree\{x_2[n]\}');

subplot(2,2,3);
stem(n2,imag(x2));
grid on
axis tight;
title('\Imm\{x_2[n]\}');

subplot(2,2,2);
stem(n2,abs(x2));
grid on
axis tight;
title('|x_2[n]|');

subplot(2,2,4);
stem(n2,angle(x2));
grid on
axis tight;
title('\anglex_2[n]');

%% c. 
y0 = abs(10*x2);
y1 = angle(conj(x2));
y2 = real(1i*x2);
y3 = imag(conj(1i*x2));

figure('Name','Exercise 2.1.7. Characteristics of Signals');
subplot(2,2,1);
stem(n2,y0);
grid on
axis tight;
title('y_0[n] = |10x_2[n]| ');

subplot(2,2,3);
stem(n2,y2);
grid on
axis tight;
title('y_2[n] = \Ree\{jx_2[n]\}');

subplot(2,2,2);
stem(n2,y1);
grid on
axis tight;
title('y_1[n]=\anglex_2^\ast[n] ');

subplot(2,2,4);
stem(n2,y3);
grid on
axis tight;
title('y_3[n]=\Imm\{(jx_2[n])^\ast\}');

figure('Name','Exercise 2.1.7. Characteristics of Signals');
subplot(2,2,1);
stem(n2,real(y0));
grid on
axis tight;
title('\Ree\{y_0[n]\}');

subplot(2,2,3);
stem(n2,imag(y0));
grid on
axis tight;
title('\Imm\{y_0[n]\}');

subplot(2,2,2);
stem(n2,abs(y0));
grid on
axis tight;
title('|y_0[n]|');

subplot(2,2,4);
stem(n2,angle(y0));
grid on
axis tight;
title('\angley_0[n]');

figure('Name','Exercise 2.1.7. Characteristics of Signals');
subplot(2,2,1);
stem(n2,real(y1));
grid on
axis tight;
title('\Ree\{y_1[n]\}');

subplot(2,2,3);
stem(n2,imag(y1));
grid on
axis tight;
title('\Imm\{y_1[n]\}');

subplot(2,2,2);
stem(n2,abs(y1));
grid on
axis tight;
title('|y_1[n]|');

subplot(2,2,4);
stem(n2,angle(y1));
grid on
axis tight;
title('\angley_1[n]');

figure('Name','Exercise 2.1.7. Characteristics of Signals');
subplot(2,2,1);
stem(n2,real(y2));
hold on;
stem(n2,real(y3),'r.');
grid on
axis tight;
title('\Ree\{y_2[n]\} (blue) and \Ree\{y_3[n]\} (red) ');

subplot(2,2,3);
stem(n2,imag(y2));
hold on;
stem(n2,imag(y3),'r.');
grid on
axis tight;
title('\Imm\{y_2[n]\} (blue) and \Imm\{y_3[n]\} (red)');

subplot(2,2,2);
stem(n2,abs(y2));
hold on;
stem(n2,abs(y3),'r.');
grid on
axis tight;
title('|y_2[n]| (blue) and |y_3[n]| (red) ');

subplot(2,2,4);
stem(n2,angle(y2));
hold on;
stem(n2,angle(y3),'r.');
grid on
axis tight;
title('\angley_2[n] (blue) and \angley_3[n] (red)');
