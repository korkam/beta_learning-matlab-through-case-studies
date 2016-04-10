% 2D Vector Lab Solution
%
%

% Copyright (c) 2011-2014, S. Hsu
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


% Problem 1: Analysis of Temperature and Precipitation Data
%
% Task 1
clear all; clc;
load weather.mat;
%
% Task 2
[r c] = size(weather);
disp('The number of rows is '); disp(r);
disp('The number of columns is '); disp(c);
%
% Task 3
disp('The length of the matrix is '); disp(length(weather));
%
% Task 4
disp('The number of dimensions of the matrix is '); disp(ndims(weather));
%
% Task 5
maximum = max(weather(:,1));
celsius = (5/9)*(maximum-32);
disp('The maximum daily temperature (in celsius) was '); disp(celsius);
%
% Task 6
inches = sum(weather(:,2));
cent = inches/2.54;
disp('The number of centimeters of yearly rain was '); disp(cent);
%
% Task 7
myMean = mean(weather(185:215,:));
myStd = std(weather(185:215,:),1);
disp('The mean and standard dev for temp in January are ');
    disp(myMean(1)); disp(myStd(1));
disp('The mean and standard dev for precip in January are ');
    disp(myMean(2)); disp(myStd(2));
clear myMean myStd;
myMean = mean(weather(216:243,:));
myStd = std(weather(216:243,:),1);
disp('The mean and standard dev for temp in February are ');
    disp(myMean(1)); disp(myStd(1));
disp('The mean and standard dev for precip in February are ');
    disp(myMean(2)); disp(myStd(2));
%
% Task 8
clear myMean myStd;
myMean(1,1) = (length(weather(185:215,1)))^(-1)*sum(weather(185:215,1));
disp('The calcualted mean for temp in January is '); disp(myMean(1,1));
myStd(1,1) = sqrt((length(weather(185:215,1)))^(-1)*sum((weather(185:215,1)-myMean(1,1)).^2));
disp('The calcualted std for temp in January is '); disp(myStd(1,1));

myMean(1,2) = (length(weather(185:215,2)))^(-1)*sum(weather(185:215,2));
disp('The calcualted mean for precip in January is '); disp(myMean(1,2));
myStd(1,2) = sqrt((length(weather(185:215,2)))^(-1)*sum((weather(185:215,2)-myMean(1,2)).^2));
disp('The calcualted std for precip in January is '); disp(myStd(1,2));
%
myMean(2,1) = (length(weather(216:243,1)))^(-1)*sum(weather(216:243,1));
disp('The calcualted mean for temp in January is '); disp(myMean(2,1));
myStd(2,1) = sqrt((length(weather(216:243,1)))^(-1)*sum((weather(216:243,1)-myMean(2,1)).^2));
disp('The calcualted std for temp in January is '); disp(myStd(2,1));

myMean(2,2) = (length(weather(216:243,2)))^(-1)*sum(weather(216:243,2));
disp('The calcualted mean for precip in January is '); disp(myMean(2,2));
myStd(2,2) = sqrt((length(weather(216:243,2)))^(-1)*sum((weather(216:243,2)-myMean(2,2)).^2));
disp('The calcualted std for precip in January is '); disp(myStd(2,2));
%
% Task 9 
bar([1 2],[myMean(1,1) myMean(2,1)]);
%
% Task 10
hold on;
%
% Task 11
errorbar([myMean(1,1) myMean(2,1)], [myStd(1,1) myStd(2,1)], 'r*');

hold;





% Problem 2: Analysis of Solar Radiation Data
%
% Task 1
% inputVec = xlsread('SAC_AP_2005_solar.csv')
clear all;
load solar.mat
%
% Task 2
[r c] = size(solar);
disp('The number of rows is '); disp(r);
disp('The number of columns is '); disp(c);
%
% Task 3
disp('The length of the matrix is '); disp(length(solar));
%
% Task 4
disp('The number of dimensions of the matrix is '); disp(ndims(solar));
%
% Task 5
maximum = max(solar(:,2));
disp('The maximum solar radiation is '); disp(maximum);
%
% Task 6
yearly = sum(solar(:,2));
energy = yearly*1000*1000;
disp('The yearly energy (in Wh) is '); disp(energy);
%
% Task 7
myMean = mean(solar(3625:4344,2));
myStd = std(solar(3625:4344,2),1);
disp('The mean and standard dev for solar radiation in June are ');
    disp(myMean); disp(myStd); 
clear myMean myStd;
myMean = mean(solar(4345:5088,2));
myStd = std(solar(4345:5088,2),1);
disp('The mean and standard dev for solar radiation in July are ');
    disp(myMean); disp(myStd); 
clear myMean myStd;
%
% Task 8
clear myMean myStd;
myMean(1) = (length(solar(3625:4344,2)))^(-1)*sum(solar(3625:4344,2));
disp('The calcualted mean for solar radiation in June is '); disp(myMean(1));
myStd(1) = sqrt((length(solar(3625:4344,2)))^(-1)*sum((solar(3625:4344,2)-myMean(1)).^2));
disp('The calcualted std for solar radiation in June is '); disp(myStd(1));

myMean(2) = (length(solar(4345:5088,2)))^(-1)*sum(solar(4345:5088,2));
disp('The calcualted mean for solar radiation in July is '); disp(myMean(2));
myStd(2) = sqrt((length(solar(4345:5088,2)))^(-1)*sum((solar(4345:5088,2)-myMean(2)).^2));
disp('The calcualted std for solar radiation in July is '); disp(myStd(2));
%
% Task 9
bar([1 2],[myMean(1) myMean(2)]);
hold on;
errorbar([myMean(1) myMean(2)], [myStd(1) myStd(2)], 'r*');






% Problem 3: Defects in Solar Panels
%
% Task 1
clear all; 
defect_percentage = 5;
panel = 0.6 + zeros(96,96);
%
% Task 2
rand_int = randi([1 100],96,96);
%
% Task 3
rand_int(rand_int<=defect_percentage) = 0;
rand_int(rand_int>defect_percentage) = 1;
%
% Task 4
panel=panel.*rand_int;
%
% Task 5
total=sum(panel);
minimum=min(total);
%
% Task 6
errors = 96 - sum(rand_int);
%
% Task 7
output = 100 - 1*errors;
%
% Task 8
total_output = sum(output);
%
% Task 9 
power = total_output*minimum*.9;
disp('The total output power is roughly '); disp(power);
%
% Task 10
pcolor(panel);
%
%
%
%
% Problem 4: Variations in Solar Panels
%
% Task 1
clear all;
defect_percentage = 5;
panel = 0.6 + zeros(96,96);
%
% Task 2
std = .01;
panel = std*randn(96) + panel;
%
% Task 3
total=sum(panel);
minimum=min(total);
%
% Task 4
within1std = panel;
within1std(within1std<(0.6-std) | within1std>(0.6+std)) = 0;
within1std(within1std>=(0.6-std) & within1std<=(0.6+std)) = 1;
number_within_1 = sum(within1std);
disp('The number within 1 std is ');
disp(number_within_1);
%
% Task 5
within2std = panel;
within2std(within2std<(0.6-2*std) | within2std>(0.6+2*std)) = 0;
within2std(within2std>=(0.6-2*std) & within2std<=(0.6+2*std)) = 1;
number_within_2 = sum(within2std);
disp('The number within 2 std is ');
disp(number_within_2);
%
% Task 6
within3std = panel;
within3std(within3std<(0.6-3*std) | within3std>(0.6+3*std)) = 0;
within3std(within3std>=(0.6-3*std) & within3std<=(0.6+3*std)) = 1;
number_within_3 = sum(within3std);
disp('The number within 3 std is ');
disp(number_within_3);
%
% Task 7
output = 100*96;
%
% Task 8
power = output*minimum*.9;
disp('The final output power is roughly '); disp(power);
%
% Task 9
pcolor(panel);
%
%
%
%
% Problem 5: Hybrid Electric Vehicle Sales
%
% Task 1
clear all;
load hev.mat;
size(data)
fordescape = sum(data(8,:));
disp('The total number of Ford Escapes Sold is '); disp(fordescape);
%
% Task 2
nissanaltima = sum(data(25,:));
disp('The total number of Nissan Altimas Sold is '); disp(nissanaltima);
%
% Task 3
hev2000 = sum(data(:,2));
disp('The number of HEVs sold in 2000 is '); disp(hev2000);
%
% Task 4
hev2010 = sum(data(:,12));
disp('The number of HEVs sold in 2010 is '); disp(hev2010);
%
% Task 5
percent = hev2010/hev2000*100;
disp('The percentage of HEVs sold in 2010 went up from 2000 by');
disp(percent);
%
% Task 6
total = sum(data);
totalsum = sum(total);
avg = totalsum/12;
disp('The average number of HEVs sold each year is '); disp(avg);
%
% Task 7
honda = sum(sum(data(12:15,:)));
toyota = sum(sum(data(30:32,:)));
disp('Toyota sold this many more cars than Honda '); disp(toyota-honda);
%
% Task 8
disp('If we add up all cars sold, there are at least this many cars out in 2010');
disp(sum(sum(data)));
%
% Task 9
prius = data(32,:);
figure;
bar(prius);
%
% Task 10
hevs = sum(data);
figure;
bar(hevs);
%
%
%
%
% Problem 6: Means of Transportation to Work
%
% Task 1
clear all;
load work.mat;
disp('The size is'); disp(size(data));
disp('There were this number of workers in 1990 '); disp(sum(data(:,2)));
%
% Task 2
total_years = sum(data);
total = sum(total_years);
alone = sum(data(1,:));
percentage = alone/total*100;
disp('The percentage of people who drive alone is '); disp(percentage);
%
% Task 3
walk = sum(data(10,:));
percent_decrease = abs(data(10,4)-data(10,1))/walk;
disp('The percent decrease in people who walk to work is '); 
disp(percent_decrease);
%
% Task 4
gallons = data(1,4)*30/27;
disp('The number of gallons used everyday in 2009 by lone drivers is');
disp(gallons);
%
% Task 5
newbus = .3*data(1,4);
newpublic = data(3,4)+newbus;
disp('The number of people taking public transportation now in 2009 is ');
disp(newpublic);
%
% Task 6
busfare = 1;
reduce = .01*(newbus/500);
disp('The new bus fare is '); disp(reduce);
%
% Task 7 (unclear question)
bike = sum(data(14,:));
disp('On average, the number of people who bike to work per year is');
disp(bike/4);
%
% Task 8
years = [1980 1990 2000 2009];
plot(years, data(7,:), '*');
%
%
%
%
% Problem 7
%
% Task 1
clear all;
load afv.mat;
disp('The size of data is '); disp(size(data));
total2004 = sum(data(13,:));
disp('The total number of AFV in 2004 is '); disp(total2004);
%
% Task 2
[myMax common1995] = max(data(4,:));
disp('The column number of the most popular AFV in 1995 is ');
disp(common1995); disp('Which is LPG');
%
% Task 3
percent_electric = data(17,8)/sum(data(17,:));
disp('The percentage of electric cars in 2008 is '); disp(percent_electric);
%
% Task 4
e85increase = data(17,6)-data(1,6);
avg_e85 = e85increase/length(data(:,6));
disp('The average increase in E85 cars is '); disp(avg_e85);
%
% Task 5
lpgincrease = data(17,1)-data(4,1);
avg_lpg = lpgincrease/length(data(4:17,1));
disp('The average decrease in LPG cars is '); disp(avg_lpg);
%
% Task 6
years = [1992:1:2008];
plot(years, data(:,6), 'r');
hold on;
plot(years, data(:,1), 'g');
disp('E85 surpassed LPG in 2003');
%
%
%
%
%