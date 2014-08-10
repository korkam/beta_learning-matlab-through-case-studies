%%  MA665 - Lab 4:  The integrate and fire neuron
%   In this tutorial we will use MATLAB to simulate the integrate and fire
%   (I&F) neuron model.  We'll investigate, in particular, how the spiking
%   activity varies as we adjust the input current I.  We will also update
%   the model to include "leakiness".

%%  Preliminaries.
%   Text preceded by a '%' indicates a 'comment'.  This text should appear
%   green on the screen.  I will use comments to explain what we're doing 
%   and to ask you questions.  Also, comments are useful in your own code
%   to note what you've done (so it makes sense when you return to the code
%   in the future).  It's a good habit to *always* comment your code.  I'll
%   try to set a good example, but won't always . . . 

%%  NOTES - Challenge Problems.
%   You'll find *seven* challange problems below.  Your task --- answer at
%   least *four* of them.  Present your results to me in whatever format you think is
%   appropriate.  Your solutions should include figures (with axes labeled
%   and captions) and explanatory text.  Also, please include any
%   MATLAB code you would like to share;  remember to include comments in the
%   code.  The comments should be detailed enough that you could share your
%   code with any of your classmates / colleagues.  Watch out for *Extreme*
%   Challenge problems --- they're tricky.  If you email me your solutions
%   please send as a single PDF that includes figures + code + text.

%%  Part 1:  Numerical solutions - Introduction
%   How do we compute a numerical solution to the integrate and fire model?
%   The basic idea is to rearrange the differential equation to get V(t+1) on
%   the left hand side, and V(t) on the right hand side.  Then, if we know
%   what's happening at time t, we can solve for what's happening at time t+1.
%   We'll discuss this in more detail during the lab . . .
%

%   What we'll find is that:
%
%   V(t+1) = V(t) + dt*(I/C)
%
%   Now, let's program this equation in MATLAB.  First, let's set the values
%   for the parameters I and C.

C=1;
I=1;

%   We also need to set the value for dt.  This defines the time step in the
%   problem.  We must choose it small enough so that we don't miss anything
%   interesting.  We'll choose:

dt=0.01;

%   Let's assume the units of time are seconds.  So, we step forward in
%   time by 0.01s.  The right hand side of our equation is nearly defined,
%   but we're still missing one thing, V(t).

%Q:  What value do we assign to V(t)?
%A:  We don't know --- that's why we're running the simulation in the first
%place!

%   So here's an easier question:  what *initial* value do we assign to
%   V(t)?  Let's choose a value of 0.2, which in our simple model we'll
%   assume represents the rest state.  Then set:

V(1)=0.2;

%Q:  Given the initial state V(1)=0.2, calculate V(2).  Then calcualte V(3).

%   After the two calculations above, we've moved forward two time steps into
%   the future, from t=0s to t=0.01s, and then from t=0.01s to t=0.02s.  But what
%   if we want to know V at t=10s?  Then, this iteration-by-hand procedure becomes
%   much too boring and error-prone.  So, what do we do?  Make the
%   computer do it . . . 

%%  Part 2:  Numerical solutions - implementation
%   Let's computerize this iteration-by-hand procedure to find V(1000).
%   To do so, we'll use a "for-loop".  Here's what it looks like:

for k=1:999
    V(k+1) = V(k) + dt*(I/C);
end

%Q:  Does this loop make sense?  Describe what's happening here.  Use
%MATLAB Help if you don't remember the "for" command.

%Q:  Why do we end the loop at k=999?

%   Execute this for-loop and examine the results in vector V.  To do so,
%   let's plot V:

figure(10)
plot(V)

%Q:  What happens to the voltage after 1000 steps?

%   This plot is informative, but not great.  Really, we'd like to plot the
%   voltage as a function of *time*, not steps or indices.  To do so, we
%   need to define a time axis:

t = (1:length(V))*dt;

%Q:  What's happening in the command above?  Does it make sense?  (If not,
%trying printing t at the command line, or plot(t).)

%   Now, with "time" defined let's redo the plot of the voltage with
%   the axes labeled appropriately.

figure(10)
plot(t,V)
xlabel('Time [s]');  ylabel('V');

%   Finally, let's put it all together . . .

%%  Part 3:  I&F CODE (version 1)
%   In Parts 1 and 2, we constructed parts of the I&F model in bits-and-pieces.
%   Let's now collect all of this code, compute a numerical solution to
%   the I&F model, and plot the results (with appropriate axes).

clear                   %Q:  What is this?  See MATLAB Help.

I=1;                    %Set the parameter I.
C=1;                    %Set the parameter C.
dt=0.01;                %Set the timestep.
V(1)=0.2;               %Set the initial condition.

for k=1:1000-1          %Compute V, step-by-step.
    V(k+1) = V(k) + dt*I/C;
end

t = (1:1000)*dt;        %Define the time axis.

figure(10)              %Plot the results.
clf()                   %Q:  What is this?  See MATLAB Help.
plot(t,V)
xlabel('Time [s]');  ylabel('Voltage [mV]');
ylim([0 10])

%Q:  Adjust the parameter I.  What happens to V(t) if I=0?  Can you set I
%so that V > 0 within 10 s?

%%  Part 4:  Voltage threshold & reset.
%   Notice, our model is missing something important:  the threshold & reset.
%   Without these, the voltage increases forever (if I>0). Now, your task in
%   lab is to update our model to include the reset.  To do so,
%   you'll need to add three things to your code.  First, you'll need to define the
%   voltage threshold "Vth".  Second, you'll need to check whether V exceeds
%   Vth using an "if-statement".  Third, when V reaches the threshold,
%   you'll need to reset V.
%
%Q (In lab Challenge):  Update the code in Part 3 to include the reset in
%our integrate and fire model.

%Q (In lab Challenge):  Save your updated code as a MATLAB *function*:
%
%             "my_IF_model.m"
%
%Make this function so that it takes as inputs parameters I and C, and the
%total length of time to simulate, and returns a plot of V versus t.  You
%might also have your function return other useful quantitites (e.g., the
%total number of spikes generated or the ISI --- the time interval between
%spikes.)

%Q (In lab Challegne):  Having constructed your model, adjust the
%parameter I and simulate the model.  Determine what happens to V(t) if
%I=10?  If I=100?

%%  Challenge Problem #1.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q (Challenge):  Use the I&F code you developed in Part 4 to compute the
%relationship between the injected current (I) and the firing rate.  Plot this
%relationship.  Remember that the firing rate is the number of times your
%model neuron spikes per second.  So, you'll need to devise a way to detect and save 
%"spikes" in your model.  You'll also need to determine the number of spikes
%that occur over some time interval (or something equivalent).  Finally, 
%please show how the rate of firing changes as you adjust parameter I.
%NOTE:  Fix C=1, the voltage threshold Vth=1, the reset voltage to 0.

%%  Challenge Problem #2.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q (Challenge):  Update the model to include a resistance term.  In other
%words, construct the "Leaky I&F model".  (1) Plot some numerical solutions to
%this model for different values of parameter "I".  (2) Determine in this model
%how the firing rate depends on I and plot this relationship.  Compare your 
%results with the firing rate curve found for the I&F model in Challenge
%Problem #1.  NOTE:  Fix C=1, the voltage threshold to 1, the reset
%voltage to 0, and choose a value for the resistance;  maybe try R=0.1.

%%  Challenge Problem #3.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q (Challenge):  Consider the following model of the "Quadratic Integrate
%and Fire" neuron,
%
%  C*dV/dt = V^2 + I
%
%Develop simulation code for this neuron.  Include a reset condition at
%Vth=1.  Then, (1) Plot examples of the output of your model for different
%values of I.  Also, (2) determine the relationship between the injected
%current (I) and the firing rate of your Quadratic I&F neuron and plot this
%relationship.  Compare to what you found for the regular I&F model in
%Challenge Problem #1.  NOTE:  Fix C=1, the voltage threshold to 1, the reset
%voltage to 0.

%%  Challenge Problem #4.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q (Challenge):  Create a nice visualization algorithm for the integrate and
%fire model.  Your algorithm should take as input important model
%parameters (e.g., input current, voltage threshold, ...) and return:  1) a plot
%of the model dynamics with spikes indicated graphically, 2) the *times*
%at which spikes occurred, and 3) the firing rate.  Of course, include any
%other outputs you think are useful.

%%  Advanced Challenge Problem #5.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q (Advanced Challenge):  Add *noise* to your integrate and fire model.  To do so,
%use the following equation for your V-update:
%
%    V(k+1) = V(k) + dt*I/C + noise*sqrt(dt)*randn;
%
%Here 'noise' is a parameter you choose.  To start, set noise=0.1.
%Remember that 'randn' returns a random number drawn from a normal
%distribution with zero mean and variance of 1.  These random numbers are
%scaled by 'sqrt(dt)' and the value chosen for parameter 'noise'.
%
%1)  Update your integrate and fire model to include noise by inserting the
%line above.  2)  Fix parameter I and plot examples of the model dynamics
%for different values of parameter 'noise'.  3)  For I=1 and noise=0.3,
%simulate the model for 1000 trials.  Use these simulated data to plot a
%spike number histogram.  Are the simulated data Poisson?  What is the average
%firing rate of this noise I&F model.

%%  Advanced Challenge Problem #6.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q (Advanced Challenge):  Another "simple" model of neural spiking was recently
%developed by Eugene Izhikevich (see Ch 22 of your textbook).  In this
%Challenge, you'll explore the "Izhikevich model neuron".  Try to implement
%this model neuron using the code provided in your text book (page 257).
%
%After you've coded the model, visit Izhikevich's website:
%
%  http://www.izhikevich.org/publications/spikes.htm
%
%Examine the 8 figures at the bottom of this webpage (URL above).  Use the
%code you've written to reproduce the regular spiking (RS) and chattering (CH)
%neural dynamics.  To do so, you'll need to fix the four parameter values
%{a,b,c,d}.  HINT:  Follow the paramter space guide plots for "RS" and "CH"
%on his website!  Plot your results for V vs t.  Explain how the
%parameter differences in these two models support the two different types
%of activity.

%%  Advanced Challenge Problem #7.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%Q (Challenge):  Make up your own challenge problem.  Make it interesting.
