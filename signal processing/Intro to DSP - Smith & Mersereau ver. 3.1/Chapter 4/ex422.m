% Exercise 4.2.2. Quantization Effects.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Step. a. Generate and plot the "analog" signal x_á(t):
Period = 20;
n = 0:Period/2;
A = 0.01;

half_block = 2*A*n/Period; 
second_half = fliplr(half_block(2:end-1));
block = [half_block second_half];
x1 = [block block block block block 0]; % Triangular Wave form with period 20 samples and 
                                                                  % max amplitude A=0.001
y1 = 0:100; % Linearly Increasing Envelope.

x = x1.*y1;
nx = y1;       % Time indices of samples.
Ts = 0.001; % Sampling period in seconds.
t = nx*Ts;   % Conversion to "analog" time.

figure('Name','Exercise 4.2.2. Quantization Effects');
plot(t,x);
title('"Analog" Input Signal x_{\alpha}(t)');
xlabel('time (sec)');
grid on;

%% Step b. Calculate the output of the A/D and D/A system for various
% number of quantization levels.
bps      = 1:10; % bits per sample, i.e. 2,4,8,...1024 levels.
Levels = 2.^bps;
Xmin   = min(x);
Xmax  = max(x);

% Preallocate the matrix that will hold the outputs.
y = zeros(10,101);
e = zeros(10,101);
SNR = zeros(1,10);

figure('Name','Exercise 4.2.2. Quantization Effects');
for i=1:5
    
    y(i,:) = AD_DA(x,Xmin,Xmax,Levels(i));
    e(i,:) = y(i,:) - x;      
    SNR(i) = 10*log10(sum(x.^2)/sum(e(i,:).^2));
    
    subplot(5,2,2*i-1);
    plot(t,x);
    hold on;
    plot(t,y(i,:),'r');
    title('Input Signal x_{\alpha}(t) (blue) and A/D&D/A Output Signal y_{\alpha}(t) (red)');
    grid;
    axis tight;
        
    subplot(5,2,2*i);
    plot(t,e(i,:),'g');
    title(['Error Signal e(t) = x_{\alpha}(t) - y_{\alpha}(t) for ',num2str(Levels(i)),' Quant. Levels']);
    grid;
    axis tight;    
    
end

figure('Name','Exercise 4.2.2. Quantization Effects');
for i=6:10
    
    y(i,:) = AD_DA(x,Xmin,Xmax,Levels(i));
    e(i,:) = y(i,:) - x;      
    SNR(i) = 10*log10(sum(x.^2)/sum(e(i,:).^2));
    
    subplot(5,2,2*i-11);
    plot(t,x);
    hold on;
    plot(t,y(i,:),'r');
    title('Input Signal x_{\alpha}(t) (blue) and A/D&D/A Output Signal y_{\alpha}(t) (red)');
    grid;
    axis tight;
    
    subplot(5,2,2*i-10);
    plot(t,e(i,:),'g');
    title(['Error Signal e(t) = x_{\alpha}(t) - y_{\alpha}(t) for ',num2str(Levels(i)),' Quant. Levels']);
    grid;
    axis tight;    
    
end

%% Plot the SNR for various Quantization Levels.
figure('Name','Exercise 4.2.2. Quantization Effects');
stem(bps,SNR,'m*');
xlabel('log_2(Quantization Levels)');
ylabel('SNR (dB)');
title('Output SNR for various Quantization Levels');
grid;
