% Exercise 4.1.2. Ideal Sampling (Time Domain).

%   Copyright 2012-2016, Ilias S. Konsoulas

%% Workspace Initialization.

clc; clear; close all;

%% Step (a). Sample the analog signal xa(t) with sampling period Ts = 1,
% in order to generate x[n].

% 'analog' signal definition.
f = 125/6;    % signal frequency in Hz.
Duration = 2; % in sec. This is how long the 'analog' signal lasts.
ta = 0:(1/10000):Duration;    % sample times
xa = sin(2*pi*f*ta);    %signal definition

% sampled signal creation.
fs = 1000;        	         % 1 kHz sampling frequency
Ts1 = 1/fs;           	      % sample period = 1 msec.
t1 = 0:Ts1:Duration;   % sample times
x = sin(2*pi*f*t1);        % signal definition
    
%plot a fraction of the signal against time
T_max = 1;  % in sec. duration of signal to plot
 
 figure('Name','Exercise 4.1.2. Ideal Sampling (Time Domain)');
subplot(2,1,1);
stem(t1,x,'r*');    % plot sampled signal
hold on
 
subplot(2,1,1)
plot(ta,xa);   % plot 'analog' signal
title([num2str(f),' Hz sine sampled at ',num2str(fs),' Hz']);
xlabel('Time (sec)') 
ylabel('x[n]')
axis([0,T_max,-1.2,1.2]);
grid on;

%% Calculate the DTFT of x[n].
n = 0: length(x)-1;
[w  X] = my_DTFT(x,n);

%% Plot the DTFT magnitude of x[n].
subplot(2,1,2);
plot(w,abs(X),'r');
hold on;
line([-2*pi*f*Ts1 -2*pi*f*Ts1], [0 max(abs(X))]);
line([2*pi*f*Ts1 2*pi*f*Ts1], [0 max(abs(X))]);
title(['\Omega_0T_s = ',num2str(2*pi*f*Ts1),' = \pi/24 rad < \pi rad']);
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3*pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' });
ylabel('|{\itX}(j\omega)|');
xlabel('\omega (rad/sample)'); 
xlim([-pi pi]);
axis tight;
grid on;

%% Steps (a) and (b).

Ts = [2 4 50 51]*1e-3; % Sampling periods.
wd = ['\pi/12 rad     '; '\pi/6 rad      '; '2\pi+\pi/12 rad'; '2\pi+\pi/8 rad ';];  

for i=1:4

    % sampled signal creation.
    t1 = 0:Ts(i):Duration;   % sampling instants
    x = sin(2*pi*f*t1);    % signal definition
    
    figure('Name','Exercise 4.1.2. Ideal Sampling (Time Domain)');
    subplot(2,1,1);
    stem(t1,x,'r*');    % plot sampled signal
    hold on
 
    subplot(2,1,1)
    plot(ta,xa);   % plot 'analog' signal
    title([num2str(f),' Hz sine sampled at ',num2str(1/Ts(i)),' Hz']);
    xlabel('Time (sec)') 
    ylabel('x[n]')
    axis([0,T_max,-1.2,1.2]);
    grid on;

% Calculate the DTFT of x[n].
    w = [-5*pi 5*pi];
     n = 0: length(x)-1;
     [w1 X] = my_DTFT2(x,n,w);
   
% Plot the DTFT magnitude of x[n].
    subplot(2,1,2);
    plot(w1,abs(X),'r');
    
    if 2*pi*f*Ts(i) <= pi
         hold on;
         line([-2*pi*f*Ts(i) -2*pi*f*Ts(i)], [0 max(abs(X))]);
         line([ 2*pi*f*Ts(i)  2*pi*f*Ts(i)], [0 max(abs(X))]);
         title(['\Omega_0T_s = ',num2str(2*pi*f*Ts(i)),' = ', wd(i,:),'< \pi rad']); 
    else
         title(['\Omega_0T_s = ',num2str(2*pi*f*Ts(i)),' = ', wd(i,:),' > \pi rad (aliasing)']);     
    end    
    
    ylabel('|{\itX}(j\omega)|');
    xlabel('\omega (rad/sample)'); 
    set(gca,'XTick',-5*pi:pi:5*pi);
    set(gca,'XTickLabel',{'-5pi','-4*pi','-3pi','-2pi','-pi','0','pi','2pi','3pi','4pi','5pi' });
    % xlabel(['\Omega_0T_s = ',num2str(2*pi*f*Ts(i)),' = ', wd(i,:), ' rad']); 
    axis tight;
    grid on;
        
end
