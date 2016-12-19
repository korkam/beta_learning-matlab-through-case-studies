% Exercise 5.2.5. Effect of the ROC.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.
clc; clear; close all;
syms z n;

%% Part a.
b1 = [1 0 -2];          % Numerator Coefficients.
a1 = [1 1/6 -1/6];    % Denominator Coefficients.
H1 = (1-2*z^(-2))/(1+1/6*z^(-1)-1/6*z^(-2));

h1 = simplify(iztrans(H1));
n1 = 0:15;
h11 = double(subs(h1,n,n1));

n2 = -15:-1;
h12 = double(subs(h1,n,n2));

% Also, one may compute the inverse z-transform using the partial fraction expansion:
[r1 p1 k1] = residuez(b1,a1);
hh11 = 12*[1 zeros(1,length(n1)-1)] + r1(1)*p1(1).^n1 + r1(2)*p1(2).^n1;
hh12 = r1(1)*p1(1).^n2 + r1(2)*p1(2).^n2;

figure('Name','Exercise 5.2.5. Effect of the ROC');
subplot(1,2,1);
zplane(b1,a1);
title('ROC = \{z : |z|>1/2\}, system is stable');

subplot(2,2,2);
stem(n1,h11);
hold on;
stem(n1,hh11,'r*');
title('h_1[n], n\geq0');
grid on;
axis tight;

subplot(2,2,4);
stem(n2,h12);
hold on;
stem(n2,hh12,'r*');
title('h_1[n], n<0');
grid on;
axis tight;

%% Part b.
b2 = 1;      % Numerator Coefficients.
a2 = [1 -2 0 2 -2 2 0 -2 1];   % Denominator Coefficients.
% 8 zeros at the origin.
% poles = [ -1 -1  j  -j  1 1 1 1]; 

H2 = 1/(1-2*z^(-1)+2*z^(-3)-2*z^(-4)+2*z^(-5)-2*z^(-7)+z^(-8));

h2 = simplify(iztrans(H2));
n1 = 0:31;
h21 = double(subs(h2,n,n1));

n2 = -31:-1;
h22 = double(subs(h2,n,n2));

figure('Name','Exercise 5.2.5. Effect of the ROC');
subplot(1,2,1);
zplane(b2,a2);
title('ROC = \{z : |z|>1\}, system is unstable');

subplot(2,2,2);
stem(n1,h21);
title('h_2[n], n\geq0');
grid on;
axis tight;

subplot(2,2,4);
stem(n2,h22);
title('h_2[n], n<0');
grid on;
axis tight;
