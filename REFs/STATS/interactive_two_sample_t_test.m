%%% Interactively plot points
%%% to show the two-sample t-test of the y-values.
%%% By Rajeev Raizada, Jan.2011.
%%% Requires the Matlab statistics toolbox.
%%%
%%% Please feel more than free to use this for teaching.
%%% If you use it, I'd love to hear from you!
%%% If you have any questions, comments or feedback, 
%%% please send them to me: raizada at cornell dot edu
%%%
%%% Some tutorial exercises which might be useful to try:
%%% 1. Click in the left-half of the figure
%%%    to make a few points in Group A with a mean of around 5,
%%%    and in the right-half to make a few points in Group B
%%%    with a mean of around 10.
%%%    The red bars show the 95% confidence interval for each group.
%%%    This means that if the data points were randomly sampled
%%%    from a broader group-population, then we can be 95% sure
%%%    that the actual mean of that broader group-population
%%%    sits somewhere within that confidence-interval.
%%% 2. What is the size of the p-value of the two-sample t-test for the groups you made?
%%%    What is the size of the t-value for the difference between the two group-means?
%%%    The meaning of the p-value is that it is the probability of observing 
%%%    that t-value, if the two group-populations that the data points 
%%%    were sampled from actually had the same means as each other.
%%%    How much overlap is there between the 95% confidence intervals
%%%    of the two groups?
%%% 3. Click to add or delete some points so that the confidence intervals
%%%    of the two groups become more overlapping with each other.
%%%    What is the new t-value? What is the new p-value?
%%% 4. Can you make two groups which have quite similar mean-values,
%%%    but where those mean-values are still significantly different from each other?
%%% 5. Now try to make two groups which have very different means,
%%%    but where the mean-values are *not* significantly different from each other.

function interactive_two_sample_t_test
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
set(gca,'XTick',axis_x_range*0.5*[-1 1]);
set(gca,'XTickLabel',['Group A';'Group B']);
set(gca,'YTick',[axis_y_lower_lim : 5 : axis_y_upper_lim ]);  
grid on;
hold on;  %%% So that new points get drawn on the same fig as the old ones
set(gca,'FontSize',14);  %%% Increase the font-size of this plot
title(['Click to add points, on old points to delete, outside axes to reset.'; ...
       ' Dots show the means. Bars show 95% confidence intervals for means  ']);
%%% Plot a line at x=0, which divides the Group A side from the Group B side
plot([0 0],[axis_y_lower_lim axis_y_upper_lim ],'k--');
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
      %%% We are going to treat all the points to the left of x=0 as Group A,
      %%% and all the points to the right of x=0 as Group B.
      %%% We'll plot Group A in blue, and Group B in black
      if mouse_x_coord < 0,  %%% Group A
         colour_of_this_point = 'b';
      else,                  %%% Group B
         colour_of_this_point = 'k'; % 'k' stands for black, in Matlab colours
      end;
      point_handles_list = [ point_handles_list; ...
                             plot(mouse_x_coord,mouse_y_coord,'*','Color',colour_of_this_point) ];
      coord_list = [ coord_list; ...
                     mouse_x_coord  mouse_y_coord ];
   end;
end;  %%% End of the else from (if mouse-click is inside figure axes)
%%% Now plot the statistics that this program is demonstrating
number_of_points = size(coord_list,1);  %%% Recount how many points we have now
if number_of_points > 1,  
   plot_the_two_sample_t_test;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_the_two_sample_t_test
global coord_list point_handles_list axis_x_range axis_y_upper_lim axis_y_lower_lim
%%%% First, delete any red stuff from the figure
%%%% in order to clear the old mean and std plots 
circle_stuff = findobj('Marker','o');  %%% The means are plotted as 'o'
delete(circle_stuff);
red_stuff = findobj('Color','r');
delete(red_stuff);
%%%% Next, calculate and plot the stats
%%%% We do this separately for Group A and Group B
%%%% The groupes are defined by whether their x-coord is > 0 or < 0
group_A_points = find(coord_list(:,1)<0);
group_B_points = find(coord_list(:,1)>=0);
number_of_points_A = length(group_A_points);
y_coords_A = coord_list(group_A_points,2);  %%% y-coords are the second column
y_mean_A = mean(y_coords_A);
y_std_A = std(y_coords_A);   %%% ste stands for Standard Error of the Mean
y_ste_A = y_std_A / sqrt(number_of_points_A);
number_of_points_A = length(group_A_points);
%%% Now do the same for Group B
number_of_points_B = length(group_B_points);
y_coords_B = coord_list(group_B_points,2);  %%% y-coords are the second column
y_mean_B = mean(y_coords_B);
y_std_B = std(y_coords_B);   %%% ste stands for Standard Error of the Mean
y_ste_B = y_std_B / sqrt(number_of_points_B);
%%% Do one-sample t-tests on each group, to get their 95% confidence intervals
[null_hypothesis_false_A,p_value_A,confidence_interval_A,t_stats_output_A] = ...
   ttest(y_coords_A);
[null_hypothesis_false_B,p_value_B,confidence_interval_B,t_stats_output_B] = ...
   ttest(y_coords_B);
%%% For more explanation of what the confidence interval means,
%%% see the accompanying script interactive_one_sample_t_test.m
%%% Note: the default two-sample t-test in Matlab pools the variances
%%% across the two groups, and does not try to deal with unequal variances.
%%% There is an option to do that, but we are not going to use it here.
%%% This is just an introductory tutorial demo, after all.
[null_hypothesis_false_AvsB,p_value_AvsB,confidence_interval_AvsB,t_stats_output_AvsB] = ...
   ttest2(y_coords_A,y_coords_B);
%%% If we have two or more points in a given class,
%%% then we plot the mean and confidence interval for that class
if number_of_points_A > 1,
   plot(-axis_x_range/2,y_mean_A,'bo','LineWidth',4);
   plot(-axis_x_range/2*[1 1],confidence_interval_A,'r-','LineWidth',2);
end;
if number_of_points_B > 1,
   plot(axis_x_range/2,y_mean_B,'ko','LineWidth',4);
   plot(axis_x_range/2*[1 1],confidence_interval_B,'r-','LineWidth',2);
end;
%%% If at least one of the classes has two or more points,
%%% and neither of the classes is empty,
%%% then we will display the two-sample t-test results
if max(number_of_points_A,number_of_points_B)>1 & ...
   min(number_of_points_A,number_of_points_B)>0,
   xlabel(['Mean-A=' num2str(y_mean_A,3) ... % The ',3' means show 3 digits  
           '   Mean-B=' num2str(y_mean_B,3) ...
           ',  t=' num2str(t_stats_output_AvsB.tstat,3) ...
           ',  p=' num2str(p_value_AvsB,2) ]); 
   ylabel(['n(A)=' num2str(number_of_points_A) ...
           '  n(B)=' num2str(number_of_points_B) ...
           '  df=' num2str(t_stats_output_AvsB.df) ]); 
end;

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
%%% Check to see whether we have fewer than two points in either class
%%% If we do, then delete the mean and confidence interval for that class, 
%%% as it isn't meaningful for just one data point
if ~isempty(coord_list),
   group_A_points = find(coord_list(:,1)<0);
   group_B_points = find(coord_list(:,1)>=0);
   number_of_points_A = length(group_A_points);
   number_of_points_B = length(group_B_points);
   if number_of_points_A < 2,
      class_A_circle_stuff = findobj('Marker','o','-and','XData',-axis_x_range/2);
      delete(class_A_circle_stuff);
      class_A_red_stuff = findobj('Color','r','-and','XData',-axis_x_range/2);
   end;
   if number_of_points_B < 2,
      class_B_circle_stuff = findobj('Marker','o','-and','XData',axis_x_range/2);
      delete(class_B_circle_stuff);
      class_B_red_stuff = findobj('Color','r','-and','XData',axis_x_range/2);
   end;
   %%% If neither of the classes has two or more points,
   %%% or either of the classes is empty,
   %%% then we will delete the two-sample t-test results
   if max(number_of_points_A,number_of_points_B)<2 | ...
      min(number_of_points_A,number_of_points_B)==0,
        xlabel('');
        ylabel('');
   end;
end;

