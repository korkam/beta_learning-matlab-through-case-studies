% pr8_3
% CoherenceStudy

clear;
N=8;
SampleRate=10;
t=[0 .1 .2 .3 .4 .5 .6 .7];

% Three Replications of Two Signals x and y
x1=[3 5 -6 2 4 -1 -4 1];
x2=[1 1 -4 5 1 -5 -1 4];
x3=[-1 7 -3 0 2 1 -1 -2];
y1=[-1 4 -2 2 0 0 2 -1];
y2=[4 3 -9 2 7 0 -5 1];
y3=[-1 9 -4 -1 2 4 -1 -5];
f=SampleRate*(0:N/2)/N;                             % Frequency Axis

% Signals Combined
X=[x1 x2 x3];
Y=[y1 y2 y3];
T=[0 .1 .2 .3 .4 .5 .6 .7 .8 .9 1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2 2.1 2.2 2.3];

cxy=cohere(X, Y, N, SampleRate, boxcar(8));         % direct MATLAB            
                                                    % command for coherence
                                                    % boxcar(8) is a
                                                    % Rectangular Window
% FFTs
fx1=fft(x1);
fx2=fft(x2);
fx3=fft(x3);

fy1=fft(y1);
fy2=fft(y2);
fy3=fft(y3);

%Power and Cross Spectra individual trials
Px1x1=fx1.*conj(fx1)/N;
Px2x2=fx2.*conj(fx2)/N;
Px3x3=fx3.*conj(fx3)/N;
MeanPx=mean([Px1x1', Px2x2', Px3x3']');     	% Average the Trials

Py1y1=fy1.*conj(fy1)/N;
Py2y2=fy2.*conj(fy2)/N;
Py3y3=fy3.*conj(fy3)/N;
MeanPy=mean([Py1y1', Py2y2', Py3y3']');     	% Average the Trials

Px1y1=fx1.*conj(fy1)/N;
Px2y2=fx2.*conj(fy2)/N;
Px3y3=fx3.*conj(fy3)/N;
MeanPxy=mean([Px1y1', Px2y2', Px3y3']');    	% Average the Trials

% Calculate the Coherence, the abs command is to get 
% the Magnitude of the Complex values in MeanPxy
C=(abs(MeanPxy).^2)./(MeanPx.*MeanPy);

% Plot the Results
figure
plot(f,C(1:5),'k');
hold;
plot(f,cxy,'r*');
title(' Coherence Study red* MATLAB routine')
xlabel(' Frequency (Hz)')
ylabel(' Coherence')

figure;
for phi=0:2*pi;polar(phi,1);end;                % Unit Circle
hold;

% Plot the individual points for the second frequency 2.5 Hz
plot(Px1y1(3)/sqrt((Px1x1(3)*Py1y1(3))),'r*')
plot(Px2y2(3)/sqrt((Px2x2(3)*Py2y2(3))),'r*')
plot(Px3y3(3)/sqrt((Px3x3(3)*Py3y3(3))),'r*')

% Plot the average
plot(MeanPxy(3)/sqrt((MeanPx(3)*MeanPy(3))),'k*');
title(' For individual Frequencies (e.g. here 2.5 Hz) all Three Points (red) are on the Unit Circle, The Average black =<1')
