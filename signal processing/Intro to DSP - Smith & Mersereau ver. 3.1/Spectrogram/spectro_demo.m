% Short-Time Fourier Transform (Spectrogram) Demo.
% This demo shows how the custom function my_spectrogram() can be used
% to produce the spectrogram of an input signal.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Load the signal to be analyzed.
 load('chirp','Fs','y');
% load('gong','Fs','y');
% load timit2.asc;  N = 256; M = 200; Fs = 8000; y = timit2; 
%load('train','Fs','y');
% load('splat','Fs','y');
% load('laughter','Fs','y');

% Play Back the selected audio signal:
soundsc(y,Fs,24);

y = y/max(abs(y));  % Input Signal Normalization.
x = y.';
% x = y(1:2*16400).'; % Note: when Fs = 8192, 16400 samples approximately correspond to 2.0 secs.  

L = length(x);
N = 128;   % Selected window size.
M = 85;   % Selected overlap between successive segments in samples.

[K S] = my_spectrogram(x,N,M,'hamm');

%% Plot the Spectrogram.
% Create Frequency Axis.
Freq_Sup = (0:N-1)*Fs/N;  % Frequency Support of the signal in Hz.
Fstep = 1000;                           % step is 1kHz.
for i=0:ceil(Fs/Fstep)-1
    [minValue Freq_Ticks(i+1)] =  min(abs(Freq_Sup - i*Fstep));
end

% Create Time Axis
Ts = 1/Fs;                                  % Sampling Interval.
TrueWinDuration = (N-M)*Ts; % True time progress at each window in sec
t = (0:L-1)/Fs;                            % Total Duration of the signal in sec.  
TimeAxisIncrements = (0:K-1)*TrueWinDuration;  % Time instants corresponding to each column of S.
tstep = 0.5;                                % Time Step is 0.1 sec. 
for i=0:ceil(max(t)/tstep)-1
     [minValue Time_Ticks(i+1)] =  min(abs(TimeAxisIncrements - i*tstep));
end

h = figure('Name','Spectrogram Demo');
colormap('jet');
surface(10*log10(S),'EdgeColor','none');
% pcolor(10*log10(S));  shading interp;
set(gca,'XTick',Time_Ticks);
% The following code segment must only be enabled when tstep = 0.1 sec.
% set(gca,'XTickLabel', {'0','0.1','0.2','0.3','0.4','0.5','0.6','0.7','0.8','0.9','1.0' ,...
%                                            '1.1','1.2','1.3','1.4','1.5','1.6','1.7','1.8','1.9','2.0',...
%                                            '2.1','2.2','2.3','2.4','2.5','2.6','2.7','2.8','2.9','3.0',...
%                                            '3.1','3.2','3.3','3.4','3.5','3.6','3.7','3.8','3.9','4.0',...
%                                            '4.1','4.2','4.3','4.4','4.5','4.6','4.7','4.8','4.9','5.0',...
%                                            '5.1','5.2','5.3','5.4','5.5','5.6','5.7','5.8','5.9','6.0'},'FontSize',8);

% The following code segment must only be enabled when tstep = 0.25 sec.
% set(gca,'XTickLabel', {'0','0.25','0.5','0.75','1.0','1.25','1.5','1.75','2.0' ,...
%                                            '2.25','2.5','2.75','3.0','3.25','3.5','3.75','4.0',...
%                                            '4.25','4.5','4.75','5.0','5.25','5.5','5.75','6.0'},'FontSize',8);

% The following code segment must only be enabled when tstep = 0.5 sec.
set(gca,'XTickLabel', {'0','0.5','1.0','1.5','2.0','2.5','3.0','3.5','4.0','4.5','5.0','5.5','6.0'},'FontSize',10);
                                       
set(gca,'YTick',Freq_Ticks);
% The following code segment must only be enabled when Fstep = 1000 Hz.
set(gca,'YTickLabel', {'0', '1000', '2000' , '3000' , '4000' , '5000', '6000' ,'7000' ,'8000'});

% The following code segment must only be enabled when Fstep = 500 Hz.
%set(gca,'YTickLabel', {'0', '500', '1000' , '1500','2000', '2500' ,'3000', '3500' , '4000', '4500'...
%                                        , '5000', '5500', '6000', '6500' ,'7000', '7500' ,'8000'});

axis tight;
grid on;
title(['Signal Length: ',num2str(L),', Window Length: ', num2str(N),', Overlap: ', num2str(M), ' samples.']);
xlabel('Time (sec)');
ylabel('Frequency (Hz)');
colorbar();
cbar_handle = findobj(h,'tag','Colorbar');
set(get(cbar_handle,'YLabel'),'String','(dB)','Rotation',0);