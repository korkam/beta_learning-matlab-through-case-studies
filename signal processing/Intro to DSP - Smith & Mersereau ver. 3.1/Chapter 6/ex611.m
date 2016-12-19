% Exercise 6.1.1. Some Simple DFT Properties.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% (a). DFT of Circularly Symmetric and Antisymmetric Sequences.
N = 16;
na = 0:N-1;

% Create a 16-point real circularly antisymmetric signal: x[k] = -x[N-k], k=1,2,...,floor((N-1)/2)
% and x[0] = 0 for even and odd length signals.
% xa = [0:7 -7:-1]; % This is  a real circularly antisymmetric signal of odd length (N=15).
xa = [0:7 0 -7:-1];  % This is  a real circularly antisymmetric signal of even length (N=16) and x[N/2]=0;.

% Create a real circularly symmetric signal: x[k] = x[N-k], k=1,2,...,floor((N-1)/2). x[0] is always unconstrained.
% xs = [2*pi 1:7 7:-1:1];  % This is  a real circularly symmetric signal of odd length.
 xs = [2*pi 1:7 3*pi 7:-1:1];    % This is  a real circularly symmetric signal of even length.
                                                 % In addition to x[0],  x[N/2] = x[8] is also unconstrained.
xsum = xa + xs;

Xa      = my_DFT(xa);
Xs      = my_DFT(xs);
Xsum = my_DFT(xsum);

figure('Name','Exercise 6.1.1. Some Simple DFT Properies');
subplot(2,2,1);
stem(na,xa);
title('Real, Circularly Antisymmetric, Even Length Sequence x_a[n]');
axis tight;
grid on;

subplot(4,2,2);
stem(na,real(Xa),'rx');
title('\Ree\{X_a[k]\}');
axis tight;
grid on;

subplot(4,2,4);
stem(na,imag(Xa),'gx');
title('\Imm\{X_a[k]\}');
axis tight;
grid on;

subplot(2,2,3);
stem(na,xs);
title('Real, Circularly Symmetric, Even Length Sequence x_s[n]');
axis tight;
grid on;

subplot(4,2,6);
stem(na,real(Xs),'rx');
title('\Ree\{X_s[k]\}');
grid on;
axis tight;

subplot(4,2,8);
stem(na,imag(Xs),'gx');
title('\Imm\{X_s[k]\}');
grid on;
axis tight;

%% Step (b). Compute and display the real and imaginary parts of DFT{xa[n] + xs[n]}.
figure('Name','Exercise 6.1.1. Some Simple DFT Properies');
subplot(1,2,1);
stem(na,xsum);
title('x_s_u_m[n] = x_a[n] + x_s[n]');
axis tight;
grid on;

subplot(2,2,2);
stem(na,real(Xsum),'rx');
title('\Ree\{X_s_u_m[k]\}');
grid on;
axis tight;

subplot(2,2,4);
stem(na,imag(Xsum),'gx');
title('\Imm\{X_s_u_m[k]\}');
grid on;
axis tight;

%% Step (c). Examine the 16-point periodic sequence xp[n]:
% np3 = 0:11;
np4 = 0:15;
% np6 = 0:23;
np8 = 0:31;

ramp = [0 1 2 3];
% xp3 = [ramp ramp ramp];
xp4 = [ramp ramp ramp ramp];
% xp6 = [ramp ramp ramp ramp ramp ramp];
xp8 = [ramp ramp ramp ramp ramp ramp ramp ramp];

% Xp3 = my_DFT(xp4);

Xp4 = my_DFT(xp4);

% Xp6 = my_DFT(xp4);

Xp8 = my_DFT(xp8);

figure('Name','Exercise 6.1.1. Some Simple DFT Properies');
% subplot(3,2,1);
% stem(np3,xp3);
% title('Periodic Sequence x_p_3[n]');
% axis tight;
% grid on;
% 
% subplot(6,2,2);
% stem(np3,real(Xp3),'r*');
% ylabel('\Ree\{X_p_3[k]\}');
% axis tight;
% grid on;
% 
% subplot(6,2,4);
% stem(np3,imag(Xp3),'g*');
% ylabel('\Imm\{X_p_3[k]\}');
% axis tight;
% grid on;

subplot(2,2,1);
stem(np4,xp4);
title('Periodic Sequence x_p_4[n]');
axis tight;
grid on;

subplot(4,2,2);
stem(np4,real(Xp4),'r*');
ylabel('\Ree\{X_p_4[k]\}');
axis tight;
grid on;

subplot(4,2,4);
stem(np4,imag(Xp4),'g*');
ylabel('\Imm\{X_p_4[k]\}');
axis tight;
grid on;

subplot(2,2,3);
stem(np8,xp8);
title('Periodic Sequence x_p_8[n]');
axis tight;
grid on;

subplot(4,2,6);
stem(np8,real(Xp8),'r*');
ylabel('\Ree\{X_p_8[k]\}');
axis tight;
grid on;

subplot(4,2,8);
stem(np8,imag(Xp8),'g*');
ylabel('\Imm\{X_p_8[k]\}');
axis tight;
grid on;

%% Step (d). Examine the 16-point random sequence xr[n]:
xr = rand(1,16);
xr(2:2:16) = 0;

Xr = my_DFT(xr);

figure('Name','Exercise 6.1.1. Some Simple DFT Properies');
subplot(1,2,1);
stem(np4,xr);
title('Random Upsampled Sequence x_r[n]\uparrow2');
axis tight;
grid on;

subplot(2,2,2);
stem(np4,real(Xr),'rx');
title('\Ree\{X_r[k]\}');
axis tight;
grid on;

subplot(2,2,4);
stem(np4,imag(Xr),'gx');
title('\Imm\{X_r[k]\}');
axis tight;
grid on;

%% Step (e). Examine the 16-point sinusoid x[n]:
x = cos(5*pi/8*na);

X = my_DFT(x);

figure('Name','Exercise 6.1.1. Some Simple DFT Properies');
subplot(1,2,1);
stem(na,x);
title('Real, Symmetric, 16-point Sequence x[n] = cos(5\pin/8)');
axis tight;
grid on;

subplot(2,2,2);
stem(na,real(X),'rx');
title('\Ree\{X[k]\}');
axis tight;
grid on;

subplot(2,2,4);
stem(na,imag(X),'gx');
title('\Imm\{X[k]\}');
axis tight;
grid on;
