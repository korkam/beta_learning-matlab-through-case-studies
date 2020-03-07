% Exercise 4.1.5. DTFT of a Sampled Signal.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Analog frequency axis in rad/sec.
omega = -25e4:100:25e4;  % Analogue frequency axis in rad/sec.
L = length(omega);
Xa = zeros(1,L);
for k=1:L
    if omega(k)<-2*pi*5000 || omega(k)>2*pi*5000
        Xa(k) = 0;
    else
        Xa(k) = 1;
    end
end

figure('Name','Exercise 4.1.5. DTFT of a Sampled Signal (No Aliasing)');
subplot(4,1,1);
plot(omega,Xa);
grid on;
title('X_\alpha(\Omega)');
xlabel('Analog Frequency \Omega (rad/sec)');
ylim([-1/10 11/10]);

%% Step (a).  Sampling above or equal to Nyquist Frequency.
fs = [10 15 30]*1e3; % Sampling rates in samples/sec.
wd1 = ['\pi rad   '; '2\pi/3 rad'; '\pi/3 rad ';];  

Ts = 1./fs;
w1 = zeros(3,L);
X1 = zeros(3,L);

for i=1:3
     for k=1:L
           w1(i,k) = omega(k)*Ts(i); % digital frequency ù=Ù*Ts (rad).
           X1(i,k) = 1/Ts(i)*Xa(k);
     end
   
    % Indices of frequency samples corresponding to the fundamental interval of  2*pi.
     Central_2pi  = find(w1(i,:)>=-pi & w1(i,:)<=pi); 

     Y1    = [              X1(i,Central_2pi)            zeros(size(X1(i,Central_2pi)))      zeros(size(X1(i,Central_2pi)))];
     Y2    = [zeros(size(X1(i,Central_2pi)))        X1(i,Central_2pi)                        zeros(size(X1(i,Central_2pi)))];
     Y3    = [zeros(size(X1(i,Central_2pi)))    zeros(size(X1(i,Central_2pi)))                  X1(i,Central_2pi)          ];
     
     w2 = [w1(i,Central_2pi)-2*pi  w1(i,Central_2pi)   w1(i,Central_2pi)+2*pi]; 

     subplot(4,1,i+1);
     plot(w2,Y1,'r');
     hold on;
     plot(w2,Y2,'b');
     plot(w2,Y3,'g');
    % plot(w1(i,:),X1(i,:));
     set(gca,'XTick',-4*pi:pi/2:4*pi);
     set(gca,'XTickLabel',{'-4pi','-7pi/2','-3pi','-5pi/2','-2pi','-3pi/2','-pi','-pi/2','0','pi/2','pi','3pi/2','2pi','5pi/2','3pi','7pi/2','4pi' })
     xlabel('Digital Frequency \omega (rad/sample)');
     title(['X(e^{j\omega}), \Omega_0*T_s = ',num2str(2*pi*5000*Ts(i)),' = ',wd1(i,:),' \leq \pi']);
     ylim([-1/10 12/10]*1/Ts(i));
     grid on;
end

%% Step (b). Sampling below Nyquist Frequency (Aliasing).

fs = [8 5 3]*1e3; % Sampling rates in samples/sec.
wd2 = ['\pi + \pi/4 rad '; '2\pi   rad      '; '3\pi + \pi/3 rad';];  
Ts = 1./fs;
X2 = zeros(3,L);
w3 = zeros(3,L);
figure('Name','Exercise 4.1.5. DTFT of a Sampled Signal (Aliasing)');

for i=1:3
    for k=1:L
          X2(i,k) = 1/Ts(i)*Xa(k);
          w3(i,k) = omega(k)*Ts(i); % digital frequency ù=Ù*Ts (rad).
    end

    % Indices of frequency samples corresponding to the fundamental interval of 2*pi. 
    Central_2pi  = find(w3(i,:)>=-pi & w3(i,:)<=pi); 
    % this is number of samples that correspond to an interval equal to 2pi.
    N_2pi = length(Central_2pi);  
    
    Z1   = shiftright(X2(i,:),     N_2pi);
    Z2   = shiftright(X2(i,:), 2*N_2pi);
    Z3   = shiftright(X2(i,:), 3*N_2pi);
    Z4   = shiftright(X2(i,:), 4*N_2pi);
    Z5   = shiftright(X2(i,:), 5*N_2pi);
    Z6   = shiftright(X2(i,:), 6*N_2pi);
    Z7   = X2(i,:);
    Z8   = shiftright(X2(i,:),  -  N_2pi);
    Z9   = shiftright(X2(i,:), -2*N_2pi);
    Z10 = shiftright(X2(i,:), -3*N_2pi);
    Z11 = shiftright(X2(i,:), -4*N_2pi);
    Z12 = shiftright(X2(i,:), -5*N_2pi);
    Z13 = shiftright(X2(i,:), -6*N_2pi);
        
    Z = Z1+Z2+Z3+Z4+Z5+Z6+Z7+Z8+Z9+Z10+Z11+Z12+Z13;
          
    subplot(3,1,i);
    plot(w3(i,:),Z);
    hold on;
    % Plot the basic component of the spectrum as well for comparison reasons.
    plot(w3(i,:),X2(i,:),'r');            
    set(gca,'XTick',-10*pi:pi:10*pi);
    set(gca,'XTickLabel',{'-10pi','-9pi','-8pi','-7pi','-6pi','-5pi','-4pi','-3pi','-2pi','-pi','0','pi','2pi','3pi','4pi','5pi','6pi','7pi','8pi','9pi','10pi' })
    xlabel('Digital Frequency \omega (rad/sample)');
    title(['X(e^{j\omega}), \Omega_0*T_s = ',num2str(2*pi*5000*Ts(i)),' = ',wd2(i,:),' > \pi']);
    xlim([-10*pi 10*pi]);
    ylim([0 17e3]);
    grid on;
            
end
