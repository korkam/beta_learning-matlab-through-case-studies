% pr12_4.m
%
% Two point Smoothing Filter's Frequency Response
% filter equation (FIR) Digital Filter:
%                y(n)=(x(n)+x(n-1))/2

clear;
wT=0:.1:2*pi;

% 1. Calculate the abs component of the fft of the impulse response
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The impulse response y for an impulse at time=0 
% equals to pulse of .5 at time=0 and at time=T,
% i.e
y=zeros(1,63);
y(1)=.5;y(2)=.5;

Y=fft(y);                           % fft of the impulse response y
                                    % --> frequency response Y
figure
subplot(2,1,1),plot(wT,abs(Y))
title('Frequency Response = fft of the Impulse Response')
axis([0 max(wT) 0 max(abs(Y))]);
ylabel('Amplitude Ratio');


% 2. The second method is to use the z-transform and replace z by exp(jwT)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The z-transform of y(n)=(x(n)+x(n-1))/2 is:
%                               Y(z)=.5* X(z)*[1+1/z]
%                       -->     H(z)=Y(z)/X(z)=.5 + .5*(1/z) = .5 + .5*exp(-jwT)
YY=(.5+.5*(exp(-j*wT)));
subplot(2,1,2),plot(wT,abs(YY))
title('Frequency Response = based on z-transform')
axis([0 max(wT) 0 max(abs(YY))]);
ylabel('Amplitude Ratio');
xlabel('Frequency (wT: Scale 0-2pi)');  % NOTE: Normally one would show 0-pi 
                                        % with pi=the Nyquist frequency

% 3. The third method is to use white noise and compare the power spectra of in- and output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the idea is that white noise represents all frequencies at the input and
% that the output shows what is transferred.  The output over the input power spectra
% represent the frequency response estimate

x=randn(10000,1);                       % create white noise
wT=1:length(x);wT=(wT/length(x))*2*pi;  % New Frequency Scale

for n=2:length(x);              % Calculate the output of the 2-point smoothing
    y(n)=(x(n)+x(n-1))/2;
end;

figure                          % plot the input x
subplot(3,1,1),plot(x)
hold
subplot(3,1,1),plot(y,'k')
title('Input Noise (blue) and Output Noise (black)')
xlabel('sample #')
ylabel('amplitude')

X=fft(x);                       % Calculate the power spectra (NOTE the
Y=fft(y);                       % NOTE: The power spectrum is the fft 
Px=X.*conj(X)/length(x);        % of the autocorrelation
Py=Y.*conj(Y)/length(y);

subplot(3,1,2), plot(wT,Px)
hold
subplot(3,1,2),plot(wT,Py,'k')
title('POWER SPECTRA Input Noise (blue) and Output Noise (black)')
xlabel('Frequency Scale (0-2pi)')
ylabel('power')

for i=1:length(x);
    % Strictly speaking abs(X(i)*conj(Y(i)))/(input variance * N) should be 
    % sufficient; here we divide by (X(i)*conj(X(i)) to correct for
    % non whiteness (colored) of the Gaussian noise input
    h_square(i)=(abs(X(i)*conj(Y(i)))/(X(i)*conj(X(i))))^2;     
end;

subplot(3,1,3),plot(wT,sqrt(h_square),'k');
title('Frequency Response = based on Input-Output white Noise')
xlabel('Frequency Scale(0-2pi)')
ylabel('Amplitude Ratio')
