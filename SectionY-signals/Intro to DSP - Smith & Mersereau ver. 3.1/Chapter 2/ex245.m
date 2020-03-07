% Exercise 2.4.5. Nonlinear Difference Equations.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.
clc; clear; close all;

%% a. 
N = 100;
n = 0:N-1; 
a = 1;
tau = .02;
f = exp(-a.*(n.*tau).^2);

figure('Name','Exercise 2.4.5. Nonlinear Difference Equations');
subplot(2,2,1);
stem(n,f);
grid on;
hold on;

%% b. 
c = exp(-2*a*tau^2);

f1 = zeros(1,N);
% Initial Values.
f1_1 = exp(-a*tau^2);    % for n=-1;
f1(1) = 1;                        % for n = 0; 
f1(2) = c*f1(1)^2/f1_1;  % for n = 1;

for k=2:N-1;
    f1(k+1) = c*f1(k)^2/f1(k-1);
end

subplot(2,2,1);
stem(0:N-1,f1,'r.');
title(['    Gaussian Function Approximation      ';
         'Nominal (blue) and Teager''s formula (red)' ]);

%% c.

f2 = zeros(1,N);
h = zeros(1,N);

% Initial Values.
h(1) = f1(1)/f1_1; % for n = 0;
f2(1) = f1(1);         % for n = 0;

for k=1:N-1
    h(k+1) = c*h(k);
    f2(k+1) = h(k+1)*f2(k);
end

subplot(2,2,2);
stem(n,f);
hold on;
stem(0:N-1,f2,'g.-');
grid on;
title(['     Gaussian Function Approximation       ';
        'Nominal (blue) and Kaiser''s formula (green)']);

subplot(2,2,3);
stem(0:N-1,f-f1,'r.');
grid on;
title('Approximation Error due to Teager''s formula');

subplot(2,2,4);
stem(0:N-1,f-f2,'g.');
grid on;
title('Approximation Error due to Kaiser''s formula');
