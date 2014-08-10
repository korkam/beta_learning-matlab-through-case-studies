%%  Analysis of Rhythmic Data (MA665) %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  We'll work through this code during lecture.  To start, download the
%  example data from the course webpage:
%
%  Then, load the data in MATLAB,

load 6_data.mat

%  In what follows there are 10 examples making use of these data sets.
%
%  Let's get started . . . 

%%  Example 1:  Use v1 & t1.  Plot the data.

plot(t1,v1)
xlabel('Time [s]');
ylabel('Voltage [mV]');

%%  Example 2:  Test Orthogonality.

dt = 0.001;         %Time step.  Data sampled at 1000 Hz.
t = (0:dt:1);       %Define time axis.

f1=11;  f2=10;              %Define two sinusoids.
x1 = cos(2.0*pi*t*f1); 
x2 = sin(2.0*pi*t*f2);

figure(10)                  %Plot the sinusoids.
subplot(2,1,1)
plot(t,x1)
hold on
plot(t,x2, 'r')
hold off
title('x1 (blue) and x2 (red)')

subplot(2,1,2)              %Plot their product and print sum.
plot(t, x1.*x2)
title(['Integral = ' num2str(sum(x1.*x2)*dt)])

%%  Example 3:  Simulated data power.

dt = 0.001;         %Time resolution.  Data sampled at 1000 Hz.
t = (dt:dt:1);      %Define time axis.

v0=15;  f=100;               %Define amplitude and frequency of sinusoid.
v = v0*sin(2.0*pi*t*f);     %Simualte data.

pow = abs(fft(v)).^2 * 2/length(v);    %Computer power.

figure(10)
clf()
subplot(2,1,1)
plot(v)
subplot(2,1,2)
plot(pow)

%%  Example 4:  Observed data
%   Q:  What is the x-axis?

load 6_data.mat                         %Load the data.

pow = abs(fft(v1)).^2 * 2/length(v1);   %Compute the spectrum.
pow = 10*log10(pow);                    %Covert to decibel scale.

figure(10)
clf()
subplot(2,1,1)
plot(t1, v1);  xlabel('Time [s]');  ylabel('Voltage')
subplot(2,1,2)
plot(pow);  xlabel('Indices');  ylabel('Power')

%%  Example 5:  Compute the spectrum and plot it with correct x-axis.

%load 6_data.mat                         %Load the data

pow = abs(fft(v1)).^2 * 2/length(v1);    %Compute the spectrum.
%pow = 10*log10(pow);                     %Convert to decibels.
pow = pow(1:length(v1)/2+1);             %Ignore negative frequencies.

dt = 0.001;                              %Define the time resolution.
df = 1/max(t1);                          %Determine the frequency resolution.
fNQ = 1/ dt / 2;                         %Determine the Nyquist frequency.
faxis = (0:df:fNQ);                      %Construct frequency axis.

figure(10)
clf()
plot(faxis, pow);
xlim([0 50])
xlabel('Frequency [Hz]')
ylabel('Power [dB]')

%%  Example 6:  Compute the spectrum using 'periodogram'
%   NOTE:  Requires the Signal Processing Toolbox in MATLAB.
%          http://www.mathworks.com/products/signal/

load 6_data.mat

dt = 0.001;                                 %The sampling interval in seconds.
Fs = 1/dt;                                  %The sampling frequency in Hertz.

periodogram(v1,[],length(v1),Fs);           %Only one line of code!
%xlim([0 50])                                %See MATLAB Help for details.


%%  Example 7:  Compute the spectrum with a Hann taper.
%   NOTE:  Requires the Signal Processing Toolbox in MATLAB.
%          http://www.mathworks.com/products/signal/
%   OR, write the Hann taper yourself and forget the toolbox!

load 6_data.mat                           %Load the data.

v0 = v1.* hann(length(v1))';              %Multiply data by Hann taper.
pow = abs(fft(v0)).^2 * 2/length(v0);     %Compute the spectrum.
pow = 10*log10(pow);                      %Convert to decibels.
pow = pow(1:length(v0)/2+1);              %Ignore negative frequencies.

dt = 0.001;                               %Define the time resolution.
f0 = 1/dt;                                %Determine the sampling frequency.
df = 1/max(t1);                           %Determine the frequency resolution.
fNQ = f0 / 2;                             %Determine the Nyquist frequency.
faxis = (0:df:fNQ);                       %Construct frequency axis.

plot(faxis, pow);
xlim([0 50])
ylim([-30 30])
xlabel('Frequency [Hz]')
ylabel('Power [dB]')

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  We'll now focus on variables 'v2' and 't2'  %%%%

%%  Example 8:  Plot the data.

load 6_data.mat                 %Load the data.

plot(t2,v2)
xlabel('Time [s]');

%%  Example 9:  Compute the power spectrum of v2 and plot it.
%   NOTE:  Requires the Signal Processing Toolbox in MATLAB.
%          http://www.mathworks.com/products/signal/

v0 = v2 .* hann(length(v2))';             %Hann taper the data.
pow = abs(fft(v0)).^2 * 2/length(v0);     %Compute the spectrum.
pow = 10*log10(pow);             %Convert to decibels.
pow = pow(1:length(v0)/2+1);              %Ignore negative frequencies.

dt = 0.001;                               %Define the time resolution.
f0 = 1/dt;                                %Determine the sampling frequency.
df = 1/max(t2);                           %Determine the frequency resolution.
fNQ = f0 / 2;                             %Determine the Nyquist frequency.
faxis = (0:df:fNQ);                       %Construct frequency axis.

plot(faxis, pow);
xlim([0 50])
xlabel('Frequency [Hz]')
ylabel('Power [dB]')

%%  Example 10:  Compute the spectrogram.
%   NOTE:  Requires the Signal Processing Toolbox in MATLAB.
%          http://www.mathworks.com/products/signal/

load 6_data.mat                             %Load the data.

dt = 0.001;                                 %The sampling interval in seconds.
Fs = 1/dt;                                  %The sampling frequency in Hertz.
[S,F,T]=spectrogram(v2,1000,500,1000,Fs);   %Window size is 1000 pts = 1 s
                                            %Overlap is 500 pts = 0.5 s
                                            %Compute fft over 1000 pts.
S = abs(S);
imagesc(T,F,10*log10(S/max(S(:))));  colorbar;
axis xy
ylim([0 20])
xlabel('Time [s]')
ylabel('Freq [Hz]')
