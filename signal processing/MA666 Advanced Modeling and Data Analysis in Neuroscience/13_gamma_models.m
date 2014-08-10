%%  MA666 - Lab 13:  Models of gamma --- ING, PING, and sparse PING. 
%   In this tutorial we will use the Hodgkin-Huxley equations to develop a
%   simple (yet biophysical) model of gamma (~40 Hz) activity.  We'll
%   consider three types of models: ING, PING, and sparse PING.

%%  Preliminaries.
%   Text preceded by a '%' indicates a 'comment'.  This text should appear
%   green on the screen.  I will use comments to explain what we're doing 
%   and to ask you questions.  Also, comments are useful in your own code
%   to note what you've done (so it makes sense when you return to the code
%   in the future).  It's a good habit to *always* comment your code.  I'll
%   try to set a good example, but won't always . . . 

%%  NOTES - Challenge Problems.
%   You'll find five challange problems below.  Your task --- answer
%   at least two of them.  Present your results to me in whatever format you think is
%   appropriate.  Your solutions should include figures (with axes labeled
%   and captions) and explanatory text.  Also, please include any
%   MATLAB code you write;  remember to include comments in the
%   code.  The comments should be detailed enough that you could share your
%   code with any of your classmates / colleagues.  Watch out for *Extreme*
%   Challenge problems --- they're tricky.
%
%   ********
%   Please email your assignment to me as a PDF by Tuesday, Dec 11 at midnight.
%   ********

%%  Part 0:  Simplest (?) model of gamma.
%   In class we discussed experimental observations of gamma, and listed
%   some critical criteria that support / destroy this rhythm.  As a naive
%   first approach to modeling the gamma rhythm, let's consider a single
%   Hodgkin-Huxley (HH) model neuron.  From the course webpage download:
%
%   HH0.m
%
%   In class, we'll examine this code and make sure we understand it.
%
%   It's (relatively) easy to simulate this model.  Let's do so, and plot
%   the results.

I0 = 6.3;    %Input drive to model.
T0 = 200;    %Total time of simulation (in ms).

[V,m,h,n,t] = HH0(I0,T0);
subplot(2,1,1)
plot(t,V);  xlabel('Time [ms]');  ylabel('Voltage [mV]')

%   Visual inspection of the time series suggests (roughly) gamma frequency
%   activity.  We can further characterize the rhythms in this activity by
%   computing the power spectrum.

dt = t(2)-t(1);  %The sampling period in ms.
subplot(2,1,2)
periodogram(V-mean(V), [], [], 1/(dt/1000))
xlim([0.01 1])

%   We observe a large peak near 50 Hz + lots of other peaks at multples of
%   ~50 Hz.  These extra peaks at higher frequency are called "harmonics".
%   They're here because the spiking activity is "sharp" --- the voltage
%   trace is *not* a sinusoid.  And to fit these sharp data with sinusoids
%   requires higher frequency sinusoids.  Anyway, the only peak important
%   to us is the first one (the one at lowest frequency).
%
%   So, consider the following claim:
%
%   CLAIM:  The model above generates spiking activity at gamma frequency.
%   Therefore, the model above is a good model of gamma.
%
%   What do you think?

%%  Part 1:  Simualte the gamma rhythm - ING.
%   We discussed in lecture three simple models of the gamma (~40 Hz) rhythm.
%   We'll start by considering a model that only involves a single cell:
%   ING. To generate the gamma rhythm, we'll connect a Hodgkin-Huxley neuron to
%   itself with an inhibitory synapse (i.e., an autapse).  We examined
%   this model in class.  First, download this single-cell model
%   from the course webpage,
%
%   ing.m
%
%   In class, we'll work through this code and make sure we understand it.
%
%   Now, let's simulate the model and see what happens.  We'll begin with
%   the inhibitory synapse turned off:

I0 = 30;    %Set the input drive to excite the cell.
gI = 0;     %Turn off inhibitory synapse, to start.
tauI = 10;  %Set decay time of inhibitory synapse to 10ms.
T0 = 100;   %Simulate for 100 ms.

[V,s,t] = ing(I0,gI,tauI,T0);
plot(t,V);  xlabel('Time [ms]');  ylabel('Voltage [mV]')

%   We find that, for these parameters, the single cell spikes rapidly.
%   Now, let's turn on the inhibitory synapse.

gI = 20;
[V,s,t] = ing(I0,gI,tauI,T0);
plot(t,V);  xlabel('Time [ms]');  ylabel('Voltage [mV]')

%   With the inhibitory synapse on, we find that the spike frequency
%   decreases.  To see how the synaptic dynamics evolve, plot,

plotyy(t,V,t,s)
xlabel('Time [ms]')

%   We see that, when the cell spikes, the synaptic gate opens.  This
%   hyperpolarizes the neuron.  As the gate slowly closes, this
%   hyperpolarization wears off.  Eventually, the synaptic gate becomes
%   closed enough that the input drive to the cell induces another spike.

%Q (In Lab Challenge):  This model captures 3 experimental observations we
%discussed in class.  To generate gamma, 1) The cell needs sufficient
%excitatory drive, 2) The GABA synapse is critical, and 3) Altering the decay
%time of the inhibitory synapse changes the gamma frequency.  Show that all
%three observations are captured in this model.

%%  Part 2:  Simulate the sparse PING rhythm.
%   We also discussed in lecture (and will continue discussing today) a
%   more complicated model of gamma - sparse PING.  This model consists of
%   populations of neurons, and lots of differential equations.  We can
%   write efficient MATLAB code for this model, as we'll see here.
%   Download the following code from the course website:
%
%   sparse_gamma.m
%
%   We'll examine this code in lab, and see that this model is complicated!
%   Let's study the dynamics piece by piece, and see whether we can induce
%   it to produce gamma activity.

%% Step 1:  Disconnect synapses, and drive the P-cells to spike.

I0p = 10;   %Set the input drive to excite the P-cells.
gP = 0;     %Turn off excitatory synapses.
gI = 0;     %Turn off inhibitory synapses.
tauI = 10;  %Set decay time of inhibitory synapse to 10ms.
eps = 4;    %Set the noise level.
T0 = 200;   %Simulate for 100 ms.

[VP,sP,VI,sI,t] = sparse_ping(I0p,gP,gI,tauI,eps,T0);

subplot(2,1,1)
plot(t,VP);  ylim([-120 50]);  xlabel('Time [ms]');  ylabel('P-cell [mV]')
subplot(2,1,2)
plot(t,VI);  ylim([-120 50]);  xlabel('Time [ms]');  ylabel('I-cell [mV]')

%   We'll see that, with the parameters above, we can induce the population
%   of P-cells to spike rapidly, in an uncorrdinated way.

%% Step 2:  Connect the P-cell synapses to the I-cells.
%   We need to choose a value for gP.  How do we pick a value?  We know we
%   need the synapse to be large enough to induce the I-cells to spike.
%   Let's try a range of values, starting small, and working our way up to
%   larger values,

gP=0.2;

%   After choosing a value, simulate the dynamics and see what we observe.

[VP,sP,VI,sI,t] = sparse_ping(I0p,gP,gI,tauI,eps,T0);

subplot(2,1,1)
plot(t,VP);  xlabel('Time [ms]');  ylabel('P-cell [mV]')
subplot(2,1,2)
plot(t,VI);  xlabel('Time [ms]');  ylabel('I-cell [mV]')

%   Are the I-cells now active?

%% Step 3:  Connect the I-cell synapses to the P-cells.
%   There's one more paramter to set - gI, the strength of the inhibitory
%   synapses on the P-cells.  We'll follow the same strategy as above -
%   choose a value for gI and see what happens.  Let's start with small
%   values and work our way up to larger values,

gI=0.25;
[VP,sP,VI,sI,t] = sparse_ping(I0p,gP,gI,tauI,eps,T0);

subplot(2,1,1)
plot(t,VP);  xlabel('Time [ms]');  ylabel('P-cell [mV]')
subplot(2,1,2)
plot(t,VI);  xlabel('Time [ms]');  ylabel('I-cell [mV]')

%   The above step completes the sparse gamma model.  Our initial
%   inspections of the dynamics appear consistent with our expectations.
%   To further explore the dynamics, let's consider some additional plots.

%% Step 4:  Visualize the synaptic activity.
%   A critical aspect of the gamma dynamics is the synaptic interactions
%   between the two cell populations.  To examine these interactions, let's
%   plot the voltages and the synaptic currents together on one figure.

subplot(2,1,1)
[AX,H1,H2] = plotyy(t,VP,t,sI);  xlabel('Time [ms]');
set(H1,'Color','g');  set(H2, 'Color', 'r')

subplot(2,1,2)
[AX,H1,H2] = plotyy(t,VI,t,sP);  xlabel('Time [ms]');
set(H1,'Color','r');  set(H2, 'Color', 'g')

%   Note that here we plot the P-cell voltages and the I-cell synapses, and
%   vice-versa.  What do you observe?

%% Step 5:  Visualize the spiking activity.
%   Also convenient is a way to visualize the spiking / voltage activity of
%   all the cells.  Here's a simple (and crude) way to do so,

figure(10)
subplot(2,1,1)
imagesc(t, (1:40), VP', [-100, 20]);
axis xy; xlabel('Time [ms]');  ylabel('P-cell #');  colorbar
subplot(2,1,2)
imagesc(t, (1:10), VI', [-100, 20]);
axis xy; xlabel('Time [ms]');  ylabel('I-cell #');  colorbar

%%  CHALLENGES

%Q (Challnege #1):  Verify that the sparse PING model is consistent with
%all experimental observations we discussed in class.  To do so, you'll
%need to run computational 'experiments' consistent with the
%pharamcological experiments performed in vitro.  Consider the following,
%i) Blocking GABA destroys the gamma rhythm, ii) Blocking AMPA destroys the
%gamma rhythm, iii) Reducing excitation to the pyramidal cells destroys the
%gamma rhtyhm, iv) Increasing the decay time of the inhibitory synapses
%slows the gamma rhythm.

%Q (Challenge #2):  Download the model of PING (Pyramidal Interneuron
%Network Gamma), from the course website,
%
%   ping.m
%
%You'll see that the model consists of two cells (a pyramidal cell and
%an inhibitory cell), and two synapses (one from P-to-I, and the
%other from I-to-P).  Set the following parameter values for the model,
%
%  I0p=20
%  gP=0.2
%  gI=0.5
%  tauI=10
%  T0=100
%
%Show that this model conforms with all experimental observations of gamma
%appropriate for this type of model.  Specifically, show that,
%i) Blocking GABA destroys the gamma rhythm, ii) Blocking AMPA destroys the
%gamma rhythm, iii) Reducing excitation to the pyramidal cell destroys the
%gamma rhtyhm, iv) Increasing the decay time of the inhibitory synapse
%slows the gamma rhythm.

%Q (Hard Challenge #3):  Add a slow, biophysical current to the ING model and
%describe how the dynamics are affected.  HINT - Try these two currents:
%  1) A muscarinic receptor-suppressed potassium current (M-current)
%  2) A hyperpolarization-activated "anomalous rectifier" current (h-current)
%See Traub et al, J Neurophysiol, 2003 for the equations.

%Q (Hard Challenge #4):  Develop a sparse gamma model with integrate-and-fire
%neurons or another simple model of spiking, like the Izhikevich neuron:
%
%   http://www.izhikevich.org/publications/spikes.htm
%
%You'll need to find a simple way to model the synapses and
%include noise.  Confirm that your model is consistent with all
%experimental observations we've discussed.

%Q (Challenge #5):  Make up your own challenge problem.  Make it really interesting.
