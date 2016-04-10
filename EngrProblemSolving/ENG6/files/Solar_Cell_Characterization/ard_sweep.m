% Copyright (c) 2011, S. Hsu
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

% -- Connect to the Arduino board
a = arduino('COM27') % set it to the correct COM port




%%
% -- Plot the data
Vdd = 5;
N_bits = 10; % ADC resolution
R_limit = 310; % current limiting resistor value
R_wiper = 310; % wiper resistance
R_ab = 10000;
R_step = 43; % 

% voltage of one "least significant bit" of the digital. 
%So this is the voltage that corresponds to "0000000001"
V_lsb = Vdd/(2^N_bits); 

a.pWrite(0,0);    
pause(1)


figure(1)
hold
step=2
for i=0:step:255+255,
    a.pWrite(0,128);    
    a.pWrite(1,128);

    pause(0.05);
    adc_out = a.analogRead(0)
    adc_voltage = adc_out*V_lsb
    R_potentiometer = i*R_step+R_wiper*2;
    solar_voltage = adc_voltage;
    plot( round(i/step), solar_voltage,'r*');% plot voltage
%    plot( solar_voltage, 1000*solar_voltage/(R_potentiometer), 'r*') % plot IV curve. multiply b y 1000 to plot mA
end
disp('DEMO1. End of sweep 1.')
input('PRESS TO CONTINUE TO NEXT SWEEP');





for i=0:step:255+255,
    a.pWrite(0,128);    
    a.pWrite(1,128);

    pause(0.05);
    adc_out = a.analogRead(0)
    adc_voltage = adc_out*V_lsb
    R_potentiometer = i*R_step+R_wiper*2;
    solar_voltage = adc_voltage;
    plot( round(i/step), solar_voltage,'b*');% plot voltage
%    plot( solar_voltage, 1000*solar_voltage/(R_potentiometer), 'r*') % plot IV curve. multiply b y 1000 to plot mA
end
hold
title('DEMO1: Solar cell output voltage at two different lighting conditions.');
ylabel('Solar cell output voltage (V)');
xlabel('Sample Number');
disp('DEMO1. End of sweep 2.')
input('PRESS TO CONTINUE TO DEMO 2\n\n\n');










figure(2)
hold
for i=0:step:255+255,
    if(i < 255)  % 0 - 10K
        a.pWrite(0,i);    
        a.pWrite(1,0);
    else  % 10K - 20K
        a.pWrite(0,255);  
        a.pWrite(1,i-255);
    end
    pause(0.05);
    adc_out = a.analogRead(0)
    adc_voltage = adc_out*V_lsb
    R_potentiometer = i*R_step+R_wiper*2;
    solar_voltage = adc_voltage;
    plot( (R_potentiometer), solar_voltage,'r*');% plot voltage
%    plot( solar_voltage, 1000*solar_voltage/(R_potentiometer), 'r*') % plot IV curve. multiply b y 1000 to plot mA
end
disp('DEMO2. End of sweep 1.')
input('PRESS TO CONTINUE TO CONTINUE');





for i=0:step:255+255,
    if(i < 255)  % 0 - 10K
        a.pWrite(0,i);    
        a.pWrite(1,0);
    else  % 10K - 20K
        a.pWrite(0,255);  
        a.pWrite(1,i-255);
    end
    pause(0.05);
    adc_out = a.analogRead(0)
    adc_voltage = adc_out*V_lsb
    R_potentiometer = i*R_step+R_wiper*2;
    solar_voltage = adc_voltage;
    plot( (R_potentiometer), solar_voltage,'b*');% plot voltage
%    plot( solar_voltage, 1000*solar_voltage/(R_potentiometer), 'b*') % plot IV curve. multiply b y 1000 to plot mA
end
hold
title('DEMO2: Solar cell output voltage at two different lighting conditions.');
ylabel('Solar cell output voltage (V)');
xlabel('Load Resistance (Ohms)');
input('END OF DEMO 4. PRESS TO CONTINUE TO DEMO 5');









% 216 -- gives quals talk. few slides cover power equations. 
% 9am. olsson 144


% picture of solar panel fixture
% solar panel fixture data
%
% schematic of arduino solar module
% BOM
% picture of modules



%%
% -- Close session
delete(a)