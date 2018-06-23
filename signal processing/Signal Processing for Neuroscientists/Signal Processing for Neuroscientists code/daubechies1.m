%daubechies1
% A level-1 Daubechies Wavelet Analysis

clear;

% Define the Daub4 scaling (alpha) and wavelet (beta) coeff
alpha(1)=(1+sqrt(3))/(4*sqrt(2));
alpha(2)=(3+sqrt(3))/(4*sqrt(2));
alpha(3)=(3-sqrt(3))/(4*sqrt(2));
alpha(4)=(1-sqrt(3))/(4*sqrt(2));
beta(1)=alpha(4);
beta(2)=-alpha(3);
beta(3)=alpha(2);
beta(4)=-alpha(1);

% # of points
N=1024;                     

% input signal 
for n=1:N;m=(n-1)/N;
    g(n)=20*m^2*(1-m)^4*cos(12*pi*m);
end; 

% Ignore the wrap around at the end!!
for m=1:N/2-2; 
    % Use direct formulas for t and f 
    a(m)=(g(2*m-1)*alpha(1)+g(2*m)*alpha(2)+g(2*m+1)*alpha(3)+g(2*m+2)*alpha(4)); 
    d(m)=(g(2*m-1)*beta(1)+g(2*m)*beta(2)+g(2*m+1)*beta(3)+g(2*m+2)*beta(4));
end;

% The level-1 Daub4 transform
D1=[a d];   

figure

plot(g,'r');
hold
plot(D1,'k');
axis([0 1024 -0.7 0.7]);
xlabel ('Time (Sample#)')
ylabel ('Amplitude')
title(' Original Signal (red) and Level-1 Daubechies Transform (black)')