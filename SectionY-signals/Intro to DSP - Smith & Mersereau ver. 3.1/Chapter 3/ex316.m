% Exercise 3.1.6. The Shift Property.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Signal Definition.
n1 = -7:7;
ee = [  3.263941e-5  -6.037312e-4  2.971067e-3  -9.563761e-3  2.457258e-2  -5.702938e-2  1.466156e-1  0 ... 
          -1.466156e-1    5.702938e-2 -2.457258e-2   9.563761e-3 -2.971067e-3   6.037312e-4   -3.263941e-5 ];
      
 %% Step (a). Display the 15-point signal ee[n] 
 
 figure('Name','Exercise 3.1.6. The Shift Property');
 subplot(1,2,1);
 stem(n1,ee);
 title('Signal ee[n] is real and odd');
 grid on;
 axis tight;
 
% ad-hoc computation of an approximation of the DTFT of ee[n]:
[w EE] = my_DTFT(ee,n1);

% Plot the real and imaginary parts of the DTFT of ee[n]:
subplot(2,2,2);
plot(w,real(EE));
title('{\Ree}\{EE(j\omega)\} = 0');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

subplot(2,2,4);
plot(w,imag(EE),'r');
title('{\Imm}\{EE(j\omega)\} is odd');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

%% Step (b). Consider the signals y0[n] = ee[n-1] and y1[n] = ee[n+1].
% First create those signals.
 n2 = n1+1; 
 figure('Name','Exercise 3.1.6. The Shift Property');
 subplot(2,2,1);
 stem(n2,ee);
 title('Signal {\ity_0}[n] = ee[n-1] is neither odd nor even');
 grid on;
 axis tight;
 
% ad-hoc computation of an approximation of the DTFT of y0 = ee[n-1]:
[w Y0] = my_DTFT(ee,n2);

 % Plot the real and imaginary parts of the DTFT of y0[n]:
subplot(4,2,2);
plot(w,real(Y0));
title('{\Ree}\{Y_0(j\omega)\} is non-zero and even');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

subplot(4,2,4);
plot(w,imag(Y0),'r');
title('{\Imm}\{Y_0(j\omega)\} is odd');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;
 
 n3 = n1-1; 
 subplot(2,2,3);
 stem(n3,ee);
 title('Signal {\ity_1}[n] = ee[n+1] is neither odd nor even');
 grid on;
 axis tight;

% ad-hoc computation of an approximation of the DTFT of y1 = ee[n+1]:
[w Y1] = my_DTFT(ee,n3);

 % Plot the real and imaginary parts of the DTFT of y0[n]:
subplot(4,2,6);
plot(w,real(Y1));
title('{\Ree}\{Y_1(j\omega)\} is non-zero and even');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
% xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;

subplot(4,2,8);
plot(w,imag(Y1),'r');
title('{\Imm}\{Y_1(j\omega)\} is odd');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
xlim([-pi pi]);
grid on;
