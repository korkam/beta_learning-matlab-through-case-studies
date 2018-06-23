% pr5_1.m

clear;
% define base sine wave s1 with 10 Hz frequency
% over a 1 second epoch
t=0:0.001:1;
f=10;
s1=(4/pi)*sin(2*pi*f*t);    % the (4/pi) factor
                            % is to get a total amplitude of 1
% define harmonics with odd frequency ratio
s3=(4/pi)*(1/3)*sin(2*pi*3*f*t);
s5=(4/pi)*(1/5)*sin(2*pi*5*f*t);
s7=(4/pi)*(1/7)*sin(2*pi*7*f*t);
s9=(4/pi)*(1/9)*sin(2*pi*9*f*t);
total=s1+s3+s5+s7+s9;
% plot results (the additions and subtraction 
% are for display purpose only!)
figure;hold;
plot(t,s1);
plot(t,s3+2);        % Note: the numbers 2, 4, 6 etc
plot(t,s5+4);        % were added for display purpose
plot(t,s7+6);        % only
plot(t,s9+8);
plot(t,total-3,'k');
axis('off');
title('Approximation of a Rectangular Wave in the Time Domain')
% plot the frequency equivalent
figure;hold;
for n=1:2:9;
    stem(n,4/(n*pi));
end;
title('Frequency Domain Representation');
xlabel('Frequency ');
ylabel('Amplitude ');
axis([0 10 0 1.5]);