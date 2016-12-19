% Exercise 6.3.7. Goertzel's Algorithm.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Signal Definitions.
% x = [1 1 1 0 0 0 0];
x = rand(1,10);
N = length(x);
X1 = zeros(1,N);

%% a. Compute all the samples of the N-point DFT of x[n] using Goertzel's algorithm.
for k=0:N-1
    b = 1;                                 % numerator coefficients.
    a = [1 -exp(1i*2*pi*k/N)]; % denominator coefficients.
    aux = filter(b,a,[x 0]);        % We append an extra zero at the end of the input vector x, that corresponds to 
                                               % time instant N because X[k] = y_k[N]. i.e. the DFT sample k equals the filter's 
                                               % response at time instant N. 
    X1(k+1) = aux(end);         % Calculate the next DFT sample as the filter's response at time N = 7. 
end

% Demonstrate how close we fall to the actual DFT with Goertzel's Algorithm:
X1 - fft(x)   %#ok<NOPTS,MNEFF>

%% b. Now do the same by direct use of the convolution formula:
% X2 = zeros(1,N);
% 
% for k=0:N-1  % for all frequency samples...
%    for m=0:N-1  % add together the convolution products...
%         X2(k+1) = X2(k+1) + x(m+1)*exp(1i*2*pi*k*(N-m)/N) ;   
%    end
% end
% 
% X2 - fft(x)
% 
% %% c. Or alternatively, by a pure convolution function:
% X3 = zeros(1,N);
%   m = 0:N;   % m here must run up to N.
% for k=0:N-1
%         hk = exp(1i*2*pi*k*m/N);   % This is a different filter kernel at a different frequency increment k.
%         conv_values = fastconv2(hk,x);
%         X3(k+1) = conv_values(N+1); % The DFT of x[n] at frequency increment k equals the output
% end                                                     % of the  filter at time increment N. 
% 
% X3 - fft(x)
