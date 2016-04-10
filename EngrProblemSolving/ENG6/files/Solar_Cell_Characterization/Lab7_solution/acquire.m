% ENG 6
%
% Lab 7 Solution
%
%
%

clear all

% Task 1
arduino_obj = arduino('COM21');

% Task 2
arduino_obj.pWrite(0,128);
pause(0.1);

% Task 3
arduino_obj.pWrite(1,255);
pause(0.1);

% Task 4
for i=1:255,
    % Step 1)
    data_point = arduino_obj.analogRead(0);
    
    % Step 2)
    data_voltage = data_point*5/1024;
    
    % Step 3)
    solar_cell_dat(i) = data_voltage;
    pause(0.1);
end

% Task 5
plot([1:255], solar_cell_dat);

% Task 5.5
xlabel('Sample number');
ylabel('Solar cell output voltage');
title('Solar cell output voltage sampled 256 times');

% Task 6
delete(arduino_obj);

