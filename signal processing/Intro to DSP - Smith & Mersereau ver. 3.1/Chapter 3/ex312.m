% Exercise 3.1.2. Symmetry in the Fourier Transform.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Step (a). Generate an arbitrary 33-point complex sequence.
Samples = 16;
% Attention: You can enter any signal of length 2*Samples+1 for x below and
%                  examine the symmetry details of its DTFT !!!
% Check for single-sided signals:
% x = [zeros(1,Samples) randn(1,Samples+1) + j*randn(1,Samples+1)];  %
% Check for double-sided signals:
x = randn(1,2*Samples+1) + 1i*randn(1,2*Samples+1);
n = -Samples:Samples; % The whole duration of the signal is 2*Samples + 1.

% Sketch the real and imaginary parts of x[n]:
figure('Name','Exercise 3.1.2. Symmetry in the Fourier Transform');
subplot(2,1,1);
stem(n,real(x));
title('\Ree\{x[n]\}');
grid on;
axis tight;

subplot(2,1,2);
stem(n,imag(x),'rx');
title('{\Imm}\{x[n]\}');
grid on;
axis tight;

%% Step (b). Decompose x[n] into its four components and provide a plot for each of them.
Re_x = real(x);  Im_x = imag(x);

% Create the time-reversed versions of the 2 signals.
Re_x_rev = fliplr(Re_x);
 Im_x_rev = fliplr(Im_x);

% Calculate the 4 signal components and plot them.
ae = (Re_x + Re_x_rev)/2;  % Real Even Part.
ao = (Re_x - Re_x_rev)/2;   % Real Odd Part.
be = (Im_x + Im_x_rev)/2;    % Imaginary Even Part.
bo = (Im_x -  Im_x_rev)/2;    % Imaginary Odd Part.

figure('Name','Exercise 3.1.2. Symmetry in the Fourier Transform');
subplot(2,2,1)
stem(n,ae);
title('{\ita_e}[n] = Even[\Ree\{x[n]\}]');
grid on;
axis tight;

subplot(2,2,2)
stem(n,ao);
title('{\ita_o}[n] = Odd[\Ree\{x[n]\}]');
grid on;
axis tight;

subplot(2,2,3)
stem(n,be,'rx');
title('{\itb_e}[n] = Even[\Imm\{x[n]\}]');
grid on;
axis tight;

subplot(2,2,4)
stem(n,bo,'rx');
title('{\itb_o}[n] = Odd[\Imm\{x[n]\}]');
grid on;
axis tight;

%% Compute an Approximation of the DTFT of x[n] .
% Then decompose this DTFT to its 4 components.
% w = -pi:pi/NSamples:pi;
% X = freqz(x,1,w);
% or using our custom function:
[w  X] = my_DTFT(x,n); 

Re_X = real(X);
Im_X  = imag(X);

% Create the frequency-reversed versions of the 2 DTFT signals.
Re_X_rev = fliplr(Re_X);
Im_X_rev  = fliplr(Im_X);

% Calculate the 4 DTFT signal components and plot them.
Ce = (Re_X + Re_X_rev)/2;  % even{Re[X(jù)]} - even real part of X(jù)
Co = (Re_X -  Re_X_rev)/2;  %   odd{Re[X(jù)]} - odd real part of X(jù)
De = (Im_X + Im_X_rev)/2;    %  even{Im[X(jù)]} - even imaginary part of X(jù)
Do = (Im_X  - Im_X_rev)/2;    %   odd{Im[X(jù)]} - odd imaginary part of X(jù)

figure('Name','Exercise 3.1.2. Symmetry in the Fourier Transform');
subplot(2,2,1)
plot(w,Ce);
title('{\itC_e}(j\omega) = Even[\Ree\{X(j\omega)\}]');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
axis tight;
grid on;

subplot(2,2,2)
plot(w,Co);
title('{\itC_o}(j\omega) = Odd[\Ree\{X(j\omega)\}]');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
axis tight;
grid on;

subplot(2,2,3)
plot(w,De,'r');
title('{\itD_e}(j\omega) = Even[\Imm\{X(j\omega)\}]');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
axis tight;
grid on;

subplot(2,2,4)
plot(w,Do,'r');
title('{\itD_o}(j\omega) = Odd[\Imm\{X(j\omega)\}]');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
axis tight;
grid on;

%% Step (c). Take the individual DTFT's of the 4 components of x[n] and see if they
% agree with the DTFT's of the components of X(jù).

% Ce_app = freqz(ae,1,w);     % DTFT of real-even part of x[n].
% Co_app = freqz(ao,1,w);     % DTFT of real-odd part of x[n].
% De_app = freqz(be,1,w);     % DTFT of imaginary-even part of x[n].
% Do_app = freqz(j*bo,1,w);   % DTFT of imaginary-odd part of x[n].

% or using our custom function:
 
[~, Ce_app] = my_DTFT(ae,n);    % DTFT of even-real part of x[n].
[~, Co_app] = my_DTFT(ao,n);    % DTFT of odd-real part of x[n].
[~, De_app] = my_DTFT(be,n);    % DTFT of even-imaginary part of x[n].
[w Do_app] = my_DTFT(1i*bo,n);  % DTFT of odd-imaginary part of x[n].

%% For the titles of the pictures below see Table 3.2./Last 4 properties.
figure('Name','Exercise 3.1.2. Symmetry in the Fourier Transform');
subplot(4,1,1);
plot(w,Ce,'LineWidth',4);
hold on;
plot(w,real(Ce_app),'r','LineWidth',2); % Imaginary part of Ce_app is zero.
title('Even[\Ree\{X(j\omega)\}] (blue) = DTFT\{Even[\Ree\{x[n]\}]\} (red)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
axis tight;
grid on

subplot(4,1,2);
plot(w,Co,'LineWidth',4);
hold on;
plot(w,real(Do_app),'r','LineWidth',2); % Imaginary part of Do_app is zero.
title('Odd[\Ree\{X(j\omega)\}] (blue) = DTFT\{j*Odd[\Imm\{x[n]\}]\} (red)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
axis tight;
grid on

subplot(4,1,3);
plot(w,De,'LineWidth',4);
hold on;
plot(w,real(De_app),'r','LineWidth',2); % Imaginary part of De_app is zero.
title('Even[\Imm\{X(j\omega)\}] (blue) = DTFT\{Even[\Imm\{x[n]\}]\} (red)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
axis tight;
grid on

subplot(4,1,4);
plot(w,imag(1i*Do),'LineWidth',4);
hold on;
plot(w,imag(Co_app),'r','LineWidth',2);
title('j*Odd[\Imm\{X(j\omega)\}] (blue) = DTFT\{Odd[\Ree\{x[n]\}]\} (red)');
set(gca,'XTick',-pi:pi/4:pi);
set(gca,'XTickLabel',{'-pi','-3pi/4','-pi/2','-pi/4','0','pi/4','pi/2','3pi/4','pi' })
xlabel('\omega (rad/sample)');
axis tight;
grid on
