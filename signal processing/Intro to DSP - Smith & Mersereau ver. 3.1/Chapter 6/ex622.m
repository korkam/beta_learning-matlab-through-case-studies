% Exercise 6.2.2. Circular Convolution.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Steps (b).
n = 0:9;
x = [ones(1,8) 0 0];

x_circconv = cconv(x,x,10); 

figure('Name',' Exercise 6.2.2. Circular Convolution');
subplot(2,1,2);
stem(n,x_circconv);
hold on;
grid on;

Samples = 10;
% Now compute the 10-point DFT of x[n]: 
X = my_DFT(x); 
   
% Now compute the 10-point inverse-DFT of X[n]*X[n]: 
x_circ = my_IDFT(X.*X);

% Or, using the definition formula:
% for k=0:Samples-1
%       for n1=0:Samples-1
%             x_circ(k+1) = x_circ(k+1) + 1/Samples*X(n1+1)*X(n1+1)*exp(j*2*pi*n1*k/Samples);
%        end
% end

%% Plot the results.
% Plot the shifted version of the sequence x[n];
% figure('Name',' Exercise 6.2.2. Circular Convolution');
subplot(2,1,1);
stem(n,x);
title('x[n]');
xlabel('Sample Number n');
axis tight;
grid on;

% Plot the real part of the IDFT of of X[n]*X[n]:
subplot(2,1,2);
stem(n,real(x_circ),'r.');
title('10-point Circular Convolution of x[n] with itself computed by IDFT (red) and by cconv(.) (blue)');
xlabel('Sample Number n');
axis tight;
grid on;
