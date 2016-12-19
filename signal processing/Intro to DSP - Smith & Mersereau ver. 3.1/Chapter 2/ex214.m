%% Exercise 2.1.4. Time Axis Alteration.
%
% The time axis of a signal, $x[n]$, can be altered to produce a new signal
% $y[n]$. The method of alteration can be as simple as a time shift, or ti
% can be a more complicated operation. A general time axis alteration can
% be expressed as:
%
% $$y[n] = x[f[n]]$$
%
% where $f[n]$ is the time axis alteration function. The value of $f[n]$
% must be an integer because the time index for digital sequences is only
% defined for integer values. As a simple example of time axis alteration,
% consider the problem of determining 
%
% $$y[n] = x[n-6]$$
%
% when
%
% $$x[n] = u[n] - u[n-5]$$.
%
% The sequence $x[n]$ is simply shifted to the right by six samples to
% produce the sequence $y[n]$. While this example poses no difficulty,
% determining the result of other alterations may not be so easy. For
% example, consider sketching:
%                             
% $$y[n] = x[3-n]$$
%
% where $f[n]=3-n$ and $x[n]$ is an arbitrary signal. A simple and
% systematic procedure for determining $y[n]=x[f[n]]$ can be summarized as
% follows:
%%
% # Sketch $x[n]$.
% # Sketch another time axis underneath it for $y[n]$.
% # Write the expression for $f[n]$.
% # To find $y[0]$, evaluate $f[0]$ (which always be an integer). Next
% evaluate $x[f[0]]$ and enter this value for $y[0]$ on time axis for
% $y[n]$ at the point $n=0$. 
% # To find $y[1]$, evaluate $f[1]$ and $x[f[1]]$. Set $y[1]=x[f[1]]$ and enter it on the $y[n]$ time axis at point $n=1$.
% # Continue this procedure until all values, $-\infty < n < \infty$, of $y[n]$ have been found.
%
% To test your understanding, consider the sequence $x[n]$ where:
%
% $$ x[n] = \left( \frac{3} {4}\ \right)^n (u[n]-u[n-5]).$$

%   Copyright 2012-2016, Ilias S. Konsoulas

%% Workspace Initialization.

clc; clear; close all;

%%  a. Without the aid of the computer, sketch $y[n]$ for each of the cases given below using the procedure just described.
%
% # $y[n] = x[-n]$ 
% # $y[n] = x[-7-n]$
% # $y[n] = x[-n+15].$

n = 0:4;
x = (3/4).^n;

figure('Name','Exercise 2.1.4. Time Axis Alteration');
subplot(2,1,1);
stem(n,x);
hold on;

stem(-n,x,'r*');
stem(-7-n,x,'g*');
stem(-n+15,x,'c*');
grid on;
title('x[n] (blue), x[-n] (red), x[-7-n] (green), x[-n+15] (cyan)');
xlabel('Sample n');

%% b. Sketch the sequences:
%%
% #  $y[n]=x[2n]$ 
% # $y[n]=x[5-2n].$

x1 = downsample(x,2);
n1 = 0:length(x1)-1;
subplot(2,1,2);

stem(n1,x1,'b*');
grid on;
hold on;

stem(5-n1,x1,'g*');
title('x[2*n] (blue), x[5-2*n] (green)');
xlabel('Sample n');
