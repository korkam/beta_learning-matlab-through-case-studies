%% GETTING STARTED WITH MATLAB

clear all; clc; %#ok<*NOPTS,*NASGU,*NOEFF>
if 0
%% <http://nyu.libguides.com/dataservices NYU DATA SERVICES>
% * Tutorials and support for academic software
% * One-on-one consultation by appointment

%%
% 
%%% Accessing MATLAB at NYU:
% 
% * Data Services Workstations - 5th floor of Bobst Library
% * Most ITS labs
% * Contact *hpc@nyu.edu* for license
% 
%%% Accessing MATLAB at home:
% 
% * Virtual Computing Lab (vcl.nyu.edu, for students only)
% * HPC Clusters (requires an account)
%%
% 
%%% MATLAB is a programming language and environment
% 
% * Exists since 1970s (Mathworks created in 1984)
% * Similar to R, Octave
% * Highly flexible, but mostly relies on typed commands
% 
%%% MATLAB is great for numeric data manipulation
% 
% * Optimized for data analysis, matrix manipulations in particular
% * Basic unit is a matrix
% * Vectorized operations are quick
% * Customizable but not point-and-click visualization
% 
%%% MATLAB is highly versatile
% 
% * Diverse set of available toolboxes
% * Vast number of pre-defined functions and implemented algorithms
% * Large online community (MATLAB Exchange)
%% EXAMPLES OF BASIC OPERATIONS
% * + addition
% * - subtraction
% * * multiplication
% * / division
% * ^ power (exponentiation)
% * ' transpose
% * .* elementwise multiplication
% * ./ elementwise division
% * .^ elementwise exponentiation
x=3;                    % Assigns 3 to x. The semicolon suppresses the output
x=10                    % Reassigns 10 to x
12*20                   % Multiplication
% Note that the result is saved in an automatically generated variable *ans*
3^4                     % 3 to the fourth power
3/8                     % Division
a=(7-28)^2/(7*3-12)     % Obeys the usual order of operations
whos                    % Displays all variables. Note that x is a 1 by 1 matrix.

A = [1,2; 3 4]          % A 2x2 matrix
whos                    % Notice that A is a 2x2 matrix
v = [3 -4]              % v is a 1x2 matrix (or vector)
w = [5 ; 7]             % w is a 2x1 matrix (or vector)
u=A*w                   % matrix multiplication
% A*v                   % illegal since the number of columns of A
                        % does not equal the number of rows of w
v*A                     % legal matrix multiplication
v.*w'                   % dot multiplication (only for matrices with same dimensions)
%% FUNCTIONS
% * Functions allow users to easily perform complex tasks using custom
% input and output
% * In most cases, *output=function(input)* (both are optional)
% * Call a function by typing function name followed by the desired set of arguments enclosed in parentheses,
% e.g. *sqrt(16)*
% * Parentheses are not required if function takes no arguments, e.g. *pwd*
% * Parentheses are not required if function takes a single string
% argument, e.g. *help sqrt*
%% DOCUMENTATION
% * *help* prints help in the command window
% * *doc* shows help in documentation browser
% * Online Documentation: <http://mathworks.com/help>
% * Find relevant functions through _related functions_ at the bottom of the _Help_ page
%% MORE BASICS

zeros(4,5)              % A 4x5 matrix of zeros
ones(3)                 % A 3x3 matrix of ones
eye(3,3)                % A 3x3 diagonal matrix of 1’s
nan(2,3,2)              % A 2x3x2 matrix of NaNs
diag(v)                 % A diagonal matrix whose diagonal is the elements of v
x=1:10                  % Creates the vector [1 2 3 4 5 6 7 8 9 10]
y=0:0.2:1               % Creates the vector [0 0.2 0.4 0.6 0.8 1.0]
z=linspace(0,1,5)       % Creates a vector with 5 elements linearly spaced between 0 and 10
sin(pi/3)               % the sin function (in radians)
exp(x)                  % Note that we have calulcated exp() for all entries in x
true                    % Returns 1
false                   % Returns 0
logical(5)              % All nonzero values of logical are true
logical(-10)
logical(0)
%% BASIC OPERATIONS WITH STRINGS

x='Pete'                     % Assigns an array of characters to variable x
y='Jane'              
[x y]                       % concatenation
[x;y]                       % concatenation only works because x and y are the same size
z = ['Steve'];
[x ' and ' z]
%[x;z]                      % Doesn’t work – sizes do not match
x(2)                        % prints ‘e’

strfind('abcde_cd','cd')    % finding one string within another	

str = 'Hello World!'
str = strrep(str,' ','')    % remove spaces from a string

Y = 'JANE'
strcmp(y,Y)                 % compare strings
strcmpi(y,Y)                % compare strings ignoring case
lower(Y)                    % convert to lower case
upper(y)                    % convert to upper case

%% FLOW CONTROL: IF, ELSEIF, ELSE
% LOGICAL COMPARISON: >, <, >=, <=, ==, &&, ||
A = randn

if A > 0
    disp('greater')
elseif A < 0
    disp('less')
elseif A == 0
    disp('equal')
else
    disp('none of the above')
    % A = [],-Inf,Inf,NaN;
    % to check for these explicitly use
    % isnan(),isinf(),isnumeric(),isempty()
end
%% FLOW CONTROL: LOOPS
% The FOR loop repeats a group of statements a fixed, predetermined number of times.
% The WHILE loop repeats a group of statements an indefinite number of times
clear x
for i = 1:20
    x(i) = sin(2*pi*i) + rand();
end
%%
clear A
for m = 1:5
    for n = 1:100
        A(m, n) = 1/(m + n - 1);
    end
end
%%
clear y
y = 2;
while y <= 100
    y = y^2;
end
disp(y)
%% INDICES AND COLON OPERATOR

A = [1 3 5; 2 4 6]
A(:)
A(:)'

size(A)
length(A)

A(1,3)
A(5); 

A(:,3)

A(:,end)

A(end)


%% CELL ARRAYS
% Both cell and structure arrays allow you to store data of different types and sizes.
% Commonly used to store lists of text strings and other heterogeneous data from spreadsheets. 
% Cell arrays have rows and columns just like a matrix of numbers, except each cell can contain any object,
% e.g. numeric matrix, character array, cell array, etc.

A = cell(3,1);  % creates a 3x1 empty cell array
A{1} = 'Hello'  % assigns char array “Hello”
A(1)            % this returns a cell
A{1}            % this returns the char array

end
%%
temperature(1,:) = {'01-Jan-2010', [45, 49, 0]};
temperature(2,:) = {'03-Apr-2010', [54, 68, 21]};
temperature(3,:) = {'20-Jun-2010', [72, 85, 53]};
temperature(4,:) = {'15-Sep-2010', [63, 81, 56]};
temperature(5,:) = {'31-Dec-2010', [38, 54, 18]};

% Plot the temperatures for each city by date.
allTemps = cell2mat(temperature(:,2));
dates = datenum(temperature(:,1), 'dd-mmm-yyyy');

plot(dates,allTemps)
datetick('x','mmm')

%% STRUCTURE ARRAYS
% Structure arrays contain data in fields that you access by name.
if 0
B = struct('name',{'Bob' 'Jane' 'Mia'},'age',{42 38 21},'category','adult')
B(2).name 	% returns string ‘Jane’
B(3).age 	% returns 21
B.category	% this field is ‘adult’ for all indices

% Extracting fields from a structure array
ages = {B.age}  % a 1x3 cell
ages = [B.age]  % a 1x3 array
names = {B.name}% a 1x3 cell
names(1)        % a cell
names{1}        % a string
end
%% ENTERING/STORING DATA

% CSVREAD assumes numeric data
% csv_data = csvread('c:\Users\Denis\Google Drive\DenisDocs\MATLAB\demo.csv',1); % gives error
csv_data = csvread('c:\Users\Denis\Google Drive\DenisDocs\MATLAB\demo.csv',1,2); % start on 2nd row and 3rd column

[num,txt,raw] = xlsread('c:\Users\Denis\Google Drive\DenisDocs\MATLAB\demo.csv');

csvwrite('c:\Users\Denis\Google Drive\DenisDocs\MATLAB\demo_out.csv',num)
xlswrite('c:\Users\Denis\Google Drive\DenisDocs\MATLAB\demo_out.xls',raw)

% save in MATLAB format
save('c:\Users\Denis\Google Drive\DenisDocs\MATLAB\demo_out.mat','num','txt','raw')

%% BASIC PLOTTING: Scatter Plot
x=0:pi/20:2*pi;
y = sin(x);
plot(x,y)
xlabel('0 to 2\pi')
ylabel('sine of x')
title('Plot of Sine Function','Fontsize',14)

xlim([-0.5 2*pi+0.5])
ylim([-1.25 1.25])
hold on
plot(x,y,'r.')
legend('plot1','plot2')
%% BASIC PLOTTING: Histogram
mu = 9;
sigma = 3;
v = normrnd(mu,sigma,[10000 1]);
close
hist(v,50) % 50 bins, default is 10
%% BASIC PLOTTING: 3D Histogram
v2 = normrnd(mu,sigma,[10000 2]);
v2(:,2) = v2(:,2)*1.5;
close
hist3(v2,[50 50]);
%% BASIC PLOTTING: Using the color dimension
close
[N,C] = hist3(v2,[50 50]);
x = [C{1}(1) C{1}(end)];
y = [C{2}(1) C{2}(end)];
image(x,y,N); axis image
%% OTHER 3D-PLOTTING
[X,Y]=meshgrid(-8:.5:8);
R=sqrt(X.^2+Y.^2)+eps;
Z=sin(R)./R;
subplot(2,2,1)
mesh(X,Y,Z,'EdgeColor','black')
subplot(2,2,2)
mesh(X,Y,Z,'EdgeColor','black')
hidden off
subplot(2,2,3)
colormap hsv
surf(X,Y,Z)
colorbar
subplot(2,2,4)
surf(X,Y,Z,'Facecolor','r','Edgecolor','none')
camlight left;lighting phong
view(-15,65)
%% GEOMETRIC STRUCTURES
figure;
colormap autumn
subplot(2,2,1); 
    sphere(50);
subplot(2,2,2); 
    [x, y, z] = ellipsoid(0,0,0,6,3,3,50);
    surfl(x, y, z)
    axis equal
subplot(2,2,3); 
    cylinder(50);
subplot(2,2,4); 
    t = 0:pi/10:2*pi;
    [X,Y,Z] = cylinder(2+cos(t));
    surf(X,Y,Z)
    axis square

%% STATISTICS TOOLBOX: Linear Regression
close all
[num,txt,raw] = xlsread('c:\Users\Denis\Google Drive\DenisDocs\MATLAB\demo.csv');
h = num(:,5:end);
X = h(:,[1 3 4]);
y = h(:,6);
stats = regstats(y,X,'linear')

%% STATISTICS TOOLBOX: T-TEST
x = normrnd(9,3,[100,1]);
y = normrnd(8,2,[100,1]);

figure; subplot(2,1,1); hist(x,100); xlim([-5 20]); subplot(2,1,2); hist(y,100); xlim([-5 20])
[h,p,ci,stats] = ttest2(x,y); % independent samples t-test
text(12,3.5,['t-test: p = ' sprintf('%0.4f',p)])
[p,h,stats] = ranksum(x,y); % non-parametric test
text(12,2.5,['rank test: p = ' sprintf('%0.4f',p)])
[h,p,ci,stats] = vartest2(x,y); % independent samples t-test
text(12,1.5,['var test: p = ' sprintf('%0.4f',p)])
%% STATISTICS TOOLBOX: Random Number Generation Tool
% Example: Get chisquare with df=10

% randtool
%% STATISTICS TOOLBOX: Distribution Fitting Tool
% fit a distribution to the data from previous step

% dfittool
%% CURVE-FITTING TOOLBOX

t = linspace(0,6*pi, 100)';
s = sin(t)+0.1*randn(100,1);

% cftool

% [fitresult, gof] = fit( t, s, fittype('fourier1'), fitoptions( fittype('fourier1') ));

%% IMAGE PROCESSING TOOLBOX
% We can separate rice grains from the background based on intensity
I = imread('rice.png');
subplot(2,2,1); imshow(I), title('original image');
BW = im2bw(I,graythresh(I));
[L,N] = bwlabel(BW);
RGB = label2rgb(L);
RGB2 = label2rgb(L, 'spring', 'c', 'shuffle');
subplot(2,2,2); imshow(RGB2);
%%%
se = strel('disk',4);
io = imopen(BW>0,se);
subplot(2,2,3); imshow(io,[])
%%%
[Lo,No] = bwlabel(io);
stats = regionprops(Lo,'all');
clear cns; for k=1:No cns(k,:) = stats(k).Centroid; areas(k,:) = stats(k).Area; end
hold on; plot(cns(:,1),cns(:,2),'r*')
subplot(2,2,4); hist(areas)
%% ADDITIONAL RESOURCES
% * <http://nyu.libguides.com/content.php?pid=38898&sid=1554472 Data Services Training page>
% * Data Services Staff <data.services@nyu.edu> or <http://bit.ly/datameeting make an
% appointment>
% * Author contributed files at <http://www.mathworks.com/matlabcentral/fileexchange/ MATLAB File
% Exchange>
%% Follow-up Survey
web('http://tinyurl.com/DSS-IntroMatlab')

