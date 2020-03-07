% Exercise 6.3.3. Computational Complexity of the FFT.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clear; clc; close all;

powers = 4:11;
lengths = 2.^powers;
timeFFT = zeros(size(powers));
timeDFT = zeros(size(powers));

for i=1:length(lengths)
% Compute its N-point DFT:
    Samples = lengths(i);
    x = rand(1,Samples);
      
    tic
    X = my_DFT(x); 
    timeDFT(i) = toc;
 
    tic
    X2 = fft(x);
    timeFFT(i) = toc;
end

 %% Plot the results.
figure('Name','Exercise 6.3.3. Computational Complexity of the FFT');
plot(log2(lengths),timeDFT,'b*-');
hold on;
plot(log2(lengths),timeFFT,'r*-');
grid on;
ylabel('Execution Time (sec)');
xlabel('Sequence Length in Log_2 Scale: log_2(length(x))');
title('DFT (blue) vs FFT (red) Execution Time)');
