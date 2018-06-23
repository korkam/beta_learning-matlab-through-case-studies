% pr17_3.m
% Linear Time Series
clear;
% Measurement Function and Initial x value
p=0.8;
x1(1)=.1;
for n=2:1000
    x1(n)=p*x1(n-1)+randn(1); % Note the Dynamic Noise Term
end
% Plot Timeseries
figure;plot(x1)
title('Linear Timeseries')
% Autocorrelation
tt=-(length(x1)-1):length(x1)-1;
x1COV=xcov(x1,'coeff');
figure;
plot(tt,x1COV,'k');
axis([-12 12 0 1]);
title('Autocorrelation Linear Timeseries');
% Return Plot
figure;
hold;
for i=2:length(x1);
    plot(x1(i-1),x1(i),'k.');
end;
title('Return Plot Linear Timeseries');   