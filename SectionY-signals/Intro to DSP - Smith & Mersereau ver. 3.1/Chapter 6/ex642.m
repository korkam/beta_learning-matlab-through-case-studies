% Exercise 6.4.2. Overlap-and-Add Method.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% a.  Generate the triangular sequence x[n]:
Period = 65;
n = 0:(Period-1)/2;
A = 1;

half_block = 2*A*n/(Period-1); 
second_half = fliplr(half_block(2:end));
block = [half_block second_half];
x = [block block block block block block block block block block block block block block block];
N = 975;   % 
x = x(1:N); % Truncate the sequence to create the desired length.

% Create a low-pass filter with cut-off frequency pi/2 first and then convert it to it's high-pass conjugate.
M = 63;
w0 = pi/2;
h_low = [ sin(w0.*(-31:-1))./(pi.*(-31:-1)) w0/pi sin(w0.*(1:31))./(pi.*(1:31)) ];
h_high = firlp2hp(h_low);
% a_high = 1;
% NSamples = 1024;
% w = 0:pi/NSamples:pi;

% Plot its frequency response.
% figure('Name',' Exercise 6.4.2. Overlap and Add Method');
%  H = freqz(h_high,a_high,w);
%  plot(w,20*log10(abs(H)));
% set(gca,'XTick',0:pi/6:pi);
% set(gca,'XTickLabel',{'0','pi/6','pi/3','pi/2','2pi/3','5pi/6','pi' })
% xlim([0 pi]);
% ylim([-80 5]);
% ylabel('(dB)');
% grid on;
% title('20log(|{\itH}(j\omega)|)');
% It is a high-pass filter.

y = conv(h_high,x);
% figure('Name',' Exercise 6.4.2. Overlap and Add Method');
% subplot(2,1,1);
% stem(0:N-1,x);
% title('x[n]');
% grid on;
% axis tight;
% 
% subplot(2,1,2);
% stem(0:N+M-2,y,'r.');
% title('High-Pass Filtered Output y[n]');
% grid on;
% axis tight;

%% b. Evaluate the convolution using the macro from Ex. 6.4.1.
N1 = 1037; % N1=N+M-1;
x1 = [x           zeros(1,N1-length(x))         ]; % Both sequences are of size N1.
h   = [h_high zeros(1,N1-length(h_high))];
y1 = fastconv(h,x1);

figure('Name',' Exercise 6.4.2. Overlap-and-Add Method');
subplot(2,1,1);
stem(0:N1-1,y1,'b');
hold on;
grid on;
axis tight;

%% c. Overlap and Add (finally).
L1 = 97;  % This is the half of the segment size to be processed at each iteration. 
% L2 = 63;
% L1>=L2 in order for the following custom function to work properly.
y2 = overlap_add(x,h_high,L1);
  
subplot(2,1,1);
stem(0:size(y2,2)-1,y2,'g.');
title([num2str(2*L1),'-point block, Overlap and Add Convolution (dots) vs built-in Convolution (circles)']);
grid on;
axis tight;

%% d. Repeat part c. but now use 128-point FFT's only.
L1 = 64;
L2 = 63;
 % L1>=L2 in order for the following custom function to work properly.
y3 = overlap_add(x,h_high,L1);

subplot(2,1,2);
stem(0:N1-1,y1,'b');
hold on;
grid on;
axis tight;
hold on;

% subplot(4,1,4);
stem(0:size(y3,2)-1,y3,'c.');
title([num2str(2*L1),'-point block, Overlap and Add Convolution (dots) vs built-in Convolution (circles)']);
grid on;
