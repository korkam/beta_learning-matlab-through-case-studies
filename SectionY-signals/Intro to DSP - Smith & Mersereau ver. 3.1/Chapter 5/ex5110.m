% Exercise 5.1.10. Stability.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Polynomial Definitions.

a = [ 1    2     0.5    0.2 ];
b = [ 1    0.5  0.2    0.1 ];
c = [ 1    4      4       2    ];

%% Step (a). Use zplot() to display the pole zero plots of the systems.
figure('Name','Exercise 5.1.10. Stability');
% H1(z) = A(z)/B(z);
subplot(2,2,1);
zplane(a,b); % 1st arg is the numerator and the 2nd arg is the denominator.
title('Zero-Pole Plot of System H_1(z)=A(z)/B(z)');
grid on;

% H2(z) = A(z)/C(z);
subplot(2,2,2);
zplane(a,c); % 1st arg is the numerator and the 2nd arg is the denominator.
title('Zero-Pole Plot of System H_2(z)=A(z)/C(z)');
grid on;

% H3(z) = B(z)/C(z);
subplot(2,2,3);
zplane(b,c); % 1st arg is the numerator and the 2nd arg is the denominator.
title('Zero-Pole Plot of System H_3(z)=B(z)/C(z)');
grid on;

% H4(z) = C(z)/B(z);
subplot(2,2,4);
zplane(c,b); % 1st arg is the numerator and the 2nd arg is the denominator.
title('Zero-Pole Plot of System H_4(z)=C(z)/B(z)');
grid on;

% Answers: 
% a. If each of the systems is causal, then the ROC is the exterior of the
% circle defined by the largest pole. Also, the ROC that corresponds to a
% stable system must include the unit circle. This means that only H1 and
% H4 are stable.
% 
% b. If we assume that all the impulse responses are left-sided sequences,
% then the ROC is defined by the interior of the circle defined by the
% smallest pole. Again, the unit circle |z|=1 must be included in the ROC
% to have a stable system. In such a case none of the (here noncausal) 
% systems is stable.
%
% c. If every impulse response is a two-sided sequence, this means that the
% ROC is an annular ring defined in the region between: the circle with radius 
% equal to the magnitude of the farthest (from the origin) pole and the circle with
% radius equal to the magnitude of the nearest (to the origin) pole. In addition,
% in order the system to be stable, this annular ring must contain the unit
% circle. Therefore, if such is the case, H2 and H3 are stable.
