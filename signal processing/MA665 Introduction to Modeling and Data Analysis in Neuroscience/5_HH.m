%%  MA665 - Lab 5:  The Hodgkin-Huxley equations and their simplification.
%   In this lab we will use MATLAB to simulate the Hodgkin-Huxley
%   neuron model.  This model is arguably the *most* important
%   computational model in neuroscience today.  We'll focus (in the first
%   half of this lab) on simulating this model and understanding its pieces.
%   The second half of the lab is *optional*, and will develop more detail
%   about techniques to simplify this complicated model.

%%  Preliminaries.
%   Text preceded by a '%' indicates a 'comment'.  This text should appear
%   green on the screen.  I will use comments to explain what we're doing 
%   and to ask you questions.  Also, comments are useful in your own code
%   to note what you've done (so it makes sense when you return to the code
%   in the future).  It's a good habit to *always* comment your code.  I'll
%   try to set a good example, but won't always . . . 

%%  NOTES - Challenge Problems.
%   You'll find *8* challange problems below.  You *must* answer the four
%   "Important Challenges", which require a detailed description of the
%   Hodgkin-Huxley model dynamics during an action potential, and plots of
%   the steady state functions and time constants for each gating variable.
%
%   The second half of the lab includes *optional* challenge problems.  These
%   optional challenges suggest techniques to simplify the complicated
%   Hodgkin-Huxley model.
%
%   As always, present your results to me in whatever format you think is
%   appropriate.  Your solutions should include figures (with axes labeled
%   and captions) and explanatory text.  Also, please include any
%   MATLAB code you write;  remember to include comments in the
%   code.  The comments should be detailed enough that you could share your
%   code with any of your classmates / colleagues.  Watch out for *Extreme*
%   Challenge problems --- they're tricky.  If you email me your solutions
%   please send as one merged PDF.

%%  Part 1:  The Hodgkin-Huxley (HH) equation code.
%   Download the MATLAB file (available on the course website),
%
%   HH0.m
%
%Q:  Examine this code.  Can you make sense of it?  Can you identify the
%gating variables?  The rate functions?  The equations that define the dynamics?
%We'll try to do all of this in lab.

%   Whenever examining code, it's useful to consider the *inputs* to the
%   code, and the *outputs* produced by the code.  There are two INPUTS to
%   HH0:
%
%    I0 = the current we inject to the neuron.
%    T0 = the total time of the simulation in [ms].
%
%   And there are five OUTPUTS:
%
%    V = the voltage of neuron.
%    m = activation variable for Na-current.
%    h = inactivation variable for Na-current.
%    n = activation variable for K-current.
%    t = the time axis of the simulation (useful for plotting).
%
%   As an example, let's simulate the HH model with input current 1 and,
%   100 ms of total time.  To do so, execute,

I0 = 1;
T = 100;
[V,m,h,n,t] = HH0(I0, T);

%   Notice that the right hand side of the last equation has two "input"
%   variables, while the left hand side has five variables
%   (within the square brackets) to label the five model outputs.
%   To visualize the results, plot the voltage versus time,

plot(t,V)
xlabel('Time [ms]')
ylabel('Voltage [mV]')
ylim([-100 40])

%Q:  Fix T0=100 and simulate the HH neuron for different values of I0.
%What happens to the voltage dynamics as V increases?  

%%  Important Challenge #1.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Please complete this one!
%
%Q (*Important Challenge*):  Fix T0=100 and I0=7, simualte the model, and plot
%the results.  You'll observe the neuron generates action potentials (or
%"spikes").  Focus on one of these spikes, and plot each of the variables
%(V,m,h,n) versus time.  Use these plots to describe in detail how each
%gating variable evolves during a single spike.  Use these results to
%describe how Na+ and K+ ions flow in / out of the neuron during a spike,
%and drive the dramatic voltage change (i.e., the spike) you observe.
%This is the *most* important model in computational neuroscience.
%Understand it deeply, and you'll have an intricate sense for the
%biophysical mechanisms of action potential generation.

%%  Important Challenge #2.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Please complete this one!
%
%Q (*Important Challenge*):  We discussed in class that the Na-activation
%variable is much faster than the other gating variables, and we sketched
%the time constants for the three gating variables.  In this challenge,
%you'll plot these time constants.
%
%Use the AUXILIARY FUNCTIONS in the code HH0.m to plot the time constants
%of each gating variable versus the voltage.  To do so, remember the expression
%we wrote in class:
%
%    tauX[V] = 1/(aX[V] + bX[V])
%
%Where "X" is "M", "H", or "N".  Plot "tauX[V]" versus "V" for each gating
%variable and describe your results.  Show that the Na-activation
%variable is the *fastest*.
%
%HELPFUL REMINDER:  To divide two vectors, use "./" not "/"

%%  Important Challenge #3.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Please complete this one!
%
%Q (*Important Challenge*):  We also discussed in class (and sketeched)
%the steady state functions for the three gating variables.  In this challenge,
%you'll plot these steady state functions.

%Use the auxiliary functions in the code HH0.m to plot the steady state
%functions of each gating variable versus the voltage.  To do
%so, use the expression we wrote in class:
%
%    Xinf[V] = aX[V] / (aX[V] + bX[V])
%
%Where "X" is "M", "H", or "N".  Plot "Xinf[V]" versus "V" for each gating
%variable and describe your results.
%
%HELPFUL REMINDER:  To divide two vectors, use "./" not "/"

%%  Important Challenge #4.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Please complete this challenge too!
%
%Q (*Important Challenge*):
%
%1) Find the continuous spiking threshold for the model neuron.  In other
%words, how much current must we inject to generate a *repeating* spike
%pattern (not just a solitary spike).  How sensitive is this
%threshold to changes in the injected current?
%
%2)  Plot the firing rate of the neuron versus the input current I0 (like
%you did for the simpler models in Lab 4).

%Hint:  Compute the number of spikes per second for different values I0,
%and plot these results.  This is a bit tricky --- You'll need to develop a
%technique to detect spikes for this model . . . you might read about
%"findpeaks" in MATLAB Help.

%%  Part 2:  Simplification.
%   NOTE:  The rest of the lab is *OPTIONAL*.  Complete it if you have time
%   and you're interested.  The goal will be to simplify the Hodgkin-Huxley
%   model, and capture its "essence".

%   The Hodgkin-Huxley (HH) model is complicated!  Mathematically, it's a
%   system of four, coupled, ordinary differential equations.  That - in
%   itself - is already complicated.  A further complication of the HH
%   model:  it's *not* easly to visualize the model dynamics.
%
%   Ideally, we'd like to examine how all four variables evolve in time.
%   In other words, we'd like to plot simultaneously (V,m,h,n) versus time,
%   and watch this curve evolve.  But, there's a problem here:  to do so
%   requires a plot in 4-dimensional space!  More explicitly, to plot the
%   model output we'll need a "dimension" (or an axis) for the voltage >V<, an axis
%   for the Na-activation >m<, an axis for the Na-inactivation >h<, and an axis
%   for the K-activation >n<.  That's 4-axes.  We're used to plotting
%   things using 2-axes (e.g., x-y) or maybe 3-axes (e.g., x-y-z).  But
%   4-axes . . . (= x-y-z-?)
%
%   So, to improve our visualization (and understanding) of the dynamics,
%   we'll attempt a simplification of the model.  We won't make this
%   simplification in an arbitrary, willy-nilly way.  Instead, we'll
%   attempt to simplify the model in a principled way, based on our
%   understanding of the biology and the full model.  You'll see that this
%   simplification helps us understand the mathematical *essence*
%   of the dynamics that generate a spike.

%   Let's start with a BIOLOGICAL FACT:
%
%   FACT:  The Na-activation variable is much faster than the other gating
%   variables.  
%
%   We'll discuss this briefly in lab, and you proved it to yourself in
%   Challenge #2.  This biological fact motivates our first simplification:
%
%   SIMPLIFICATION #1 = Treat the variable m[t] as an "instantaneous varible".
%
%   In practive this means we'll disregard the differential equation dm/dt,
%   and replace >>m<< with its steady state value.  By doing so, we assume
%   that >>m<< approaches its steady state value really fast (namely,
%   instantaneously).

%%  Challenge Problem #5.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q (Challenge):  Copy the file 'HH0.m' to a new file 'HH1.m' and perform
%the simplification #1.  You'll need to do two main things:
%
%  1)  In the line of code that updates the voltage [i.e.,
%   in the line of code beginning 'V(i+1) = V(i) + dt*(...'], replace:
%                     m(i) ---> minf[V]
%   where minf[V] is the steady state value for the Na-activation current.
%   Remember you can write minf[V] as a function of the auxillary functions
%   aM[V] and bM[V] in the code.
%
%  2)  Eliminate the line of code that updates 'm' in the model.
%
%Your new model should consist of three, coupled, ordinary
%differential equations.  Simulate this model for T0=100, I0=7 and plot the
%results for the remaining variables (V, h, and n).  How well do these
%results (from your simplified model) match the results of the complete
%model you simualted in the "Important Challenge #1"?  [Make sure to hand in
%your code 'HH1.m']

%%  Part 3:  More simplification.

%   Simplication #1 is known as the 'quasi-steady state approximation'.  It
%   simplifies our model by reducing the number of differential equations we
%   need to study by one;  we've eliminated the 'm' dynamics and our model
%   now evolves in 3-dimensional space (V,h,n).
%
%   To simplify the model a bit more, consider this BIOLOGICAL FACT:
%
%   FACT:  The Na-inactivation and K-activation are surprisingly related.
%
%   To see this, look back at your class notes or Challenge #2 and #3 for plots of the
%   time constants and steady state functions for these variables.  You'll find
%   that the time constants are *roughly* similar.  Also, you might have
%   noticed the following relationship between the steady state functions:
%
%   (Steady state of n) ~ 1 - (steady state of h)
%
%   Where '~' means 'approximately equal to';  See Challenge #3 to confirm
%   this observation.
%
%   This surprising relationship motivates the second simplification:
%
%   SIMPLIFICATION #2 = Relace 'n' and 'h' with a single, new variable 'w'.
%   Specifically, replace:
%                            n ---> w
%                            h ---> (1-w)

%%  Challenge Problem #6.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q (Challenge):  Define a new model that utilizes simplifications #1 and #2.
%To do so, it's helpful to first complete Challenge Problem #5.  If you've
%done so, copy the file 'HH1.m' to a new file 'HH2.m' and perform
%simplification #2 as follows:
%
%   1)  In the line of code that updates the voltage [i.e.,
%   in the line of code beginning 'V(i+1) = V(i) + dt*(...'], replace:
%                     n(i) ---> w(i)
%                     h(i) ---> 1-w(i)
%
%   2) Eliminate the line of code that updates 'h' in the model.
%	3) In the line of code that updates 'n', replace 'n' with 'w'.  This
%	differential equation will serve to update the new variable.
%   4) Eliminate all remaining occurences of 'h' in the model.
%   5) Replace all remaining occurences of 'n' with 'w' in the model.
%
%After making these changes, simulate this model for T0=100, I0=7.  Plot
%the dynamics of the two model variabels (V,w) versus time.  Describe
%how the voltage dynamics match (or mismatch) the results of the complete
%HH model you simualted above.  Do you think this simple model is a good
%approximation of the full HH model?

%%  Challenge Problem #7.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   After simplification #2, the model is much simpler.  It now consists of
%   only two coupled differential equations:  one for the voltage, and the
%   other for the new gating variable 'w'.  With the model now living in
%   two dimensional space, we can easily visualize the dynamics --- namely,
%   we can plot these dynamics on a two-dimensional surface, i.e., on a
%   sheet of paper.  More explicitly, we can plot the voltage 'V' versus the gating
%   variable 'w' (instead of plotting either variable versus time, as we had done in
%   the previous examples).
%
%Q (Challenge):  Construct a series of these two dimensional plots for
%0 < I0 < 2.  Follow the curve as it moves through the two
%dimensional space (V,w) and explain what's happening at each point. Explain
%the transitions you observe as you increase I0.

%%  **Extreme** Challenge #8.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This one is difficult!!
%Q (Challenge):  Describe the mathematical mechanisms that govern the
%transition from rest to spiking in the simplified 2-dimensional model
%"HH2.m".  NOTE:  These types of issues will be covered in MA666.