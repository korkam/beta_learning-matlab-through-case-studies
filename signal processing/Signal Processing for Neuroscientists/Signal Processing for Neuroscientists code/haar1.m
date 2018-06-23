% haar1
% A level-1 Haar Wavelet Analysis

clear;

N=1024;                                 % # of points

for n=1:N;m=(n-1)/N;g(n)=20*m^2*(1-m)^4*cos(12*pi*m);end; % input signal 

for m=1:N/2;
    a(m)=(g(2*m-1)+g(2*m))/sqrt(2);     % Use direct formulas for t and f 
    d(m)=(g(2*m-1)-g(2*m))/sqrt(2);
end;

H1=[a d];                               % The level-1 Haar transform

figure

plot(g,'r');
hold
plot(H1,'k');
axis([0 1024 -0.7 0.7]);
xlabel ('Time (Sample#)')
ylabel ('Amplitude')
title(' Original Signal (red) and Level-1 Haar Transform (black)')