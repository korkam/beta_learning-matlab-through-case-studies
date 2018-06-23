% pr8_2.m
% autocorrelation
clear;
le=10000;
x=randn(le,1);

y(1)=0.25*x(1);
y(2)=0.25*x(2)+0.5*x(1);

for i=3:le; 
    y(i)=0.25*x(i)+0.5*x(i-1)+0.25*x(i-2);
end;

tau=-(le-1):(le-1);
c=xcov(y,'coef');

figure;
stem(tau,c);
title('Autocorrelation ');
xlabel('Lag');
ylabel('Correlation (0-1)');
axis([-10 10 -.1 1.1]);