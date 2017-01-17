function windData = WindAnalysisFcn2(filename)
%% Wind Turbine Data Analysis
% This demo analyzes wind data measured on a meteorological observation
% tower to see if the location is a good prospect for a wind turbine. Data
% is from three different wind sensors at 80m. Temperature is also recorded
% at 3m height.  Data is logged every hour.

% Copyright 2013-2016 The MathWorks, Inc.

%% Handle No-Input Case
if nargin == 0
  % If user doesn't supply a file name, request one
  [fname, pname] = uigetfile('*.txt');
  filename = fullfile(pname, fname);
  
else
  % Check to make sure input is a string
  validateattributes(filename, {'char'}, {'row'})
  
  % Check to make sure file exists
  if ~exist(filename, 'file')
    error('File "%s" cannot be found', filename);
  end
end

%% Read in Turbine Data from Text File

% Function autogenerated from import tool
[~, fname, ~] = fileparts(filename);
[Time,Speed1,Speed2,Speed3,Temp] = importWindDataFcn(filename);

%% Average Wind Speed for Different Sensors
AvgSpeed = mean([Speed1 Speed2 Speed3],2);

%% Determine Icing Conditions
% Remove any readings effected by icing which results in extremely
% inaccurate values biased towards zero.  Icing conditions are when
% tavg < tIce and vavg < vIce.

IceTemp = 2;
IceSpeed = 1;

% Comparing to the critical values
idxIceTemp = Temp < IceTemp;
idxIceSpeed = AvgSpeed < IceSpeed;

idxIce = idxIceTemp & idxIceSpeed;

% Remove values related to icing
Time(idxIce) = [];
Temp(idxIce) = [];
AvgSpeed(idxIce) = [];

%% Distribution of Wind Speeds at Hub Height
% Use a weibull distribution to fit the distribution of wind speeds which
% is known to often give a good fit to wind speed distributions.

dv = 0.5;

% Calculate probability of wind speed range
[ProbSBins,SpeedBinEdges] = histcounts(AvgSpeed,...
    'BinWidth',dv,'Normalization','probability');
SpeedBins = SpeedBinEdges(1:end-1) + dv/2;

%% Defining the Turbine Power Curve
% To calculate average turbine power and capacity factor, we need to make
% some assumptions regarding the wind turbine model and its power curve.
% We will assume a 1MW wind turbine and the following turbine power
% curve.

% Turbine power curve coefficents
PRated = 1e6;     % wind turbine rated power (W)
SIn = 2;          % cut-in speed (m/s)
SR = 14;          % rated output speed (m/s)
SOut = 25;        % cut-out speed (m/s)

% Calculating power curve
PowerSBins = PRated * (SpeedBins.^2-SIn^2) / (SR^2-SIn^2);
PowerSBins(SpeedBins <= SIn) = 0;
PowerSBins(SpeedBins > SOut) = 0;
PowerSBins(SpeedBins >= SR & SpeedBins <= SOut) = PRated;

%% Calculating Average Turbine Power and Capacity Factor
% Capacity factor is ratio of the actual output of a turbine over a period
% of time and its potential output if it had operated at full capacity the
% entire time. Typical capacity factor range from 20-�50% depending on
% location and wind turbine.

% Integrate power at given velocity * velocity probability distribution
% function over range of possible velocities

% Calculate average power by summing the products of vel probability and power
AvgPower = sum(ProbSBins .* PowerSBins);    % (W)

% Calculating capacity factor (average power / rated power)
cf = AvgPower / PRated;

disp(['Assumed wind turbine rated power (MW): ' num2str(PRated/1e6)])
disp(['Averaged turbine power (kW): ' num2str(AvgPower/1e3)])
disp(['Capacity factor (%): ' num2str(cf*100)])

%% Combine into a Structure
% We will combine the information into a structure for easy data
% management.

windData.date     = Time;
windData.temp     = Temp;
windData.avgSpeed = AvgSpeed;
windData.avgPower = AvgPower;
windData.cf       = cf;
windData.filename = fname;
