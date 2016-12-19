% Exercise 6.1.4. Spatial Aliasing.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Step (a). 
N = 128;    % Number of signal samples.
n = 0:N-1;
x = (39/40).^n;

% Now compute the 128-point DFT of x[n]: 
X = my_DFT(x);
 
% Plot the results.
k = 0:N-1;
figure('Name','Exercise 6.1.4. Spatial Aliasing'); 
% Plot the DFT magnitude of x[n]:
subplot(3,1,1);
stem(k,abs(X),'bx');
title('|X[k]|  = |DFT\{x[n]\}|, n=0,1,...127');
xlabel('Sample Number k');
hold on;
axis tight;
grid on;

%% Step (b). Generate the 64-point sequence y[n] by spatial aliasing.
% y[n] = x[n] + x[n+64];
N = 64;
y = x(1:64) + x(65:128);

% Now compute the 64-point DFT of y[n]: 
Y = my_DFT(y);
 
% Plot the DFT magnitude of y[n]:
k = 0:N - 1;
subplot(3,1,2);
stem(k,abs(Y),'bx');
title('|Y[k]|  = |DFT\{y[n]\}| = |DFT\{x[n]+x[n+64]\}|, n=0,1,...,63');
xlabel('Sample Number k');
hold on;
axis tight;
grid on;

%% Step (c). Generate the 32-point sequence z[n] by spatial aliasing.
% z[n] = y[n] + y[n+32];
N = 32;
z = y(1:32) + y(33:64);

% Now compute the 32-point DFT of z[n]:
Z = my_DFT(z);
 
% Plot the DFT magnitude of y[n]:
k = 0:N - 1;
subplot(3,1,3);
stem(k,abs(Z),'bx');
title('|Z[k]|  = |DFT\{z[n]\}|= |DFT\{y[n]+y[n+32]\}|, n=0,1,...,31');
xlabel('Sample Number k');
hold on;
axis tight;
grid on;

%% Plot all the results together to show where the individual samples of Y[k] and Z[k]
% correspond in the X[k] DFT.
figure('Name','Exercise 6.1.4. Spatial Aliasing');
subplot(2,1,1);
stem(0:127,abs(X));
title('|X[k]| vs |Y[k]|\uparrow2');
xlabel('Sample Number k');
hold on;
axis tight;
grid on;

Y_mod = [];
for k=1:64
    Y_mod = [Y_mod Y(k) 0]; %#ok<*AGROW>
end

stem(0:127,abs(Y_mod),'r*');

subplot(2,1,2);
stem(0:127,abs(X));
title('|X[k]| vs |Z[k]|\uparrow4');
xlabel('Sample Number k');
hold on;
grid on;
axis tight;

Z_mod = [];
for k=1:32
    Z_mod = [Z_mod Z(k) zeros(1,3)];
end

stem(0:127,abs(Z_mod),'g*');
