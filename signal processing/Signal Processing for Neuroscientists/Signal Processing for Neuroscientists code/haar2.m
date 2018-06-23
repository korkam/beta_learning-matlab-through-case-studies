%haar2
% A level-1 Haar Wavelet Analysis

clear;

N=1024;                             % # of points

g=zeros(1,1024);                    % fill array with zero
for n=1:N;
    if (n>100)&(n<200);g(n)=1;end;
    if (n>300)&(n<500);g(n)=-0.1;end;
    if (n>550)&(n<590);g(n)=-0.2;end;
    if (n>600)&(n<900);g(n)=2;end;
end;                                % input signal 

for m=1:N/2;
    a(m)=(g(2*m-1)+g(2*m))/sqrt(2); % Use direct formulas for t and f 
    d(m)=(g(2*m-1)-g(2*m))/sqrt(2);
end;

H1=[a d];                           % The level-1 Haar transform

figure

plot(g,'r');
hold
plot(H1,'k');
axis([0 1024 -0.5 3.5]);
xlabel ('Time (Sample#)')
ylabel ('Amplitude')
title(' Original Signal (red) and Level-1 Haar Transform (black)')