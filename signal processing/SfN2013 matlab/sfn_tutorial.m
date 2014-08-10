%% The Science of Large Data Sets: Spikes, Fields, and Voxels
%  Society for Neuroscience Short Course #2, San Diego, 2013
%  "Introduction to Field Analysis Techniques: The Power Spectrum and Coherence"
%  Mark Kramer (BU)
%  http://math.bu.edu/people/mak/sfn-2013/

%%  Example 1.  Load the data, and plot it.  %%

load d1.mat                                         % Load the data.
plot(t,x)                                           % ... and plot it.   
T=2;                                                % Define the total duration of recording.

xlabel('Time [s]')                                  % Label the x-axis.
ylabel('V [\muV]')                                  % ... and y-axis.

%%  Example 2.  Zoom in, and plot the individual sampled points.

hold on                                             % Hold the graphics window,
plot(t,x, 'k*')                                     % ... plot the individual samples.
xlim([1 1.1])                                       % ... select a narrow time interval.
hold off                                            % Release the graphics window.
dt = 0.002;                                         % Define the sampling interval.

%%  Example 3.  Plot the power spectrum (with real and imaginary parts).

Sxx=2*dt^2/T*fft(x).*conj(fft(x));                  % Compute the power spectrum,
Sxx=10*log10(Sxx);                                  % ... convert to a decibel scale.
plot(Sxx)                                           % ... and plot it.

%%  Example 4.  Plot the power spectrum (with real part only).

Sxx=2*dt^2/T*fft(x).*conj(fft(x));                  % Compute the power spectrum.
Sxx=10*log10(real(Sxx));                            % ... keep the real part and convert to a decibel scale.
plot(Sxx)                                           % ... and plot it.

ylim([-80 10])                                      % Set range of y-values in plot.
xlabel('Indices [ ]')                               % Label x-axis.
ylabel('Power [dB]')                                % Label y-axis.

%%  Example 5.  Plot the power spectrum with correct axes.

Sxx = 2*dt^2/T * fft(x).*conj(fft(x));			    % Compute the power spectrum. 
Sxx=10*log10(Sxx);                                  % ... convert to a decibel scale.
Sxx = Sxx(1:length(x)/2+1);                         % ... ignore negative frequencies.		
df = 1/T;                                           % Determine the frequency resolution. 
fNQ=1/dt/2;                                         % Determine the Nyquist frequency. 
faxis = (0:df:fNQ);                                 % Construct the frequency axis.
plot(faxis, Sxx)                                    % Plot power versus frequency. 
ylim([-80 10])                                      % Set range of y-values in plot.
xlabel('Frequency [Hz]');  ylabel('Power [dB]')     % Label the axes.

%%  Example 6.  Plot the power spectrum without the decibel scale

Sxx = 2*dt^2/T * fft(x).*conj(fft(x));              % Compute the power spectrum. 
Sxx = Sxx(1:length(x)/2+1);                         % ... ignore negative frequencies.		
df = 1/T;                                           % Determine the frequency resolution. 
fNQ=1/dt/2;                                         % Determine the Nyquist frequency. 
faxis = (0:df:fNQ);                                 % Construct the frequency axis.
plot(faxis, Sxx)                                    % Plot power versus frequency. 
ylim([0 10])                                        % Set range of y-values in plot.
xlabel('Frequency [Hz]'); ylabel('Power [\muV^2/Hz]')  % Label the axes.

%%  Example 7.  Apply the Hann taper to the data, and plot it.

xh = hann(length(x)).*x;                            % Apply the Hann taper to the data.
plot(t,xh)                                          % ... and plot it.
xlabel('Time [s]');  ylabel('V [\muV]')             % Label the axes.

%%  Example 8.  Compute the power spectrum of the Hann tapered data.

Sxx = 2*dt^2/T * fft(xh).*conj(fft(xh));			% Compute the power spectrum of Hann tapered data.
Sxx=10*log10(Sxx);                                  % ... convert to a decibel scale.
Sxx = Sxx(1:length(x)/2+1);                         % ... ignore negative frequencies.		
df = 1/T;                                           % Determine the frequency resolution. 
fNQ=1/dt/2;                                         % Determine the Nyquist frequency. 
faxis = (0:df:fNQ);                                 % Construct the frequency axis.
plot(faxis, Sxx)                                    % Plot power versus frequency. 
ylim([-80 10])                                      % Set range of y-values in plot.
xlabel('Frequency [Hz]');  ylabel('Power [dB]')     % Label the axes.

%use Hann taper to reveal pow freq in side

%%  Example 9.  Load the multisensor data and visualize data from the first trial.

clear
load d2.mat                                         % Load the multi-sensor data.

plot(t,x(1,:))                                      % Plot the data from sensor "x", first trial.
hold on                                             % ... hold the graphics window.
plot(t,y(1,:), 'r')                                 % ... plot the data from sensor "y", first trial.
hold off                                            % ... release the graphics window.

ylabel('Voltage [mV]'); xlabel('Time [s]')          % Label the axes.
dt = 0.002;                                         % ... define the sampling interval.
T=1;                                                % ... and the total duration of recording.

%%  Example 10.  Compute the power spectrum for the x sensor, first trial.

Sxx = 2*dt^2/T * fft(x(1,:)).*conj(fft(x(1,:)));	% Compute the power spectrum for sensor "x", first trial. 
Sxx=10*log10(Sxx);                                  % ... convert to a decibel scale.
Sxx = Sxx(1:length(x)/2+1);                         % ... ignore negative frequencies.		
df = 1/T;                                           % Determine the frequency resolution. 
fNQ=1/dt/2;                                         % Determine the Nyquist frequency. 
faxis = (0:df:fNQ);                                 % Construct the frequency axis.
plot(faxis, Sxx)                                    % Plot power versus frequency. 
ylim([-80 10])                                      % Set range of y-values in plot.
xlabel('Frequency [Hz]');  ylabel('Power [dB]')     % Label the axes.

%%  Example 11.  Compute the trial averaged power spectrum for sensor x.

K  = size(x,1);                                     % Define the number of trials.
N  = size(x,2);                                     % Define the number of indices per trial.

Sxx = zeros(1,N);
for k=1:K                                                   % For each trail,
    x0 = x(k,:);                                            % ... get the data,
    Sxx = Sxx + 2*dt^2/T * abs(fft(x0).*conj(fft(x0)));     % ... compute the power spectrum and add to the sum.
end
Sxx = Sxx / K;                                      % ... divide by # trials to compute the mean.
Sxx=10*log10(Sxx);                                  % ... convert to a decibel scale.
Sxx = Sxx(:,1:N/2+1);                               % ... ignore negative frequencies.

df = 1/T;                                           % Determine the frequency resolution.
fNQ = 1/dt/2;                                       % Determine the Nyquist frequency.
faxis = (0:df:fNQ);                                 % Construct the frequency axis.
plot(faxis, Sxx)                                    % Plot power versus frequency.
xlabel('Frequency [Hz]'); ylabel('Power [dB]');     % Label the axes       

%%  Example 12.  Compute the coherence.

K  = size(x,1);                                     % Define the number of trials.
N  = size(x,2);                                     % Define the number of indices per trial.
Sxx = zeros(K,N);                                   % Create variables to save the spectra.
Syy = zeros(K,N);
Sxy = zeros(K,N);
for k=1:K                                                   % Compute the spectra for each trial.
    Sxx(k,:) = 2*dt^2/T * fft(x(k,:)) .* conj(fft(x(k,:))); % ... power spectrum of x.
    Syy(k,:) = 2*dt^2/T * fft(y(k,:)) .* conj(fft(y(k,:))); % ... power spectrum of y.
    Sxy(k,:) = 2*dt^2/T * fft(x(k,:)) .* conj(fft(y(k,:))); % ... cross spectrum.
end
Sxx = Sxx(:,1:N/2+1);                               % Ignore the negative frequencies.
Syy = Syy(:,1:N/2+1);
Sxy = Sxy(:,1:N/2+1);
Sxx = mean(Sxx,1);                                  % Average the spectra across trials.
Syy = mean(Syy,1);
Sxy = mean(Sxy,1);

cohr = abs(Sxy) ./ (sqrt(Sxx) .* sqrt(Syy));        % Compute the coherence.

df = 1/T;                                           % Determine the frequency resolution.
fNQ = 1/dt/2;                                       % Determine the Nyquist frequency.
faxis = (0:df:fNQ);                                 % Construct the frequency axis.
plot(faxis, cohr);                                  % Plot the coherence versus frequency.
ylim([0 1])                                         % Set the axes limits.
xlabel('Frequency [Hz]'); ylabel('Coherence [ ]')   % Label axes.

%%  Example 13.  Coherence for a single trial.

x0 = x(1,:);                                        % Select the first trial from sensor x.
y0 = y(1,:);                                        % Select the first trial from sensor x.

Sxx = 2*dt^2/T * fft(x0) .* conj(fft(x0));          % Power spectrum of x.
Syy = 2*dt^2/T * fft(y0) .* conj(fft(y0));          % Power spectrum of y.
Sxy = 2*dt^2/T * fft(x0) .* conj(fft(y0));          % Cross spectrum between x and y.

Sxx = Sxx(1:N/2+1);                                 % Ignore the negative frequencies.
Syy = Syy(1:N/2+1);
Sxy = Sxy(1:N/2+1);

cohr = abs(Sxy) ./ (sqrt(Sxx) .* sqrt(Syy));        % Compute the coherence.

df = 1/T;                                           % Determine the frequency resolution.
fNQ = 1/dt/2;                                       % Determine the Nyquist frequency.
faxis = (0:df:fNQ);                                 % Construct the frequency axis.
plot(faxis, cohr);                                  % Plot the coherence versus frequency.
ylim([0 1.1])                                       % Set the axes limits.
xlabel('Frequency [Hz]'); ylabel('Coherence [ ]')   % Label axes.

%%  Example 14.  Coherence for a single trial of noise.

x0 = randn(1,N);                                    % Generate a single trial of random data for sensor x.
y0 = randn(1,N);                                    % Generate another trial of random data for sensor y.

Sxx = 2*dt^2/T * fft(x0) .* conj(fft(x0));          % Power spectrum of x.
Syy = 2*dt^2/T * fft(y0) .* conj(fft(y0));          % Power spectrum of y.
Sxy = 2*dt^2/T * fft(x0) .* conj(fft(y0));          % Cross spectrum between x and y.

Sxx = Sxx(1:N/2+1);                                 % Ignore the negative frequencies.
Syy = Syy(1:N/2+1);
Sxy = Sxy(1:N/2+1);

cohr = abs(Sxy) ./ (sqrt(Sxx) .* sqrt(Syy));        % Compute the coherence.

df = 1/T;                                           % Determine the frequency resolution.
fNQ = 1/dt/2;                                       % Determine the Nyquist frequency.
faxis = (0:df:fNQ);                                 % Construct the frequency axis.
plot(faxis, cohr);                                  % Plot the coherence versus frequency.
ylim([0 1.1])                                       % Set the axes limits.
xlabel('Frequency [Hz]'); ylabel('Coherence [ ]')   % Label axes.