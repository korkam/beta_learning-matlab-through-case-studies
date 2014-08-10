%%  MA665 - Lab 2:  Spike Train Analysis.
%   In this tutorial we will analyze spike train data collected in an
%   "experiment".  You will load the data in MATLAB, and then analyze the
%   data using the techniques we discussed in lecture.

%%  Preliminaries.
%   Text preceded by a '%' indicates a 'comment'.  This text should appear
%   green on the screen.  I will use comments to explain what we're doing 
%   and to ask you questions.  Also, comments are useful in your own code
%   to note what you've done (so it makes sense when you return to the code
%   in the future).  It's a good habit to *always* comment your code.  I'll
%   try to set a good example, but won't always . . . 

%%  NOTES - Challenge Problems.
%   You'll find *six* challange problems.  Your task --- answer
%   the first *three* of them.  Present your results to me in whatever format you think is
%   appropriate.  Your solutions should include figures (with axes labeled
%   and captions) and explanatory text.  Also, please include any
%   MATLAB code you write;  remember to include comments in the
%   code.  The comments should be detailed enough that you could share your
%   code with any of your classmates / colleagues.  At the end of this Lab
%   are more advanced challenge problems.

%%  Part 1:  Load and visualize the data.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   The spike train data will consist of 1000 trials, each lasting 500 ms with a
%   sampling rate of 1000 Hz.
%
%Q:  Given this, how many samples will you have per trial?

%   Load the data.  To do so, visit the course webpage,
%
%   http://makramer.info/MA665
%
%   and download the file 'd1.mat' in Week 2.  Having done that, load the data,

load('d1.mat')

%   Upon loading d1, your workspace should hold a single variable 'd'.
%
%Q:  What are the dimensions of d?

%   It's useful to define two new variables that record the number of
%   trials, and the length of each trial:

n_trials = 1000;
T = 500;

%   Notice that here we've used the entire length of the data (500 ms) as
%   our counting window.

%   To get a sense for the data, let's plot the results from a single trial.

figure(1)
plot(d(1,:), '-*');
xlabel('Time [ms]');  ylabel('Spikes');

%Q:  What values do the data assume?  What constitutes a spike?

%Q:  Visual inspection of data is a powerful tool.  Describe what you "see"
%in the plot.  In this single trial, does the neuron spike "a lot"
%or "a little"?  Estimate the number of spikes in this trial.

%Q:  The results for one trial can be deceiving.  Visualize the output of
%additional trials.  Do you notice any consistency?

%Q: One way to characterize the data is to count the number of spikes 
%per trial.  For trials 1-5, plot each trial (as above) and count the number
%of spikes.  Save your results and show them to me, or to someone else in
%class, and compare your results.

%%  Part 2:  Quantify the spiking.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Through visual inspection, we've examined the spiking for a handful of
%   trials, and counted the number of spikes per trail.  Let's now attempt
%   to summarize the data for *all* trials.
%
%   We could try to do this by hand (as in the previous exercise). But
%   counting spikes by hand is TEDIOUS.  Imagine repeating this procedure
%   for 1000 trials!  We can more effectively count the number of spikes
%   per trial by issuing a command in MATLAB.  Consider the following,

n_spikes_per_trial = sum(d,2);

%Q:  Does the above command make sense?  Read the MATLAB Help
%section for the command 'sum' to make sure you understand it.  Determine
%why we issue the command:
%    >> sum(d,2)
%and not the command,
%    >> sum(d,1)

%Q:  Compare your results counting the number of spikes in trials
% 1-5 (found through visual inspection above) with the first five
%elements of the variable 'n_spikes_per_trial'.  Do the two match?  Explain.

%   Now, compute the average number (or mean number) of spikes per trial.

n_avg = mean(n_spikes_per_trial);

%Q:  Have you used the command 'mean' before?  If not, look it up in MATLAB
%Help!

%Q:  What is the numerical value for n_avg?  Is this consistent with your
%visual inspection of the data?

%%  Part 3:  Histograms.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   We've learned one quantitative element about the data:  the mean number
%   of spikes per trial.  To learn more about the data, let's compute a histogram 
%   of the number of spikes per trial.  This is the "spike number histogram"
%   (SNH).  Consider the following snippet of code:

figure(10)
hist(n_spikes_per_trial, (0:1:40))
xlabel('n = number of spikes');
ylabel('Number of trials containing n spikes');
title('SNH')
hold on
plot([n_avg, n_avg], [0, max(hist(n_spikes_per_trial, (0:1:30)))], 'r', 'LineWidth', 2)
hold off

%   There's a lot happening in the above series of commands.  First, we
%   compute a histogram of the number of spikes per trial when we issue the
%   command:
%
%   >> hist(n_spikes_per_trial, (0:1:40))
%
%Q:  Remember the 'hist' command?  Check out MATLAB Help!
%Q:  Why do we input two arguments to the 'hist' command?  What is the
%purpose of the second argument?  Vary the second argument in 'hist' and
%re-execute the snippet of code above.  Examine how the histogram plot
%changes.

%   MATLAB creates a plot in Figure 10.  The horizontal axis indicates the number of 
%   spikes observed in a trial --- let's call this 'n'.  The vertical axis indicates the
%   number of trials that contain n spikes.  To make this clear, we label the
%   axes, and we title the plot:
%
%   >>  xlabel('n = number of spikes');
%   >>  ylabel('Number of trials containing n spikes');
%   >>  title('SNH')
%
%   We'd like to include one more item on the plot --- the mean number of
%   spikes per trial.  Let's do this graphically.  First, we'll tell Figure 10
%   to "hold" whatever is currently in the graphics window:
%
%   >>  hold on
%
%   We then plot the item we want:
%
%   >>  plot([n_avg, n_avg], [0, max(hist(n_spikes_per_trial))], 'r', 'LineWidth', 2)
%
%   The x-coordinate in this plot is n_avg, the mean number of spikes per
%   trial.  The y-coordinate can be anything;  here we make it range from 0 to
%   the maximum value recorded on the vertical axis.  The result is a
%   *vertical* line.  To make this line stand out, we color it red, and
%   increase its line width to 2.
%
%Q (*OPTIONAL* Mini-challenge):  Include text on the plot that prints the numerical value of
%the mean number of spikes per trial.
%
%   When we're done adding more items to the figure, we turn hold off.
%
%   >>  hold off

%%  Part 4:  Average firing rate.%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Q:  Use your results above to compute the average firing rate of the data.
%Tell me what you find in lab, or compare with a classmate.
%HINT:  It's one line of code in MATLAB!  See you lecture notes ...

%%  Part 5:  ISI.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   We've spent some time considering the number of spikes per trial, and
%   visualized these results in the SNH.  Let's now investigate the
%   *time intervals* between spikes.  Namely, let's compute the
%    ISIs (InterSpike Intervals).

%   First, we have to convert the observed data "d" to a list of ISIs.
%   Remember, the data "d" indicates the *time* of each spike (in each trial).
%   What we'd like to know now is the time *between* spikes.  To compute the
%   time between spikes, we'll do the following:

ISI = [];
for k=1:n_trials
    spike_times = find(d(k,:) == 1);
    isi0 = diff(spike_times);
    ISI = [ISI, isi0];
end

%Q:  That's a complicated series of commands!  Study it and explain it to a
%classmate or me.  Use MATLAB Help to look up commands you don't yet know.

%Q:  Execute the commands above and examine the vector ISI.  What is it's
%size?  Does it make sense to you?

%   Once we've constructed the vector ISI, we can calculte its mean,

mean_ISI = mean(ISI);

%Q:  Examine the value of the mean ISI.  Does it seem reasonable?  Why (or
%why not)?

%   The vector ISI is a huge list of numbers, indicating the time interval
%   between spikes for all (1000) trials.  To summarize these ISI results,
%   we'll make a histogram.  This is the "ISI histogram".  In Challenge
%   Problem #1 below you're asked to compute and plot the ISI histogram.

%%  Part 6:  PSTH
%   We also discussed in class the poststimulus time histogram, or PSTH.
%   To compute the PSTH, we first need to compute the probability of a
%   spike at any moment in time.  Consider the following code:

prob_spike = sum(d,1)/n_trials;

%Q:  Why does this line of code reveal the probability of spiking at any
%moment in time?

%Q:  Use the above line of code to compute the PSTH, and plot it as a
%function of time.  In the line of code above, what is the size of the tiny
%bin used to divide the time axis?  How does the instantaneous
%frequency evolve over time?

%%  Challenge Problem #1.

%Q (Challenge 1):  Compute and plot the ISI histogram.  Label the
%axes.  Explain what you find.  What is the average ISI?  What is the most
%common ISI?  Are those two numbers the same?  Try to interpret the ISI
%histogram in terms of spike train data --- given the ISI plot, can you
%draw a representative spike train?
%
%HINT:  Modify the code we used above to compute the spike number histogram (SNH).

%%  Challenge Problem #2.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   We've studied a single data set.  Let's now consider a second data set
%   with the following properties:
%
%   Number of trials:  1000
%   Duration of each trial:  500 ms
%   Samping rate:  1000 Hz.
%
%   You can download this data set from the course website:
%
%   http://makramer.info/MA665
%
%   Download the file 'd2.mat'.

%Q (Challenge 2.a):  (1) Load this data set and determine the average number of
%spikes per trial, the average firing rate, and the average ISI.  (2) Compute
%and plot the SNH, ISI histogram, and PSTH and indicate the average value of each
%measure on each plot.  (3) Compare the results for 'd1' and 'd2'.  How are
%they similar?  How do they differ?  (4) Using all of the tools at your
%disposal, conclude that either d1 and d2 display similar activity, or d1
%and d2 display different activity.  (5)  Describe in words how the
%activity in d2 behaves.
%
%NOTE:  Please submit your MATLAB code and plots to support your results.
%Make everything *beautiful*.

%Q (Challenge 2.b):  We've assumed throughout our analysis a sampling
%window of size T=500 ms --- the length of each trial.  Is this the best
%choice for 'd1' and 'd2'?  Why?  Justify your conclusion.

%%  Challenge Problem #3 (Option 1)
%   Consider a third data set with the same properties as above:
%
%   Number of trials:  1000
%   Duration of each trial:  500 ms
%   Samping rate:  1000 Hz.
%
%   Download this data set from the course website:
%
%   http://makramer.info/MA665
%
%   Download the file 'd3.mat'.

%Q (Challenge 3.a):  (1) Load this data set and determine the average number of
%spikes per trial, the average firing rate, and the average ISI.  (2) Compute
%and plot the SNH, ISI histogram, and PSTH and indicate the average value of each
%measure on each plot.  (3) Compare the results for 'd1', 'd2', and 'd3'.  How are
%they similar?  How do they differ?  (4) Describe in words how the activity
%in d3 behaves.
%
%NOTE:  Please submit your MATLAB code and plots to support your results.
%Make everything *beautiful*.

%%  Advanced Challenge #3 (Option 2)  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Visit Blackboard for this course and download the file
%   "Point_Process_Notes.pdf" from the Course Documents section.  Work
%   through this document by downloading the specified spike train data set
%   and executing the MATLAB code.  Notify me of any typos, suggestions,
%   ideas, etc.  I'm interested to know anything you like or dislike.  What
%   makes sense?  What doesn't make sense?

%%  Advanced Challenge #4  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   NOTE:  Advanced challenges are OPTIONAL.  %

%Q (Challenge #4):  Apply these analysis techniques to your own
%data.  Explain your results (and your data).

%%  Advanced Challenge #5  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   NOTE:  Advanced challenges are OPTIONAL.  %

%Q (Challenge #5):  Our visual inspection of the spiking data proceeded in a
%trial-by-trial way.  Namely, we plotted the spiking (evolving in
%time) separately for each trial.  A more effective visualization would
%display the spiking activity for *all* trials over time.  This is sometimes
%called a "rastergram" or "spike raster" plot.  See, for example,
%
%  http://www.scholarpedia.org/article/Image:Chirast1.png
%
%The challenge --- make a rastergram of the spiking data for 'd1', 'd2', and 'd3'.
%Specifically, devise a method to visualize the spiking activity of all trials
%over time.  Ideally, make this a *function* in MATLAB you can use in the
%future for (two-dimensional) data sets of any number of trials / samples /
%sampling frequency.

%%  Advanced Challenge #6  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Q (Challenge #6):  Make up your own question.  Make it *interesting*.
