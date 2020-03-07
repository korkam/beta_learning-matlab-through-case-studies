% Exercise 6.2.1. Introduction to Circular Shifting.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Steps (a) and (b).
Samples = 16; 
n = 0:15; k = n;
time_shift = [0 1 15 2 14 4 12 5 11 6 10 1 17 33 49 2 18 34 50];
x = [1 zeros(1,15)];
figure(1); 
 
for i=1:length(time_shift)
    
 x_sh = circshift(x,[0 time_shift(i)]);
        
 % Now compute the 16-point DFT of circularly shifted x[n]: 
 Xsh = my_DFT(x_sh);
 
%% Plot the results.
% Plot the shifted version of the sequence x[n];
subplot(3,1,1);
stem(k,x_sh);
title(['x[(n-n_0) mod N] is x[n] circularly shifted by n_0= ',num2str(time_shift(i)),' sample(s)']);
xlabel('Sample Number k');
axis tight;
grid on;

% Plot the real part of the DFT of h[n]:
subplot(3,1,2);
stem(k,real(Xsh),'gx');
hold on;
plot(k,cos(2*pi*k*time_shift(i)/Samples),'b');
hold off;
title(['\Ree\{X_s_h_i_f_t[k]\} = \Ree\{W_N^{kn_0} X[k]\} = cos(2\pikn_0/N) = cos(',num2str(time_shift(i)),'\pik/8)']);
xlabel('Sample Number k');
axis tight;
grid on;

% Plot the DFT magnitude of h[n]:
subplot(3,1,3);
stem(k,imag(Xsh),'rx');
hold on;
plot(k,-sin(2*pi*k*time_shift(i)/Samples),'b');
hold off;
title(['\Imm\{X_s_h_i_f_t[k]\} = \Imm\{W_N^{kn_0} X[k]\} = -sin(2\pikn_0/N) = -sin(',num2str(time_shift(i)),'\pik/8)']);
xlabel('Sample Number k');
axis tight;
grid on;

display('Press any key to continue...');
pause;

end
