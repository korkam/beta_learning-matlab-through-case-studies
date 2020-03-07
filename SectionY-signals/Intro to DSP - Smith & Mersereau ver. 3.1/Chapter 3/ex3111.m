% Exercise 3.1.11. Some Discrete-Time Fourier Transform (DTFT) Pairs.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Step (a). Compute and display the DTFT of the following finite-length signals:
n1 = 0:63;
n2 = n1;
n3 = 0:31;

x1 = sin(pi*n1/8);
x2 = cos(pi*n1/8);
x3 = ones(32,1);  

n4 = -20:20;
x4 = [sin(pi.*(-20:-1)/2)./(pi*(-20:-1)) 1/2 sin(pi.*(1:20)/2)./(pi.*(1:20))];

n5 = -32:31;
basic_blk = [1 1 1 1 0 0 0 0];
x5 = [basic_blk basic_blk basic_blk basic_blk basic_blk basic_blk basic_blk basic_blk];

n6 = -32:31;
basic_blk2 = [1 0 0 0 0 0 0 0];
x6 = [basic_blk2 basic_blk2 basic_blk2 basic_blk2 basic_blk2 basic_blk2 basic_blk2 basic_blk2];

%% Step (c).  Calculate and Display the real and imaginary parts of VV(jù).

% Computation of an approximation of the DTFT of vv[n]:
[w, X1] = my_DTFT(x1,n1); %#ok<*ASGLU>

[w, X2] = my_DTFT(x2,n2);

[w, X3] = my_DTFT(x3,n3);

[w, X4] = my_DTFT(x4,n4);

[w, X5] = my_DTFT(x5,n5);

[w X6] = my_DTFT(x6,n6);

%% Plot the DTFT magnitude of all signals using 2 figures..
hfig1 = figure('Name','Exercise 3.1.11. Some Discret-Time Fourier Transform (DTFT) Pairs');
subplot(3,3,1);
stem(n1,x1,'b.');
title('{\itx_1}[n] = sin(\pin/8)*\{u[n]-u[n-64]\}');
axis tight;
grid on;

subplot(3,3,2);
plot(w,abs(X1),'r');
ylabel('|{\itX_1}(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

subplot(3,3,3);
plot(w,unwrap(angle(X1)),'g');
ylabel('{\angleX_1}(j\omega)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

subplot(3,3,4);
stem(n2,x2,'b.');
title('{\itx_2}[n] = cos(\pin/8)*\{u[n]-u[n-64]\}');
axis tight;
grid on;

subplot(3,3,5);
plot(w,abs(X2),'r');
ylabel('|{\itX_2}(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

subplot(3,3,6);
plot(w,unwrap(angle(X2)),'g');
ylabel('{\angleX_2}(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

subplot(3,3,7);
stem(n3,x3,'b.');
title('{\itx_3}[n] = u[n]-u[n-32]');
axis tight;
grid on;

subplot(3,3,8);
plot(w,abs(X3),'r');
ylabel('|{\itX_3}(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

subplot(3,3,9);
plot(w,unwrap(angle(X3)),'g');
ylabel('{\angleX_3}(j\omega)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

tightfig(hfig1);

%% Figure 2.
hfig2 = figure('Name','Exercise 3.1.11. Some Discret-Time Fourier Transform (DTFT) Pairs');
subplot(3,3,1);
n4 = -20:20;
stem(n4,x4,'b.');
title('{\itx_4}[n] = \{sin(\pin/2)/(\pin)\}\{u[n+20]-u[n-21]\}');
axis tight;
grid on;

subplot(3,3,2);
plot(w,abs(X4),'r');
ylabel('|{\itX_4}(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

subplot(3,3,3);
plot(w,unwrap(angle(X4)),'g');
ylabel('{\angleX_4}(j\omega)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

subplot(3,3,4);
n5 = -32:31;
stem(n5,x5,'b.');
title('{\itx_5}[n]: 64-point square wave with period 8');
axis tight;
grid on;

subplot(3,3,5);
plot(w,abs(X5),'r');
ylabel('|{\itX_5}(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

subplot(3,3,6);
plot(w,unwrap(angle(X5)),'g');
ylabel('{\angleX_5}(j\omega)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

subplot(3,3,7);
n6 = -32:31;
stem(n6,x6,'b.');
title('{\itx_6}[n]: 64-point impulse train with period 8');
axis tight;
grid on;

subplot(3,3,8);
plot(w,abs(X6),'r');
ylabel('|{\itX_6}(j\omega)|');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

subplot(3,3,9);
plot(w,unwrap(angle(X6)),'g');
ylabel('{\angleX_6}(j\omega)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

tightfig(hfig2);
