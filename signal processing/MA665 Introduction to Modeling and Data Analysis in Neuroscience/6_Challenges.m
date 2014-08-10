%   Lab 6 Challenges:  Analysis of Rhythmic Data

%%  NOTES - Challenge Problems.
%   You'll find *6* challange problems below.  Please attempt at least 2 of them.
%
%   As always, present your results to me in whatever format you think is
%   appropriate.  Your solutions should include figures (with axes labeled
%   and captions) and explanatory text.  Also, please include any
%   MATLAB code you write;  remember to include comments in the
%   code.  The comments should be detailed enough that you could share your
%   code with any of your classmates / colleagues.  Watch out for *Extreme*
%   Challenge problems --- they're tricky.  If you email me your solutions
%   please send as PDF.

%%  Challenge Problem #1.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find a data set, and compute its power spectrum.  This can
% be your own data, data you borrow from a friend, data you download from
% the Internet, etc.  Non-neuroscience data are fine too (financial time series,
% weather data, ...) Make sure you know enough about the data to compute the
% power spectrum.  State explicitly the frequency resolution and Nyquist
% frequency.  Plot your power spectrum results, and draw some conclusions
% about the data.

%%  Challenge Problem #2.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% We discussed in class the Hann taper.  There are many
% different taper choices.  Investigate three of these here:
%
%   http://www.nrbook.com/a/bookcpdf.php  ---  See 13.4, pg 554, Eqns
%   13.4.13, 13.4.14, and 13.4.15.
%
%   NOTE:  See top of this webpage to get appropriate Adobe Reader Plugin.
%
% Write a MATLAB function to compute each taper.  Plot the three tapers and
% compare.  Then apply each taper to the data set "v1" we analyzed in lab,
% and compare your results (both to the rectangular taper [the default case]
% and between the different taper methods).  Which taper do you like best?

%%  Challenge Problem #3.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Visit Blackboard for this course and download the file
%   "Power_Spectrum_Notes_EEG.pdf" from the Course Documents section.  Work
%   through this document by downloading the specified EEG data set
%   and executing the MATLAB code.  Notify me of any typos, suggestions,
%   ideas, etc.  I'm interested to know anything you like or dislike.  What
%   makes sense?  What doesn't make sense?

%%  Challenge Problem #4.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the power spectra of voltage data recorded from
% a slice of cortical brain tissue.  Download the data sets from the course
% webpage (under the Week 6 tab):
%
%    "lfp1.dat" & "lfp2.dat"     NOTE:  Sampling rate = 30,000 Hz.
%
% These data are local field potential (LFP) recordings from a small
% region of cortex in vitro.  To make these recordings, a small slice of
% cortical tissue was removed from the brain and kept alive
% (temporarily) in a petri dish. Compute the power spectrum and windowed
% power spectrum of each LFP.  Plot the results over the frequency range
% [0Hz - 200Hz].  Describe the rhythms you observe.

%%  Hard Challenge Problem #5.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Analyze some human voltage data.  Get it here:
%
%    http://math.bu.edu/people/kolaczyk/datasets.html
%
%On this webpage, click on the link "Epileptic seizures".  You'll download
%a zip file, which when unzipped will contain voltage data recorded from multiple
%electrodes (76 in total).  Each electrode records directly from the brain's
%surface of a human subject with epilepsy.  For more details about the data
%(including the sampling frequency) see the file "README.EPILEPSY" in the zip
%folder.  The challenge:
%
%  1)  Load "sz1_pre.dat" into MATLAB.
%  2)  Compute the power spectrum for each electrode (there are 76
%  electrodes total), average the spectra over all electrodes, and plot
%  your results (with correct axes).  In other words, plot the average
%  spectra recorded from all electrodes.
%  3)  Repeat the analysis for "sz1_ict.dat".  How do the spectra differ (if
%  at all)?  NOTE:  Data in "sz1_pre.dat" precede the seizure, while data
%  in "sz1_ict.dat" occur during the seizure.

%%  Extreme Challenge Problem #6.  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%There are many more sophisticated ways to
%compute power spectra.  One technique invovles the "multi-taper method".
%A toolbox for MATLAB - called "Chronux" - exists to compute power spectra
%using the multi-taper method.  Visit the Chronux website:
%
%    http://www.chronux.org
%
%and download the Chronux software.  Compute the power spectrum for data
%set v1 and the windowed power spectrum for data set v2 using the Chronux software.
%(Hint:  see the functions "mtspectrumc.m" and "mtspecgramc.m")  Describe
%in words / pictures how the multi-taper method works, and its advantages
%over "single-taper" (e.g., Hanning) methods.
