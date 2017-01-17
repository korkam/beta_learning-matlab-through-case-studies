% this is a script to analyze wind power production at a given site

% Copyright 2013-2016 The MathWorks, Inc.

%% import data
importWindData
%% clean up data
AllSpeeds = [Speed1, Speed2, Speed3]
AvgSpeed = mean(AllSpeeds,2);
IdxIceTemp = Temp <2;
IdxIceSpeed = AvgSpeed < 1;
IdxIce = IdxIceTemp & IdxIceSpeed;
%% visualize data
scatter(Temp,AvgSpeed)
hold on
scatter(Temp(IdxIce),AvgSpeed(IdxIce),'r')
AvgSpeed(IdxIce) = [];
histogram(AvgSpeed)