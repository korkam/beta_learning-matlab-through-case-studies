% Exercise 4.2.4. Differential PCM (DPCM).

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Input Signal Definition.
n = 0:127;
sig2 = [  -0.274444    -0.158955   -0.167545   -0.165211   -0.154067   -0.320626   -0.749707    -1.1583     -1.10281       -0.492357 ...
                0.271884     0.768013     1.03283      1.42601       2.07593      2.6392         2.67847       2.20081     1.7232          1.74708 ...
                2.19292       2.48789        2.27761      1.86289       1.7358        1.8546         1.6893         0.939427  -0.0728632  -0.744631 ...
               -0.729974   -0.190663      0.268538    0.0210645 -0.935608   -1.86542     -2.14922     -2.10712    -2.56296       -3.68731 ...
               -4.71406     -4.81841       -3.93683     -2.71228      -1.90939     -1.84222     -2.09811     -1.94242    -1.27889       -0.904643 ...
               -1.35155     -1.86906       -1.31318      0.179706     1.27598       1.18847      0.522903    0.264174    0.674371      1.39601 ...
                1.94644      1.93291         1.42226      1.16511       1.78753       2.80757      3.17272      2.63765       1.83751        1.20592 ...
                0.740349    0.661187      1.21962       1.88343      1.82934       1.25857       1.08766     1.37117        1.27045       0.597237 ...
                0.106065    0.124149      0.11511     -0.176149   -0.309803    -0.170674   -0.283292  -0.759003    -1.01958      -0.913395 ...
              -1.00485      -1.44554       -1.6533       -1.40785      -1.18962      -1.17762     -0.998523  -0.729378    -0.996981    -1.7157 ...
              -1.91439      -1.28989       -0.737964   -0.817325   -0.91145      -0.496191   -0.0469474 -0.0514117 -0.184242    -0.0794939 ...
               0.0107923 -0.0937298   -0.0292553  0.338215    0.515594     0.290003     0.1678         0.405325     0.520231     0.256455 ...
               0.101658    0.346782       0.525275    0.314985    0.159542     0.419079     0.669932     0.482865 ];

Xmax = max(sig2);
Xmin = min(sig2);
K = (Xmax - Xmin)/2;
Px = 1/length(sig2)*sum(sig2.^2);
    
figure('Name','Exercise 4.2.4. Differential PCM (DPCM)');
subplot(3,1,1);
stem(n,sig2);
grid on;
axis tight;
title('Original Signal x[n] = sig2[n] (blue) and reconstructed version xhat[n] (green)');
hold on;
     
 %% Step (a) Calculate sequence y[n]. 
h = [1 -0.8];
y = conv(sig2,h);

n2 = 0:length(y)-1;
subplot(3,1,2);
stem(n2,y);
grid on;
axis tight;
title('Differential Signal y[n] = x[n] - 0.8x[n-1] (blue) and quantized version yhat[n] (red)');
hold on;

% Now quantize the y[n] signal using 4 bits per sample:
bps = 4;
L = 2^bps;
yq = uniform_quantizer(y,L,max(y),min(y));

stem(n2,yq,'rx');

%% Reconstruct the signal x[n] by applying the inverse filter: xhat[n] = 0.8xhat[n-1] + yhat[n]:
binv = 1; ainv = [1 -0.8];
xhat = filter(binv,ainv,yq);

subplot(3,1,1);
stem(n,xhat(1:128),'gx');

%% Compute and display the error signal.
e = xhat(1:128) - sig2;
subplot(3,1,3);
stem(n,e);
grid on;
axis tight;
title(['DPCM Quantization Error e_q[n] = xhat[n] - x[n] for ',num2str(bps),' bits per sample']);
disp(['DPCM Quantization Error using: ',num2str(bps),' bits per sample']);
disp(['The max absolute value of quantization error is: ', num2str(max(abs(e)))]);
disp(['The actual SNR for DPCM quantization is:         ', num2str(10*log10(sum(sig2.^2)/sum(e.^2))), ' dB']);
disp('  ');

%% Step (b). Determine how many quantization levels would be required in a PCM
% encoder to achieve the same SNR.
% Now quantize the original signal x[n] signal using a 16 level PCM encoder:
bps1 = 4;
L1 = 2^bps1;

xq = uniform_quantizer(sig2,L1,max(sig2),min(sig2));
ex = xq - sig2;

disp(['PCM Quantization Error using: ',num2str(bps1),' bits per sample']);
disp(['The max absolute value of quantization error is: ', num2str(max(abs(ex)))]);
disp(['The actual SNR for PCM quantization is:            ', num2str(10*log10(sum(sig2.^2)/sum(ex.^2))), ' dB']);
disp('  ');

%% Step (c). Find the optimum value of alpha that maximizes the SNR.
a = 0.1:0.00025:0.9; 
SNR = zeros(size(a));

for i=1:length(a)
     
     % First create the 1st order FIR (differentiation) filter
     h = [1 -a(i)];
     y = conv(sig2,h); % apply the 1st order FIR filter.
   
     % Perform quantization on the output signal y[n].
    yq = uniform_quantizer(y,L,max(y),min(y));
   
    % Create the inverse 1st order IIR (reconstruction) filter
    binv = 1; ainv = [1 -a(i)];
    xhat = filter(binv,ainv,yq); % apply the IIR filter.
    
    % Measure the error and the SNR
    ex = xhat(1:128) - sig2;
    SNR(i) = 10*log10(sum(sig2.^2)/sum(ex.^2));

end

figure('Name','Exercise 4.2.4. Differential PCM (DPCM)');
plot(a,SNR');
grid on;
ylabel('SNR (dB)');
xlabel('\alpha values');

[value index] = max(SNR);
disp(['The measured SNR is maximum for á = ', num2str(a(index)), ' and  its value is ',num2str(value),' dB']);


