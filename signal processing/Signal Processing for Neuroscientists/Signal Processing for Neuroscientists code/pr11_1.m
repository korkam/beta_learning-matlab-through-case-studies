% pr11_1.m
% Approximation of an Ideal Filter

clear;

t=0:.1:10;
f=10*(0:50)/100;
yy=square(2*pi*0.2*t);                  % square wave 0.2 Hz

YY=fft(yy);                             % fft
PYY=YY.*conj(YY)/length(yy);            % Power spectrum
YY_F=YY;
for k=21:81;YY_F(k)=0;end;              % Remove High Frequencies 
PYY_F=YY_F.*conj(YY_F)/length(yy);      % Power spectrum
iyy_ac=ifft(YY_F);                      % Inverse Transform

iyy_ac=real(iyy_ac);                    % Due to imprecision in calculation 
                                        % iyy_ac contains a small imaginary
                                        % component, which is removed by this
                                        % statement

figure
subplot(2,1,1);plot(PYY,'k');
title(' The Power Spectrum Before Filtering ')
subplot(2,1,2);plot(PYY_F,'r');
title(' The Power Spectrum After Filtering (Removing) part 21-81 ')

figure
plot(f,PYY(1:length(f)),'k')
title(' First Half of Power Spectrum ploted vs. Frequency')
xlabel ('Frequency (Hz)');
ylabel ('Power (AU)');

figure;
plot(t,yy,'k');
axis([0 10 -1.5 1.5]);
hold;
plot(t,iyy_ac,'r');
title ('Original Signal (black) and Ideal Filtered One (r)');
xlabel ('Time (s)');
ylabel ('Amplitude (AU)');