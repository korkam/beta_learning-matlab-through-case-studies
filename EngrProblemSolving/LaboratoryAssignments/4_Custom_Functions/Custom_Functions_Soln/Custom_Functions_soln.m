% Custom Functions Lab Solutions
%

% Copyright (c) 2012, S. Hsu
% All rights reserved.

% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in the
%       documentation and/or other materials provided with the distribution.
%     * Neither the name of the University of California, Davis nor the
%       names of its contributors may be used to endorse or promote products
%       derived from this software without specific prior written permission.

% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
% ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
% DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
% (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
% ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
% SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

% Problem 1: Solar Panel Parameters
clear all; clc;
%
% Task 1
% In function file "solar_panel.m"
%
% Task 2
for i=10:100
    [vout iout] = solar_panel(i,i);
    max_out_power = .9*vout*iout;
    disp(max_out_power);
end
%
% Task 3
figure; hold on;
for i=10:100
    [vout iout] = solar_panel(i,i);
    max_out_power = .9*vout*iout;
    num_diodes = i*i;
    plot(num_diodes, max_out_power, '*');
end
hold off;
%
%
%
%
%% Problem 2: Optimal Solar Panel Parameters
clear all; clc;
%
% Task 1
% In function file "solar_panel_optimal.m"
%
% Task 2
illum = 500;
for i=10:100
    [vopt iopt] = solar_panel_optimal(illum);
    vopt = i*vopt;
    iopt = i*iopt;
    max_out_power = vopt*iopt;
    disp(max_out_power);
end
%
%% Task 3
figure; hold on;
for i=10:100
    [vopt iopt] = solar_panel_optimal(illum);
    vopt = i*vopt;
    iopt = i*iopt;
    max_out_power = vopt*iopt;
    num_diodes = i*1;
    plot(num_diodes, max_out_power, '*');
end
hold off;
%
%
%
%
%% Problem 3: Measuring MATLAB Performance
clear all; clc;
%
% Task 1
x = rand(1000);
y = rand(1000);
tic; z = x.*y; toc;

tic;
for i=1:1000
    for j=1:1000
        z(i,j) = x(i,j)*y(i,j);
    end
end
toc;
%
%
%
%
%% Problem 4: Delay in Using Functions
clear all; clc;
%
% Task 1
% function is called "myadd.m"
a = [1 2 3 4 5 6 7 8 9 10]';
b = [1 2 3 4 5 6 7 8 9 10]';

tic;
for i=1:1000000
    output = a+b;
end
toc;

tic;
for i=1:1000000
    myadd(a,b);
end
toc;
%
%
%
%
%% Problem 5: Comparing Fixed and Tracking Solar Panel Configurations
%
% Task 1
clear all; clc;
load lab6.mat
%
x = fix(:,1);
y = fix(:,2);
%
% Task 2
figure;
plot(x,y);
%
% Task 3
figure;
x_exp = exp(x);
plot(x_exp,y); hold on;
%
% Task 4
p = polyfit(x_exp,y,1);
%
% Task 5
x_logspace = logspace(1,8.6);
m = p(1); b = p(2);
yt = m.*x_logspace + b;
%
% Task 6
plot(x_logspace, yt, 'r'); hold off;
%
% Task 7
x_linspace = log(x_logspace);
%
% Task 8
figure;
plot(x,y); hold on;
plot(x_linspace,yt,'r'); hold off;
%
% Task 9
disp('The b value for the fixed solar panel is'); disp(b);
single_x_exp = exp(single(:,1));
q = polyfit(single_x_exp,single(:,2),1);
disp('The b value for the single solar panel is'); disp(q(2));
%
%
%
%
%% Problem 6: Solving Nonlinear Equations with Newtons Method
%
% Task 1
clear all; clc;
Ilight = 500*10^-3;
Idark = 0.6*10^-6;
Vt = 26*10^-3;
R = 10;

idiode_1 = @(vout) vout/R;

idiode_2 = @(vout) Ilight - Idark * (exp(vout/Vt)-1);

vout = (0:0.01:0.4);

figure; hold on;
plot(vout,idiode_1(vout));
plot(vout,idiode_2(vout),'r');
hold off;
% roughly x=.3522, y=.352
%
% Task 2
idiode_3 = @(vout) Ilight - Idark*(exp(vout/Vt)-1) - vout/R;
actual_root = fzero(idiode_3,.352);
disp('The actual root is'); disp(actual_root);
%
% Task 3
Vout = @(idiode) Vt*log((Ilight-idiode)/Idark+1);

vout = .35;
for i=1:10
    idiode = idiode_1(vout);
    vout = Vout(idiode);
end
disp('Idiode is'); disp(idiode);
disp('Vout is'); disp(vout);
%
%
% Task 4
f1 = @(vout) Ilight - Idark*(exp(vout/Vt)-1) - vout/R;
f2 = @(vout) (-Vt)^(-1)*Idark*exp(vout/Vt) - R^(-1);
%
vout = myNewton(10); disp('After 10 iterations, vout is'); disp(vout);
vout = myNewton(50); disp('After 50 iterations, vout is'); disp(vout);
vout = myNewton(100); disp('After 100 iterations, vout is'); disp(vout);
vout = myNewton(1000); disp('After 1000 iterations, vout is'); disp(vout);
%
%
%
%
%