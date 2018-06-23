% pr17_2.m
% Linear Time Series
clear;
% Measurement Function and Initial x value
p=0.8;
x0(1)=.1;
for n=2:1000
    x0(n)=p*x0(n-1);    % Note ABSENCE of Dynamic Noise Term
end
% Plot Timeseries
figure;plot(x0)
title('Linear Timeseries')
% Autocorrelation
tt=-(length(x0)-1):length(x0)-1;
x0COV=xcov(x0,'coeff');
figure;
plot(tt,x0COV,'k');
axis([-12 12 0 1]);
title('Autocorrelation Linear Timeseries');
% Return Plot
figure;
hold;
for i=2:length(x0);
    plot(x0(i-1),x0(i),'k.');
end;
title('Return Plot Linear Timeseries');   