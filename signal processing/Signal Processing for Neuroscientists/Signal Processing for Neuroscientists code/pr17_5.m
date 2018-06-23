% pr17_5.m
% Random Time Series
clear;
x3=randn(1,1000);
% Plot Timeseries
figure;plot(x3)
title('Random Timeseries')
% Autocorrelation
tt=-(length(x3)-1):length(x3)-1;
x3COV=xcov(x3,'coeff');
figure;
plot(tt,x3COV,'k');
axis([-12 12 0 1]);
title('Autocorrelation Random Timeseries');
% Return Plot
figure;
hold;
for i=2:length(x3);
    plot(x3(i-1),x3(i),'k.');
end;
title('Return Plot Random Timeseries');   