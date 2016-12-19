% Exercise 2.3.3. Introduction to Graphical Convolution.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Signal Definition.

n = 0:31;
x = (9/10).^n;
y = [zeros(1,40) ones(1,20) zeros(1,40)];
n2 = -40:59;

x1 = [zeros(1,70) x];
x2 = fliplr(x1);
n1 = -40:61;

y3 = conv(x,y);

figure('Name','Exercise 2.3.3. Introduction to Graphical Convolution');
subplot(3,2,1);
stem(n,x);
title('x[n] = (9/10)^n*\{u[n]-u[n-32])\}');
grid on;

subplot(3,2,2);
stem(n2,y,'r.');
title('y[n] = u[n]-u[n-20]');
grid on;

for i=0:65
     y2 = shiftright(x2,i);
     subplot(3,1,2);
     stem(n2,y,'r.');
     ylim([0 1.15]);
     hold on;
     stem(n1,y2);
     hold off;
     xlim([-40 60]);
     grid;
     if i>9
         title(['c[',num2str(i-9),'] = \fontsize{16}\Sigma\fontsize{10}y[m]x[',num2str(i-9),'-m]']);
     elseif i==9
         title('c[0] = \fontsize{16}\Sigma\fontsize{10}y[m]x[-m]');
     elseif i<9
         title(['c[',num2str(i-9),'] = \fontsize{16}\Sigma\fontsize{10}y[m]x[',num2str(i-9),'-m]']);
     end
    
     subplot(3,1,3);
     stem(i-9,y3(41-9+i),'r*');
     xlim([-10 56]);
     title('c[n] = x[n]\asty[n]');
     grid on;
     hold on;   
     pause(0.25);
end
