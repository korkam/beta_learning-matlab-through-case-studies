% Exercise 3.2.4. Filtering a Sinusoid and a Random Sequence.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Step (a).
% h1[n] is a high-pass FIR filter.
n1 = 0:6;
b1 = [ 0.036 -0.036 -0.29 0.56 -0.29 -0.036 +0.036];
a1 = 1;

% Plot its frequency response.
figure('Name',' Exercise 3.2.4. Filtering a Sinusoid and a Random Sequence');
[w H1] = my_DTFT(b1,n1);
plot(w,20*log10(abs(H1)));
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlim([-pi pi]);
ylim([-80 5]);
ylabel('(dB)');
xlabel('Digital Frequency \omega (rad/sample)');
grid on;
title('20log(|{\itH_1}(j\omega)|)');

%% Step (b).
n = 0:255;
x1 = sin(pi*n/5) + sin(2*pi*n/5) + sin(3*pi*n/5) + sin(4*pi*n/5);
x2 = rand(256,1) - 0.5;

%Compute the DTFT of x1[n] and x2[n]:
[w  X1] = my_DTFT(x1,n); %#ok<*ASGLU>

[w  X2] = my_DTFT(x2,n);

%% Plot the DTFT magnitude of x1[n] and x2[n].
figure('Name',' Exercise 3.2.4. Filtering a Sinusoid and a Random Sequence');
subplot(2,2,1);
stem(n,x1,'b.');
title('{\itx_1}[n] = sin(\pin/5) + sin(2\pin/5) + sin(3\pin/5) + sin(4\pin/5);');
axis tight;
grid on;

subplot(2,2,2);
plot(w,abs(X1),'r');
ylabel('|{\itX_1}(j\omega)|');
set(gca,'XTick',-pi:pi/5:pi);
set(gca,'XTickLabel',{'-pi','-4pi/5','-3pi/5','-2pi/5','-pi/5','0','pi/5','2pi/5','3pi/5','4pi/5','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

subplot(2,2,3);
stem(n,x2,'b.');
title('{\itx_2}[n]');
axis tight;
grid on;

subplot(2,2,4);
plot(w,abs(X2),'r');
ylabel('|{\itX_2}(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

%% Srep (c). Calculate the outputs y1[n] and y2[n] and their DTFT.

y1 = filter(b1,a1,x1);  % output to the sinusoid.
y2 = filter(b1,a1,x2);  % output to the random signal.

% Compute the DTFT of y1[n] and y2[n].
[w  Y1] = my_DTFT(y1,n);

[w  Y2] = my_DTFT(y2,n);

%% Plot the DTFT magnitudes of y1[n] and y2[n].
figure('Name',' Exercise 3.2.4. Filtering a Sinusoid and a Random Sequence');
subplot(2,2,1);
stem(n,y1,'b.');
title('{\ity_1}[n]');
axis tight;
grid on;

subplot(2,2,2);
plot(w,abs(Y1),'r');
hold on;
plot(w,max(abs(Y1))*abs(H1));
title('|{\itY_1}(j\omega)| (red) and |{\itH_1}(j\omega)| (blue)');
set(gca,'XTick',-pi:pi/5:pi);
set(gca,'XTickLabel',{'-pi','-4pi/5','-3pi/5','-2pi/5','-pi/5','0','pi/5','2pi/5','3pi/5','4pi/5','pi' })
xlabel('\omega (rad/sample)');

xlim([-pi pi]);
axis tight;
grid on;

subplot(2,2,3);
stem(n,y2,'b.');
title('{\ity_2}[n]');
axis tight;
grid on;

subplot(2,2,4);
plot(w,abs(Y2),'r');
hold on;
plot(w,max(abs(Y2))*abs(H1));
title('|{\itY_2}(j\omega)| (red) and |{\itH_1}(j\omega)| (blue)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;
