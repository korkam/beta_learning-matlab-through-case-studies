% Exercise 6.4.3. Extracting Good Values from Circular Convolutions.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Signal Definitions:
N1 = 128;
x = randn(N1,1);

% Create the low-pass filter h[n].
N2 = 16;
w0 = pi/3; % Cutoff frequency.
h = [ sin(w0.*(-N2/2:-1))./(pi.*(-N2/2:-1)) w0/pi sin(w0.*(1:N2/2-1))./(pi.*(1:N2/2-1)) ].';

win = hamming(N2);

%% a. Calculate the linear and the circular convolutions.

y1 = conv(win.*h,x);
y2 = cconv(win.*h,x,N1);

figure('Name','Exercise 6.4.3. Extracting Good Values from Circular Convolutions');
subplot(2,1,1);
stem(y1);
grid on;
hold on
stem(y2,'r.');
title(['Linear Convolution (blue circles) vs Circular Convolution (red dots) of size N =', num2str(N1),'.']);
axis tight;

e = y1-[y2; zeros(N2-1,1)];
Le = length(e);

for k=1:Le
subplot(2,1,2);
    if abs(e(k))>1e-10
       stem(k,e(k) ,'r*');
       hold on;
    else
        stem(k,e(k) ,'bo');
     end
end
title('Difference between the 2 convolution sequences');
grid on;
axis tight;

% Here is the number of unequal values between the 2 convolution sequences:
disp(['Number of total unequal convolution values are 2*(N2-1) = ', num2str(sum(abs(y1-[y2; zeros(N2-1,1)])>1e-8))]);

% The number of unequal values are 2*(N2-1).
% If you ignore the trailing N2-1 unequal values, due to the fact that
% the circular convolution sequence lasts only N samples, then the 
% net amount of unequal values are the first N2-1 values of it.
% N2 is the length of the shorter sequence.
