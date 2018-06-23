% pr15_2.m
% multihaar
% Multi Resolution Analysis MRA Haar Wavelet Analysis

clear;

N=1024;                     % # of points

for n=1:N;m=(n-1)/N;g(n)=20*m^2*(1-m)^4*cos(12*pi*m);end; % input signal p.4 Walker

for m=1:N/2;
    a1(m)=(g(2*m-1)+g(2*m))/sqrt(2); % Use direct formulas for t and f 
    d1(m)=(g(2*m-1)-g(2*m))/sqrt(2);
end;

H1=[a1 d1];   % The level-1 Haar transform

for m=1:N/4;
    a2(m)=(a1(2*m-1)+a1(2*m))/sqrt(2); % Use direct formulas for t and f 
    d2(m)=(a1(2*m-1)-a1(2*m))/sqrt(2);
end;

H2=[a2 d2 d1];

for m=1:N/8;
    a3(m)=(a2(2*m-1)+a2(2*m))/sqrt(2); % Use direct formulas for t and f 
    d3(m)=(a2(2*m-1)-a2(2*m))/sqrt(2);
end;

H3=[a3 d3 d2 d1];

for m=1:N/16;
    a4(m)=(a3(2*m-1)+a3(2*m))/sqrt(2); % Use direct formulas for t and f 
    d4(m)=(a3(2*m-1)-a3(2*m))/sqrt(2);
end;

H4=[a4 d4 d3 d2 d1];

for m=1:N/32;
    a5(m)=(a4(2*m-1)+a4(2*m))/sqrt(2); % Use direct formulas for t and f 
    d5(m)=(a4(2*m-1)-a4(2*m))/sqrt(2);
end;

H5=[a5 d5 d4 d3 d2 d1];

for m=1:N/64;
    a6(m)=(a5(2*m-1)+a5(2*m))/sqrt(2); % Use direct formulas for t and f 
    d6(m)=(a5(2*m-1)-a5(2*m))/sqrt(2);
end;

H6=[a6 d6 d5 d4 d3 d2 d1];

for m=1:N/128;
    a7(m)=(a6(2*m-1)+a6(2*m))/sqrt(2); % Use direct formulas for t and f 
    d7(m)=(a6(2*m-1)-a6(2*m))/sqrt(2);
end;

H7=[a7 d7 d6 d5 d4 d3 d2 d1];

for m=1:N/256;
    a8(m)=(a7(2*m-1)+a7(2*m))/sqrt(2); % Use direct formulas for t and f 
    d8(m)=(a7(2*m-1)-a7(2*m))/sqrt(2);
end;

H8=[a8 d8 d7 d6 d5 d4 d3 d2 d1];

for m=1:N/512;
    a9(m)=(a8(2*m-1)+a8(2*m))/sqrt(2); % Use direct formulas for t and f 
    d9(m)=(a8(2*m-1)-a8(2*m))/sqrt(2);
end;

H9=[a9 d9 d8 d7 d6 d5 d4 d3 d2 d1];

for m=1:N/1024;
    a10(m)=(a9(2*m-1)+a9(2*m))/sqrt(2); % Use direct formulas for t and f 
    d10(m)=(a9(2*m-1)-a9(2*m))/sqrt(2);
end;

H10=[a10 d10 d9 d8 d7 d6 d5 d4 d3 d2 d1];
figure
plot(H10,'k');
title(' MRA: H10 [a10 d10 d9 d8 .... d1] ');

% Plot a few examples;
figure
plot(g,'r.'); hold; plot(g,'r');
axis tight
xlabel ('Time (Sample#)')
ylabel ('Amplitude')
title(' MRA: Original Signal 1024 samples (red) ')
figure
plot(d1,'.'); hold; plot(d1);
axis tight
xlabel ('Time (Sample#)')
ylabel ('Amplitude')
title('Fluctuation d1')
figure
plot(a1,'k.'); hold; plot(a1)
axis tight
xlabel ('Time (Sample#)')
ylabel ('Amplitude')
title('Trend a1')
figure
plot(d6,'.'); hold; plot(d6)
axis tight
xlabel ('Time (Sample#)')
ylabel ('Amplitude')
title('Fluctuation d6')
figure
plot(a6,'k.'); hold; plot(a6)
axis tight
xlabel ('Time (Sample#)')
ylabel ('Amplitude')
title('trend a6')


