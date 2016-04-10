% 1D Vector Lab Solution 
%
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


% Problem 1: Solar Radiation Spectrum Modeling
%
clear all; clc;
% (1)
nanometers = [0:2:2000];
meters = nanometers.*(10^-9);
T = 5700;
c = 3*10^8;
h = 6.63*10^-34;
k = 1.38*10^-23;
radiance = (2*pi*c^2*h)./(meters.^5) .* (exp((h*c)./(meters.*k*T))-1).^(-1);
plot(nanometers, radiance);
xlabel('Nanometers');
ylabel('Spectral Radiance');
title('Spectral Radiance of a Black Body versus Wavelength');
%
% (2)
[maximum maxlocation] = max(radiance);
maxwav = meters(maxlocation);
disp('The wavelength that gives maximum radiance is');
disp(maxwav);
%
% (3)
T1 = 450*10^(-12);
    kilometers = [5000:1:10000];
    meters = kilometers.*(10^3);
    radiance1 = (2*pi*c^2*h)./(meters.^5) .* (exp((h*c)./(meters.*k*T1))-1).^(-1);
    figure
    plot(kilometers, radiance1); title('Temperature 1: 450 pico Kelvin');
    [max1 loc1] = max(radiance1);
    disp('The wavelength (in kilometers) that gives maximum radiance for T1 = 450 pico Kelvin is');
    disp(kilometers(loc1));
T2 = 3*10^(9);
    nanometers = [0:10^-6:10*10^-3];
    meters = nanometers.*(10^-9);
    radiance2 = (2*pi*c^2*h)./(meters.^5) .* (exp((h*c)./(meters.*k*T2))-1).^(-1);
    figure
    plot(nanometers, radiance2); title('Temperature 2: 3 giga Kelvin');
    [max2 loc2] = max(radiance2);
    disp('The wavelength (in nanometers) that gives maximum radiance for T2 = 3 giga Kelvin is');
    disp(nanometers(loc2)); 
T3 = 350*10^(6);
    nanometers = [0:10^-6:20*10^-3];
    meters = nanometers.*(10^-9);
    radiance3 = (2*pi*c^2*h)./(meters.^5) .* (exp((h*c)./(meters.*k*T3))-1).^(-1);
    figure
    plot(nanometers, radiance3); title('Temperature 3: 350 mega Kelvin');
    [max3 loc3] = max(radiance3);
    disp('The wavelength (in nanometers) that gives maximum radiance for T3 = 350 mega Kelvin is');
    disp(nanometers(loc3)); 
    
T4 = 350*10^9;
    nanometers = [0:10^-9:20*10^-6];
    meters = nanometers.*(10^-9);
    radiance4 = (2*pi*c^2*h)./(meters.^5) .* (exp((h*c)./(meters.*k*T4))-1).^(-1);
    figure
    plot(nanometers, radiance4); title('Temperature 4: 350 giga Kelvin');
    [max4 loc4] = max(radiance4);
    disp('The wavelength (in nanometers) that gives maximum radiance for T4 = 350 giga Kelvin is');
    disp(nanometers(loc4));
    
%
%
% Problem 2: Rainwater Storage System
clear all;
% Task 1: Enter data into MATLAB as vectors
precip_inches = [4.5 4.61 3.26 1.46 0.7 0.16 0 0.06 0.12 1.12 3.16 4.56];
% Task 2: Convert precipitation data from inches to meters
% Task 3: Calculate the amount of rainfall in a year
precip_meters = precip_inches.*2.54*(1/100);
land_area = 121*1000;
volume_rain = precip_meters.*land_area;
totalvolume_m = sum(volume_rain);
totalvolume_liters = totalvolume_m*(1/.001);
totalvolume_gallons = totalvolume_liters*(1/3.78);
disp('Total volume (in liters) in a year is'); disp(totalvolume_liters);
disp('Total volume (in gallons) in a year is'); disp(totalvolume_gallons);
% Task 4: First convert the given area from feet into meters. Then
% calculate the amount of rainfall inside that area.
new_area = 10*(12)*(2.54)*(1/100)*30*(12)*(2.54)*(1/100);
volume_smaller = precip_meters.*new_area;
volume_sm_m = sum(volume_smaller);
volume_sm_liters = volume_sm_m *(1/.001);
volume_sm_gallons = volume_sm_liters*(1/3.78);
disp('Total volume (in liters) in a year for the smaller system is'); disp(volume_sm_liters);
disp('Total volume (in gallons) in a year for the smaller system is'); disp(volume_sm_gallons);
% Task 5: Enter the usage into a vector
avg_usage = [8.8 10.0 8.2 0.7 1.2 4.0 10.8 1.6];
avg_usage_liters = avg_usage.*3.78;
% Task 6: yearly usage for each activity
avg_yearly_usage_liters = avg_usage_liters.*365;
% Task 7: Calculate the amount of water one person uses in a year.
total_avg_yearly_usage_liters = sum(avg_yearly_usage_liters);
disp('Water usage (liters) for one person'); disp(total_avg_yearly_usage_liters);
% Task 8: Calculate the amount of water 5 people use in a year.
total_vol_water = 5*total_avg_yearly_usage_liters;
disp('Water usage (liters) for five people'); disp(total_vol_water);
%
%
% Problem 3: Degree-day Calculation
clear all;
% Task 1: Enter all data into MATLAB as vectors
coolingdegreedays = [19 26 56 22 5 0 0 2 4 3 9 14]; %san francisco
days_per_month = [31 28 31 30 31 30 31 31 30 31 30 31];
% Task 2: Using cooling degree days to calculate the average temperature
avgtemp_month = coolingdegreedays./days_per_month + 65;
disp('The average temperature per month is'); disp(avgtemp_month);
%
%
% Problem 4: Ventilation System Design
clear all; 
% Task 1: Enter all data into vectors
length = [65 20 113 20 50 15];
width = [50 19 50 30 50 20];
height = [35 10 60 10 20 8];
airchanges = [12 12 10 5 15 10];
fantype3 = [14 1600 1050 3.5];
% Task 2: calculate  the number of fans according to the formula given on
% the lab handout.
volumeperhour = length.*width.*height.*airchanges;
cfm_hour = fantype3(2)*60;
number_of_fans = volumeperhour./cfm_hour;
disp('The number of fans needed in each location is'); disp(number_of_fans);
% Task 3: The power required for each location is simply the voltage times
% current times the number of fans used.
power = fantype3(4)*115.*number_of_fans;
disp('The amount of power needed at each location is'); disp(power);
% Task 4: The noise is simply 3 dB times the revolution increment (num
% rev./300) * number of fans used
noise = 3.*fantype3(3)./300.*number_of_fans;
disp('The amount of noise at each location is'); disp(noise);
% Task 5: Calculate the figure of merit for each fan type.
blade = [10 12 14 16 18 20];
cfm = [695 1025 1600 1200 3075 3275];
rpm = [1550 1550 1050 1550 1050 1075];
current = [1.8 1.8 3.5 3.5 3.5 3.5];
fom = cfm./(blade.*rpm.*current);
[fan_max loc] = max(fom);
disp('The fan with the largest FOM is fan number...'); disp(loc);
% Task 6: Modified FOM.
fom2 = cfm./(blade.*rpm.*rpm.*current);
[fan_max loc] = max(fom2);
disp('Now, the fan with the largest FOM is fan number...'); disp(loc);
%
%
% Problem 5: Solar Power on Satellite
clear all; 
% Task 1: Enter data into vector. Divide 1 metric ton (1000 kg) by the
% individual weight of each solar panel type.
panel_weight = [10 19.5 7 8];
numberofpanels = 1000./panel_weight
disp('The number of panels that can fit on the satellite is'); disp(numberofpanels);
% Task 2: Take the number of panels and multiply it by the power per panel
power = [60 240 60 72];
totalpower = power.*numberofpanels;
disp('The amount of power available is'); disp(totalpower);
% Task 3: Take the number of panels and multiply it by the cost per panel.
cost = [150 200 150 100];
totalcost = cost.*numberofpanels;
disp('The cost to use each type of panel is'); disp(totalcost);
% Task 4: Divide watts by the total cost for using the number of panels
% calculated in Task 1.
wattsperdollar = totalpower./totalcost;
disp('The watts-per-dollar metric for each panel is'); disp(wattsperdollar);
% Task 5: Now re-calculate the number of panels that you can use based on
% the 200 square meter constraint.
panelarea = [10 15 6 10];
numberofpanels = 200./panelarea
% Re-calculate the total power. Re-calculate the total cost. Divide the
% total power by total cost to obtain the new watt-per-dollar metric.
% watt-per-dollar metric here is still the same as before. It is
% independent of the number of panels used.
totalpower = power.*numberofpanels;
totalcost = cost.*numberofpanels;
wattsperdollar = totalpower./totalcost;
disp('The new watts-per-dollar metric for each panel is'); disp(wattsperdollar);
%
%
% Problem 6: Renewable Gym
clear all; 
% Task 1: Enter all data into vectors. The total energy generated is simply
% the number of units times the power per unit times the usage (in hours)
units = [20 15 15 20 10];
power = [500 500 300 200 100];
usage = [500 200 300 700 200];
electricity = units.*power.*usage./60;
totalenergy = sum(electricity);
disp('The total energy is'); disp(totalenergy);
% Task 2: Multiply the price per watt by the number of watts generated.
profitperday = totalenergy*.0001;
disp('The gym makes this amount of money in a month, assuming 30 days to a month');
disp(profitperday*30);
% Task 3: Calculate the cost of electricity, and profits from selling
% electricity for 30 days; then divide the difference by 500 members, which
% gives the new electricity cost. Add the new electricy cost back to the
% %65 of the $59 membership fee.
electricitycost = 59*.35*500;
newtotalcost = electricitycost-profitperday*30;
newcostpermember = newtotalcost/500;
newmemberprice = 59*.65+newcostpermember;
disp('The new membership price is'); disp(newmemberprice);
%
%
% Problem 7: Smart Batteries
clear all;
% Task 1: Enter the table data into vectors. Then calculate the energy per
% hour by dividing the battery capacity by the lifetime. (lifetime should be in hours)
batt_cap = [1500 2500 3000 2700 2000];
lifetime = [0.8 1.5 4.2 2.3 1.8];
lifetime_hours = lifetime.*24;
energyperhour = batt_cap./lifetime_hours;
disp('The energy per hour for each phone is'); disp(energyperhour);
% Task 2: The new life time is re-calculated by reducing the battery
% capacity. Then dividing the reduced capacity by the energy per hour (usage)
new_cap = batt_cap.*0.9;
new_lifetime = new_cap./energyperhour;
disp('The new lifetimes (in days) are'); disp(new_lifetime./24);
% Task 3: The harvested energy for 10 minutes is simply the current times
% the time (in hours -- hence 10/60)
harvestedenergy = 1*(10/60);
disp('The harvested energy (in mAh) for 10 minutes is'); disp(harvestedenergy);
% Task 4: Life time of smart phone is equal to the reduced battery capacity
% PLUS the harvested energy (1mA times the number of hours energy is
% harvested), divided by energy per hour (which is the usage).
final_lifetime = (batt_cap.*0.8 + 1.*lifetime.*24)./energyperhour;
disp('The final lifetime with the smart battery is (in days)');
disp(final_lifetime./24);
%
%
% Problem 8: Investing in Solar Power
clear all;
% Task 1: Enter all data into vectors
% The current worth of your portfolio is equal to the current price per
% share times the number of shares you own.
shares = [100 70 10 200 30];
purchaseprice = [.88 .56 .12 1.32 2.32];
currentprice = [.96 1.23 .13 3.20 1.98];
disp('Stocks are currently worth'); disp(sum(currentprice.*shares));
% Task 2: The profit or loss is simply the difference between the current
% and purchase price, times the number of shares you own.
profit = sum(shares.*(currentprice-purchaseprice));
disp('The current profit/loss is'); disp(profit);
% Task 3: The broker's fees is first calculated. Then the adjusted profit
% is the original profit subtracted by the broker's fee.
broker = [.012 .008 .003 .018 .011];
broker_fee = sum(shares.*currentprice.*broker)
newprofit = profit - broker_fee;
disp('After the brokers, the profit/loss is'); disp(newprofit);
% Task 4: The amount after taxes and fees to accountant is calculated
% below.
taxedprofit = newprofit*.8 - 100;
disp('After taxes, the profit/loss is'); disp(taxedprofit);
    
    
    
    
    
    
    
    
    