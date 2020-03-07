% Exercise 6.5.6. The Chirp z-Transform (CZT).

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace initialization.

clc; clear; close all;

%% a. Sketch the locations of the samples in the z-plane.
A = 1.0*exp(1i*pi/4);
W = 1.0015*exp(-1i*pi*.1);
M = 40;
% z = A*(W.^(-(0:M-1)));
% figure('Name','Exercise 6.5.6. The Chirp z-Transform (CZT)');
% zplane([],z.');
% grid on;

%% b. Way #1. Compute the CZT as a linear convolution.
N = 128;
x = randn(1,N);

X1 = zeros(1,M);
 
 for k=0:M-1
      for n=0:N-1
           X1(k+1) = X1(k+1) + x(n+1)*(A^(-n))*(W^(n^2/2))*(W^(-(n-k)^2/2));  
      end
           X1(k+1) = X1(k+1)*W^(k^2/2);
 end

Y = czt(x,M,W,A);

Z1 = X1 - Y;

% disp(['Total Error Magnitude, sum(|X1[k]-Y[k]|) is: ',num2str(sum(abs(Z1)))]);

%% c.  Way #2. CZT computed as a typical convolution sum.
X2 = zeros(1,M);

for k=0:M-1
     for n=0:N-1
           X2(k+1) = X2(k+1) + x(n+1)*(A^(-n))*W^(n*k); 
     end
end

% Z2 = X2 - Y;
% Z3 = X2 - X1;
% 
% disp(['Total Error Magnitude, sum(|X2[k]-Y[k]|) is: ',num2str(sum(abs(Z2)))]);
% 
% figure('Name','Exercise 6.5.6. The Chirp z-Transform (CZT)');
% subplot(2,2,1);
% stem(real(Z2));
% title('\Ree\{X_2[k]-Y[k]\}');
% grid;
% 
% subplot(2,2,2);
% stem(real(Z3));
% title('\Ree\{X_2[k]-X_1[k]\}');
% grid;
% 
% subplot(2,2,3);
% stem(imag(Z2),'r.');
% title('\Imm\{X_2[k]-Y[k]\}');
% grid;
% 
% subplot(2,2,4);
% stem(imag(Z3),'r.');
% title('\Imm\{X_2[k]-X_1[k]\}');
% grid;

%% d. Way #3. CZT Algorithm employed from paper by Rabiner, Schafer and Rader (1969).
L = 2^nextpow2(M+N-1); % We choose L as a power of two and L>=N+M-1.
n = 0:N-1;
k = 0:M-1;
n1 = L-N+1:L-1;
L1 = L*ones(1,N-1);

% Step 1. Form an L-point sequence y[n]:
y = [ x.*(A.^(-n)).*W.^(n.^2/2)   zeros(1,L-N)];

% Step 2. Define an L-point sequence v[n] as follows:
v = [ W.^(-k.^2/2)  zeros(1,L-(N+M-1))  W.^(-(L1-n1).^2/2)];

% Step 3. Calculate the convolution using the fft and ifft.
g = fastconv(y,v);

% Step 4. Multiply by the W^(k^2/2) factor.
X3 = W.^(k.^2/2).*g(1:M);  

Z4 = X3 - Y;
Z5 = X3 - X2;

disp(['Total Error Magnitude, sum(|X3[k]-Y[k]|) is: ',num2str(sum(abs(Z4)))]);

figure('Name','Exercise 6.5.6. The Chirp z-Transform (CZT)');
subplot(2,2,1);
stem(real(Z4));
title('\Ree\{X_3[k]-Y[k]\}');
grid;

subplot(2,2,2);
stem(real(Z5));
title('\Ree\{X_3[k]-X_2[k]\}');
grid;

subplot(2,2,3);
stem(imag(Z4),'r.');
title('\Imm\{X_3[k]-Y[k]\}');
grid;

subplot(2,2,4);
stem(imag(Z5),'r.');
title('\Imm\{X_3[k]-X_2[k]\}');
grid;

%%
% Z6 = X3 - X1;
% 
% disp(['Total Error Magnitude, sum(|X2[k]-X1[k]|) is: ',num2str(sum(abs(Z3)))]);
% disp(['Total Error Magnitude, sum(|X3[k]-X1[k]|) is: ',num2str(sum(abs(Z6)))]);
% disp(['Total Error Magnitude, sum(|X3[k]-X2[k]|) is: ',num2str(sum(abs(Z5)))]);
% 
% figure('Name','Exercise 6.5.6. The Chirp z-Transform (CZT)');
% subplot(2,2,1);
% stem(real(Z1));
% title('\Ree\{X_1[k]-Y[k]\}');
% grid;
% 
% subplot(2,2,2);
% stem(real(Z6));
% title('\Ree\{X_3[k]-X_1[k]\}');
% grid;
% 
% subplot(2,2,3);
% stem(imag(Z1),'r.');
% title('\Imm\{X_1[k]-Y[k]\}');
% grid;
% 
% subplot(2,2,4);
% stem(imag(Z6),'r.');
% title('\Imm\{X_3[k]-X_1[k]\}');
% grid;

%% e. Design a length-32 lowpass filter with cutoff 0.45pi.
% Estimate and display 100 samples of the DTFT of this lowpass filter
% in [0.3ð 0.6ð].
w0 = 0.45*pi;
n = -15:15;
h = [ sin(w0*(-15:-1))./(pi*(-15:-1)) w0/pi sin(w0*(1:15))./(pi*(1:15))]; 

% Compute its DTFT first.
[w H] = my_DTFT(h,n);

figure('Name','Exercise 6.5.6. The Chirp z-Transform (CZT)');
subplot(2,2,1);
plot(w,abs(H));
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlim([0 pi]);
ylim([-0.1 1.15]);
grid on;
title('|{\itH}(j\omega)|');

subplot(2,2,2);
plot(w,angle(H));
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlim([-pi pi]);
grid on;
title('\angle{\itH}(j\omega)');

% Now compute the requested zoom in frequency using the CZT:
wstart = 0.3*pi; wend = 0.6*pi;    % Interval of zoom-in is: [wstart wend].
M = 128;                                        % Number of steps.
A = 1.0*exp(1i*wstart);                   % Starting point.
W = 1.0*exp(-1i*(wend-wstart)/M); % Step.
z = A*(W.^(-(0:M-1)));   % This is the sequence of points (on the z-plane) where CZT will be computed.
w1 = angle(z);         % DTFT frequencies that correspond to these points when they lie on the unit circle.

H1 = my_CZT(h,M,W,A);

subplot(2,2,3);
plot(w1,abs(H1));
set(gca,'XTick',0:pi/4:pi);
set(gca,'XTickLabel',{'0','pi/4','pi/2','3pi/4','pi' })
xlim([wstart wend]);
ylim([-0.1 1.15]);
grid on;
title('|{\itH}(j\omega)| zoomed-in on [0.3\pi 0.6\pi]');

subplot(2,2,4);
plot(w1,angle(H1));
set(gca,'XTick',0:pi/4:pi);
set(gca,'XTickLabel',{'0','pi/4','pi/2','3pi/4','pi' })
xlim([wstart wend]);
grid on;
title('\angle{\itH}(j\omega) zoomed-in on [0.3\pi 0.6\pi]');

% Plot the locations on the z-plane.
figure('Name','Exercise 6.5.6. The Chirp z-Transform (CZT)');
zplane([],z.');
title(['Locations on the z-plane where the length-',num2str(M),' chirp z-transform of h[n] was computed']);
l1 = line('Xdata', real ([ 0    z(1)]),'Ydata',imag([ 0   z(1)]),'Color','r','LineStyle','-','EraseMode','xor'); 
l2 = line('Xdata', real ([ 0    z(end)]),'Ydata',imag([ 0   z(end)]),'Color','r','LineStyle','-','EraseMode','xor'); 
grid on;
