% ENG6 Project 1 Solution

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

clear all
clc


load weather


%% Task 3 
count = 1;
exist = 0;
for i=2:length(state(:,1)),
    for j=1:i-1,
        if strcmp(state(i,1:2),state(j,1:2)) == 1
            exist = 1;
        end
    end
    if exist == 0
        count = count+1;
    end
    exist = 0;
end
fprintf('Task 3: In total, %d states exist in the database.\n\n', count);


%% Task 4
count = 0;
len = 0;
exist = 0;
for i=1:length(city(:,1)),
    for j=1:length(city(i,:)),
        if isspace(city(i,j)) && (j < length(city(i,:)))
            if ~isspace(city(i,j+1))
                len = len + 1;
            end
        else
            len = len + 1;
        end
    end
    if len > 10
        count = count+1;
    end
    len = 0;
end
fprintf('Task 4: %d cities in the database have names longer than 10 characters.\n\n', count);

%% Task 5
avg_of_each_row=sum(wind')./12;
[y imax]=max(avg_of_each_row);
[y imin]=min(avg_of_each_row);
fprintf('Task 5: %s experiences the most wind while %s experiences the least wind.\n\n',deblank(city(imax,:)),deblank(city(imin,:)));


%% Task 6
percent = length(find(avg_of_each_row>8))/length(avg_of_each_row);
fprintf('Task 6: %2.0f percent of cities have yearly wind speed greater than 8 mph.\n\n', percent*100);


%% Task 7

for i=1:length(wind(:,1)),
    percent(i)=length(find(wind(i,:)>8))/12;
end
[y imax]=max(percent);
fprintf('Task 7: %s has the highest percentage of months with wind speed greater than 8 mph. %d percent.\n\n',deblank(city(imax,:)),percent(imax)*100)


%% Task 8
month = {'January' 'February' 'March' 'April' 'May' 'June' 'July' 'August' 'September' 'October' 'November' 'December'};
[max_of_each_city month_index]=max(solar');
[max_month city_index]=max(max_of_each_city);
fprintf('Task 8: %s has the greatest monthly solar insolation in %s.\n\n', deblank(city(city_index,:)), month{month_index(city_index)} );


%% Task 9
avg_of_each_row=sum(solar')./12;
num_cities = length(find(avg_of_each_row>4));
fprintf('Task 9: %d cities have solar insolation greater than 4 kW per square meter.\n\n', num_cities);


%% Task 10
[solar_july ijuly] = max(solar(:,7));
[solar_dec idec] = max(solar(:,12));
fprintf('Task 10: %s has the largest solar insolation in July, while %s has the largest in December.\n\n',deblank(city(ijuly,:)),deblank(city(idec,:)));

%% Task 11
city_index=1:length(wind(:,1));
avg_wind = sum(wind')./12;
avg_solar = sum(solar')./12;
wind_for_city_with_solar = avg_wind(avg_solar>4);
iwind_for_city_with_solar=city_index(avg_solar>4);

damage = wind_for_city_with_solar(wind_for_city_with_solar>3);
damage_index = iwind_for_city_with_solar(wind_for_city_with_solar>3);

[y1 i1]=max(damage);
fprintf('Task 11: In order of likeliness to damage solar panels: ');
fprintf('%s, ', deblank(city(damage_index(i1),:)));

damage2=damage(damage ~= y1);
[y2 i2]=max(damage2);
fprintf('%s, ', deblank(city(damage_index(i2),:)));

damage3=damage2(damage2 ~= y2);
[y3 i3]=max(damage3);
fprintf('%s.\n\n', deblank(city(damage_index(i3),:)));

%% Task 12
precip_feb = precip(:,2)*10*1550.0031; % 10 square meter * 1550.0031 square inch/square meter
precip_aug = precip(:,8)*10*1550.0031;

[yfeb ifeb] = max(precip_feb); 
[yaug iaug] = max(precip_aug);
p2_feb = precip_feb(precip_feb ~= yfeb);
p2_aug = precip_aug(precip_aug ~= yaug);
[yfeb ifeb2] = max(p2_feb); 
[yaug iaug2] = max(p2_aug);

p3_feb = p2_feb(p2_feb ~= yfeb);
p3_aug = p2_aug(p2_aug ~= yaug);
[yfeb ifeb3] = max(p3_feb); 
[yaug iaug3] = max(p3_aug);

fprintf('Task 12: %s, %s, and %s experiences the most rain in February while %s, %s, and %s experience the most rain in August.\n\n',deblank(city(ifeb,:)),deblank(city(ifeb2,:)),deblank(city(ifeb3,:)),deblank(city(iaug,:)),deblank(city(iaug2,:)),deblank(city(iaug3,:)))

%% Task 13
myPrecip = precip; % don't mess with the data, so create a copy
myPrecip(wind < 3) = myPrecip(wind < 3)*0.95;
myPrecip(wind >= 3 & wind <= 5 ) = myPrecip(wind >= 3 & wind <= 5 )*0.9;
myPrecip(wind > 5) = myPrecip(wind > 5)*0.7;

[y i]=max(sum(myPrecip'));

fprintf('Task 13: Accounting for loss due to strong wind, %s collects the most rainwater in a year.\n\n', deblank(city(i,:)));


%% Task 14
sol_avg = sum(solar')/12;
win_avg = sum(wind')/12;
pre_avg = sum(precip')/12;

% set cities with no solar panels installed to 0
sol_avg(sol_avg <= 4) = 0;
% set cities with no wind problem (no strong wind) to 0
win_avg(win_avg <= 3) = 0;
% set cities with not enough rain to 0
pre_avg(pre_avg <= 3) = 0;

% The none zero entries are cities with solar panels installed, and have
% wind problem, and have rain problem
% This variable contains a bunc of indexes (between 1 to 54) of cities that
% might have solar panels damaged due to wind and rain
damage_index = find(sol_avg & win_avg & pre_avg);

% for these cities, we will rank them using precipitation
pre_avg = pre_avg(damage_index);
[pre_avg_top city1] = max(pre_avg);

pre_avg(pre_avg == pre_avg_top) = 0;
[pre_avg_second city2] = max(pre_avg);

pre_avg(pre_avg == pre_avg_second) = 0;
[pre_avg_third city3] = max(pre_avg);

fprintf('Task 14: In order of likeliness to have solar panels damaged due to rain: %s, %s, and %s.\n\n',deblank(city(damage_index(city1),:)),deblank(city(damage_index(city2),:)),deblank(city(damage_index(city3),:)));


%% Task 15
tot_sol_pow = sum(solar');
tot_win_pow = (sum(wind')./3)*1.8;

num_win_cities = length(find(tot_sol_pow <= tot_win_pow));
num_sol_cities = length(find(tot_sol_pow > tot_win_pow));

fprintf('Task 15: %d cities should install wind turbines.\n\n', num_win_cities);


%% Task 16
% The task should read: "...average monthly solar..."
tot_sol_pow = sum(solar');
tot_win_pow = (sum(wind')./3)*1.8;
avg_sol_pow = tot_sol_pow./12;

num_cities_both = length(find((tot_sol_pow <= tot_win_pow) & (avg_sol_pow > 4)));

fprintf('Task 16: %d cities should install both solar panels and wind turbines.\n\n', num_cities_both);


%% Task 17
tot_sol_pow = sum(solar');
tot_win_pow = (sum(wind')./3)*1.8;

index_unsuitable = find(tot_sol_pow < 40 & tot_win_pow < 40);
num_unsuitable = length(find(tot_sol_pow < 40 & tot_win_pow < 40));

fprintf('Task 17: %d city (cities) are UNSTUIABLE to use both wind and solar power.', num_unsuitable);

for i=1:num_unsuitable,
    fprintf(' %s, ', deblank(city(index_unsuitable(i),:)) );
end
fprintf('.\n\n');

%% Task 18
tot_sol_pow = sum(solar');
tot_win_pow = (sum(wind')./3)*1.8;

num_suitable = length(find(tot_sol_pow > 55 | tot_win_pow > 70));

fprintf('Task 18: %d cities are SUITABLE for at least one type of renewable energy.\n\n', num_suitable);


%% Task 19
tot_sol_pow = sum(solar');
tot_win_pow = (sum(wind')./3)*1.8;

num_suitable_one_type = length(find(xor(tot_sol_pow > 55,tot_win_pow > 70)));

fprintf('Task 19: %d cities are SUITABLE for ONLY ONE type of renewable energy.\n\n', num_suitable_one_type);

%% Task 20
tot_sol_pow = sum(solar');
tot_win_pow = (sum(wind')./3)*1.8;

num_adq_one_type = length(find((tot_sol_pow>= 40 & tot_sol_pow <= 55) | (tot_win_pow>= 40 & tot_win_pow <= 70)));

fprintf('Task 20: %d cities are ADEQUATE for at least one type of renewable energy.\n\n', num_adq_one_type);

%% Task 21
tot_sol_pow = sum(solar');
tot_win_pow = (sum(wind')./3)*1.8;

num_adq_both = length(find((tot_sol_pow>= 40 & tot_sol_pow <= 55) & (tot_win_pow>= 40 & tot_win_pow <= 70)));

fprintf('Task 21: %d cities are ADEQUATE for at both solar and wind power.\n\n', num_adq_both);


%% Task 22
fprintf('Task 22: see plots\n\n');
city_name = 'Miami';
city_len = length(city_name);
start_ind = strfind(reshape(city(:,1:city_len)',1,city_len*length(city(:,1))),city_name);
row_ind = round(start_ind/city_len);
figure
hold
plot(solar(row_ind,:),'r-.','Linewidth', 2.5)
plot(precip(row_ind,:),'r:','Linewidth', 2.5)
title(strcat('Sunlight and Precipitation for ',city_name))
legend('Solar', 'Precipitation')
hold

city_name = 'Seattle';
city_len = length(city_name);
start_ind = strfind(reshape(city(:,1:city_len)',1,city_len*length(city(:,1))),city_name);
row_ind = round(start_ind/city_len);
figure
hold
plot(solar(row_ind,:),'-.','Linewidth', 2.5)
plot(precip(row_ind,:),':','Linewidth', 2.5)
title(strcat('Sunlight and Precipitation for ',city_name))
legend('Solar', 'Precipitation')
hold

city_name = 'Boston';
city_len = length(city_name);
start_ind = strfind(reshape(city(:,1:city_len)',1,city_len*length(city(:,1))),city_name);
row_ind = round(start_ind/city_len);
figure
hold
plot(solar(row_ind,:),'m-.','Linewidth', 2.5)
plot(precip(row_ind,:),'m:','Linewidth', 2.5)
title(strcat('Sunlight and Precipitation for ',city_name))
legend('Solar', 'Precipitation')
hold


%% Task 23

% See "sum_square.m" file
fprintf('Task 23: see sum_square.m\n\n');

%% Task 24

correlation = sum_square(solar, precip)./sqrt(sum_square(solar,solar).*sum_square(precip,precip));

[y i]=min(correlation);

fprintf('Task 24: Top three cities whose correlation between precipitation and solar dataset closest to -1:\n');
fprintf('%s\n', deblank(city(i,:)));

correlation(correlation == y) = 1;
[y i]=min(correlation);
fprintf('%s\n', deblank(city(i,:)));

correlation(correlation == y) = 1;
[y i]=min(correlation);
fprintf('%s\n', deblank(city(i,:)));
