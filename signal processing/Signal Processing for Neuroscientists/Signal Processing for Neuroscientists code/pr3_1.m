% pr3_1.m
% Measurement Noise
clear;
% Measurement Function and Initial x value
A=3.5;
p=0.8;
x(1)=18;

for n=2:1000
    x(n)=A+p*x(n-1);
end
% Additive Noise
noise=randn(1,1000)*2;

M=x+noise;

figure;plot(M)
title('Measurement Noise')