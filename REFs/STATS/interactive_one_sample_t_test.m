%%% Interactively plot points
%%% to show the one-sample t-test of the y-values, against zero.
%%% By Rajeev Raizada, Jan.2011.
%%% Requires the Matlab statistics toolbox.
%%%
%%% Please feel more than free to use this for teaching.
%%% If you use it, I'd love to hear from you!
%%% If you have any questions, comments or feedback, 
%%% please send them to me: raizada at cornell dot edu
%%%
%%% Some tutorial exercises which might be useful to try:
%%% 1. Click to make 10 points with a mean y-value of around 5,
%%%    and a standard deviation of around 10.
%%%    (The points will need to be quite spread-out for this).
%%%    The red bars show the 95% confidence interval.
%%%    This means that if the data points were randomly sampled
%%%    from a broader population, then we can be 95% sure
%%%    that the actual mean of that broader population
%%%    sits somewhere within that confidence-interval.
%%%    Does this 95% confidence interval include the value y=0?
%%%    What is the size of the p-value of the t-test?
%%%    The meaning of this p-value is that it is the probability of observing
%%%    that t-value, if the population that the points were sampled from 
%%%    actually had a mean equal to zero.
%%% 2. Now add another 10 points, keeping the mean the same at around 5,
%%%    and the standard devation the same at around 10.
%%%    What happens to the size of the 95% confidence interval?
%%%    Does this confidence interval include y=0 now?
%%%    What is the new p-value?

function interactive_one_sample_t_test
%%% Set up some global variables, holding the coords of the points
%%% and the graphics-handles of the points (so that we can erase them
%%% from the plot). Making these variables global is ugly, but it works
global coord_list point_handles_list axis_x_range axis_y_upper_lim axis_y_lower_lim
%%% Call the make-a-fresh-figure function, to get started.
%%% That function also sets up what happens when we click in the figure.
make_a_fresh_figure_and_empty_points_list;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function make_a_fresh_figure_and_empty_points_list
global coord_list point_handles_list axis_x_range axis_y_upper_lim axis_y_lower_lim
coord_list = [ ];
point_handles_list = [];
figure(1);
clf;  %%% Clear the figure
%%% Set up an initial space to click inside
axis_x_range = 30;
axis_y_upper_lim = 20;
axis_y_lower_lim = -10;
axis([axis_x_range*[-1 1] axis_y_lower_lim axis_y_upper_lim]);  
axis('square');  %%% Make the axis square (and equally scaled)
set(gca,'XTick',[]);
set(gca,'YTick',[axis_y_lower_lim : 5 : axis_y_upper_lim ]);  
grid on;
hold on;  %%% So that new points get drawn on the same fig as the old ones
set(gca,'FontSize',14);  %%% Increase the font-size of this plot
title(['Click to add points, on old points to delete, outside axes to reset.'; ...
       '  Dot shows the mean. Bars show 95% confidence interval for mean.   ']);
%%% Plot the zero line, against which the t-test is performed
plot(axis_x_range*[-1 1],[0 0],'k--');
%%% Tell Matlab to call a function every time
%%% when the mouse is pressed in this figure
set(gcf,'windowbuttondownfcn',{@function_to_call_when_mouse_button_is_clicked});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function function_to_call_when_mouse_button_is_clicked(source,event_data)
global coord_list point_handles_list axis_x_range axis_y_upper_lim axis_y_lower_lim
mouse_current_point_output = get(gca,'currentpoint');
%%% For some reason, this current point value has two rows.
%%% Maybe one for the mouse down-click and one for the release?
%%% Anyway, we only want the values from row 1.
mouse_x_coord = mouse_current_point_output(1,1);
mouse_y_coord = mouse_current_point_output(1,2);
%%% If the click is outside the range, then clear figure and points list
if abs(mouse_x_coord)>axis_x_range | ...
      mouse_y_coord<axis_y_lower_lim | mouse_y_coord>axis_y_upper_lim,
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
   plot_the_one_sample_t_test;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_the_one_sample_t_test
global coord_list point_handles_list axis_x_range axis_y_upper_lim axis_y_lower_lim
%%%% First, delete any red stuff from the figure
%%%% in order to clear the old mean and std plots (which are red)
red_stuff = findobj('Color','r');
delete(red_stuff);
%%%% Next, calculate and plot the stats
number_of_points = size(coord_list,1);  %%% Recount how many points we have now
y_coords = coord_list(:,2);  %%% y-coords are the second column
y_mean = mean(y_coords);
y_std = std(y_coords);   
y_ste = y_std / sqrt(number_of_points); %%% ste stands for Standard Error of the Mean
[null_hypothesis_false,p_value,confidence_interval_from_matlab,t_stats_output] = ...
   ttest(y_coords,0);
%%%% Let's also calculate the 95% confidence interval.
%%%% This is the range such that, if we we draw a sample 
%%%% from a population whose true population-mean is y_mean, 
%%%% then that sample's mean will lie within the confidence-interval
%%%% 95% of the time.
%%%% First, we need the critical value of t (two-tailed). 
%%%% Because we are using a two-tailed test, that means that 
%%%% we want to cover the middle 95% of the range of t-value,
%%%% i.e. with 2.5% in each tail on either end.
%%%% So, we want a t-crit value such that there is a 97.5% chance
%%%% of getting a sample with a t-score of *less than* t_crit.
%%%% To get this t_crit value, we need an inverse-t function
%%%% and also the number of degrees-of-freedom (often called df),
%%%% which for a one-sample t-test is simply (number_of_points-1)
df = number_of_points - 1;
t_crit = tinv(0.975,df); % 95% critical value of t, two-tailed
%%%% The 95% confidence interval is the range between
%%%% t_crit standard errors below the mean, and t_crit ste's above.
confidence_interval = y_mean + t_crit*y_ste*[-1 1];
%%%% Uncomment these next two lines if you want to check against Matlab
%disp(['Matlab confidence interval: ' num2str(confidence_interval_from_matlab')])
%disp(['Our confidence interval:    ' num2str(confidence_interval)])
%
%%%% Now, plot the mean and confidence interval in red
plot(0,y_mean,'ro','LineWidth',4);
plot([0 0],confidence_interval,'r-','LineWidth',2);
xlabel(['Mean=' num2str(y_mean,2) ... % The ',2' means show 2 digits  
        ', STE=STD/sqrt(n)=' num2str(y_ste,2) ...
        ', t=Mean/STE=' num2str(t_stats_output.tstat,2) ...
        ', p=' num2str(p_value,2) ]); 
ylabel(['n = ' num2str(number_of_points) ...
        ',  STD = ' num2str(y_std,2) ]); 
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function point_to_be_deleted = check_if_click_is_on_an_existing_point(mouse_x_coord,mouse_y_coord)
global coord_list point_handles_list axis_x_range axis_y_upper_lim axis_y_lower_lim
number_of_points = size(coord_list,1);  %%% Number of rows in list
%%% See if our click is within some threshold of an existing point.
%%% If it is, we will delete that point.
%%% Otherwise, we will add a new point
if number_of_points > 0, %%% If there are zero points, we don't need to bother checking for deletion
   xy_coord_matching_matrix = ones(number_of_points,1)*[ mouse_x_coord mouse_y_coord ];
   squared_distances_from_existing_points = (coord_list - xy_coord_matching_matrix).^2;
   sum_sq_dists = sum(squared_distances_from_existing_points,2); %% Sum across columns
   euclidean_dists = sqrt(sum_sq_dists);
   distance_threshold = axis_x_range/50;
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