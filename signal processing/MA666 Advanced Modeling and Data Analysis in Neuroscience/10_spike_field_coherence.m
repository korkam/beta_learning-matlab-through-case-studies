%%  MA666 - Lab 3 (10):  Spike-field coherence. 
%   In this tutorial we will develop tools to compute the spike-field
%   coherence.  We'll first see how to implement this code ourselves, then
%   we'll interface with the MATLAB software package Chronux. 

%%  Preliminaries.
%   Text preceded by a '%' indicates a 'comment'.  This text should appear
%   green on the screen.  I will use comments to explain what we're doing 
%   and to ask you questions.  Also, comments are useful in your own code
%   to note what you've done (so it makes sense when you return to the code
%   in the future).  It's a good habit to *always* comment your code.  I'll
%   try to set a good example, but won't always . . . 

%%  NOTES - Challenge Problems.
%   You'll find 6 challange problems below.  Your task --- answer
%   at least 3 of them.  Present your results to me in whatever format you think is
%   appropriate.  Your solutions should include figures (with axes labeled
%   and captions) and explanatory text.  Also, please include any
%   MATLAB code you write;  remember to include comments in the
%   code.  The comments should be detailed enough that you could share your
%   code with any of your classmates / colleagues.  Watch out for *Extreme*
%   Challenge problems --- they're tricky.  If you email me your solutions,
%   please send as PDF.

%%  Part 1:  Power spectrum of a spike train.
%   To compute the power spectrum of a spike train, we first need to calculate
%   the Fourier transform of the spike train.  We'll start by considering
%   the case of random (Poisson) spiking, and compute the Fourier transform
%   (FT) both 'by-hand' and using built-in MATLAB routines.  We already can
%   guess what this spectrum should look like, right?

N=1000; dt=0.001; T=N*dt;  %N is the # of pts, dt the time step, and T the total time.
tm = (1:N)*dt;             %Time axis, useful for plotting.

%   To generate Poisson spiking, we'll generate N Poisson random numbers
%   from a distribution with rate lambda.  We'll usually keep lambda small,
%   because the probability of a spike in any time bin is small.

lambda0 = 0.1;               %Spikes/bin = spikes/ms, in this case. 
dn = poissrnd(lambda0,1,N);  %# spikes in each bin.

%   Subtract the mean rate from the spike train.
dn = dn - mean(dn);

%   And let's plot it.
subplot(3,1,1)
plot(tm, dn)

%   Before we compute the spectrum, let's first compute the auto-covariance
%   of the spike train.  You'll need to download from the course website,
%
%   my_cc_circ_shift
%
%   Can you guess what the auto-covariance will look like?
[acf, lag] = my_cc_circ_shift(dn,dn);       %Compute AC with circular-shifts.
acf = acf(N/2:end-N/2);                     %Only keep the middle half of AC.
lag = lag(N/2:end-N/2);                     %... and of the lags.

%   Let's also plot the AC.  Does it make sense?
subplot(3,1,2)
plot(lag, acf)

%   Finally, we'll compute the FT of the spike train.  We'll first do so
%   by-hand.  To start, define the frequency axis.
fj = (-N/2:N/2-1)/N/dt;

%   We can also define a taper - here we use the 'default' taper.
h = ones(1,N);

%   Then compute the FT 'by-hand'.
X0 = zeros(1,length(fj));                           %An empty vec to hold results.
for j=1:length(fj)                                  %For each freq,
    X0(j) = sum(h .* dn .* exp(-2*pi*1i*fj(j)*tm)); %... data * taper * sinusoids.
end

%   The power spectrum is the FT multiplied by its complex conjugate, and
%   scaled.  Let's plot the results.  In addition, we'll also plot the
%   average rate (lambda) of the Poisson process.
subplot(3,1,3)
S = dt^2/T*(X0.*conj(X0));
plot(fj,S)
hold on
plot(fj,dt*lambda0*ones(length(fj),1), 'r')
hold off

%   Above we computed the FT by-hand.  We don't need to do this.  Instead,
%   we can compute the power spectrum using built-in MATLAB routines.  Do
%   so, and plot the results, in the next few lines.
pow = dt^2/T*(abs(fft(dn)).^2);
hold on
plot(fj, fftshift(pow), 'og')
hold off

%%  Part 2:  Power spectrum for multiple trials of Poisson spiking data.
%   Above, we computed the power spectrum of a single spike train.  It's
%   often the case that multiple instances of a spike train will be
%   observed (over multiple trials, say).  Let's consider multi-trial
%   observations of a spike train, and compute the average spectrum over
%   the trails.

%   First, define the number of trials, the length of each trial, the time
%   step, and the total time of each trial.
K=10; N = 1000; dt = 0.001; T=N*dt;

%   Then define the frequencies for the power spectrum.
df = 1/T;
faxis = (-N/2:N/2-1)*df;

%   We'll again consider Poission spikes with fixed rate lambda.
lambda0 = 0.1;

%   ... and generate multiple trials.  For each trial, generate the Poisson
%   spike data, compute the power spectrum, and compute the AC.  Save the
%   results of these last two computations for each trial.
S = zeros(K,length(faxis));
acf = zeros(K, N);
for k=1:K

    dn = poissrnd(lambda0,1,N);
    dn = dn - mean(dn);

    X0 = fft(dn);
    S0 = dt^2/T*(abs(fft(dn)).^2);
    
    S(k,:) = S0;

    [acf0, lag] = my_cc_circ_shift(dn,dn);
    acf(k,:) = acf0(N/2:end-N/2);
end
lag = lag(N/2:end-N/2);

%   Finally, plot the results of the AC and the power spectrum, both
%   averaged over all K trials.

subplot(2,1,1)
plot(lag, mean(acf,1)); xlabel('Lags [ms]'); ylabel('AC')

subplot(2,1,2)
S = mean(S,1);
plot(faxis,S)
hold on
plot(faxis,lambda0*dt*ones(length(faxis),1), 'r')
hold off
ylim([0 0.001]); xlabel('Freq [Hz]'); ylabel('Power')

%%  Part 3:  Power spectrum for multiple trials of refractory spiking data.
%   So far, we only considered examples of Poisson random data.  We did so
%   because we knew what power spectrum to expect (a constant one).  Let's
%   now consider a second example of spike train data:  spiking with a
%   refractory period.  We discussed in lecture what the spectrum should
%   be.  Let's see if that expectation holds.

%   The code below is the same as the code in Part 2.  What's changed is
%   the data we'll analyze.

%  Initial set up.
K=50; N=1000; dt=0.001; T=N*dt;

%  Define the frequencies.
df = 1/T;
faxis = (-N/2:N/2-1)*df;

%  Define quantities that change over trials.
lambda0=zeros(K,1);
S = zeros(K,length(faxis));
acf = zeros(K, N);
for k=1:K

    %Generate Poisson spiking with a refractory period.  This part is a bit
    %tricky.  In the above example, we fixed lambda - the probability of a 
    %spike.  Here, we allow lambda to vary in time.  Specifically, after a
    %spike occurs, we make the probability of a spike in the next 5 steps
    %very small;  this acts as the refractory period.
    c0=0.1;  c1=0.1;  b0=0.00;  b1=-0.5;
    dn = zeros(1,N);
    lambda = zeros(1,N);
    for t=6:N
        lambda(t) = c0 + c1*exp(b0 + b1*dn(t-1)+b1*dn(t-2)+b1*dn(t-3)+b1*dn(t-4)+b1*dn(t-5));
        dn(t) = poissrnd(lambda(t)); 
    end
    lambda0 = lambda0 + mean(lambda)/K;
    
    %The rest of the code is the same as Part 2.
    
    dn = dn - mean(dn);
    
    X0 = fft(dn);
    S0 = dt^2/T*(abs(fft(dn)).^2);
    
    S(k,:) = S0;

    [acf0, lag] = my_cc_circ_shift(dn,dn);
    acf(k,:) = acf0(N/2:end-N/2);
end
lag = lag(N/2:end-N/2);

%  And plot the results.  Are the AC and the power spectrum as you expect?
subplot(2,1,1)
plot(lag, mean(acf,1));

subplot(2,1,2)
S = mean(S,1);
plot(faxis,fftshift(S))
hold on
plot(faxis,mean(lambda0)*dt*ones(length(faxis),1), 'r')
hold off
ylim([0 0.0003])

%%  Part 4:  Spike-spike coherence. 
%   We've now computed the FT of spike trains, and used the FT to compute
%   the power spectrum.  We can also use the FT to compute the coherence
%   between two spike trains.  Remember that coherence detects a constant
%   phase relationship between two siganls over trials at some frequency.
%   The multi-trial structure is critical (just as it was for the field
%   data we considered earlier in the course).
%
%   We'll start by considering two sets of Poisson spike trains.  We
%   already have an expectation for the coherence (right?).  Let's now
%   compute it.

%   Set the simulation parameters, using multiple trials.
K=20; N = 1000; dt = 0.001; T=N*dt;
tm = (1:N)*dt;

%   Define the frequencies.
df = 1/T;
faxis = (-N/2:N/2-1)*df;

%   We'll consider random spikes with rate lambda0.
lambda0 = 0.05;

%   Define output variables for the spectra of the two signals.
X1 = zeros(K,length(faxis));
X2 = zeros(K,length(faxis));
for k=1:K

    %Generate the random data.
    dn1 = poissrnd(lambda0,1,N);
    dn2 = poissrnd(lambda0,1,N);

    %Compute mean rate of each.
    lambda1 = mean(dn1);
    lambda2 = mean(dn2);

    %Subtract the mean rates.
    dn1 = dn1-mean(dn1);
    dn2 = dn2-mean(dn2);
    
    %Compute the FTs.
    X01 = fft(dn1);
    X02 = fft(dn2);
    
    %Save the results.
    X1(k,:) = X01;
    X2(k,:) = X02;
end

%   Now, compute the power spectra and cross spectrum.
S11 = zeros(1,length(faxis));
S12 = zeros(1,length(faxis));
S22 = zeros(1,length(faxis));
for k=1:K
    S11 = S11 + dt^2/T*(X1(k,:).*conj(X1(k,:)))/K;
    S12 = S12 + dt^2/T*(X1(k,:).*conj(X2(k,:)))/K;
    S22 = S22 + dt^2/T*(X2(k,:).*conj(X2(k,:)))/K;
end

%   And then the coherence.
cohr = S12.*conj(S12) ./S11 ./S22;

%   Let's plot everything to have a look.
subplot(3,1,1)
plot(tm, dn1)

subplot(3,1,2)
plot(tm, dn2)

subplot(3,1,3)
plot(faxis,fftshift(cohr))
ylim([0 1])

%   Are the results what you expected?

%%  Part 5:  Spike-field coherence.
%   In the previous section we considered the coherence between two spike
%   trains.  Now let's consider the coherence between a spike train, and a
%   field (for example, an LFP).  We still require a multi-trial structure.
%   The code that follows is very similar to the code in Part 4;  the
%   primary change is to replace one of the spike trains with a field.

%   Set the simulation parameters, using multiple trials.
K=100; N = 1000; dt = 0.001; T=N*dt;
tm = (1:N)*dt;

%   Define the frequencies.
df = 1/T;
faxis = (-N/2:N/2-1)*df;

%   We'll include random spikes with rate lambda0.
lambda0 = 0.01;

%   We'll also generate an LFP with frequency f1 Hz.
f1 = 10;

%   Define output variables for the spectra of the two signals.
X1 = zeros(K,length(faxis));
X2 = zeros(K,length(faxis));
for k=1:K

    %Define the LFP signal as a sinusoid + noise.
    s  = sin(2.0*pi*tm * f1 + 1*pi*randn)+0.1*randn(1,N);
    
    %The spikes occur at random times.
    dn = poissrnd(lambda0,1,N);

    %Subtract the mean rates.
    dn = dn-mean(dn);
    
    %Compute the FTs.
    X01 = fft(dn);
    X02 = fft(s);
    
    %Save the results.
    X1(k,:) = X01;
    X2(k,:) = X02;
end

%   Now, compute the power spectra and cross spectrum.
S11 = zeros(1,length(faxis));
S12 = zeros(1,length(faxis));
S22 = zeros(1,length(faxis));
for k=1:K
    S11 = S11 + dt^2/T*(X1(k,:).*conj(X1(k,:)))/K;
    S12 = S12 + dt^2/T*(X1(k,:).*conj(X2(k,:)))/K;
    S22 = S22 + dt^2/T*(X2(k,:).*conj(X2(k,:)))/K;
end

%   And then the coherence.
cohr = S12.*conj(S12) ./S11 ./S22;

%   Let's plot everything to have a look.
subplot(3,1,1)
plot(tm, dn)

subplot(3,1,2)
plot(tm, s);

subplot(3,1,3)

plot(faxis,fftshift(cohr))
ylim([0 1]);  xlim([-50 50])

%   Are the results what you expected?

%%  Part 6:  Multi-taper method and single trial coherence.
%   We'll discuss today in lab how we can compute the coherence for a single
%   trial of data.  The 'trick' is to use the multi-taper method, in which
%   each taper is treated as a trial.  We'll implement an example of the
%   multi-taper coherence here.  I'll recommend, if you pursue this on your
%   own, use the software Chronux (see next part of lab).

%   Set the simulation parameters, and notice only a single trial.
N = 1000; dt = 0.001; T=N*dt;

%Random.
lambda = 0.1;
dn1 = poissrnd(lambda,1,N);
dn2 = poissrnd(lambda,1,N);

dn1 = dn1-mean(dn1);
dn2 = dn2-mean(dn2);

%   Tapers - we need to make some choices.  The first choice is the time-
%   bandwidth product = TW.  The time (T) is set by the length of our
%   recording (in this case, T=1s).  We now get to choose the half-bandwidth W.
%   What does this mean?  Consider the following expression,
%
%   TW = p
%
%   where we're free to choose p.  We can rearrange this, and solve for W,
%
%   W = p * 1/T = p * df
%
%   where df is the frequency resolution.  So, by choosing TW (or
%   equivalently p) large, we worsen our frequency resolution.  Why would we
%   ever do that?  Because the rule of thumb for choosing the number of
%   tapers is,
%
%   # tapers = 2 TW - 1
%
%   So, the larger TW (or p), the more tapers we'll use, and the more we
%   reduce the variance of the spectrum.  Thus, there's a tradeoff - we give
%   up some frequency resolution to reduce the variance.

%   Here's a standard choice.
TW = 3;
num_tapers = 2*TW-1;

%   In this case, T=1s, so W = 3 * 1Hz = 3Hz.  W is the half-bandwidth, so
%   any spectral peaks smear out by +/- 3Hz.  We concede this bandwidth to
%   gain 5 tapers.

%   With these choices, compute the tapers,
[dps_seq] = dpss(N,TW,num_tapers);

%  Define the frequencies.
df = 1/T;
faxis = (-N/2:N/2-1)*df;

%  Compute the FTs.
X1 = zeros(num_tapers, N);
X2 = zeros(num_tapers, N);
for k=1:num_tapers
    h = dps_seq(:,k)';
    
    X01 = fft(h.*dn1);
    X02 = fft(h.*dn2);

    X1(k,:) = X01;
    X2(k,:) = X02;
end

S11 = zeros(1, N);
S22 = zeros(1, N);
S12 = zeros(1, N);
for k=1:num_tapers
    S11 = S11 + dt^2/T*(X1(k,:).*conj(X1(k,:)))/num_tapers;
    S22 = S22 + dt^2/T*(X2(k,:).*conj(X2(k,:)))/num_tapers;
    S12 = S12 + dt^2/T*(X1(k,:).*conj(X2(k,:)))/num_tapers;
end

cohr = abs(S12) ./ sqrt(S11.*S22);
plot(faxis, fftshift(cohr))
ylim([0 1])

%%  Part 7:  Chronux.
%   Above we used the multi-taper method to compute the coherence between
%   two single trials of spike train data.  There's a nice software package
%   for doing this, which you can download from here,
%
%   http://www.chronux.org
%
%   Once you've installed this software, it's easy to compute the coherence
%   between two spike trains.  Here's an example,

%   Set the simulation parameters, and notice only a single trial.
N = 1000; dt = 0.001; T=N*dt;

%   Random spiking data.
lambda = 0.1;
dn1 = poissrnd(lambda,1,N);
dn2 = poissrnd(lambda,1,N);

%   Set up parameters for Chronux.
params.Fs = 1/dt;       %Set the sampling frequency.
params.tapers = [3 5];  %Set TW and # tapers.

%   Compute the coherence.
[C,phi,S12,S1,S2,f]=coherencypb(dn1',dn2',params);

%   Plot the results.
plot(f,C)
xlabel('Freq [Hz]');  ylabel('Coherence')
ylim([0 1])

%%  CHALLENGES.

%Q (Challnege #1):  Analyze your own data set of spiking neurons, or of
%spiking neurons and fields, using the tools developed in this lab.

%Q (Challenge #2):  In Part 5 we considered spike-field coherence between
%a sinusoidal field and random spike train, and found little spike-field
%coherence, as expected.  In this Challenge, please generate a simulated data
%set with strong spike-field coherence.  You might start with the rhythmic field
%('s') in Part 5, and adjust the spiking to occur at a particular phase of
%the field.  Compute the spike-field coherence, and show that it is near 1
%at some frequency.

%Q (Challnege #3):  Consider the data set 'case_study_1.mat' on the course
%website for this week's lab.  The data consists of three components,
%
%    s = An LFP field.
%    n1 = A spike train from Neuron #1.
%    n2 = A spike train from Neuron #2.
%
%Each component is 100 trials by 1000 indices, and the sampling interval
%between indices (i.e., dt) is 1 ms.  Analyze these data using the tools
%developed in this lab.  Specifically, consider i) The field power
%spectrum, ii) The spike power spectra, iii) The spike-spike coherence, and
%iv) The spike-field coherence.  Does the field have a dominant rhythm?  Do
%the spike trains have a dominant rhythm?  Are the spike trains coherent? Is each
%spike train coherent with the field?

%Q (Challnege #4):  Consider the data set 'case_study_2.mat' on the course
%website for this week's lab.  The data consists of three components,
%
%    s = An LFP field.
%    n1 = A spike train from Neuron #1.
%    n2 = A spike train from Neuron #2.
%
%Each component is 100 trials by 1000 indices, and the sampling interval
%between indices (i.e., dt) is 1ms.  Analyze these data using the tools
%developed in this lab.  Specifically, consider i) The field power
%spectrum, ii) The spike power spectra, iii) The spike-spike coherence, and
%iv) The spike-field coherence.  Does the field have a dominant rhythm?  Do
%the spike trains have a dominant rhythm?  Are the spike trains coherent? Is each
%spike train coherent with the field?

%Q (Challenge #5):  Construct a *single* trial of simulated spike train
%data with strong coherence over a narrow frequency range.  Use the
%multi-taper method to compute the single trial coherence, and confirm your
%simulation behaves as expected.

%Q (Challenge #6):  The multi-taper method also works for single trials of
%*field* data (e.g., for single trials of EEG or LFP traces).  To explore
%this, generate two fields of artificial data.  For example, you might
%consider two fields of noise data (e.g., 'randn') with a single trial
%of each.  Use the multi-taper method to compute the coherence between the
%two fields.  What do you find?  Generate simulated (single-trial) data
%in which you expect both weak coherence (e.g., consider noise data) and
%strong coherence.