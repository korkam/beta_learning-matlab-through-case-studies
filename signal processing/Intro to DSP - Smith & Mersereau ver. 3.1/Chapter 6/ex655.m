% Exercise 6.5.5. Transform Coding.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace initialization.

clc;  clear; close all;

%% Signal Definition.
n = 0:127; N=128;
sig2 = [-0.274444 -0.158955 -0.167545 -0.165211     -0.154067  -0.320626 -0.749707 -1.1583     -1.10281     -0.492357 ...
              0.271884  0.768013  1.03283     1.42601        2.07593      2.6392       2.67847    2.20081    1.7232         1.74708 ...
              2.19292    2.48789     2.27761     1.86289       1.7358        1.8546        1.6893      0.939427 -0.0728632 -0.744631 ... 
             -0.729974 -0.190663  0.268538   0.0210645 -0.935608  -1.86542     -2.14922  -2.10712    -2.56296      -3.68731 ...
             -4.71406   -4.81841   -3.93683    -2.71228      -1.90939    -1.84222     -2.09811  -1.94242    -1.27889      -0.904643 ...
             -1.35155   -1.86906   -1.31318     0.179706     1.27598      1.18847     0.522903  0.264174   0.674371     1.39601 ...
              1.94644    1.93291     1.42226     1.16511       1.78753      2.80757     3.17272    2.63765     1.83751        1.20592 ...
              0.740349  0.661187   1.21962    1.88343       1.82934      1.25857     1.08766    1.37117      1.27045       0.597237 ...
              0.106065  0.124149   0.11511   -0.176149   -0.309803  -0.170674  -0.283292 -0.759003  -1.01958      -0.913395 ...
            -1.00485   -1.44554     -1.6533     -1.40785     -1.18962    -1.17762    -0.998523  -0.729378  -0.996981    -1.7157 ...
            -1.91439   -1.28989    -0.737964  -0.817325  -0.91145    -0.496191  -0.0469474 -0.0514117 -0.184242 -0.0794939 ...
           0.0107923 -0.0937298 -0.0292553 0.338215 0.515594 0.290003 0.1678 0.405325 0.520231 0.256455 0.101658 ...
          0.346782    0.525275     0.314985   0.159542 0.419079 0.669932 0.482865];
      
%% a. Quantize x[n] to 17 levels between -4.82 and 4.82 and evaluate its SNR.  
% sig2q = zeros(1,N);    
Xmax = max(sig2);
Xmin = min(sig2);
K = (Xmax - Xmin)/2;
Px = 1/length(sig2)*sum(sig2.^2);
     
bps = 4; % use 4 bits per sample.

figure('Name','Exercise 6.5.5. Transform Coding');
subplot(2,1,1);
stem(n,sig2);
grid on;
axis tight;
hold on;
title('Original Signal sig_2[n] (blue) and Quantized Signal in time domain (red)');
     
L = 2^bps + 1; % We want an odd number of reproducer values in order to have the 
                          % zero-value quantization level (i.e. use a midtread quantizer).
                          % This assumes that Xmin = - Xmax. 
                         
max_level0 = max(sig2);
min_level0  = min(sig2);

% max_level0 = 4.82;
% min_level0 = -4.82;

% Midtread Quantizer Operation:
sig2q = uniform_quantizer(sig2,L,max_level0,min_level0);

stem(n,sig2q,'rx');
hold on;

% From Decision Levels and Reproducer Values vectors you can create 
% matrices for ploting purposes...
% dec_lev_mat = zeros(L+1,N);
% rep_val_mat  = zeros(L,N);
% for i=1:L+1
%     dec_lev_mat(i,:) = dec_lev0(i)*ones(1,N);
%     if i<=L
%        rep_val_mat(i,:)  = rep_val0(i)*ones(1,N);
%     end
% end

% plot(n,dec_lev_mat,'c');
% plot(n,rep_val_mat,'y');

% Compute and display the error signal.
e = sig2q - sig2;
subplot(2,1,2);
stem(n,e,'r.');
grid on;
axis tight;
title(['Quantization Error e_1_q[n] = sig_2_q[n] - sig_2[n] for ',num2str(bps),' bits per sample']);

disp(['"Uniform Quantization of sig2[n] using L = ',num2str(L),' levels"']);
% disp(['The maximum absolute value of quantization error e_q[n] is: ', num2str(max(abs(e)))]);
disp(['The actual SNR for this quantization is: ', num2str(10*log10(sum(sig2.^2)/sum(e.^2))), ' dB']);
disp(['The theoretical SNR for this quantization is: ', num2str(6.02*bps + 10*log10(3*Px/K^2)), ' dB']);
disp(['Using this coding we need to send ', num2str(bps*length(sig2)), ' bits in total']);
disp('  ');
disp('  ');
% The relationship between the bits used and the SNR is: SNR(dB) = 6.02*bps + 10*log10(3K).
% K = Px/K^2, Px: source signal power, K = (Xmax - Xmin)/2.

%% b. Compute and quantize the DFT of x[n].
X = fft(sig2);

Re_X = real(X);
Im_X = imag(X);

% Now quantize the real and imaginary parts of the DFT{sig2}:
% max_level1 = 80;
% min_level1 = -80;
 max_level1 = max(Re_X);
 min_level1  = min(Re_X);

Re_Xq = uniform_quantizer(Re_X,L,max_level1,min_level1);

% max_level2 = 61;
% min_level2  = -61;
 max_level2 = max(Im_X);
 min_level2  = min(Im_X);

Im_Xq = uniform_quantizer(Im_X,L,max_level2,min_level2);

% Next, recombine the quantized real and imaginary parts:
Xq = Re_Xq + 1i*Im_Xq;

% Truncation: Keep only the significant frequency components. i.e. the indices 0<=k<=32.
Xqt = [Re_Xq(1:33) zeros(1,N-65) fliplr(Re_Xq(2:33))] + 1i*[Im_Xq(1:33) zeros(1,N-65) -fliplr(Im_Xq(2:33))];  

% Return to time domain at the receiver end...
x    = real(ifft(Xq));
x1 = real(ifft(Xqt));

figure('Name','Exercise 6.5.5. Transform Coding');
subplot(2,1,1);
stem(n,sig2);
grid on;
axis tight;
hold on;
title('Original Signal sig_2[n] (blue), DFT Quantized (red), Truncated-to-33-points DFT and Quantized (green)');
stem(n,x,'rx');
stem(n,x1,'g.');

% Compute and display the error signal.
e2    = x - sig2;  % error due to DFT quantization.
e21 = x1 - sig2; % error due to DFT quantization and truncation.
subplot(2,1,2);
stem(n,e2,'r');
hold on;
stem(n,e21,'g.');
grid on;
axis tight;
title(['Quantization Error e_2_q[n] = IDFT\{DFT_q\{sig_2[n]\}\} - sig_2[n] (red) for ',num2str(bps),' bits per DFT sample';
        '  Quantization and Truncation Error e_2_q_t[n] = IDFT\{DFT_q_t\{sig_2[n]\}\} - sig_2[n] (green)   ']);

disp('"Coding via Discrete Fourier Transform Quantization"');
% disp(['The maximum absolute value of quantization error e2_q[n] is: ', num2str(max(abs(e2)))]);
disp(['The actual SNR for this quantization is: ', num2str(10*log10(sum(sig2.^2)/sum(e2.^2))), ' dB']);
disp(['Using this coding we need to send ', num2str(bps*length(X)), ' bits in total']);
disp('  ');
disp('"Coding via Truncated Discrete Fourier Transform Quantization"');
% disp(['The maximum absolute value of quantization error e2_q[n] is: ', num2str(max(abs(e21)))]);
disp(['The actual SNR for this quantization is: ', num2str(10*log10(sum(sig2.^2)/sum(e21.^2))), ' dB']);
disp(['Using this coding we need to send ', num2str(bps*33*2), ' bits in total']);
disp('  ');
disp('  ');

%% c. Signal coding via DCT quantization.
Y = my_DCT(sig2);

% Now quantize the Y[k] = DCT{sig2[n]}:
% max_level3 =  10;
% min_level3 = -10;
 max_level3 = max(Y);
 min_level3  = min(Y);

Yq = uniform_quantizer(Y,L,max_level3,min_level3);

% Create a truncated version of Yq[k].
Yqt = [Yq(1:66) zeros(1,N-66)];

% Now go back to the time domain...
y = idct(Yq);
y1 = idct(Yqt);

figure('Name','Exercise 6.5.5. Transform Coding');
subplot(2,1,1);
stem(n,sig2);
grid on;
axis tight;
hold on;
title('Original Signal sig_2[n] (blue), DCT Quantized (red), Truncated-to-66-points DCT and Quantized (green)');
stem(n,y,'rx');
stem(n,y1,'g.');

% Compute and display the error signal.
e3 = y - sig2;     % error due to DCT quantization.
e31 = y1 - sig2; % error due to DCT quantization and truncation.
subplot(2,1,2);
stem(n,e3,'r');
hold on;
stem(n,e31,'g.');
grid on;
axis tight;
title(['Quantization Error e_3_q[n] = IDCT\{DCT_q\{sig_2[n]\}\} - sig_2[n] (red) for ',num2str(bps),' bits per DCT sample';
        '  Quantization and Truncation Error e_3_q_t[n] = IDCT\{DCT_q_t\{sig_2[n]\}\} - sig_2[n] (green)   ']);

disp('"Coding via Discrete Cosine Transform Quantization"');
% disp(['The maximum absolute value of quantization error e3_q[n] is: ', num2str(max(abs(e3)))]);
disp(['The actual SNR for this quantization is: ', num2str(10*log10(sum(sig2.^2)/sum(e3.^2))), ' dB']);
disp(['Using this coding we need to send ', num2str(bps*length(Y)), ' bits in total']);
disp('  ');
disp('"Coding via Truncated Discrete Cosine Transform Quantization"');
% disp(['The maximum absolute value of quantization error e3_q[n] is: ', num2str(max(abs(e31)))]);
disp(['The actual SNR for this quantization is: ', num2str(10*log10(sum(sig2.^2)/sum(e31.^2))), ' dB']);
disp(['Using this coding we need to send ', num2str(bps*66), ' bits in total']);
disp('  ');
disp('  ');

%% d. Signal coding via DHT quantization.
Z = my_DHT(sig2);

% Now quantize the Z[k] = DHT{sig2[n]}:
% max_level4 = 120;
% min_level4  = -120;
 max_level4 = max(Z);
 min_level4  = min(Z);

Zq = uniform_quantizer(Z,L,max_level4,min_level4);

% Create a truncated version of Z[k]:
Zqt = [Zq(1:34) zeros(1,N-34-32) Zq(97:N)];

% Now go back to the time domain...
z = 1/length(sig2)*my_DHT(Zq);
z1 = 1/length(sig2)*my_DHT(Zqt);

figure('Name','Exercise 6.5.5. Transform Coding');
subplot(2,1,1);
stem(n,sig2);
grid on;
axis tight;
hold on;
title('Original Signal sig_2[n] (blue), DHT Quantized (red), Truncated-to-66-points DHT and Quantized (green)');
stem(n,z,'rx');
stem(n,z1,'g.');

% Compute and display the error signal.
e4 = z - sig2;     % error due to DHT quantization.
e41 = z1 - sig2; % error due to DHT quantization and truncation.
subplot(2,1,2);
stem(n,e4,'r');
hold on;
stem(n,e41,'g.');
grid on;
axis tight;
title(['Quantization Error e_4_q[n] = IDHT\{DHT_q\{sig_2[n]\}\} - sig_2[n] (red) for ',num2str(bps),' bits per DHT sample';
        '  Quantization and Truncation Error e_4_q_t[n] = IDHT\{DHT_q_t\{sig_2[n]\}\} - sig_2[n] (green)   ']);

disp('"Coding via Discrete Hartley Transform Quantization"');
% disp(['The maximum absolute value of quantization error e4_q[n] is: ', num2str(max(abs(e4)))]);
disp(['The actual SNR for this quantization is: ', num2str(10*log10(sum(sig2.^2)/sum(e4.^2))), ' dB']);
disp(['Using this coding we need to send ', num2str(bps*length(Z)), ' bits in total']);
disp('  ');
disp('"Coding via Truncated Discrete Hartley Transform Quantization"');
% disp(['The maximum absolute value of quantization error e4_q[n] is: ', num2str(max(abs(e41)))]);
disp(['The actual SNR for this quantization is: ', num2str(10*log10(sum(sig2.^2)/sum(e41.^2))), ' dB']);
disp(['Using this coding we need to send ', num2str(bps*(34+32)), ' bits in total']);
disp('  ');
