% pr4_2.m
% Inverted Noise Trial
clear;

x=randn(1,5000000);
y=randn(1,5000000);
% Time Series
figure;hold
plot(x+10,'k')
plot(y-10,'k')
title('Signal x upper trace; Signal y lower trace')
sum=x+y;
dif=x-y;
figure;hold
plot(sum+10,'k')
plot(dif-10,'k')
title('Sum x+y upper trace; Difference x-y lower trace')
% Distributions
figure
hist(x,sqrt(length(x)))
title('PDF x')
figure
hist(y,sqrt(length(y)))
title('PDF y')
figure
hist(sum,sqrt(length(sum)))
title('PDF sum: x+y')
figure
hist(dif,sqrt(length(dif)))
title('PDF difference: x-y')
