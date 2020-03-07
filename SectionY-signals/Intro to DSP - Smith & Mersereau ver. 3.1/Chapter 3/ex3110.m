 % Exercise 3.1.10. The Initial Value Theorem.

 %   Copyright 2012-2016, Ilias S. Konsoulas.

 %% Workspace Initialization.
 
 clc; clear; close all;
 
%% Signal Definitions.
gg = [0.00307787 0.001838499 0.0009756996 0.02195124 0.06561216 0.09 0.06561216 0.02195124 ...
          0.0009756996 0.001838499 0.00307787];

n = 0:10; % signal starts at n=0;

vv = gg;  % vv[n] = gg[n+5].

n1 = -5:5; % signal starts at n=-5;  It;s an even signal.

%% Step (c).  Calculate and Display the real and imaginary parts of VV(jù).

% Computation of an approximation of the DTFT of vv[n]:
[w VV] = my_DTFT(vv,n1);

% Plot the magnitude the real and imaginary parts of VV(jù):
figure('Name',' Exercise 3.1.10. The Initial Value Theorem');
subplot(1,2,1);
plot(w,real(VV));
title('\Ree\{VV(j\omega\})');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlim([-pi pi]);
xlabel('Digital Frequency \omega (rad/sample)');
% axis tight;
grid on;

subplot(1,2,2);
plot(w,imag(VV),'r');
title('{\Imm}\{VV(j\omega)\}');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlim([-pi pi]);
xlabel('Digital Frequency \omega (rad/sample)');
% axis tight;
grid on;

%% Calculate the area under the ral part of VV(jù):
Area_Under_Real_VV = 2*pi*sum(real(VV))/length(VV) %#ok<*NOPTS>

disp(['Initial Value vv[0] =:', num2str(vv(6)) ]);
disp(['1/(2*pi)*Area under VV(jù) = ', num2str(Area_Under_Real_VV/(2*pi)) ]);
disp(['Samples Used to Approximate the Integral: ', num2str(length(VV)) ]);
