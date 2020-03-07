% Exercise 4.3.3. Upsampling.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Step (c). 
n = 0:65;
x = cos(pi/5*n);
xlength = length(x);

%% Step (a). Perform upsampling by a factor L = 2 and 10.
L = [2 10];

y1 = my_upsample(x,L(1));   % Insert 1 zero between the samples of x[n].
y2 = my_upsample(x,L(2));   % Insert 9 zeros between the samples of x[n].

%% Step (b). Calculate the DTFT's of the yT[n].
n   = 0:xlength - 1;
n1 = 0:length(y1) - 1;
n2 = 0:length(y2) - 1;

[w   X]  = my_DTFT(x,n); %#ok<*ASGLU>

[w  Y1] = my_DTFT(y1,n1);

[w  Y2] = my_DTFT(y2,n2);

%% Plot the DTFT magnitudes of xT[n] and yT[n]. Display only the frequency range of interest:
% Plot the signals.
figure('Name','Exercise 4.3.3. Upsampling');
subplot(3,2,1);
stem(n, x,'b.');
title('{\itx}[n] = cos(\pin/5)');
axis tight;
grid on;

subplot(3,2,2);
plot(w,abs(X),'r');
hold on;
ylabel('|{\itX}(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' });
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

subplot(3,2,3);
stem(n1, y1,'g.');
title(['y_1[n] = {\itx}[n] \uparrow ',num2str(L(1))]);
axis tight;
grid on;

subplot(3,2,4);
plot(w,abs(Y1),'r');
ylabel('|Y_1(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' });
xlabel('\omega (rad/sample)');
axis tight;
grid on;

subplot(3,2,5);
stem(n2, y2,'g.');
title(['y_2[n] = {\itx}[n] \uparrow ',num2str(L(2))]);
axis tight;
grid on;

subplot(3,2,6);
plot(w,abs(Y2),'r');
ylabel('|Y_2(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' });
xlabel('\omega (rad/sample)');
axis tight;
grid on;
