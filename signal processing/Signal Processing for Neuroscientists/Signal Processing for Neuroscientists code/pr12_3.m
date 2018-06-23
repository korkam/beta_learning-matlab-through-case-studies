% pr12_3.m
% comparison of experimental and calculated 
% amplitude ratios of an RC low-pass filter

clear;
R=10^4;
C=3.3e-6;

n=1;
for k=0.3:.1:1000;
    f(n)=k;
                    % magnitude of equation (11.4) or (11.6) in dB
                    % the sqrt of the expression in equation (12.4)
                    % represents one of the graphs in the Bode plot
    r(n)=20*log10(sqrt((1/(1+(R*C*2*pi*k)^2))));
    n=n+1;
end;

% measured data for the low-pass RC circuit
% IF YOU MEASURED THE FILTER'S OUTPUT/INPUT RELATIONSHIP,
% ENTER YOUR DATA HERE
fm=[0.3 0.5 1 2 5 10 20 50 100 200 500 1000 ];
db=[0.00 0.00 -0.34 -0.70 -3.19 -6.72 -11.40 -16.26 -24.22 -30.24 -39.36 -45.38];
%

% plot results
figure;
semilogx(f,r,'k');
hold;
semilogx(fm,db,'ko');
axis([0.3 1000 -50 1]);
title ('Measured (o) and Calculated (line) Amplitude Ratio');
xlabel('Frequency (Hz)');
ylabel('Output/Input Ratio (dB)');
