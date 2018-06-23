% pr12_2.m
% Bode_Nyquist.m
% Bode Plot and Nyquist Plot for a low pass filter

% Filter Components
R=10e3;
C=3.3e-6;

% Formula for amplitude A = 1/sqrt[1 + (RCw)^2] with w=2 x pi x f
for i=1:5000;
    f(i)=i;
    A(i)=1/(sqrt(1+(R*C*2*pi*f(i))^2)); 	% formula derived for the 
                                            % absolute part
    H(i)=1/(1+R*C*2*pi*f(i)*j);         	% frequency response
    rl=real(H(i));                      	% real part of H
    im=imag(H(i));                          % imaginary part of H
    PHI(i)=atan2(im,rl);                 	% phase
end;

% for w=1/RC there is A=1/sqrt[1/2] ~ 0.7
% 20 x log10{[1/sqrt(2)]} ~ -3.0 (The -3dB point)

F_3db=1/(2*pi*R*C);                         % Here we use Equation (12.5)

figure
subplot(3,1,1), semilogx(f,20*log10(A))
xlabel('Frequency(Hz)')
ylabel('Amplitude Ratio (dB)')
axis([0 1000 -50 0]);

t=['BODE PLOT Low Pass Filter: R = ' num2str(R) ' Ohm; C = ' num2str(C) ' F; and -3dB frequency = ' num2str(F_3db) ' Hz'];
title(t)
subplot(3,1,2),semilogx(f,(PHI*360)/(2*pi))
xlabel('Frequency(Hz)')
ylabel('Phase (degrees)')
axis([0 1000 -100 0]);

subplot(3,1,3),polar(PHI,A)
xlabel('Real')
ylabel('Imaginary')
title('Nyquist Plot')
