%%% Interactively plot points
%%% to show their mean, standard deviation, 
%%% and the Normal distribution with that mean and SD.
%%% By Rajeev Raizada, Jan.2011.
%%% Requires the Matlab statistics toolbox.
%%%
%%% Please feel more than free to use this for teaching.
%%% If you use it, I'd love to hear from you!
%%% If you have any questions, comments or feedback, 
%%% please send them to me: raizada at cornell dot edu
%%%
%%% Some tutorial exercises which might be useful to try:
%%% 1. Click to add n=10 points.
%%%    Their mean x-value is the large red dot.
%%%    The vertical lines show standard deviation (SD) distances from the mean.
%%%    How many of the points lie within one SD of the mean?
%%%    How many of the points lie within two SDs of the mean?
%%% 2. Click to add more points, putting most of them near the mean.
%%%    How many points do you need altogether before some of them
%%%    start to lie more than two SDs away from the mean?
%%% 3. When it is three standard deviations away from the mean,
%%%    the bell-shaped Normal distribution curve is very close to zero.
%%%    It is so close that you might not even be able to see
%%%    the very short vertical dotted lines at the 3 SD marks.
%%%    Click to add a lot of points near the mean,
%%%    so that the Normal curve gets taller and thinner,
%%%    and add a couple of far-distant points at the sides.
%%%    See if you can get some points to lie more than 3 SDs from the mean.

function interactive_mean_std_normal_distribution
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
axis_x_range = 10;
axis_y_upper_lim = 0.2;
axis_y_lower_lim = -0.07;
axis([axis_x_range*[-1 1] axis_y_lower_lim axis_y_upper_lim]);  
set(gca,'XTick',axis_x_range*[ -1: 0.2: 1 ]);
set(gca,'YTick',[ 0 ]);
grid on;
hold on;  %%% So that new points get drawn on the same fig as the old ones
set(gca,'FontSize',14);  %%% Increase the font-size of this plot
title(['Click to add points, on old points to delete, outside axes to reset.'; ...
       '    Dot shows the mean. Vertical dotted lines show STDs from mean   ']);
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
if number_of_points > 1,  
   plot_the_mean_std_and_normal;
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_the_mean_std_and_normal
global coord_list point_handles_list axis_x_range axis_y_upper_lim axis_y_lower_lim
%%%% First, delete any red stuff from the figure
%%%% in order to clear the old mean and std plots 
circle_stuff = findobj('Marker','o');  %%% The means are plotted as 'o'
delete(circle_stuff);
red_stuff = findobj('Color','r');
delete(red_stuff);
%%%% Next, calculate and plot the stats
x_coords = coord_list(:,1);  %%% x-coords are the first column
x_mean = mean(x_coords);
x_std = std(x_coords);   
plot(x_mean,0,'ro','LineWidth',4);
x_range_to_plot = axis_x_range*[ -1: 0.02: 1 ];  % Specify a range of curve-positions to plot
normal_curve = 1/(x_std*sqrt(2*pi)) * exp(-(x_range_to_plot-x_mean).^2/(2*x_std.^2));
plot(x_range_to_plot,normal_curve,'r-');
%%% If we want, we can cross-check this against the Matlab function normpdf
%normal_curve_matlab = normpdf(x_range_to_plot,x_mean,x_std);
%plot(x_range_to_plot,normal_curve_matlab,'ro');
for std_to_show = [ -3:3 ],
   this_std_x_value = x_mean + std_to_show*x_std;
   this_std_normal_curve_value = 1/(x_std*sqrt(2*pi)) * exp(-std_to_show.^2/2);
   plot( this_std_x_value*[1 1],[0 this_std_normal_curve_value],'r--');
end;
number_of_points = size(coord_list,1);  %%% Number of rows in list
xlabel(['n = ' num2str(number_of_points) ...
        '   Mean = ' num2str(x_mean,3) ... % The ',3' means show 3 digits
        ',  STD = ' num2str(x_std,3) ]); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function point_to_be_deleted = check_if_click_is_on_an_existing_point(mouse_x_coord,mouse_y_coord)
global coord_list point_handles_list axis_x_range axis_y_upper_lim axis_y_lower_lim
number_of_points = size(coord_list,1);  %%% Number of rows in list
%%% See if our click is within some threshold of an existing point.
%%% If it is, we will delete that point.
%%% Otherwise, we will add a new point
if number_of_points > 0, %%% If there are zero points, we don't need to bother checking for deletion
   xy_coord_matching_matrix = ones(number_of_points,1)*[ mouse_x_coord mouse_y_coord ];
   distances_from_existing_points = (coord_list - xy_coord_matching_matrix);
   %%% Because the x and y axes have different scales,
   %%% we need to rescale the distances so that it doesn't matter whether
   %%% you try to delete a dot by clicking near it in the x or y directions
   axis_range_scaled_distances =  ...
        [ distances_from_existing_points(:,1)/(2*axis_x_range) ...
          distances_from_existing_points(:,2)/(axis_y_upper_lim-axis_y_lower_lim) ];
   squared_distances_from_existing_points = axis_range_scaled_distances.^2;
   sum_sq_dists = sum(squared_distances_from_existing_points,2); %% Sum across columns
   euclidean_dists = sqrt(sum_sq_dists);
   distance_threshold = 0.01;
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

