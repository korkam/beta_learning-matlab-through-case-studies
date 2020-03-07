% Exercise 4.2.3. Pulse Code Modulation (PCM).

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Signal Definition:
n = 0:127;
sig1 = [  0.053072   2.50476    6.28272   5.66692      7.15524    4.74468   4.05338    -0.951826  -0.355782  -0.178474 ...
             -4.53328    -1.77349  -1.18494    6.49746       8.88762    7.2847      8.77318   12.5205       8.69112      5.56718 ... 
              2.33496     0.669848 -6.669        -3.90154      3.6807      6.9564    12.2854     15.003       13.6003      14.7413 ...
            12.7436       7.9413       2.6083      0.083313   -8.67922  -5.9038     -6.60358     3.48682     6.69906   11.8809 ...
            16.1609     14.8135     19.0071     8.27394       1.93774  -0.732094 -1.74249  -9.66668     -4.2829       0.635162 ...
              5.79418     4.29612   18.4729   14.9448       17.0403   13.1003       7.84108   4.33852     -0.73204    -8.06208 ...
            -9.98264     0.147254 -1.33437    5.11608     11.7541   13.7578     17.2883   11.3011       12.4756     12.6692 ...
            -5.1785      -4.83242 -11.1247   -10.3123       -4.65992    9.26004     7.72928 13.2496       13.6202     13.6527 ...
           11.0848       6.71036     6.84748    3.13742     -0.125101 -2.89924    -4.09132   0.74125       0.573994   6.70654 ...
           13.8819     15.5512     15.5392      8.57646      2.40868     3.33468    -1.17195  -0.921316   -0.748508  -6.13324 ...
             2.70514     6.7956     11.6155    15.1737      10.7859        8.58418      5.30204   1.99815      0.0601832 -5.979 ...
           -2.99086    -6.35042     3.17674     1.1939        8.85262   10.0346       11.5943   11.0055       7.68358       4.79346 ...
          -0.840252   -2.34162    -0.561824  -0.832206  -0.684186    3.35212      6.00404   8.0498];
     
    sig1q = zeros(1,length(sig1));
    
    Xmax = max(sig1);
    Xmin = min(sig1);
    K = (Xmax - Xmin)/2;
    Px = 1/length(sig1)*sum(sig1.^2);
     
 %% Steps (a)-(b). Quantize r[n] to eight levels. 
bps = [3 4 6 8 10 16]; % use bps(i) bits per sample.

for i=1:6

figure('Name','Exercise 4.2.3. Pulse Code Modulation (PCM)');
subplot(2,1,1);
stem(n,sig1);
grid on;
axis tight;
hold on;
title('Original Signal sig1 (blue) and Quantized Signal (red)');
     
L = 2^bps(i);

sig1q = uniform_quantizer(sig1, L, Xmax, Xmin); 

stem(n,sig1q,'rx');

%% Compute and display the error signal.
e = sig1q - sig1;
subplot(2,1,2);
stem(n,e);
grid on;
axis tight;
title(['Quantization Error e_q[n] = rhat[n] - r[n] for ',num2str(bps(i)),' bits per sample']);
disp(['Quantization of sig1[n] using: ',num2str(bps(i)),' bits per sample']);
disp(['The max absolute value of quantization error is: ', num2str(max(abs(e)))]);
disp(['The actual SNR for this quantization is:               ', num2str(10*log10(sum(sig1.^2)/sum(e.^2))), ' dB']);
disp(['The theoretical SNR for this quantization is:       ', num2str(6.02*bps(i) + 10*log10(3*Px/K^2)),  ' dB']);
disp('  ');
% The relationship between the bits used and the SNR is: SNR(dB) = 6.02*bps
% + 10*log10(3K), K = Px/K^2. Px: source signal power, K = (Xmax - Xmin)/2.
% 
end
