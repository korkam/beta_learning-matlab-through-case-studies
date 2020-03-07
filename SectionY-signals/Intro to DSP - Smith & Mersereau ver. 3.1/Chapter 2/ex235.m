% Exercise 2.3.5. More Convolution.

%   Copyright 2012-2016, Ilias S. Konsoulas

%% Workspace Initialization.

clc; clear; close all;

%% a. Signal Definitions.
n1 = 0:12;
v1 = [1 0 0 0 0 0 1 0 0 0 0 0 1];

n2 = 0:15;
v21 = [0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0];  % v1[n-1].
v22 = [0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0];  % v1[n-2].
v23 = [0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1];  % v1[n-3].
  v2 = v21+v22+v23;

n3 = 0:4;
n31 = n3 + 1;  % This time index vector corresponds to v3[n-1].
v3 = (2/3).^n3;

%% b. 
[ny0 y0] = my_conv(v1,v3,n1,n3);

[ny10 y10] = my_conv(v1,v1,n1,n1); 

[ny1 y1] = my_conv(v1,y10,n1,ny10);

[ny2 y2] = my_conv(v1,v2,n1,n2);

[ny3 y3] = my_conv(v3,v2,n3,n2);

[ny4 y4] = my_conv(v3,v3,n3,n31);

hfig = figure('Name','Exercise 2.3.5. More Convolution');

subplot(5,3,1);
stem(n1,v1);
grid on;
title('v_1[n] = \delta[n]+\delta[n-6]+\delta[n-12]');

subplot(5,3,2);
stem(n3,v3,'g*');
grid on;
title('v_3[n] = (2/3)^n\{u[n]-u[n-5]\}');

subplot(5,3,3);
stem(ny0,y0,'r.');
grid on;
title('y_0[n] = v_1[n]\astv_3[n]');

subplot(5,3,4);
stem(n1,v1);
grid on;
title('v_1[n]');

subplot(5,3,5);
stem(n1,v1,'g*');
grid on;
title('v_1[n]');

subplot(5,3,6);
stem(ny1,y1,'r.');
grid on;
title('y_1[n] = v_1[n]\astv_1[n]\astv_1[n]');

subplot(5,3,7);
stem(n1,v1);
grid on;
title('v_1[n]');

subplot(5,3,8);
stem(n2,v2,'g*');
grid on;
title('v_2[n] = v_1[n-1]+v_1[n-2]+v_1[n-3]');

subplot(5,3,9);
stem(ny2,y2,'r.');
grid on;
title('y_2[n] = v_1[n]\astv_2[n]');

subplot(5,3,10);
stem(n3,v3);
grid on;
title('v_3[n]');

subplot(5,3,11);
stem(n2,v2,'g*');
grid on;
title('v_2[n]');

subplot(5,3,12);
stem(ny3,y3,'r.');
grid on;
title('y_3[n] = v_3[n]\astv_2[n]');

subplot(5,3,13);
stem(n3,v3);
grid on;
title('v_3[n]');

subplot(5,3,14);
stem(n31,v3,'g*');
grid on;
title('v_3[n-1]');

subplot(5,3,15);
stem(ny4,y4,'r.');
grid on;
title('y_4[n] = v_3[n]\astv_3[n-1]');

% tightfig(hfig);
