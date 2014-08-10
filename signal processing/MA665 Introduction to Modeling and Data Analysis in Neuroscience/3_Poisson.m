%%  MA665 - Lab 3:  Poisson models
%   In this tutorial we will construct Poisson models of spiking.  We
%   will also analyze the data from the previous tutorial and determine if
%   it is, in fact, Poisson.

%%  Preliminaries.
%   Text preceded by a '%' indicates a 'comment'.  This text should appear
%   green on the screen.  I will use comments to explain what we're doing 
%   and to ask you questions.  Also, comments are useful in your own code
%   to note what you've done (so it makes sense when you return to the code
%   in the future).  It's a good habit to *always* comment your code.  I'll
%   try to set a good example, but won't always . . . 

%%  NOTES - Challenge Problems.
%   You'll find *seven* challange problems.  Your task --- answer
%   at least three of them.  Present your results to me in whatever format you think is
%   appropriate.  Your solutions should include figures (with axes labeled
%   and captions) and explanatory text.  Also, please include any
%   MATLAB code you write;  remember to include comments in the
%   code.  The comments should be detailed enough that you could share your
%   code with any of your classmates / colleagues.  Watch out for *Extreme*
%   Challenge problems --- they're tricky.  If you email me your solutions
%   please send as PDF.

%%  Part 1:  Is the data Poisson?
%   To start, we'll return to a data example from last week's tutorial.
%   Download the data from Lab 2 at:
%
%   http://makramer.info/MA665
%
%   And start by loading the first data set,

load('d1.mat')

%   As before, you should now see the variable 'd' in the workspace.  Each
%   row corresponds to a trial (1000 in total) and each column corresponds
%   to a moment in time (500 in total).  The sampling rate is 1000 Hz.  So,
%   we collect 1000 trials from our spiking neuron, each lasting 500 ms.
%   Remember?

%   In class, we determined a method to check if a data set exhibits
%   Poisson properties:  compute the Fano factor.  To do so, we must
%   compute the mean and variance in the number of spikes per trial.  First,
%   let's calculate the number of spikes per trial.  We performed this same
%   calculation in Lab 2,

n_spikes_per_trial = sum(d,2);

%Q:  Compute the variance in the number of spikes per trial.
%HINT:  You'll need to implement a MATLAB command to compute the "variance".
%Try looking in MATLAB Help . . .

%   The formula for the Fano factor is:
%
%   FANO =  [variance in the # of spikes per trial] / [average # spikes per trial]
%
%   Hmm . . . 

%Q (In lab):  What is the Fano factor for "d1"?  Compare with your
%classmates.

%Q (In lab):  Based on your calculation, do you think the data is Poisson?

%%  Part 2:  Generating Poisson distributions.
%   We've talked about Poisson distributions, but we haven't seen any.
%   What do Poisson distributions actually look like?  To answer this, let's
%   generate Poission distributions in MATLAB and plot them.

%   In MATLAB, it's easy to generate samples from a Poisson distribution.
%   To do so, we must first specify a single parameter --- lambda.  Let's start
%   with the choice,

lambda=10;

%   By making this choice, we fix the average number of spikes per trial to
%   10. Now, let's generate a single random number from a Poisson
%   distribution with lambda=10,

poissrnd(lambda)

%Q (in lab):  Execute the above command a few times.  What type of values do you get?

%   It's sometimes useful to generate a vector of Poisson random numbers.  Here's
%   how to generate 10,000 Poisson random numbers with parameter lambda,

myRands = poissrnd(lambda, [10000,1]);

%Q (in lab):  Convince yourself that the list of numbers in "myRands" is, in fact,
%Poisson distributed.  Do this in any way you think appropriate, but do
%some calculations . . . no circular arguments!  HINT:  Think "Fano" ...

%   Now, let's visually examine the *distribution* of these Poisson random
%   numbers.  To do so, we can plot a histogram of these numbers.

hist(myRands, (0:1:30))
xlabel('Random Number Value');
ylabel('Counts')

%   We can scale the vertical axis of this plot to display instead the
%   *proportion* of numbers within each interval.  To do so, let's call,

[h b] = hist(myRands, (0:1:30));

%   Notice that, in this case, we call the "hist" function with two
%   outputs.  These outputs hold:  the histogram counts (h) and the bins
%   (b).  Let's now plot the histogram counts scaled by the total number of
%   Poission numbers,

bar(b,h/10000)
xlabel('Random Number Value');
ylabel('Proportion')

%%%%  ASIDE %%%%
%
%   We can compare the histogram computed from the list of random
%   numbers to the acutal probability density function for a Poisson
%   distribution.  To do so,

hold on
plot(b,poisspdf(b,lambda), 'r')
hold off

%   See MATLAB Help if you're interested in the function "poisspdf".

%%  Part 3:  Is the data *not* Poission?
%   To justify that neural data is Poission, we examine the Fano factor.  If
%   it's *near* one, then we claim that the data is Poission.  But
%   how "near one" is near enough?  Does a Fano factor of 1.10 indicate
%   that the data is Poisson or not?
%
%   To answer this, we'll first hypothesize that the neural data *is* Poission.
%   We'll then compare the Fano factor we compute from the data (the "statistic") to the
%   distribution of Fano factors we expect for a true Poission process.  If we
%   find that our statistic lies outside the 95% confidence intervals of
%   this distribution, then we'll reject our hypothesis that the data is
%   Poission.  Note:  this is a standard argument in statistics --- assume
%   something is true, then reject this assumption.
%
%   The first step is to determine the distribution of the Fano factor for
%   true Poisson data.  It turns out that this distribution is a "gamma"
%   distribution with the following form,
%
%   FANO ~ gamma((N-1)/2, 2/(N-1))
%
%   where "N" is the number of trials (in our case).  Let's look at this
%   gamma probability density and try to get an intuitive sense for its
%   shape.  To do so, execute the following code,

N = 1000;                               %The number of trials, in our case.
FANO = (0:0.001:2);                     %Define a range of FANO values we might observe.
y = gampdf(FANO, (N-1)/2, 2/(N-1));     %Compute the gamma distribution [See MATLAB Help if you're interested] ...
y = y/N;                                %Scale the gamma distribution by the total number of trials.
plot(FANO,y);                           %  and plot it
xlabel('Fano Factor')
ylabel('Proportion')
title('Distribution of Fano factors expected for Poisson data')

%   The most probable value for the Fano factor is 1, but we would *not* be
%   surprised to observe a Fano factor of 1.05 or 0.95 if the data are
%   Poisson.  On the other hand, we would be *very* surprised to observe a
%   Fano factor of 1.5 or 0.5;  the probability of those values occuring
%   is very low if the data are indeed Poisson.

%   Let's now define the 95% confidence interval for the Fano factor,

upper = gaminv(0.975, (N-1)/2, 2/(N-1));
lower = gaminv(0.025, (N-1)/2, 2/(N-1));

%   The first line determines the value of the FANO factor at which 97.5% of
%   the area under the PDF is to the left.  The second line determines the
%   value of the FANO factor at which only 2.5% of the area under the PDF
%   is to the left.

%   We expect true Poission data to generate Fano factors between [lower, upper]
%   95% of the time.  Let's plot these limits on the gamma distribution,

hold on
plot([lower lower], [0 max(y)], 'r');
plot([upper upper], [0 max(y)], 'r');
hold off

%   The two (vertical) red lines on the plot indicate the 95% confidence
%   interval for the Fano factor.  In other words, when we observe 1000
%   trials, we expect to observe a Fano factor between the red lines 95% of
%   the time if the data are Poisson.  If we observe a Fano factor outside
%   of this interval, we reject the hypothesis that the data are Poission.

%Q (in lab):  Use these results to test the hypothesis that "d1" is Poisson
%data.  Discuss your results in lab.

%%  Part 4a:  Generating Poisson distributions from binomial distributions.
%   In class, we discussed the binomial distribution, which was useful for
%   examining the outcome of coin flips.  We can compute binomial random
%   numbers (just as we computed Poisson random numbers) using built-in
%   MATLAB commands.  Let's compute a single binomial random number,

m=1;
p=0.5;
binornd(m,p)

%   In the call to function "binornd" we specify two parameters,
%
%   m = total number of coin flips.
%   p = probability of success (i.e., heads) of each coin flip, 0 <= p <= 1.
%
%   The output of the function "binornd" is number of successes.  This number is
%   always less than (or equal to) m.

%Q (in lab):  Keep m=1 fixed, and vary p.  What values does "binornd" return when p
%is near 0 (i.e., when the chance of success is small)?  When p is near 1
%(i.e., when the chance of success is large)?

%   Now, let's make the probability of success really small (p=0.01).

p=0.01;
binornd(m,p)

% Q (in lab):  Execute the above 3 lines of code multiple times.  How many success do
%you tend to observe?

%   It's irritating to execute three lines of code over and over again.
%   So, instead, let's generate a long list of binomial random numbers.  We
%   do so by adding another argument to the end of the function "binornd",

myRands = binornd(m,p,[500,1]);

%   Here we generate 500 binomial random numbers.  Each random number is
%   drawn from the same binomial distribution with m and p as specified
%   above.  Let's plot "myRands" and see what we've created,

plot(myRands)

%   Notice that it's mostly zeros.  Every so often, we observe a single
%   "successful coin flip" --- let's think of these rare, successful events 
%   as spikes.  In other words, let's imagine that the "1"s in "myRand"
%   correspond to times when a simulated neuron generates a spike, and
%   the "0"s correspond to spike free times.  Our simulated neuron is
%   dominated by spike free times (i.e., it rarely spikes).  You may have
%   expected this;  the probability of success (p) is quite low.

%%  Part 4b:  Simulating spike trains using the binomial distribution.
%   The last result in Part 4a suggests we can simulate spike trains using
%   the binomial distribution.  Let's do this, but now for a number of
%   trials.  First, let's define the number of trials (100), the length of each
%   trial (500ms), and a new matrix "data" to hold the data we create,

ntrials=100;
T = 500;
data = zeros(ntrials, T);

%   We'll consider 100 trials and, for each
%   trial, let's generate 500 binomial random numbers with p=0.01 and
%   m=500.  We'll think of each random number as representing the number
%   of spikes in a 1 ms time interval;  because we collect 500 binomial
%   random numbers, we'll imagine this represents 500 ms of data (per
%   trial).  In each subinterval our simulated neuron spikes (success!) or does not
%   spike.  For each trial, let's compute and save the 500 coin-flips.
%   All of this is done in the next five lines of MATLAB code,

m=1; p=0.01;
for k=1:ntrials
    spikes = zeros(T,1);
    for i=1:T
        spikes(i) = binornd(m,p);
    end
    data(k,:) = spikes;
end

%Q:  Do the previous five lines make sense?  Be able to explain in words
%each line.

%%  Challenge Problem #1.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q (Challenge 1):  Analyze the data sets "d2.mat" and "d3.mat" available
%on the course website from Lab 2.  Are these data sets Poisson?  If not,
%can you identify aspects of the spiking activity that make it non-Poisson?

%%  Challenge Problem #2.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q (Challenge 2):  In Part 2 we generated the variable "myRands" by drawing
%from a Poisson distribution.  Determine how this distribution changes as 
%the parameter "lambda" is varied.  Support your description with plots
%(hint: make histograms!).  Compute the mean, varaiance, and Fano factor of
%"myRands" in each case.

%%  Challenge Problem #3.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q (Challenge 3):  Choose some values of the Fano factor and
%sketch examples of spike trains you would expect to produce these Fano
%factors (these can be hand sketches, like I often make on the blackboard
%in class).  Consider in particular the cases when
%  i) the Fano factor is near 0,
%  ii) the Fano factor is near 1, and
%  iii) the Fano factor is much greater than 1.
%Explain your reasoning for each sketch.

%%  Challenge Problem #4  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Visit Blackboard for this course and download the file
%   "Point_Process_Notes.pdf" from the Course Documents section.  Work
%   through this document by downloading the specified spike train data set
%   and executing the MATLAB code.  Notify me of any typos, suggestions,
%   ideas, etc.  I'm interested to know anything you like or dislike.  What
%   makes sense?  What doesn't make sense?

%%  Challenge Problem #5.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q (Challenge 5):  Generate a data set of your own that consists of periodic
%spiking without variability --- for example, in each trial, make the simulated neuron
%spike every 100 ms.  Repeat the analysis above for your new data set, and
%show that data is (or is not) Poisson.

%%  Challenge Problem #6. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q (Challenge 6):  We generated a new data set "data" in Part 4b consisting of 
%100 trials, each lasting 500 ms.  We've done this using *binomial* random
%numbers (i.e., flipping a biased coin at each moment of time and counting a 
%success as a spike).  Using the tools developed above, analyze these simulated
%spike train data.  Plot the SNH, the ISI histogram, and compute the Fano factor.

%%  Challenge Problem #7. %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q (Challenge 7):  Modify the "for-loop" in Part 4b to compute the ISI for
%each trial.  Examine and report the properties of the ISIs.  What
%distribution do the ISIs appear to follow?

%%  Challenge Problem #8.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Q (Challenge 8):  Analyze your own data set using the techniques above.  Is
%the spiking data Poisson?  Please explain the data details of your data in your
%write up.