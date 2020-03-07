%% Exercise 2.1.3. Elementary Signals.
%
% This problem explores a number of discrete-time signals that commonly
% arise in digital signal processing and provides a vehicle for becoming
% acquainted with the signal generator that will be used throughout this
% text. The signal generator can be executed by typing *x siggen*. It
% can generate a variety of different signals.
% A small set of elementary signals is needed in this exercise. To begin,
% create the following signals of length 16 $(0\leq n \leq15)$.
%
% * $b[n]$, a 16-point block sequence with unit amplitude.
% * $r[n]$, the first 16-points of the ramp function, defined as $nu[n]$.
% * $t[n]$, 16-points of a periodic triangular wave with period 8, a maximum value of one,
%                and starting point $n=0$.
% * $e[n]$, the first 16 points of the one-sided exponential, $(5/6)^nu[n]$.
%
% Display and sketch them using *x view*. Signals are often formulated
% or expressed in terms of elementary signals. Using the elementary signals
% just created, sketch the following new signals:
%
% # $\upsilon[n]=r[n-6]u[n];$
% # $\alpha[n] = b[n] - b[n-6]$, if $n<10$ and 0 otherwise;
% # $y[n] = e[n+10] b[n];$
% # $z[n] = t[n] (u[n]-u[n-10]);$
% # $e_e[n]=ev\{e[n]\} (u[n+5]-u[n-5]);$
% # $e_o[n]=od\{e[n]\} (u[n+5]-u[n-5]);$
%
% This should be done initially without the aid of the computer, but you
% may use the functions *x lshift*, *x subtract*, *x truncate*,
% *x reverse*, and *x view* to check your results.

%   Copyright 2012-2016, Ilias S. Konsoulas

%% Workspace Initialization.

clc; clear; close all;

%% Generate the basic signals of common length 16.
N = 16;
n = 0:N-1;

b = ones(1,N);  % Block of ones.
r = n;                  % Ramp function.

P = 8;  % Triangular wave period.
n1 = 0:P/2-1;
n2 = P/2:P-1;
P1 = P*ones(1,length(n2));
A = 1;

tri_block = [2*A*n1/P 2*A*(P1-n2)/P]  ; 
t = [tri_block tri_block]; % % Periodic Triangular wave 

e = (5/6).^n; % One sided exponential.

%% a. Create and display õ[n] = r[n-6]*u[n].
figure('Name','Exercise 2.1.3. Elementary Signals');
subplot(3,1,1);
stem(n,r);
grid;
hold on;
stem(n+6,r,'r*');
title('r[n] (blue) and õ[n]=r[n-6]*u[n] (red)');

%% b. Create and display á[n]=b[n]-b[n-6].
a = [b(1:6) zeros(1,10)];
subplot(3,1,2);
stem(n,b);
grid;
hold on;
stem(n,a,'r*');
title('b[n] (blue) and á[n]=b[n]-b[n-6] (red)');

%% c. Create and display y[n]=e[n+10]*b[n].

y = [e(11:16) zeros(1,10)].*b;
subplot(3,1,3);
stem(n,e);
grid;
hold on;
stem(n-10,e,'r*');
stem(n,y,'g');
title('e[n] (blue), e[n+10] (red) and y[n]=e[n+10]*b[n] (green)');

%% d. Create and display z[n]=t[n]*(u[n]-u[n-10]).
z = [t(1:10) zeros(1,6);];

figure('Name','Exercise 2.1.3. Elementary Signals');
subplot(3,1,1);
stem(n,t);
grid;
hold on;
stem(n,z,'r*');
title('t[n] (blue) and z[n]=t[n]*(u[n]-u[n-10]) (red)');

%% e. Create and display e_e[n]=even{e[n]}*(u[n+5]-u[n-5]).

m = -N+1:N-1; % The whole duration of the signal is 2*(N-1) + 1.

e_ext = [ zeros(1,N-1) e];

% figure(3);
% stem(m,e_ext);
% grid on;

e_even = (e_ext + fliplr(e_ext))/2;
e_odd   = (e_ext - fliplr(e_ext))/2;

subplot(3,1,2);
stem(m,e_even);
grid;
hold on;
stem(-5:4,e_even(11:20),'r*');
title('e_e_v_e_n[n] (blue) and e_e[n]=e_e_v_e_n[n]*(u[n+5]-u[n-5]) (red)');

%% f. Create and display e_o[n]=odd{e[n]}*(u[n+5]-u[n-5]).

subplot(3,1,3);
stem(m,e_odd);
grid;
hold on;
stem(-5:4,e_odd(11:20),'r*');
title('e_o_d_d[n] (blue) and e_o[n]=e_o_d_d[n]*(u[n+5]-u[n-5]) (red)');


