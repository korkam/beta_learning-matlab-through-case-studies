%%  MA666 - Lab 1 (8):  Correlation and coherence
%   In this lab we will review the power spectrum, develop our own code to
%   compute the coherence and cross correlation, and apply these measures to
%   two cases studies of data.

%%  Preliminaries.
%   Text preceded by a '%' indicates a 'comment'.  This text should appear
%   green on the screen.  I will use comments to explain what we're doing 
%   and to ask you questions.  Also, comments are useful in your own code
%   to note what you've done (so it makes sense when you return to the code
%   in the future).  It's a good habit to *always* comment your code.  I'll
%   try to set a good example, but won't always . . . 

%%  NOTES - Challenge Problems.
%   You'll find 4 challange problems below.  Your task --- answer
%   at least the first three of them.  Present your results to me in whatever format
%   you think is appropriate.  Your solutions should include figures (with axes labeled
%   and captions) and explanatory text.  Also, please include any
%   MATLAB code you write;  remember to include comments in the
%   code.  The comments should be detailed enough that you could share your
%   code with any of your classmates / colleagues.  Watch out for *Extreme*
%   Challenge problems --- they're tricky.

%%  Part 1:  Warm-up, Computing the power spectrum in 3 ways.
%   We discussed in class the discrete Fourier transform and power
%   spectrum.  Let's compute these quantities in three ways.  We'll begin
%   by writing out every step, and conclude using a built-in MATLAB
%   routine.

%   First, create some data.
dt = 0.001;             %The sampling interval.
t = (dt:dt:3);          %Define a time axis.
T = max(t);             %Define max time.
N = length(t);          %Define total # of data indices.
x = sin(2.0*pi*t*10) + randn(1,N);   %Create the data, a simple sinusoid + noise.

%  Now, define the frequencies at which we'll evaluate the Fourier
%  transform.  We consider frequencies between the +/- Nyquist frequency
%  (the sampling frequency divided by two), in steps of 1/T = the frequency
%  resolution,
fj = (-1/dt/2: 1/T :1/dt/2-1/T);

%  For each freq compute the Fourier transform and save in X.
X = zeros(1,length(fj));
for j=1:length(fj)
    X(j) = sum(x .* exp(-2*pi*1i*fj(j)*t));
end

%  Compute the power spectrum.
pow = 2*dt^2/T * X.*conj(X);

%  And plot it on a decibel scale.
subplot(3,1,1)
plot(fj, 10*log10(real(pow)));  axis tight;  xlim([0 20]);  ylim([-50 0])
xlabel('Freq [Hz]');  ylabel('Power')

%  Second, let's compute the Fourier transform using built-in MATLAB
%  routines.  Then, it's one step,
X = fft(x);

%  Create the frequency axis.
df = 1/T;
fNQ = 1/dt/2;
faxis = (-fNQ:df:fNQ-df);

%  Re-compute the power spectrum.
pow = 2*dt^2/T * X.*conj(X);

%  And plot it on a decibel scale.  Note the use of "fftshift".
subplot(3,1,2)
plot(faxis, 10*log10(fftshift(pow)));  axis tight;  xlim([0 20]);  ylim([-50 0])
xlabel('Freq [Hz]');  ylabel('Power')

%  Third, use a built-in MATLAB routine to compute and plot spectrum.
subplot(3,1,3)
periodogram(x, [], N, 1/dt);  xlim([0 20]);  ylim([-50 0])

%  All three measures should give the same result.  Confirm this.

%%  Part 2:  Compute the cross covariance (by hand) and apply to noisy data.
%   First, generate two noisy signals.

dt = 0.001;                     %The sampling interval.
t = (dt:dt:1);                  %Time axis.
x = 0.2*randn(1,length(t));     %Signal x.
y = 0.2*randn(1,length(t));     %Signal y.

%   Plot the two signals to have a look.  Visual inspection is always a
%   good place to start data analysis.

figure(10)
plot(t,x)
hold on
plot(t,y, 'g')
hold off
xlabel('Time [s]')

%   These signals are *not* coupled (right?  They're just noise).  Let's
%   compute the cross covariance.  Can you already guess what values
%   the cross covariance will obtain?  We'll (first) develop our
%   own MATLAB code to compute this measure. We'll do this 'by hand' through
%   the following code available on the course website.
%
%       my_cc_circ_shift.m
%
%   We'll work through this code in lab, and make sure we understand it.
%   To apply the code is simple,

[rxy, lag] = my_cc_circ_shift(x,y);

%   And plot the results.

figure(1);  clf()
plot(lag, rxy)
xlabel('Lags [ms]');  ylabel('Cross Covariance');

%Q (Challenge for LAB):  Modify the 'my_cc_circ_shift.m' code to compute the cross
%correlation, a normalized measure.  Then, 1) Compute the auto-correlation of x and
%plot the results, and 2) Compute the cross correlation between x and y above
%and plot the results.  Finally, 3) Compare these results to the
%built-in MATLAB routine 'xcorr'.  See MATLAB Help to learn more.

%%  Part 3:  Relationship of power spectrum to autocovariance.
%   In class, we showed the relationship between the power spectrum of a
%   signal and its autocovariance.  Namely, they are Fourier transform
%   pairs.  In class we showed that,
%
%        The power spectrum is the FT of the auto-covariance.
%
%   It's also true that,
%
%        The auto-covariance is the inverse FT of the power spectrum.
%
%   We'll show this second statement below for simulated data.  

%  Make a signal.
dt = 0.001;  t = (dt:dt:2);  T = max(t);  N = length(t);
d = sin(2*pi*t*10) + randn(1,length(t));

%  Compute the Fourier transform.
dfft = fft(d);

%  Compute the power spectrum, then take the inverse Fourier transform, and
%  scale by 1/(2 dt).  The result should be the auto-covariance of x.
pow = 2*dt^2/T* conj(dfft).*dfft;
acFFT = 1/(2*dt)*ifft(pow);

%  Rearrange to put negative lags in the correct place.
acFFT = fftshift(acFFT);

%  Compute the autocovariance using our cross-covariance routine.
[ac, lags] = my_cc_circ_shift(d,d);         %Compute covariance.
ac = ac(N/2:end-N/2);                       %Consider lags -N/2 to N/2.
lags = lags(N/2:end-N/2)*dt;                %Consider lags -N/2 to N/2.

%  To compare, plot the results.
clf()
subplot(3,1,1)
plot(t,d);
ylabel('Data');  xlabel('Time [s]')

subplot(3,1,2)
plot(lags, acFFT);
hold on;
plot(lags, ac, 'go');
hold off
ylabel('Covariance');  xlabel('Lags [s]')

subplot(3,1,3)
plot(lags, acFFT - ac)
ylabel('Difference');  xlabel('Lags [s]')

%%  Part 4:  Compute the the squared coherence (by hand) between two signals.
%   In class we developed an expression for the squared coherence.  We will
%   now write code to compute the squared coherence.  We'll work through
%   the following code in lab, and make sure we understand it.

%   Define two signals.  Can you guess their coherence?
dt = 0.001;  t = (dt:dt:1);  N = length(t);  T = max(t);
x = randn(1,N);                         %Signal x, random noise.
y = randn(1,N);                         %Signal y, random noise.

%   Define the frequency axis.
df = 1/T;
fNQ = 1/dt/2;
faxis = (-fNQ:df:fNQ-df);

%  Compute the Fourier transform of x.
Xd = fft(x);

%  Compute the Fourier transform of y.
Yd = fft(y);

%  Compute the auto and cross spectra, and organize frequencies.
Sxx = 2*dt/N*(Xd.*conj(Xd));  Sxx = fftshift(Sxx);
Syy = 2*dt/N*(Yd.*conj(Yd));  Syy = fftshift(Syy);
Sxy = 2*dt/N*(Xd.*conj(Yd));  Sxy = fftshift(Sxy);

%  Compute the squared coherence.
cohr = Sxy.*conj(Sxy) ./ (Sxx.*Syy);

%  Plot the results.
subplot(5,1,1)
plot(t,x)
hold on
plot(t,y, 'g')
hold off
xlabel('Time [s]');  ylabel('Data')

subplot(5,1,2)
plot(faxis, Sxx);  ylabel('Abs(Sxx)^2');  xlim([-50,50])
subplot(5,1,3)
plot(faxis, Syy);  ylabel('Abs(Syy)^2');  xlim([-50,50])
subplot(5,1,4)
plot(faxis, Sxy.*conj(Sxy));  ylabel('Abs(Sxy)^2');  xlim([-50,50])
subplot(5,1,5)
plot(faxis, cohr)
xlabel('Freq [Hz]'); ylabel('Squared Coherence'); xlim([-50,50]); ylim([-0.1,1.1])

% Hmm . . . something odd happening here?

%%  CHALLENGES

%Q (Challenge #1).  Update the coherence measure to include multiple trials.
%Consider the following simulated data,
%
%    K=100; dt=0.001; t=(dt:dt:1); N=length(t);
%    x = zeros(K,N);
%    y = zeros(K,N);
% 
%    for k=1:K
%      x(k,:) = randn(1,length(t));
%      y(k,:) = randn(1,length(t));
%    end
%
%Notice that in this case there are 100 trials, each of length 1s (here dt=1ms).
%In this case the data is random in each trial.  So we expect the ensemble averaged
%coherence to be zero.  i) Update the code above to compute the ensemble
%averaged coherence for these pure-noise data.  ii)  Repeat your coherence
%analysis for the following simulated data consisting of two sinusoids with
%constant phase shift and added noise,
%
%    K=100; dt=0.001; t=(dt:dt:1); N=length(t);
%    x = zeros(K,N);  f1 = 10;
%    y = zeros(K,N);  f2 = 10;
% 
%    for k=1:K
%      x(k,:) = sin(2.0*pi*t*f1 + 0.3*pi) + 0.1*randn(1,length(t));
%      y(k,:) = cos(2.0*pi*t*f1) + 0.1*randn(1,length(t));
%    end

%Q (Challenge #2).  Case Study 1.  Download the data 'Case_Study_1.mat'
%from the course website.  You'll find the file contains three variables,
%
%  x = observation of time series x [ntrials, time].
%  y = observation of time series y [ntrials, time].
%  dt = sampling interval in [s].
%
%Both x and y are observed simultaneously for 100 trials, each trial lasting 1s.
%The sampling interval dt = 0.001s.  Use the tools developed in this lab
%to analyze these data.  Please compute, i) the power spectra of x and y, 
%ii) the cross correlation between x and y, and iii) the coherence between
%x and y.  For (i) and (ii), compute the power spectra and cross
%correlation for each trial, and average the results over all trials.

%Q (Challenge #3).  Case Study 2.  Download the data 'Case_Study_2.mat'
%from the course website.  You'll find the file contains three variables,
%
%  x = observation of time series x [ntrials, time].
%  y = observation of time series y [ntrials, time].
%  dt = sampling interval in [s].
%
%Both x and y are observed simultaneuously for 100 trials, each trial lasting 1s.
%The sampling interval dt = 0.001s.  Use the tools developed in this lab
%to analyze these data.  Please compute, i) the power spectra of x and y, 
%ii) the cross correlation between x and y, and iii) the coherence between
%x and y.  For (i) and (ii), compute the power spectra and cross
%correlation for each trial, and average the results over all trials.

%Q (Challenge #4).
%   Visit the Blackboard website for this course and download the file
%   "Coherence_and_Correlation_Notes_ECoG.pdf" from the Course Documents section.
%   Work through this document by downloading the specified data set
%   and executing the MATLAB code.  Notify me of any typos, suggestions,
%   ideas, etc.  I'm interested to know anything you like or dislike.  What
%   makes sense?  What doesn't make sense?

%Q (Challenge #5).  i) Examine the MATLAB function 'mscohere' and use it to
%compute the coherence between simulated data. ii) Examine the function
%'coherencyc' in the Chronux Toolbox found here,
%
%    http://www.chronux.org/
%
%and use the function to compute the coherence between *single trial* simulated
%noisy data.
