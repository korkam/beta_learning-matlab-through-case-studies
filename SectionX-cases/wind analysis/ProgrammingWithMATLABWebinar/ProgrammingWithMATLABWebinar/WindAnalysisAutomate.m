%% Automated Wind Turbine Data Analysis
% Analyzes wind data (from multiple locations) stored in a directory to see
% if the locations are good prospect for a wind turbine.

% Copyright 2013-2016 The MathWorks, Inc.

%% Get List of Files in Directory
% First, we get the list of files from the data directory.

clear

dirname = 'WindDataFiles';
files = dir(fullfile(dirname,'*.txt'));

disp('Files to process')
disp({files.name}')

%% Run Wind Data Analysis
% Then, we loop through each file and perform the analysis, storing the
% results into a structure.

% Pre-allocate results structure
winddata(length(files)) = struct('date',[],'temp',[],'avgSpeed',[],...
    'avgPower',[],'cf',[],'filename',[]);

for ii = 1:length(files)
    
    % Get filename
    filename = fullfile(dirname,files(ii).name);
    
    % Display filename
    disp(' ')
    disp(['Analyzing ' filename])
    
    % Generate and save results
    winddata(ii) = WindAnalysisFcn(filename);
    
    snapnow   % used for publishing
end

%% Conclusion
% Based on the analysis, we can determine which site has the highest
% capacity factor.

% Determine the location with highest capacity factor
allCFPct = [winddata.cf]*100;
[maxCFPct,maxIDX] = max(allCFPct);
[~,loc] = fileparts(winddata(maxIDX).filename);

% Plot capacity factor of each location
figure
bar(allCFPct,'FaceColor',[.25 .25 1],'EdgeColor','none')
set(gca,'YGrid','on')
xlabel('Tower Location')
ylabel('Capacity Factor (%)')
hold on

% Mark the best location with a red color
bar(maxIDX,maxCFPct,'FaceColor',[1 .25 .25],'EdgeColor','none')
text(maxIDX,maxCFPct,'Best Location',...
    'HorizontalAlignment','center','VerticalAlignment','Bottom')

% Output result to screen
disp(' ')
disp([loc ' had the highest capacity factor of ' num2str(maxCFPct) '%']);
disp(['Average power: ' num2str(winddata(maxIDX).avgPower/1e3) ' kW']);

%% Save Output to MAT-File
% Save the results for later use.

save windataAnalysis.mat winddata

