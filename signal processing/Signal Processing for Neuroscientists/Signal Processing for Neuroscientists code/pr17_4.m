% pr17_4.m
% Nonlinear Time Series
clear;
% Measurement Function and Initial x value
p=4.0;
x2(1)=0.35;
for n=2:1000
    x2(n)=p*x2(n-1)*(1-x2(n-1)); % No Dynamic Noise Term
end
% Plot Timeseries
figure;plot(x2)
title('Nonlinear Timeseries')
% Autocorrelation
tt=-(length(x2)-1):length(x2)-1;
x2COV=xcov(x2,'coeff');
figure;
plot(tt,x2COV,'k');
axis([-12 12 0 1]);
title('Autocorrelation Nonlinear Timeseries');
% Return Plot
figure;
hold;
for i=2:length(x2);
    plot(x2(i-1),x2(i),'k.');
end;
title('Return Plot Nonlinear Timeseries');   
