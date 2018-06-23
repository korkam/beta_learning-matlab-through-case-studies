% pr8_1.m
% Discrete Convolution

d=1;                            % unit impulse 
h=[.25 .5 .25];                 % impulse response
i=[20 20 20 12 40 20 20];       % input
ii=[20 20 40 12 20 20 20];      % reversed input
x=0:10;                         % x -axis

figure
subplot(6,1,1),stem(x(1:length(d)),d)
axis([0 7 0 1.5]);
title(' Unit Impulse')
axis('off')

subplot(6,1,2),stem(x(1:length(h)),h)
axis([0 7 0 1.5]);
title('Impulse Response y=.25x(n)+.5x(n-1)+.25x(n-2)')

subplot(6,1,3),stem(x(1:length(i)),i)
axis([0 7 0 50]);
title(' LTI Input')

subplot(6,1,4),stem(x(1:length(ii)-1),ii(2:length(ii)))
axis([0 7 0 50]);
title(' Reversed LTI Input @ n=5')

subplot(6,1,5),stem(x(1:length(h)),h)
axis([0 7 0 1.5]);
title(' Impulse Response Again')
axis('off');

r5=.25*20+.5*40+.25*12;
subplot(6,1,6),stem(x(1:length(r5)),r5)
axis([0 7 0 50]);
title('Response @n=5 = .25*20+.5*40+.25*12 = 28')
xlabel('Sample #')