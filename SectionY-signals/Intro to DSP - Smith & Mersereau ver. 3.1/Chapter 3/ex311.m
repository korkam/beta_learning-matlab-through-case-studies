% Exercise 3.1.1 Response of a System to a Complex Exponential.
% Attention: Maximize figures 1 and 2 for best visual results. 

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.
clc; clear; close all;

%% Impulse Response h[n] is defined as:
h = [ 0.03  0.4  0.54  0.2  -0.2 ]; 

omegas = [0 pi/9  2*pi/9  3*pi/9  4*pi/9  5*pi/9  6*pi/9 7*pi/9 8*pi/9 pi ];

omega_str = ['0n     '; '\pin/9 ';  '2\pin/9';  '3\pin/9';  '4\pin/9';  '5\pin/9';  '6\pin/9'; '7\pin/9'; '8\pin/9'; '\pin   '; ];
N = 64;      % This is the selected size of the complex exponential applied at the input of filter h[n].

n = 0:N-1;
M = length(h);
K = N + M -1; % This is the size of the output signal y[n].
k = 0:K-1;

x = zeros(6,N);
y = zeros(6,N+length(h)-1); % This is the size of convolution between h and x(i,:).

% First create the inputs and then compute the outputs via convolution:
for i=1:size(omegas,2)
     x(i,:) = exp(1i*omegas(i)*n);
     y(i,:) = fastconv2(h, x(i,:));  % This is a custom function developed in the context of chapter 6.
end

%% Step (a). Display the real and imaginary parts of the complex exponentials.
%                also, Examine and Record the magnitude of each of output sequences y[i].
figure('Name','Exercise 3.1.1 Response of a System to a Complex Exponential');
% (Maximize the figure in order symbols to appear correctly).
for i=1:5
    
    subplot(5,4,4*i-3);
    stem(n,real(x(i,:)),'x');
    title(['\Ree\{x_{', int2str(i), '}[n]\} = cos(',omega_str(i,:),')']);
    axis tight;
    grid on;
 
    subplot(5,4,4*i-2);
    stem(n,imag(x(i,:)),'x','r');
    title(['\Imm\{x_{', int2str(i), '}[n]\} = sin(',omega_str(i,:),')']);
    axis tight;
    grid on;
    
    subplot(5,4,4*i-1);
    stem(k,abs(y(i,:)),'x');
    title(['|y_', int2str(i), '[n]|']);
    axis tight;
    ylim([0 1.15]);
    grid on;
  
    subplot(5,4,4*i);
    stem(k,angle(y(i,:)),'x','r');
    title(['\angley_', int2str(i), '[n]']);
    axis tight;
    grid on;
        
end

x1 = 0.28;
y1 = 0.9;
annotation('textbox',[x1 y1 0.1 0.1],'String','Inputs','FontSize',20,'LineStyle','none');

x1 = 0.685;
y1 = 0.9;
annotation('textbox',[x1 y1 0.1 0.1],'String','Outputs','FontSize',20,'LineStyle','none');

%% 
figure('Name','Exercise 3.1.1 Response of a System to a Complex Exponential');
% (Maximize the figure in order symbols to appear correctly).
for i=6:10
        
        subplot(5,4,4*i-23);
        stem(n,real(x(i,:)),'x');
        title(['\Ree\{x_{',int2str(i),'}[n]\} = cos(',omega_str(i,:),')']);
        axis tight;    
        grid on;
        
        subplot(5,4,4*i-22);
        stem(n,imag(x(i,:)),'x','r');
        title(['\Imm\{x_{',int2str(i),'}[n]\} = sin(',omega_str(i,:),')']);
        axis tight;
        grid on;
        
        subplot(5,4,4*i-21);
        stem(k,abs(y(i,:)),'x');
        title(['|y_{',int2str(i),'}[n]|']);
        axis tight;
        ylim([0 1.15]);
        grid on;
   
        subplot(5,4,4*i-20);
        stem(k,angle(y(i,:)),'x','r');
        title(['\angley_{',int2str(i),'}[n]']);
        axis tight;
        grid on;
        
end

x1 = 0.28;
y1 = 0.9;
annotation('textbox',[x1 y1 0.1 0.1],'String','Inputs','FontSize',20,'LineStyle','none');

x1 = 0.685;
y1 = 0.9;
annotation('textbox',[x1 y1 0.1 0.1],'String','Outputs','FontSize',20,'LineStyle','none');

%% Step (b). Construct a graph with amplitude on the vertical axis and frequency in the range
% (0<= omega<= pi) along the horizontal axis.
% Select a steady-state value. For example, n = 50, and form the values vector:
y_ssmags = abs(y(:,50));

figure('Name','Exercise 3.1.1 Response of a System to a Complex Exponential');
plot(omegas, y_ssmags, '*-');
title('Magnitude of Output Response vs Input Frequency');
set(gca,'XTick',0:pi/9:pi);
set(gca,'XTickLabel',{'0','pi/9','2pi/9','3pi/9','4pi/9','5pi/9','6pi/9','7pi/9','8pi/9','pi' })
axis tight;
grid on;
xlabel('Digital Frequency (rad/sample)');


%% Step (c). Calculate and Plot the DTFT of |H(e^jù)|. Compare your result with Step (b).

figure('Name','Exercise 3.1.1 Response of a System to a Complex Exponential');
% Plot the frequency response (or DTFT) of the FIR filter h[h]:
freqz(h,1);
hold on;
plot(omegas/pi, 20*log10(y_ssmags), 'r*-');
title(['System Frequency Response via built-in function freqz() (blue)';
        '  and Magnitude of Output Steady-State Values |y[50]| (red)   ';]);
