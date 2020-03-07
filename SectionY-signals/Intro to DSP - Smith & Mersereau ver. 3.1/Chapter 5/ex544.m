% Exercise 5.4.4. Poles and Zeros at Infinity.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% System function definition:
b = [2 -3/4];         % Numerator Coefficients.
a = [1 -3/4 1/8];  % Denominator Coefficients.

% [z p k] = tf2zpk(b,a);  % Find the poles and zeros of the original function.

%% a. Produce and display the Poles/Zeros plot.
figure('Name','Exercise 5.4.4. Poles and Zeros at the Origin and at Infinity'); 
subplot(3,2,1);
zplane(b,a);
xlim([-1.5 1.5]);
ylim([-1 1]);
title(['H(z) has a single zero at the origin';
        '    or a single pole at Infinity    ']);

% Find and plot the implulse response.
delta = [1 zeros(1,15)];
h = filter(b,a,delta); % Calculate the first 16 points of h[n].

subplot(3,2,2);
stem(0:15,h);
grid on;
title('h[n] = \{(1/2)^n+(1/4)^n\}*u[n]');
axis tight;

%% b.(i). Insert a zero at z = 0. This happens by multipying the system function H(z) 
% by z (or by dividing with z^-1). However, by this operation, the system function H(z) becomes 
% improper and MatLab symbolic toolbox cannot handle it. Therefore, I illustrate what happens
% to the impulse response manually. All in all the impulse response sequence advances a single
% step forward and therefore it starts from n=-1. This makes the system noncausal.
% Inserting a zero at the origin is equivalent of adding a pole at Infinity.

% As noted above, the following lines of code do not work:
% The new system function H1(z) = z*H(z) is:
% H1 = (2*z - 3/4)/(1 - 3/4*z^(-1) + 1/8*z^(-2));
% h11= simplify(iztrans(H1))
n1 = -1:14;  
%h1 = double(subs(h11,n,n1)); % If MatLab could figure this out, it would
% correspond to an impulse response of a non-causal system as shown on the next plot:
subplot(3,2,4);
stem(n1,h,'*r');
title('h_1[n] = \{(1/2)^{n+1}+(1/4)^{n+1}\}*u[n+1]');
grid on;
axis tight;

subplot(3,2,3);
zplane(b,a);
title(['H_1(z) = zH(z) has a double zero at the origin';
        '         or a double pole at Infinity         ']);
xlim([-1.5 1.5]);
ylim([-1 1]);

%% c. Introduce a pole at z = 0. This happens when we multiply the numerator of H(z) by z^(-1):
% This is equivalent to adding a pole at Infinity.

b2 = [0   2  -3/4];  % Numerator Coefficients.
a2 = [1 -3/4 1/8];  % Denominator Coefficients.

% Produce and display the Poles/Zeros plot.
subplot(3,2,5);
zplane(b2,a2);
title(['H_2(z) = z^{-1}H(z) has no zero at the origin';
        '            and no pole at Infinity          ']);
xlim([-1.5 1.5]);
ylim([-1 1]);

% Find and plot the implulse response.
delta = [1 zeros(1,15)];
h2 = filter(b2,a2,delta); % Calculate the first 16 points of h[n].

subplot(3,2,6);
stem(0:15,h2,'g.');
grid on;
title('h_2[n] = \{(1/2)^{n-1}+(1/4)^{n-1}\}*u[n-1]');
axis tight;
