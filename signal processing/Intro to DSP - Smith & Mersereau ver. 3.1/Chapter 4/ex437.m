% Exercise 4.3.7. Fractional Sampling Rate Conversion.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Signal Definitions.
n = 0:127;
x = cos(pi/30*n) + cos(pi/5*n);

%% Steps (b) and (d).  Change the sampling rate of x[n] by a factor 3/4 and then by a factor 4/3.
% Create a 31-point low pass filter with cutoff min(pi/M,pi/N) and gain M:
M1 = 3; N1 = 4;
w0 = pi/max(M1,N1);
h1 = M1*[ sin(w0*(-15:-1))./(pi*(-15:-1)) w0/pi sin(w0*(1:15))./(pi*(1:15))]; % zero-phase low-pass FIR filter with gain M1 and cutoff at min(pi/M1,pi/N1).
wh = hamming(31).'; % 31-point symmetric Hamming window.

y1 = fraction_sample(x,h1.*wh,M1,N1); % downconversion of x[n] by a factor of 3/4.
Ly1 = length(y1);

figure('Name','Exercise 4.3.7. Fractional Sampling Rate Conversion');
subplot(3,2,1);
stem(n,x,'b.');
hold on;
title('x[n] = cos(\pin/30) + cos(\pin/5) (blue) and x_h_a_t[n] (green) ');
grid on;
axis tight;

subplot(3,2,3);
stem(y1,'r.');
title('y_1[n] = x[n] \downarrow 3/4');
grid on;
axis tight;

h4 = N1/M1*h1; % Scale the filter kernel in order to be of gain N1.
% h4 = N1*[ sin(w0*(-15:-1))./(pi*(-15:-1)) w0/pi sin(w0*(1:15))./(pi*(1:15))];
xhat = fraction_sample(y1,h4.*wh,N1,M1); % upconversion of y1[n] by a factor of 4/3.
Lhat = length(xhat);

subplot(3,2,5);
stem(xhat,'g.');
title('x_{hat}[n] = \{x[n] \downarrow 3/4\} \uparrow 4/3');
grid on;
axis tight;

xhatT = xhat(11:end-11); % Truncate xhat[n] in order to keep a signal of duration equal to x[n].
                                          % i.e. we remove the head and the tail of the signal. 

subplot(3,2,1);
plot(n,xhatT,'g.-');
grid on;
axis tight;

%% Computation of an approximation of X(jù), Y1(jù) and Xhat(jù):
w1 = [-2*pi/5  2*pi/5];

[w      X] = my_DTFT2(x,n,w1); %#ok<*ASGLU>

[w Xhat] = my_DTFT2(xhat,0:Lhat-1,w1);

[w     Y1] = my_DTFT2(y1,0:Ly1-1,w1);

%% Plot the magnitude of X(jù):
subplot(2,2,2);
plot(w,abs(X),'b','Linewidth',4);
hold on;
title('|X(j\omega)| (blue) and |X_{hat}(j\omega)| (green) ');
set(gca,'XTick',-2*pi/5:pi/10:2*pi/5);
set(gca,'XTickLabel',{'-2pi/5','-3pi/10','-pi/5','-pi/10','0','pi/10','pi/5','3pi/10','2pi/5' })
xlabel('\omega (rad/sample)');
axis tight;
grid on;

% Plot the magnitude of Y1(jù):
subplot(2,2,4);
plot(w,abs(Y1),'r');
hold on
line([-N1/M1*pi/5   -N1/M1*pi/5  ], [0 max(abs(Y1))]);
line([ N1/M1*pi/5    N1/M1*pi/5  ], [0 max(abs(Y1))]);
line([-N1/M1*pi/30  -N1/M1*pi/30], [0 max(abs(Y1))]);
line([ N1/M1*pi/30   N1/M1*pi/30], [0 max(abs(Y1))]);
title('|Y_1(j\omega)|');
set(gca,'XTick',-2*pi/5:pi/10:2*pi/5);
set(gca,'XTickLabel',{'-2pi/5','-3pi/10','-pi/5','-pi/10','0','pi/10','pi/5','3pi/10','2pi/5' })
xlabel('\omega (rad/sample)');
axis tight;
grid on;

% Plot the magnitude of Xhat(jù):
subplot(2,2,2);
plot(w,abs(Xhat),'g','Linewidth',2);
%title(['|Xhat(j\omega)|']);
set(gca,'XTick',-2*pi/5:pi/10:2*pi/5);
set(gca,'XTickLabel',{'-2pi/5','-3pi/10','-pi/5','-pi/10','0','pi/10','pi/5','3pi/10','2pi/5' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
axis tight;
grid on;

%% Calculate the downsampling and upsampling error:
% n = 0:127;
% edu = x - xhatT; % error of downsampling by 3/4 and then upsampling by 4/3.
% 
% figure('Name','Exercise 4.3.7. Fractional Sampling rate Conversion');
% subplot(1,2,1);
% stem(n,edu);
% title('e_d_u[n] = x[n] - xhat[n]');
% grid on;
% axis tight;
% 
% [w  EDU] = my_DTFT2(edu,n,w1,NSamples);
% 
% % Plot the magnitude of EDU(jù):
% subplot(1,2,2);
% plot(w,abs(EDU),'b');
% hold on;
% title(['|E_d_u(j\omega)| ']);
% set(gca,'XTick',-2*pi/5:pi/10:2*pi/5);
% set(gca,'XTickLabel',{'-2pi/5','-3pi/10','-pi/5','-pi/10','0','pi/10','pi/5','3pi/10','2pi/5' })
% axis tight;
% grid on;

%% Step (c)1. Repeat step (b) with M=6 and N=8;
M2 = 6; N2 = 8;
% Create a 31-point low pass filter with cutoff min(pi/M,pi/N);
w0 = pi/max(M2,N2);
h2 = M2*[ sin(w0*(-15:-1))./(pi*(-15:-1)) w0/pi sin(w0*(1:15))./(pi*(1:15))]; % zero-phase low-pass FIR with gain M and cutoff at min(pi/M,pi/N).

y2 = fraction_sample(x,h2.*wh,M2,N2); 
Ly2 = length(y2);

figure('Name','Exercise 4.3.7. Fractional Sampling Rate Conversion');
subplot(2,2,1);
stem(n,x,'b.');
title('x[n] = cos(\pin/30) + cos(\pin/5) ');
grid on;
axis tight;

subplot(2,2,3);
stem(y2,'r.');
title('y_2[n]  = x[n] \downarrow 6/8');
grid on;
axis tight;

% Computation of an approximation of Y2(jù):
[w  Y2] = my_DTFT2(y2,0:Ly2-1,w1);

% Plot the magnitude of X(jù):
subplot(1,2,2);
plot(w,abs(X),'b');
hold on;
title('|X(j\omega)| (blue) - |Y_2(j\omega)| (red)');
set(gca,'XTick',-2*pi/5:pi/10:2*pi/5);
set(gca,'XTickLabel',{'-2pi/5','-3pi/10','-pi/5','-pi/10','0','pi/10','pi/5','3pi/10','2pi/5' })
xlabel('\omega (rad/sample)');
axis tight;
grid on;

% Plot the magnitude of Y2(jù):
subplot(1,2,2);
plot(w,abs(Y2),'r');
hold on;
line([-N2/M2*pi/5   -N2/M2*pi/5  ], [0 max(abs(Y2))],'Color','c');
line([ N2/M2*pi/5    N2/M2*pi/5  ], [0 max(abs(Y2))],'Color','c');
line([-N2/M2*pi/30 -N2/M2*pi/30], [0 max(abs(Y2))],'Color','c');
line([ N2/M2*pi/30  N2/M2*pi/30], [0 max(abs(Y2))],'Color','c');

% title(['|Y_2(j\omega)|']);
set(gca,'XTick',-2*pi/5:pi/10:2*pi/5);
set(gca,'XTickLabel',{'-2pi/5','-3pi/10','-pi/5','-pi/10','0','pi/10','pi/5','3pi/10','2pi/5' })
axis tight;
grid on;

%% Step (c)2. Repeat step (b) with M=24 and N=32;
M3 = 24; N3 = 32;
% Create a 31-point low pass filter with cutoff min(pi/M,pi/N);
w0 = pi/max(M3,N3);
h3 = M3*[ sin(w0*(-15:-1))./(pi*(-15:-1)) w0/pi sin(w0*(1:15))./(pi*(1:15))]; % zero-phase low-pass FIR with gain M and cutoff at min(pi/M,pi/N).

y3 = fraction_sample(x,h3.*wh,M3,N3); 
Ly3 = length(y3);

figure('Name','Exercise 4.3.7. Fractional Sampling rate Conversion');
subplot(2,2,1);
stem(n,x,'b.');
title('x[n] = cos(\pin/30) + cos(\pin/5) ');
grid on;
axis tight;

subplot(2,2,3);
stem(0:Ly3-1,y3,'r.');
title('y_3[n] = x[n] \downarrow 24/32');
grid on;
axis tight;

%% ad-hoc computation of an approximation of X(jù) and Y2(jù):
[w  Y3] = my_DTFT2(y3,0:Ly3-1,w1);

% Plot the magnitude of X(jù):
subplot(1,2,2);
plot(w,abs(X),'b');
hold on
title('|X(j\omega)| (blue)  - |Y_3(j\omega)| (red)');
set(gca,'XTick',-2*pi/5:pi/10:2*pi/5);
set(gca,'XTickLabel',{'-2pi/5','-3pi/10','-pi/5','-pi/10','0','pi/10','pi/5','3pi/10','2pi/5' });
xlabel('\omega (rad/sample)');
axis tight;
grid on;

% Plot the magnitude of Y3(jù):
subplot(1,2,2);
plot(w,abs(Y3),'r');
hold on;
line([-N3/M3*pi/5   -N3/M3*pi/5  ], [0 max(abs(Y3))],'Color','c');
line([ N3/M3*pi/5    N3/M3*pi/5  ], [0 max(abs(Y3))],'Color','c');
line([-N3/M3*pi/30 -N3/M3*pi/30], [0 max(abs(Y3))],'Color','c');
line([ N3/M3*pi/30  N3/M3*pi/30], [0 max(abs(Y3))],'Color','c');

% title(['|Y_3(j\omega)|']);
set(gca,'XTick',-2*pi/5:pi/10:2*pi/5);
set(gca,'XTickLabel',{'-2pi/5','-3pi/10','-pi/5','-pi/10','0','pi/10','pi/5','3pi/10','2pi/5' });
axis tight;
grid on;

%% Now plot the kernels and frequency responses of the low=pass filters used in all steps 
% for comparison.
n1 = -15:15;
figure('Name','Exercise 4.3.7. Fractional Sampling Rate Conversion');
subplot(4,2,1);
stem(n1,h1.*wh,'.');
title('h_1[n]*w_{ham}[n]');
axis tight;
grid on;

subplot(4,2,3);
stem(n1,h2.*wh,'.');
title('h_2[n]*w_{ham}[n]');
axis tight;
grid on;

subplot(4,2,5);
stem(n1,h3.*wh,'.');
title('h_3[n]*w_{ham}[n]');
axis tight;
grid on;

subplot(4,2,7);
stem(n1,h4.*wh,'.');
title('h_4[n]*w_{ham}[n]');
axis tight;
grid on;

[w  H1] = my_DTFT2(h1.*wh,n1,w1);

[w  H2] = my_DTFT2(h2.*wh,n1,w1);

[w  H3] = my_DTFT2(h3.*wh,n1,w1);

[w  H4] = my_DTFT2(h4.*wh,n1,w1);

% Plot the magnitude of X(jù):
subplot(4,2,2);
plot(w,abs(H1),'b');
title('|H_1(j\omega)|');
set(gca,'XTick',-2*pi/5:pi/10:2*pi/5);
set(gca,'XTickLabel',{'-2pi/5','-3pi/10','-pi/5','-pi/10','0','pi/10','pi/5','3pi/10','2pi/5' })
xlabel('\omega (rad/sample)');
axis tight;
grid on;

subplot(4,2,4);
plot(w,abs(H2),'b');
title('|H_2(j\omega)|');
set(gca,'XTick',-2*pi/5:pi/10:2*pi/5);
set(gca,'XTickLabel',{'-2pi/5','-3pi/10','-pi/5','-pi/10','0','pi/10','pi/5','3pi/10','2pi/5' })
xlabel('\omega (rad/sample)');
axis tight;
grid on;

subplot(4,2,6);
plot(w,abs(H3),'b');
title('|H_3(j\omega)|');
set(gca,'XTick',-2*pi/5:pi/10:2*pi/5);
set(gca,'XTickLabel',{'-2pi/5','-3pi/10','-pi/5','-pi/10','0','pi/10','pi/5','3pi/10','2pi/5' })
xlabel('\omega (rad/sample)');
axis tight;
grid on;

subplot(4,2,8);
plot(w,abs(H4),'b');
title('|H_4(j\omega)|');
set(gca,'XTick',-2*pi/5:pi/10:2*pi/5);
set(gca,'XTickLabel',{'-2pi/5','-3pi/10','-pi/5','-pi/10','0','pi/10','pi/5','3pi/10','2pi/5' })
xlabel('\omega (rad/sample)');
axis tight;
grid on;
