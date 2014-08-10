%%  MA666 - Lab 11:  The FitzHugh-Nagumo model represents a dramatic
%   simplification of the Hodgkin-Huxley equations.  Here, we'll briefly
%   suggest how we might simplify the HH equations.

%%  Preliminaries.
%   Text preceded by a '%' indicates a 'comment'.  This text should appear
%   green on the screen.  I will use comments to explain what we're doing 
%   and to ask you questions.  Also, comments are useful in your own code
%   to note what you've done (so it makes sense when you return to the code
%   in the future).  It's a good habit to *always* comment your code.  I'll
%   try to set a good example, but won't always . . . 

%%  Part 1:  Simplifying the Hodgkin-Huxley (HH) equation.
%   Download the MATLAB file (available on the course website),
%
%   HH0.m
%
%   There are two INPUTS:
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
%   As an example, let's simulate the HH model with input current 10 and,
%   100 ms of total time.  To do so, execute,

I0 = 10;
T = 100;
[V,m,h,n,t] = HH0(I0, T);

%   As in class, plot V vs m, and n vs 1-h.

figure(10)
subplot(2,1,1)
plotyy(t,V, t,m);  title('Blue = V, Green = m')
subplot(2,1,2)
plot(t,n);  title('Blue = n, Red = 1-h')
hold on
plot(t,1-h, 'r')
hold off
xlabel('Time [ms]')

%  From these plots, do you believe a simplification, from 4 variable to 2
%  variables, can take place?
