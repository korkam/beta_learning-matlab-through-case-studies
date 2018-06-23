%daubechies2
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

N=1024;                     % # of points

g=zeros(1,1024);            % fill array with zero
for n=1:N;
    if (n>100)&(n<200);g(n)=1;end;
    if (n>300)&(n<500);g(n)=-0.1;end;
    if (n>550)&(n<590);g(n)=-0.2;end;
    if (n>600)&(n<900);g(n)=2;end;
end;                        % input signal  
                            

for m=1:N/2-2;              % we ignore the wrap around at the end!!
    a(m)=(g(2*m-1)*alpha(1)+g(2*m)*alpha(2)+g(2*m+1)*alpha(3)+g(2*m+2)*alpha(4)); % Use direct formulas for t and f 
    d(m)=(g(2*m-1)*beta(1)+g(2*m)*beta(2)+g(2*m+1)*beta(3)+g(2*m+2)*beta(4));
end;

D1=[a d];                   % The level-1 Daub4 transform

figure

plot(g,'r');
hold
plot(D1,'k');
axis([0 1024 -0.5 3.5]);
xlabel ('Time (Sample#)')
ylabel ('Amplitude')
title(' Original Signal (red) and Level-1 Daubechies Transform (black)')