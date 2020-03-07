% Exercise 2.1.6. The Geometric Series.
% This exercise calls for some algebraic simplifications to 4 signals given as
% sums of geometric series. Then it asks from the student to compare the
% analytically found simplified forrmula with the given series-like form.

% Copyright 2012-2016, Ilias S. Konsoulas

%% Workspace Initialization.

clc; clear; close all;

%% Signal Definitions.
N  = 50; 
n0 = 0:N;  % Compute the first 51 samples of all signals.

%% a.
%                   n                          n 
%  x1[n] = { Sum(7/8)^m  -   Sum(3/4)^m }u[n]. 
%                 m=0                    m=0  
x1 = zeros(1,N+1);
for n=0:N
      m = 0:n;
      s1 = (7/8).^m;  s2 = (3/4).^m;
      x1(n+1) = sum(s1) - sum(s2);
end

% Now perform the analytic computation of x1[n]:
x1a = 4 - 7*(7/8).^n0 + 3*(3/4).^n0;

figure('Name','Exercise 2.1.6. The Geometric Series');
subplot(4,2,1);
stem(n0,x1);
title('First  51 samples of x_1[n] numerically (blue) and analytically (red) computed.');
hold on;
stem(n0,x1a,'r*');
axis tight;
grid on;

% Calculate the numerical error:
e1 = x1 - x1a;
subplot(4,2,2);
stem(n0,e1,'.');
title('e_1[n] = x_1_{ (analytic)} - x_1_{ (numeric)}');
axis tight;
grid on;

%% b.
%                  Inf                                   n 
%  x2[n] = { Sum(m+1)(1/2)^m  +  Sum(8/9)^m }u[n]. 
%                 m=0                              m=0  
x2 = zeros(1,N+1);
m = 0:1000;   % 1000 is enough to approximate +Inf here.
s1 = sum((m+1).*(1/2).^m);
for n=0:N
      m = 0:n;
      s2 = (8/9).^m;
      x2(n+1) = s1 + sum(s2);
end

% Now perform the analytic computation of x2[n]:
x2a = 13 - 8*(8/9).^n0;

subplot(4,2,3);
stem(n0,x2);
title('First  51 samples of x_2[n] numerically (blue) and analytically (red) computed.');
hold on;
stem(n0,x2a,'r*');
axis tight;
grid on;

% Calculate the numerical error:
e2 = x2 - x2a;
subplot(4,2,4);
stem(n0,e2,'.');
title('e_2[n] = x_2_{ (analytic)} - x_2_{ (numeric)}');
axis tight;
grid on;

%% c.
%                 n-10          
%  x3[n] = { Sum(7/8)^m }u[n]. 
%                 m=-10          
x3 = zeros(1,N+1);
for n=0:N
     m = -10:n-10;
     s1 = (7/8).^m;
     x3(n+1) = sum(s1);
end

% Now perform the analytic computation of x3[n]:
x3a = 8*((8/7)^10)*(1 - (7/8).^(n0+1));

subplot(4,2,5);
stem(n0,x3);
title('First  51 samples of x_3[n] numerically (blue) and analytically (red) computed.');
hold on;
stem(n0,x3a,'r*');
axis tight;
grid on;

% Calculate the numerical error:
e3 = x3 - x3a;
subplot(4,2,6);
stem(n0,e3,'.');
title('e_3[n] = x_3_{ (analytic)} - x_3_{ (numeric)}');
axis tight;
grid on;

%% d.
%                   n                    
%  x4[n] = { Sum(m*(9/10)^m) }u[n]. 
%                 m=0                  
x4 = zeros(1,N+1);
for n=0:N
      m = 0:n;
      s1 = m.*(9/10).^m;
      x4(n+1) = sum(s1);
end

% Now perform the analytic computation of x4[n]:
x4a = (n0.*0.9.^(n0+2) - (n0+1).*0.9.^(n0+1) + 0.9) / (1-0.9)^2 ;

subplot(4,2,7);
stem(n0,x4);
title('First  51 samples of x_4[n] numerically (blue) and analytically (red) computed.');
hold on;
stem(n0,x4a,'r*');
axis tight;
grid on;

% Calculate the numerical error:
e4 = x4 - x4a;
subplot(4,2,8);
stem(n0,e4,'.');
title('e_4[n] = x_4_{ (analytic)} - x_4_{ (numeric)}');
axis tight;
grid on;
