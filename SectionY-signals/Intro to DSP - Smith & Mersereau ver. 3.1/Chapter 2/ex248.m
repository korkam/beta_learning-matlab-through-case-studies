% Exercise 2.4.8. Random Sequences.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace initialization.

clc; clear; close all;

%% Signal Definitions.

NumOfSamples = 16*1024;
bins = 100;

%% Step (a).
% Scale the Uniform random sequence x1 into the interval (-50,50).
% And plot its histogram.
X = rand(10,NumOfSamples) - 0.5*ones(10,NumOfSamples);

y = 100*X(1,:);

figure('Name','Exercise 2.4.8. Random Sequences');
subplot(1,2,1);
hist(y,bins);
grid on;
title('Histogram of x_1[n] = 100*[rand(1,N) - 0.5]');
xlim([-50 50]);

%% Step (b). Add the sequences x1[n] to x10[n] and display their histograms.
y2 = sum(12*X);
 
subplot(1,2,2);
hist(y2,bins); 
title('Histogram of y_2[n] = 12*(x_1[n] + x_2[n] + ... + x_{10}[n])');
grid on;
xlim([-50 50]);

y3 = y;
figure('Name','Exercise 2.4.8. Random Sequences');
subplot(2,5,1);
hist(y,bins);
title('Histogram of z_1[n] = x_1[n]');
grid on;
xlim([-50 50]);

for n = 2:10
      y3 = y3 + 100*X(n,:);
      subplot(2,5,n);
      hist(y3,bins);
      grid on;
      if n<10
          title(['Histogram of z_',num2str(n),'[n] = z_',num2str(n-1),'[n] + x_',num2str(n),'[n]']);
      else
          title('Histogram of z_1_0[n] = z_9[n] + x_{10}[n]');
      end
      xlim([-300 300]);
end
