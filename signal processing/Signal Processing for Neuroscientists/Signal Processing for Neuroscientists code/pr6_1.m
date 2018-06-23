% pr6_1.m
% A four point FFT

clear;

x(0+1)=0;               % input time series x(n) 
x(1+1)=1;               % Indices are augmented by 1 
x(2+1)=1;
x(3+1)=0;

W4=exp(-j*2*pi/4);      % the W4 twiddle factor
W0=W4^0;                % and the 0-3rd powers
W1=W4^1;
W2=W4^2;
W3=W4^3;

X(0+1)=(x(0+1)+x(2+1)*W0)+W0*(x(1+1)+x(3+1)*W0);
X(1+1)=(x(0+1)+x(2+1)*W2)+W1*(x(1+1)+x(3+1)*W2);
X(2+1)=(x(0+1)+x(2+1)*W0)+W2*(x(1+1)+x(3+1)*W0);
X(3+1)=(x(0+1)+x(2+1)*W2)+W3*(x(1+1)+x(3+1)*W2);

% check with MatLab fft
fx=fft(x);

figure
hold
plot(X);
plot(fx,'r+');
title('Results 4-point hand programmed FFT (blue) and the MATLAB routine (red +)')