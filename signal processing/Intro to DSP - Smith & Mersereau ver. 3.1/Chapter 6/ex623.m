% Exercise 6.2.3. Circular and Linear Convolutions.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Step (a). Generate a 16-point ramp function beginning at n = 0.
n = 0:15;
x = n; 

figure('Name','Exercise 6.2.3. Circular and Linear Convolutions'); 
y1 = cconv(x,x,16); 
subplot(2,1,1);
stem(n,y1);
hold on;
title('Circular Convolution of x[n] with itself');
grid on;

%% Step (b). Perform the linear convolution y2[n] = x[n]*x[n].
y2 = conv(x,x); % The size of this is 2*length(x)-1 = 31 points starting from 0.
n2 = 0:30;

subplot(2,1,2);
stem(n2,y2);
hold on;
stem(n+16,y1,'r*');
title(['Circular Conv. y_1[n] = cconv(x,x,16) (red) and Linear Conv. y_2[n] = x[n]\astx[n] (blue)';
         '       1^{st} Half of Spatially De-Aliased samples: y_1[n] - y_2(17:end), (green)        ';
         '       2^{nd} Half of Spatially De-Aliased samples: y_1[n] - y_2(1:16), (magenta)        ';]);
grid on;
% Perform and display De-Aliasing on the circular convolution sequence y1[n].
stem(0:15,y1-[y2(17:31) 0],'g.');
stem(16:31,y1-y2(1:16),'m.');
axis tight;

%% Step (c). Spatially alias y2[n] with itself.
y3 = y2(1:15) + y2(17:31); 
y3 = [y3 y2(16)];

subplot(2,1,1);
stem(n,y3,'r*');
title('Spatially Aliased Linear Convolution (red)  is equal to Circular Convolution (blue)');
grid on;

