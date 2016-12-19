% Exercise 6.2.5. Circular Shift.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Step (a). Generate a 15-point triangular sequence x[n].
n = 0:14;
A = 5; P =15;
n1 = 0:(P-1)/2;
half_block = 2*A*n1/(P-1); 
second_half = fliplr(half_block(2:end));
x = [half_block second_half];

figure('Name','Exercise 6.2.5. Circular Shift');
subplot(2,3,1);
stem(n,x);
title('x[n]');
xlabel('Sample Number n');
xlim([0 14]);
grid on;

% Circularly shift x[n] by 3 samples to the right.
y = circshift(x,[0 3]);

subplot(2,3,4);
stem(n,y);
hold on;
%title('y[n] = circshift(x[n],3)');
xlabel('Sample Number n');
xlim([0 14]);
grid on;

%% Step (b). Evaluate the two 15-point DFT's.
N = 15;  % Number of signal samples.

X = my_DFT(x);
Y = my_DFT(y);

% Plot the DFT magnitudes of x[n] and y[n]:
subplot(2,3,2);
stem(n,abs(X),'r*');
title('|X[k]|');
xlabel('Sample Number k');
axis tight;
grid on;

subplot(2,3,5);
stem(n,abs(Y),'r*');
title('|Y[k]|');
xlabel('Sample Number k');
axis tight;
grid on;

% Plot the DFT phases of x[n] and y[n]:
subplot(2,3,3);
stem(n,angle(X),'.g');
title('\angleX[k]');
xlabel('Sample Number k');
axis tight;
grid on;

subplot(2,3,6);
stem(n,angle(Y),'.g');
title('\angleY[k]');
xlabel('Sample Number k');
axis tight;
grid on;

%% Step (c). The circular shift can be achieved by circularly convolving x[n] with h[n].
h = [0 0 0 1 zeros(1,11)]; % A shifted impulse with length same as x[n].

y2 = cconv(x,h,N);

subplot(2,3,4);
stem(n,y2,'m.');
title(['    y[n] = circshift(x[n],3) (blue)   ';
        'y_2[n] = cconv(x[n],h[n],15) (magenta)']);
xlabel('Sample Number n');
xlim([0 14]);
grid on;

% Now compute the 15-point DFT of h[n]: 
H = my_DFT(h);

% Plot the DFT magnitudes of x[n] and y[n]:
figure('Name','Exercise 6.2.5. Circular Shift');
subplot(1,3,1);
stem(n,h);
title('h[n]');
xlabel('Sample Number n');
xlim([0 14]);
axis tight;
grid on;

subplot(1,3,2);
stem(n,abs(H),'r*');
title('|H[k]|');
xlabel('Sample Number k');
axis tight;
grid on;

subplot(1,3,3);
stem(n,angle(H),'gx');
title('\angleH[k]|');
xlabel('Sample Number k');
axis tight;
grid on;

%% Step (d). Compute the inverse 15-point DFT of Y[k]/X[k].
% h2 = zeros(1,N);
% Now compute the inverse 15-point DFT of h[n]: 
h2 = my_IDFT(Y./X);

% Or, using the definition formula:
%  for n=0:N-1
%        for k=0:N-1
%             h2(n+1) = h2(n+1) + 1/N*Y(k+1)/X(k+1)*exp(j*2*pi*n*k/N);
%        end
%  end
 
n = 0:N - 1;
% Plot the DFT magnitudes of x[n] and y[n]:
figure('Name','Exercise 6.2.5. Circular Shift');
stem(n,h2);
title('h_2[n] = IDFT\{Y[k]/X[k]\} = h[n]');
xlabel('Sample Number n');
axis tight;
grid on;
