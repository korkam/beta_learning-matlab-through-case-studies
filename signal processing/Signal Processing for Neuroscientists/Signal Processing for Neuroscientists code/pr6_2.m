%pr6_2
% DFT and FFT demo on an 8-point data set

clear;

% Input
% -----
N=8;                                        % # of points
 w=2*pi/(N-1);                              % w - angular frequency 
 for n=1:N;
     x(n)=sin(w*(n-1));                     % sinusoidal signal
 end;
 
 figure;
 subplot(4,1,1),plot(x)                     % plot the time domain signal
 title(' Time Domain Signal');
 
 % The direct Matlab route
 % -----------------------
  fx=fft(x);
 subplot(4,1,2),plot(abs(fx))               % plot the magnitude of the fft signal
 title(' Magnitude of the FFT Signal using the MatLab fft command');
 
 % program DFT 'by hand'
 % ---------------------
WN=exp(-j*2*pi/N);                          % the twiddle factor

MULT=0;                                     % counter for the # of multiplications
 for k=1:N;                                 % Calculate Discrete Fourier Transform 
    DXN(k)=0;                               % with Nested loops NxN calculations
        for n=1:N;
            DXN(k)=DXN(k)+(x(n)*WN^((n-1)*(k-1))); MULT=MULT+1;  % The formula for calculation of discrete transform
        end;
 end;
 ('Multiplications 8-point DFT algorithm : ')
                    MULT                    % report total multiplications =N^2 (64)
                    
 subplot(4,1,3),plot(abs(DXN))              % plot the magnitude of the 'hand calculated' fft signal
  title(' Magnitude of the DFT Signal using the discrete tranform algorithm');
 
 % AN APPROACH WITH THE INPUT 'SCRAMBLED' (Fig. 6.3)
 % The rest of the algorithm is NOT optimized 
 % -------------------------------------------------
 % Scrambling the input 'by hand'
 W0=exp(-j*2*pi/N)^0;                      % the twiddle factors for an 8-point FFT
 W1=exp(-j*2*pi/N)^1; 
 W2=exp(-j*2*pi/N)^2; 
 W3=exp(-j*2*pi/N)^3; 
 W4=exp(-j*2*pi/N)^4;
 W5=exp(-j*2*pi/N)^5;
 W6=exp(-j*2*pi/N)^6;
 W7=exp(-j*2*pi/N)^7;
 %scramble input in array sx                Binary Index
 sx(1)=x(1);                                % 000         index is 1-1=0
 sx(2)=x(5);                                % 100         index is 5-1=4
 sx(3)=x(3);                                % 010         index is 3-1=2
 sx(4)=x(7);                                % 110         index is 7-1=6
 sx(5)=x(2);                                % etc
 sx(6)=x(6);
 sx(7)=x(4);
 sx(8)=x(8);
 
 MULT=0;                                    % counter for the multiplications
 k=1;
 while (k<N);
     sx1(k)=sx(k)+W0*sx(k+1); MULT=MULT+1;
     k=k+1;
     sx1(k)=sx(k-1)+W4*sx(k);MULT=MULT+1;
     k=k+1;
 end;
 
 k=1;
 while (k<N);
     sx2(k)=sx1(k)+W0*sx1(k+2);MULT=MULT+1;
     k=k+1;
     sx2(k)=sx1(k)+W2*sx1(k+2);MULT=MULT+1;
     k=k+1;
     sx2(k)=W4*sx1(k)+sx1(k-2);MULT=MULT+1;
     k=k+1;
     sx2(k)=W6*sx1(k)+sx1(k-2);MULT=MULT+1;
     k=k+1;
 end;
   
 k=1;
     sx3(k)=sx2(k)+W0*sx2(k+4);MULT=MULT+1;
     k=k+1;
     sx3(k)=sx2(k)+W1*sx2(k+4);MULT=MULT+1;
     k=k+1;
     sx3(k)=sx2(k)+W2*sx2(k+4);MULT=MULT+1;
     k=k+1;
     sx3(k)=sx2(k)+W3*sx2(k+4);MULT=MULT+1;
     k=k+1;
     sx3(k)=W4*sx2(k)+sx2(k-4);MULT=MULT+1;
     k=k+1;
     sx3(k)=W5*sx2(k)+sx2(k-4);MULT=MULT+1;
     k=k+1;
     sx3(k)=W6*sx2(k)+sx2(k-4);MULT=MULT+1;
     k=k+1;
     sx3(k)=W7*sx2(k)+sx2(k-4);MULT=MULT+1;
     ('Multiplications 8-point FFT algorithm : ')
     MULT                                       % report total multiplications = N * log2(N) (24)
subplot(4,1,4),plot(abs(sx3))                   % plot the magnitude of the 'hand calculated' fft signal
title(' Magnitude of the FFT Signal using the self implemented fast tranform algorithm');