% Exercise 6.4.5. Use of the DFT for Deconvolution.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace initialization.

clc; clear; close all;

%% Signal Definitions.
n = 0:31;
n1 = n - 20;

x = (0.98).^n;
y = (0.98).^n + 0.5*(0.98).^n1.*[zeros(1,20) ones(1,12);];

figure('Name',' Exercise 6.4.5. Use of the DFT for Deconvolution');
stem(n,x);
hold on;
grid;
stem(n,y,'r.');
title('x[n] (blue) and y[n] (red)');

%% a. Compute the 32-point DFT's of x[n] and y[n].

X = fft(x);
Y = fft(y);

figure('Name',' Exercise 6.4.5. Use of the DFT for Deconvolution');
subplot(2,1,1);
stem(n,abs(X));
title('|X[k]|');
grid on;
axis tight;

subplot(2,1,2);
stem(n,abs(Y));
title('|Y[k]|');
grid on;
axis tight;

% Perform deconvolution by evaluating the inverse DFT of Y[k]/X[k].
h = ifft(Y./X);

figure('Name',' Exercise 6.4.5. Use of the DFT for Deconvolution');
subplot(2,1,1);
stem(n,real(h));
title('\Ree\{h[n]\}');
grid on;
axis tight;

subplot(2,1,2);
stem(n,imag(h));
title('\Imm\{h[n]\}');
grid on;
axis tight;

%% b. Repeat part a. using 64-point DFT's.
n2 = 0:63;
n3 = n2 - 20;

x1 = (0.98).^n2;
y1 = (0.98).^n2 + 0.5*(0.98).^n3.*[zeros(1,20) ones(1,44)];

figure('Name',' Exercise 6.4.5. Use of the DFT for Deconvolution');
stem(n2,x1);
hold on;
grid;
stem(n2,y1,'r.');
title('x[n] (blue) and y[n] (red)');

X1 = fft(x1);
Y1 = fft(y1);

figure('Name',' Exercise 6.4.5. Use of the DFT for Deconvolution');
subplot(2,1,1);
stem(n2,abs(X1));
title('|X_6_4[k]|');
grid on;
axis tight;

subplot(2,1,2);
stem(n2,abs(Y1));
title('|Y_6_4[k]|');
grid on;
axis tight;

%% Perform deconvolution by evaluating the inverse DFT of Y1[k]/X1[k].
h1 = ifft(Y1./X1);

figure('Name',' Exercise 6.4.5. Use of the DFT for Deconvolution');
subplot(2,1,1);
stem(n2,real(h1));
title('\Ree\{h_6_4[n]\}');
grid on;
axis tight;

subplot(2,1,2);
stem(n2,imag(h1));
title('\Imm\{h_6_4[n]\}');
grid on;
axis tight;

%% c. Repeat part a. using 256-point DFT's.
n4 = 0:255;
n5 = n4 - 20;

x2 = (0.98).^n4;
y2 = (0.98).^n4 + 0.5*(0.98).^n5.*[zeros(1,20) ones(1,236)];

figure('Name',' Exercise 6.4.5. Use of the DFT for Deconvolution');
stem(n4,x2);
hold on;
grid;
stem(n4,y2,'r.');
title('x[n] (blue) and y[n] (red)');

X2 = fft(x2);
Y2 = fft(y2);

figure('Name',' Exercise 6.4.5. Use of the DFT for Deconvolution');
subplot(2,1,1);
stem(n4,abs(X2));
title('|X_2_5_6[k]|');
grid on;
axis tight;

subplot(2,1,2);
stem(n4,abs(Y2));
title('|Y_2_5_6[k]|');
grid on;
axis tight;

%% Perform deconvolution by evaluating the inverse DFT of Y2[k]/X2[k].
% We finally came close to the correct impulse response h[n] by use of this method.
h2 = ifft(Y2./X2);

figure('Name',' Exercise 6.4.5. Use of the DFT for Deconvolution');
subplot(2,1,1);
stem(n4,real(h2));
title('\Ree\{h_2_5_6[n]\}');
grid on;
axis tight;

subplot(2,1,2);
stem(n4,imag(h2));
title('\Imm\{h_2_5_6[n]\}');
grid on;
axis tight;
