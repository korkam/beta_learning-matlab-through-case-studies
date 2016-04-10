% Logic, Flow control, and Loops Lab Solutions
%
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

%
% Problem 1: Savings from Solar Energy
% 
% Task 1
clear all; clc;
conditions = [1 1 1 2 2 3 3 3 4 4 4 4 3 3 1 3 2 1];
power = [20 30 50 120];

totalpower_per_panel = 0;
for i=1:length(conditions)
    totalpower_per_panel = totalpower_per_panel + power(conditions(i))*1;
end
totalpower_array = (350*totalpower_per_panel)/1000;
disp('The total energy (kWh) produced by the solar panel array is ');
disp(totalpower_array);
%
% Task 2
savings = [.00009 .0002 .0009 0.0016];
totalsavings_per_panel = 0;
for i=1:length(conditions)
    totalsavings_per_panel = totalsavings_per_panel + power(conditions(i))*1*savings(conditions(i));
end
totalsavings_array = 350*totalsavings_per_panel;
disp('The total savings ($) is ');
disp(totalsavings_array);
%
% Task 3
cloudypower = [.5*20 .5*30 .7*50 .7*120];
totalcloudypower_per_panel = 0;
for i=1:length(conditions)
    totalcloudypower_per_panel = totalcloudypower_per_panel + cloudypower(conditions(i))*1;
end
totalcloudypower_array = (350*totalcloudypower_per_panel)/1000;
disp('The total energy (kWh) produced on a cloudy day is ');
disp(totalcloudypower_array);
%
% Task 4
totalcloudysavings_per_panel = 0;
for i=1:length(conditions)
    totalcloudysavings_per_panel = totalcloudysavings_per_panel + cloudypower(conditions(i))*1*savings(conditions(i));
end
totalcloudysavings_array = 350*totalcloudysavings_per_panel;
disp('The total savings ($) on a cloudy day is ');
disp(totalcloudysavings_array);
%
%
%
%
% Problem 2: Solar Panel Rental
%
% Task 1
clear all; 
energy_per_month = [200 170 150 260 20 430 300 320 310 460 310 370 380 50 430 180 400];
energyavailable_for_sale = 400 - energy_per_month;
monthlyrevenue_total = 0;
for i=1:length(energy_per_month)
    monthlyrevenue_per_customer = 0;
    % If energy available for sale is negative, the company only makes
    % money from rental fee
    if (energyavailable_for_sale(i) > 0) 
        monthlyrevenue_per_customer = 20 + energyavailable_for_sale(i)*.05;
    else
        monthlyrevenue_per_customer = 20;
    end
    monthlyrevenue_total = monthlyrevenue_total + monthlyrevenue_per_customer;
end
disp('The company total monthly revenue ($) is ');
disp(monthlyrevenue_total);
%
% Task 2
months = 0;
revenue = 0;
while (revenue < 100000)
    revenue = revenue + monthlyrevenue_total;
    months = months + 1;
end
disp('The number of months to break even is ');
disp(months);
%
%
%
%
% Problem 3: Solar Array Sizing
%
% Task 1
clear all; 
budget = 10000;
price_per_panel = 50;
discount = [0 0.1 0.15 0.2];
num_panels = 1;
cost = 0;
while(cost < budget)
    if(num_panels >= 1 & num_panels <=5)
        current_discount = discount(1);
    elseif(num_panels >= 6 & num_panels <=29)
        current_discount = discount(2);
    elseif(num_panels >= 30 & num_panels <=99)
        current_discount = discount(3);
    else
        current_discount = discount(4);
    end
    
    cost = cost+num_panels*price_per_panel*(1-current_discount);
    
    num_panels = num_panels+1;
end
disp('The number of solar panels the customar can afford is');
disp(num_panels);
%
% Task 2
% The constraints for this task has changed from cost to power.
% Only two lines have changed in the code from Task 1, they are denoted
% with '**'
peak_power = 50000;
panel_power = 40;
generated_power = 0;
num_panels = 1;
cost = 0;
while(generated_power < peak_power) % ** Change 1
    if(num_panels >= 1 & num_panels <=5)
        current_discount = discount(1);
    elseif(num_panels >= 6 & num_panels <=29)
        current_discount = discount(2);
    elseif(num_panels >= 30 & num_panels <=99)
        current_discount = discount(3);
    else
        current_discount = discount(4);
    end
    
    cost = cost+num_panels*price_per_panel*(1-current_discount);
    generated_power = generated_power+num_panels*40; % ** Change 2
    
    num_panels = num_panels+1;
end
disp('The number of solar panels the customar will need is');
disp(num_panels);
disp('The cost to make his business 100% off the grid is');
disp(cost);
%
%
%
%
% Problem 4: Financing for Solar Power
%
% Task 1
clear all; 
principal = 50000;
total_amount = principal;
rate = 0.01;
num_years = 30;
for i=1:num_years,
    total_amount = total_amount + total_amount*rate;
end
disp('The total amount (principal+interest) the customer will have paid back at the end of the loan duration is:');
disp(total_amount);
% Task 2
A = principal * (1+rate)^num_years;
disp('The total amount calculated using the compound interest formula is')
disp(A);
% Task 3
monthly_payment = A/(num_years*12);
disp('The average monthly payment is');
disp(monthly_payment);
% Task 4
monthly_principal = principal/(num_years*12);
monthly_interest = monthly_payment - monthly_principal;
disp('The average interest paid every month is');
disp(monthly_interest);

%
%
%

% Problem 5: Modeling Solar Cell using Taylor Series
%
% Task 1
clear all; 
Ilight = 500*10^-3;
Idark = .6*10^-6;
Vt = 26*10^-3;
V=0.3;
I_calc = Ilight + Idark - Idark*exp(V/Vt);
taylor_approx = 1;
x = V/Vt;
for i=1:5
    taylor_approx = taylor_approx + (x^i)/factorial(i);
    Isolar = Ilight + Idark - Idark*taylor_approx;
end
disp('5 terms of Taylor series approximation of the solar panel current (at V=0.3) is');
disp(Isolar);

%
% Task 2
taylor_approx = 1;
x = V/Vt;
for i=1:20
    taylor_approx = taylor_approx + (x^i)/factorial(i);
    Isolar = Ilight + Idark - Idark*taylor_approx;
end
disp('20 terms of Taylor series approximation of the solar panel current (at V=0.3) is');
disp(Isolar);
%
% Task 3
clear taylor_approx Isolar;
x = V/Vt;
newest_term=1; i=1;
while (newest_term > .001)
    newest_term=(x^i)/factorial(i);
    i=i+1;
end
disp('The number of iterations to reach an approximation term smaller than 0.0001 is')
disp(i-1)

%
% Task 4
clear taylor_approx Isolar;
taylor_approx = 1;
x = V/Vt;
newest_term=1; i=1; error=1;
while (error > .01)
    newest_term=(x^i)/factorial(i);
    taylor_approx = taylor_approx + newest_term;
    Isolar(i) = Ilight + Idark - Idark*taylor_approx;
    error = abs((I_calc-Isolar(i))/I_calc);
    i=i+1; 
end
disp('The number of iterations to reach an approximation error smaller than 1 percent is')
disp(i-1)
%
%
%
%
% Problem 6: Investing in Solar Power
%%
% Task 1
clear all; 
curr_month = 1;
cost_per_watt_solar= 0.22;
cost_per_watt_elec = 0.07
solar_rate = -0.05;
elec_rate = 0.02;
while cost_per_watt_solar > cost_per_watt_elec
    
    if(mod(curr_month,3) == 0) % For solar power, update cost/watt every three months
        cost_per_watt_solar = cost_per_watt_solar+cost_per_watt_solar*solar_rate;
    elseif(mod(curr_month,9) ==0 )% For conventional electricity, update cost/watt every nine months
        cost_per_watt_elec = cost_per_watt_elec+cost_per_watt_elec*elec_rate;
    end
    
    curr_month=curr_month + 1;
end
disp('The number of months it takes for solar to become comparable to conventional electricity is');
disp(curr_month-1);

%%
% Task 2
amount = 10000;
goal = 20000;
price = 19.23;
num_shares = 520;
curr_month = 1;
while (amount < goal)

    if(mod(curr_month,3) == 0)
        growth = amount*0.04;
        amount = amount+ growth;

    end
    
    curr_month=curr_month+1;
end
disp('The number of months it takes for the investment to double, or $20000');
disp(curr_month-1);
%
%%
%
%
% Problem 7: Electric Vehicle Issues
%
% Task 1
clear all; 
format short g;
num_recharge = [0 0 0 0];
for i=1:31,
    if(mod(i,4)==0) % EV2
        num_recharge(2)=num_recharge(2)+1;
    elseif(mod(i,3)==0) % EV3
        num_recharge(3)=num_recharge(3)+1;
    elseif(mod(i,2)==0) % EV4
        num_recharge(4)=num_recharge(4)+1;
    else % EV1
        num_recharge(1)=num_recharge(1)+1;
    end
end
disp('The total number of times the four EV recharges is');
disp(sum(num_recharge));

% Task 2
num_vehicles = 1e6*[16 27 1 4];
load = sum(num_recharge .* num_vehicles * 2);
disp('The additional load on the power grid (mega watts) is ');
disp(load/1000);
%
% Task 3
range = [117 370 200 190];
range_per_kwh = range./24;
disp('The range per kWh for each vehicle is');
disp(range_per_kwh);
%
% Task 4
solar_area = [6 8 4 8];
power_per_area = [200 500 400 700];
hours_active = [8 3 4 6];
solar_power = solar_area.*power_per_area.*hours_active;
new_range = range + range_per_kwh.*solar_power./1000;
new_range_per_kwh = new_range./24;
disp('The new range per kWh for each vehicle is');
disp(new_range_per_kwh);


%
% Solution to Problem 8 for Lab Quiz 4-5
%

clear all

% Task 0: Import all variables
load illum.mat


% Task 1:
plot(illumination(:,1),illumination(:,2:6));
title('Current vs. Illumination across 5 trials')
xlabel('Illumination (Lux)');
ylabel('Electronic Current (Ampere)');
legend('Trial 1', 'Trial 2', 'Trial 3', 'Trial 4', 'Trial 5');

%% Task 2 to  9
Nrow = 35;
Ncol = 1;
    

% Iterate through all time points.
for i=1:length(load_profile),
    
    % Look-up the current that corresponds to the illumination condition
    for j=1:length(illumination),
        if(illumination(j,1) == illumination_profile(i))            
            % Calculate the average current.
             i_Light = 0;
             for k=2:6,
                 i_Light = i_Light + illumination(j,k);
             end
             i_Light = i_Light/length(k);
        end
    end
    
    % At this point, we have 'i_Light', which is the current that corresponds 
    % to the current illumination condition, 'illumination_profile(i)'

    % Calculate Vmp and Imp that corresponds to i_Light
    % -- This is the maximum amount of power available from the solar
    % panel under illumination that gives 'i_Light'.
    [vmp imp] = panel_mpp(i_Light, Nrow, Ncol);

    % Calculate what is actually delivered.
    vpd = pd( i_Light )*Nrow;
    ipd = vpd / load_profile(i);    
    
    p_u(i) = vpd*ipd;
    p_r(i) = vmp*imp;
end

% Task 10
figure
hold
plot(1:length(load_profile),p_u,'r:');
plot(1:length(load_profile),p_r,'b-');
title('Regulated and unregulated power delivered to load');
xlabel('Time steps');
ylabel('Power (Watt)');
legend('Unregulated','Regulated')
hold


