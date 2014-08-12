%%% Interactively plot points
%%% to show the correlation between the x and y directions.
%%% By Rajeev Raizada, Jan.2011.
%%% Requires the Matlab statistics toolbox.
%%%
%%% Please feel more than free to use this for teaching.
%%% If you use it, I'd love to hear from you!
%%% If you have any questions, comments or feedback, 
%%% please send them to me: raizada at cornell dot edu
%%%
%%% Some tutorial exercises which might be useful to try:
%%% 1. Click to make a few points in more or less a straight line.
%%%    What is the correlation value? 
%%%    Now add a point far away from the line.
%%%    What does adding that point do to the correlation value?
%%%    Try deleting the point by clicking on it, then re-adding it, to compare.
%%% 2. Click outside the axes to reset the plot.
%%%    Now put in about 10 points in a oval-ish cloud,
%%%    deleting and adjusting them so that you get a correlation
%%%    of around r=0.6.
%%%    What is the size of the p-value associated with this correlation?
%%%    (This p-value is the probability of observing this r-value
%%%    if the population the points were sampled from actually had zero correlation).
%%%    Now add another 10 points, so that there are 20 in all,
%%%    while keeping the correlation value at r=0.6.
%%%    What is the p-value now?
%%% 3. Click outside the axes to reset the plot.
%%%    Now make in turn, approximately, each of the four plots 
%%%    shown in Anscombe's Quartet:
%%%    http://en.wikipedia.org/wiki/Anscombe's_quartet
%%%    What does this tell you about how only knowing a correlation-value
%%%    might give you a misleading picture of the data?

function interactive_correlation_plot
%%% Set up some global variables, holding the coords of the points
%%% and the graphics-handles of the points (so that we can erase them
%%% from the plot). Making these variables global is ugly, but it works
global coord_list point_handles_list axis_range
%%% Call the make-a-fresh-figure function, to get started.
%%% That function also sets up what happens when we click in the figure.
make_a_fresh_figure_and_empty_points_list;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function make_a_fresh_figure_and_empty_points_list
global coord_list point_handles_list axis_range
coord_list = [ ];
point_handles_list = [];
figure(1);
clf;  %%% Clear the figure
axis_range = 10;
axis(axis_range*[-1 1 -1 1]);  %%% Set up an initial space to click inside
axis('square');  %%% Make the axis square (and equally scaled)
set(gca,'XTick',axis_range*[-1:0.2:1]);
set(gca,'YTick',axis_range*[-1:0.2:1]);  %%% Make the grid spacing equal on both axes
grid on;
hold on;  %%% So that new points get drawn on the same fig as the old ones
set(gca,'FontSize',14);  %%% Increase the font-size of this plot
title(['Click to add points, on old points to delete, outside axes to reset.'; ...
       '           The red line is the linear regression best-fit.          ']);
%%% Tell Matlab to call a function every time
%%% when the mouse is pressed in this figure
set(gcf,'windowbuttondownfcn',{@function_to_call_when_mouse_button_is_clicked});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function function_to_call_when_mouse_button_is_clicked(source,event_data)
global coord_list point_handles_list axis_range
mouse_current_point_output = get(gca,'currentpoint');
%%% For some reason, this current point value has two rows.
%%% Maybe one for the mouse down-click and one for the release?
%%% Anyway, we only want the values from row 1.
mouse_x_coord = mouse_current_point_output(1,1);
mouse_y_coord = mouse_current_point_output(1,2);
%%% If the click is outside the range, then clear figure and points list
if max(mouse_x_coord,mouse_y_coord)>axis_range | ...
      min(mouse_x_coord,mouse_y_coord)<-axis_range,
   make_a_fresh_figure_and_empty_points_list;
else, %%% If the click is inside the range,
   number_of_points = size(coord_list,1);  %%% Number of rows in list
   %%% Call check_if_click_is_on_an_existing_point function, which is below.
   %%% If the click is on an existing point, then that point gets deleted.
   point_to_be_deleted = check_if_click_is_on_an_existing_point(mouse_x_coord,mouse_y_coord);
   %%% If we are not deleting a point, then we are adding a new point.
   if isempty(point_to_be_deleted),
      point_handles_list = [ point_handles_list; ...
                             plot(mouse_x_coord,mouse_y_coord,'*') ];
      coord_list = [ coord_list; ...
                     mouse_x_coord  mouse_y_coord ];
   end;
end;  %%% End of the else from (if mouse-click is inside figure axes)
%%% Now plot the statistics that this program is demonstrating
number_of_points = size(coord_list,1);  %%% Recount how many points we have now
if number_of_points > 1,  %%% We only calculate mean and std if there are two or more points
   plot_the_correlation;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_the_correlation
global coord_list point_handles_list axis_range
%%%% First, delete any red stuff from the figure
%%%% in order to clear the old mean and std plots (which are red)
red_stuff = findobj('Color','r');
delete(red_stuff);
%%%%% Next, calculate and plot the stats
number_of_points = size(coord_list,1);  %%% Recount how many points we have now
x_coords = coord_list(:,1);
y_coords = coord_list(:,2);
x_coords_with_constant_term = [ x_coords ones(number_of_points,1)];
%%%% To get the best-fit line, we'll do a regression
[betas,beta_intervals,residuals,residual_intervals,regression_stats] = ...
    regress(y_coords,x_coords_with_constant_term);
slope = betas(1);
y_intercept = betas(2);
%%%% Plot the best-fit line in red
plot(axis_range*[-1 1], y_intercept + slope*axis_range*[-1 1],'r-');
%%%% Check that the stats we get from regress and from corr are the same
r_squared_from_regression = regression_stats(1);
r_from_regression = sign(slope)*sqrt(r_squared_from_regression);
p_from_regression = regression_stats(3);
[r_from_corr,p_from_corr] = corr(x_coords,y_coords); %%% Yes, they're the same
xlabel([num2str(number_of_points) ' points: ' ...
        '  p-value of corr = ' num2str(p_from_regression,2) ... % The ,2 means to show two digits
        '  Correlation, r = ' num2str(r_from_regression,2) ]);

        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function point_to_be_deleted = check_if_click_is_on_an_existing_point(mouse_x_coord,mouse_y_coord)
global coord_list point_handles_list axis_range
number_of_points = size(coord_list,1);  %%% Number of rows in list
%%% See if our click is within some threshold of an existing point.
%%% If it is, we will delete that point.
%%% Otherwise, we will add a new point
if number_of_points > 0, %%% If there are zero points, we don't need to bother checking for deletion
   xy_coord_matching_matrix = ones(number_of_points,1)*[ mouse_x_coord mouse_y_coord ];
   squared_distances_from_existing_points = (coord_list - xy_coord_matching_matrix).^2;
   sum_sq_dists = sum(squared_distances_from_existing_points,2); %% Sum across columns
   euclidean_dists = sqrt(sum_sq_dists);
   distance_threshold = axis_range/50;
   point_to_be_deleted = find(euclidean_dists < distance_threshold );
   if ~isempty(point_to_be_deleted),
      %%% We only want one matching point.
      %%% It's possible that more than one might be within threshold.
      %%% So, we take the unique smallest distance
      [distance_val,point_to_be_deleted] = min(euclidean_dists);
      coord_list(point_to_be_deleted,:) = []; %% Delete row for that point
      delete(point_handles_list(point_to_be_deleted)); %% Erase the point with that handle
      point_handles_list(point_to_be_deleted) = []; %% Delete that handle
   end;
else, %%% If there are zero points, then we are not deleting any 
   point_to_be_deleted = [];
end;
%%% Check to see whether we have fewer than two points.
%%% If we do, then delete the stats info from the plot, 
%%% as it isn't meaningful for just one data point
number_of_points = size(coord_list,1);  %%% Number of rows in list
if number_of_points < 2,  %%% We only show mean and std if there are two or more points
   red_stuff = findobj('Color','r');
   delete(red_stuff);
   xlabel('');
   ylabel('');
end;
