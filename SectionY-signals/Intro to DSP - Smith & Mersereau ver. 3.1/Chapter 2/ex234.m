% Exercise 2.3.4. Convolving Sequences.

%   Copyright Jan. 2012-2016, Ilias S. Konsoulas.

%% Initialize Workspace.

clc; clear; close all;

%% Signal Definitions.
n1 = 0:3;
x1 = ones(1,4);

n2 = 0:5;
x2 = ones(1,6);

n3 = 0:4;
x3 = (7/8).^n3;
n3_shift = n3 + 3;
x3_sh = x3;

n4 = 0:5;
x4 = sin(pi*n4/12 + pi/4);

%% a. Compute and display the convolutions as requested:

[ny1 y1] = my_conv(x1,x2,n1,n2);

hfig = figure('Name','Exercise 2.3.4. Convolving Sequences');

subplot(4,3,1);
stem(n1,x1);
grid on;
title('x_1[n] = u[n]-u[n-4]');

subplot(4,3,2);
stem(n2,x2,'g*');
grid on;
title('x_2[n] = u[n]-u[n-6]');

subplot(4,3,3);
stem(ny1,y1,'r.');
grid on;
title('x_1[n]\astx_2[n]');

[ny2 y2] = my_conv(x1,x3_sh,n1,n3_shift);

subplot(4,3,4);
stem(n1,x1);
grid on;
title('x_1[n]');

subplot(4,3,5);
stem(n3_shift,x3_sh,'g*');
grid on;
title('x_3[n-3]');

subplot(4,3,6);
stem(ny2,y2,'r.');
grid on;
title('x_1[n]\astx_3[n-3]');

[ny3 y3] = my_conv(x1,x4,n1,n4);

subplot(4,3,7);
stem(n1,x1);
grid on;
title('x_1[n]');

subplot(4,3,8);
stem(n4,x4,'g*');
grid on;
title('x_4[n] = sin(\pin/12+\pi/4)\{u[n]-u[n-6]\}');

subplot(4,3,9);
stem(ny3,y3,'r.');
grid on;
title('x_1[n]\astx_4[n]');

[ny4 y4] = my_conv(x3,x4,n3,n4);

subplot(4,3,10);
stem(n3,x3);
grid on;
title('x_3[n] = (7/8)^n\{u[n]-u[n-5]\}');

subplot(4,3,11);
stem(n4,x4,'g*');
grid on;
title('x_4[n]');

subplot(4,3,12);
stem(ny4,y4,'r.');
grid on;
title('x_3[n]\astx_4[n]');

tightfig(hfig);
