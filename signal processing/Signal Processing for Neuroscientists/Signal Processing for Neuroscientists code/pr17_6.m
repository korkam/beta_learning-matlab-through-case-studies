%pr17_6.m
% Cross-Correlation
clear
%input funtion
t=0:.001:5;                     % Timebase
tt=-(length(t)-1):length(t)-1;  % Cross-Correlation lags
f1=20;                          % Frequencies in Hz
f2=20.7;
f3=40;
x=sin(2*pi*f1*t);               % Sine Waves
xx=0.5*sin(2*pi*f1*t+pi);
y=sin(2*pi*f2*t);
z=sin(2*pi*f3*t);
xr=x; 
for i=1:length(x); 
    if (x(i)< 0); 
        xr(i)=-1;                % rectangular wave
    else;
        xr(i)=1;
    end;
end;
% Correlation
x_x=xcorr(x,'coeff');           % Autocorrelation
x_xx=xcorr(x,xx,'coeff');       % Cross-Correlations
x_y=xcorr(x,y,'coeff');
x_z=xcorr(x,z,'coeff');
x_xr=xcorr(x,xr,'coeff');
% Figures Waveforms
figure;
hold;
plot(x);
plot(xx,'r')
plot(y,'g')
plot(z,'k')
plot(xr,'m')
axis([0 200 -1.1 1.1])
title('Sine Waves')
xlabel('sample point')
ylabel('Amplitude')
% Figures Correlations
figure;
hold;
plot(tt,x_x,'+')
plot(tt,x_xx,'r')
plot(tt,x_y,'g')
plot(tt,x_z,'k')
plot(tt,x_xr,'m')
axis([-100 100 -1.1 1.1])
title('Correlations')
xlabel('Lag')
ylabel('Correlation Coefficient')