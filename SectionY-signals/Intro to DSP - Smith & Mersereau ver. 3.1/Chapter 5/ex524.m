% Exercise 5.2.4. Computing the Inverse z-Transform.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.
clc; clear; close all;

%% System Function definition.
% H = 1/(1 - 5*z^(-1) + 5.75*z^(-2) + 1.25*z^(-3) - 1.5*z^(-4));
b = 1;                                        % Numerator coefficients.
a = [1  -5   5.75   1.25   -1.5];  % Denominator coefficients.
% Zeros: 4 at the origin.
% Poles: [-1/2  1/2  2  3]

%% Step (a). Determine the impulse response using partial fractions.
% If we assume that H(z) describes a causal system then h[n] is a
% Right-sided sequence and the ROC is {z : |z|>max(|pi|)=3}.
[r, p, k] = residuez(b,a);

n1 = 0:16;
hcausal = r(1)*p(1).^n1 + r(2)*p(2).^n1 + r(3)*p(3).^n1 + r(4)*p(4).^n1;

figure('Name','Exercise 5.2.4. Computing the Inverse z-Transform');
subplot(2,2,1);
stem(n1,hcausal,'*');
title('h[n], n\geq0 (causal)');
grid on;
axis tight;

%% Step (b). Assume that this system function corresponds to an anticausal system.
% Since H(z) describes an anticausal system, h[n] is a left-sided sequence
% and in this case the ROC is {z : |z|<min(|pi|)=1/2}.
n2 = -20:-1;
hanticausal = r(1)*p(1).^n2 + r(2)*p(2).^n2 + r(3)*p(3).^n2 + r(4)*p(4).^n2;

subplot(2,2,2);
stem(n2,hanticausal,'r*');
title('h[n], n<0 (anticausal)');
grid on;
axis tight;

% figure('Name','Exercise 5.2.4. Computing the Inverse z-Transform');
subplot(2,1,2);
zplane(b,a);
title('H(z) Poles and Zeros');
grid on;
