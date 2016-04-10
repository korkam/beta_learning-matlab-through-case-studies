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
a = arduino('COM11') % set it to the correct COM port

%%
% -- Plot the data
Vdd = 3.3;
N_bits = 10; % ADC resolution
R_limit = 5000; % current limiting resistor value
R_wiper = 39; % wiper resistance
R_step = 39; % 10000 ohms/256 steps = resistance per step

% voltage of one "least significant bit" of the digital. 
%So this is the voltage that corresponds to "0000000001"
V_lsb = Vdd/(2^N_bits); 

a.pWrite(-1,128);

figure(1)
hold

j = 255;
for i=1:1000,

    a.pWrite(1,j);    
    
    if mod(i,2) == 0,
        j = j-1;
    end
    
    pause(0.2);

    adc_out = a.analogRead(0);
    adc_voltage = adc_out*V_lsb;

    R_potentiometer = j*(10000-60)/256+R_wiper;
    
    solar_voltage = adc_voltage*(R_potentiometer+R_limit)/(R_potentiometer);
%    plot( j, value_p,'r*');% plot voltage
    plot( solar_voltage, 1000*solar_voltage/(R_potentiometer+R_wiper), 'r*') % plot IV curve. multiply b y 1000 to plot mA
    
end
hold

%%
% -- Close session
delete(a)