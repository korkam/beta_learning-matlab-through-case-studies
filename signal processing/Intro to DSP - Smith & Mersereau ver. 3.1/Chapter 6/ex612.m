% Exercise 6.1.2. Direct DFT Evaluation.
% This script demonstrates the DFT calculation time needed
% when the definition formula is used.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.
clc; clear; close all;

%% (a). DFT Execution Time of Random Sequences with variable size.
Seq_Size = 2.^(4:10); % Various Sequence Sizes selected as powers of 2.
L = length(Seq_Size);
T = zeros(1,L);

for i=1:L
     Samples = Seq_Size(i);
     x = rand(1,Samples) + 1i*rand(1,Samples);
     X = zeros(1,Samples);

    tic;
    for k=0:Samples-1
         for n=0:Samples-1
              X(k+1) = X(k+1) + x(n+1)*exp(-1i*2*pi*n*k/Samples);
         end
    end
    T(i) = toc;
end
    
figure('Name','Exercise 6.1.2. Direct DFT Evaluation');
plot(log2(Seq_Size),T,'r*-');
title('Execution Time vs Sequence Length');
xlabel('log_2(Sequence Length)');
ylabel('Execution Time (sec)');
axis tight;
grid on;
