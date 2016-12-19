% Exercise 6.5.3. The Discrete Cosine Transform (DCT).

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace initialization.
clc; clear; close all;

% Period = 65;
% n = 0:(Period-1)/2;
% A = 1;
% half_block = 2*A*n/(Period-1); 
% second_half = fliplr(half_block(2:end));
% block = [half_block second_half];
% x = [block block];

N = 256;
x = randn(1,N)+1i*randn(1,N);

X = my_DCT(x);
X1 = dct(x);

figure('Name',' Exercise 6.5.3. The Discrete Cosine Transform (DCT)');
subplot(2,1,1);
stem(real(X-X1),'.');
title(' \Ree\{my\_DCT(x) - dct(x)\}');
axis tight;
grid;

subplot(2,1,2);
stem(imag(X-X1),'r.');
title(' \Imm\{my\_DCT(x) - dct(x)\}');
axis tight;
grid;
