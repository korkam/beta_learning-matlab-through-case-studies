% Exercise 4.2.1. Quantization.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Create r[n].
n = -1000:1000;
r = n/1000;
% rhat   = zeros(1,length(r));
% rhat2 = zeros(1,length(r));
rhat4 = zeros(1,length(r));
rhat5 = zeros(1,length(r));

figure('Name','Exercise 4.2.1. Quantization');
subplot(2,3,1);
plot(n,r);
title('Ramp r[n] and mid-riser quantized version rhat_1[n] (red)');
grid on;
ylim([-1.05 1.05]);
hold on;

%% Step (a). Quantize r[n] to eight levels. 
bps = 3; % use 3 bits/sample.
L = 2^bps;
rhat = uniform_quantizer(r,L,max(r),min(r));

plot(n,rhat,'r');

%% Step (b). Compute and display the error signal.
e = rhat - r;
subplot(2,3,4);
plot(n,e);
grid on;
axis tight;
title('Mid-riser Quantization Error e_q_1[n] = rhat_1[n] - r[n]');
disp(['The maximum absolute value of quantization error e_q1[n] is: ', num2str(max(abs(e)))]);
disp(['The SNR for mid-riser quantization is: ', num2str(10*log10(sum(r.^2)/sum(e.^2))), 'dB']);
disp('  ');

%% Step (c). Calculate new Decision Levels and reproducer values:
% Xmin = -1; Xmax = 1;
% Delta2 = (Xmax - Xmin)/L;
% dec_lev2 = Delta2*[-L/2:-1 0 1:L/2];
% rep_val2  = Delta2*[-L/2:-1 0 1:L/2];
% 
% % Naive Quantizer Operation:
% for k=1:length(r)
%      for level=1:L
%         if r(k)>= dec_lev2(level) & r(k)<dec_lev2(level+1)
%             rhat2(k) = rep_val2(level);
%         elseif r(k) > dec_lev2(L)
%             rhat2(k) = rep_val(L);
%         elseif r(k) < dec_lev2(1)
%             rhat2(k) = rep_val2(1);            
%         end
%     end
% end
% 
% subplot(2,3,2);
% plot(n,r);
% title('Original Signal r[n] (blue) and quantized version rhat_2[n] (red)');
% grid on;
% ylim([-1.05 1.05]);
% hold on;
% 
% plot(n,rhat2,'r');
% 
% % Compute and display the new quantization error signal.
% e2 = rhat2 - r;
% subplot(2,3,5);
% plot(n,e2);
% grid on;
% axis tight;
% title('Quantization Error e2_q[n] = rhat_2[n] - r[n]');
% disp(['The maximum absolut value of quantization error e2_q[n] is: ', num2str(max(abs(e2)))]);
% disp(['The SNR for this quantization is: ', num2str(10*log10(sum(r.^2)/sum(e2.^2))), 'dB']);
% disp('  ');

%% If we assume that  Xmin <= r[n] <=Xmax, then the situation is better:
% n2 = -875:875;
% r2 = n2/1000;
% rhat3 = zeros(1,length(r2));
% 
% % Quantizer Operation:
% for k=1:length(r2)
%      for level=1:L
%           if r2(k) >= dec_lev2(level) & r2(k) < dec_lev2(level+1)
%              rhat3(k) = rep_val2(level);
%           elseif r2(k) > dec_lev2(L)
%              rhat3(k) = rep_val2(L);
%           elseif r2(k) < dec_lev2(1)
%              rhat3(k) = rep_val2(1);            
%           end
%     end
% end
% 
% subplot(2,3,3);
% plot(n2,r2);
% title('Truncated Signal r_3[n] (blue) and quantized version rhat_3[n] (red)');
% grid on;
% ylim([-1 1]);
% hold on;
% 
% plot(n2,rhat3,'r');
% axis tight;
% 
% % Compute and display the new quantization error signal.
% e3 = rhat3 - r2;
% subplot(2,3,6);
% plot(n2,e3);
% grid on;
% axis tight;
% title('Quantization Error e3_q[n] = rhat_3[n] - r[n]');
% disp(['The maximum absolut value of quantization error e3_q[n] is: ', num2str(max(abs(e3)))]);
% disp(['The SNR for this quantization is: ', num2str(10*log10(sum(r2.^2)/sum(e3.^2))), ' dB']);
% disp(' ');
%% Step (d).(1). Quantize r[n] to nine levels instead of eight.

% figure(2);
subplot(2,3,2);
plot(n,r);
title('Ramp r[n] and mid-tread quantized version rhat_2[n] (red)');
grid on;
ylim([-1.05 1.05]);
hold on;

% Apply new number of quantization levels.
L2 = 9; % For a mid-tread quantizer.
rhat2 = uniform_quantizer(r,L2,max(r),min(r));

plot(n,rhat2,'r');

% Compute and display the error signal.
e4 = rhat2 - r;
subplot(2,3,5);
plot(n,e4);
grid on;
axis tight;
title('Mid-tread Quantization Error e_q_2[n] = rhat_2[n] - r[n]');
disp(['The maximum absolute value of quantization error eq2[n] is: ', num2str(max(abs(e4)))]);
disp(['The SNR for mid-tread quantization is: ', num2str(10*log10(sum(r.^2)/sum(e4.^2))), 'dB']);
disp('  ');

% Calculate new Decision Levels and reproducer values:
% Xmin = -0.8889; Xmax = 0.8889;
% Delta4 = (Xmax - Xmin)/L2;
% dec_lev4 = Xmin + Delta4*(0:L2);
% rep_val4  = Xmin + Delta4/2 + Delta4*(0:L2-1);
% 
% % Quantizer Operation:
% for k=1:length(r)
%      for level=1:L2
%         if r(k) >= dec_lev4(level) & r(k) < dec_lev4(level+1)
%             rhat5(k) = rep_val4(level);
%         elseif r(k) > dec_lev4(L2)
%             rhat5(k) = rep_val4(L2);
%         elseif r(k) < dec_lev4(1)
%             rhat5(k) = rep_val4(1);            
%         end
%     end
% end
% 
% subplot(2,2,2);
% plot(n,r);
% title('Original Signal r[n] and quantized version rhat_5[n]');
% grid on;
% ylim([-1 1]);
% hold on;
% 
% plot(n,rhat5,'r');
% 
% % Compute and display the new quantization error signal.
% e5 = rhat5 - r;
% subplot(2,2,4);
% plot(n,e5);
% grid on;
% axis tight;
% title('Quantization Error e5_q[n] = rhat_5[n] - r[n]');
% disp(['The maximum absolut value of quantization error e5_q[n] is: ', num2str(max(abs(e5)))]);
% disp(['The SNR for this quantization is: ', num2str(10*log10(sum(r.^2)/sum(e5.^2))), 'dB']);
% disp('  ');

%% Step (d).(2). Quantize x[n] to 8 levels.
n3 = 0:20;
x = 5*sin(pi*n3/10);
% xhat1 = zeros(1,length(x));
% xhat2 = zeros(1,length(x));

% figure(3);
subplot(2,3,3);
stem(n3,x);
title(['x[n] = 5sin(\pin/10), mid-riser quantized version xhat_1[n] (red)';
         '       and mid-tread quantized version xhat_2[n] (green)         ']);
grid on;
hold on;

% Apply new number of quantization levels.
L=8; % For a mid-riser quantizer. 
xhat1 = uniform_quantizer(x,L,max(x),min(x));

L=9; % For a mid-tread quantizer.
xhat2 = uniform_quantizer(x,L,max(x),min(x));

stem(n3,xhat1,'rx');
hold on;
stem(n3,xhat2,'gx');

% Compute and display the error signal.
e51 = xhat1 - x;
e52 = xhat2 - x;

subplot(2,3,6);
stem(n3,e51,'rx');
hold on;
stem(n3,e52,'gx');
grid on;
axis tight;
title(['Mid-riser Quantization Error e_q_5_1[n] (red)  ';
        'Mid-tread Quantization Error e_q_5_2[n] (green)']);

disp(['The maximum absolute value of quantization error eq51[n] is: ', num2str(max(abs(e51)))]);
disp(['The SNR for mid-riser quantization is: ', num2str(10*log10(sum(x.^2)/sum(e51.^2))), ' dB']);
disp('  ');

disp(['The maximum absolute value of quantization error eq52[n] is: ', num2str(max(abs(e52)))]);
disp(['The SNR for mid-tread quantization is: ', num2str(10*log10(sum(x.^2)/sum(e52.^2))), ' dB']);
disp('  ');
