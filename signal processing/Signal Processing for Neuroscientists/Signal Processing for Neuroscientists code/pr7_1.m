% pr7_1.m
% Spectrum
% WvD 2004

srate=1000;                             % sample rate
pt=512;                                 % points (2^n) for the FFT
range=(pt/2);                           % range for the spectral plot

t=0:1/srate:0.6;                        % time axis
f=srate*(0:range)/pt;                   % frequency axis
                                      
x=sin(2*pi*50*t)+sin(2*pi*120*t);
y=x+randn(1,length(t));                 % signal + noise in mV

figure                                  % plot signal
plot(t,y)
title('Time Series')
xlabel('time (s)')
ylabel('Amplitude (mV)')

Y=fft(y,pt);                            % do a 512 pt FFT
Pyy=Y.*conj(Y)/pt;                      % Power spectrum

figure                                  % Plot result
plot(f,Pyy(1:length(f)));               
title('Powerspectrum')
xlabel('Frequency (Hz)')
ylabel('Power (mV2)')

