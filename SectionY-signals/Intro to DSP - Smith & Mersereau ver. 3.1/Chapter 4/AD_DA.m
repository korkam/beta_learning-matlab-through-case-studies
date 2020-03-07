function y = AD_DA(x,Xmin,Xmax,Levels)
% This function represents an A/D converter in series with a D/A converter
% for the sake of exercise 4.2.2. where quantization effects are studied.
% Unlike the textbook instructions, here the input signal x is assumed
% already sampled with Ts = 1msec. Therefore, no sampling operation
% takes place here.

%   Copyright 2012-2016, Ilias S. Konsoulas
% Quantization of the input signal x:
xq = uniform_quantizer(x,Levels,Xmax,Xmin);

% The quantized signal xq is also assumed to exist in analog time
% and therefore it constitutes a weighted impulse train as described
% in the textbook's macro. No "sti" conversion required. 

% Filter the "analogue" impulse train xq(t) with low-pass IIR filter hh[n]:
hh_b = [0.007170507 -0.01914651 0.03186915 -0.03505794 0.03186915 -0.01914651 0.007170507];
hh_a = [1 -4.716277 9.676021 -10.97638 7.236803 -2.623675 0.4082634];

% Insert some zeros at the end of xq to make it suitable for filter command:
xq = [xq zeros(1,20)];
ya = filter(hh_b,hh_a,xq);

% Extract the block of interest:
y = ya(8:108);
