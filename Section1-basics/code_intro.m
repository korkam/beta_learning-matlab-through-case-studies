%% GETTING STARTED WITH MATLAB
clear all; clc; %#ok<*NOPTS,*NASGU,*NOEFF,*LOGL,*ASGLU,*SAGROW>
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
%% Examples of basic operations
% * + addition
% * - subtraction
% * * multiplication
% * / division
% * ^ power (exponentiation)
% * ' transpose
% * .* elementwise multiplication
% * ./ elementwise division
% * .^ elementwise exponentiation
x=3                     % Assigns 3 to x. 
x=10;                   % Reassigns 10 to x. The semicolon suppresses the output
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
A*v                     % illegal since the number of columns of A
                        % does not equal the number of rows of w
v*A                     % legal matrix multiplication
v.*w'                   % dot multiplication 
                        % (only for matrices with same dimensions)
%%
% A.*A vs A*A vs A^2 vs A.^2
x=1:10                  % Creates the vector [1 2 3 4 5 6 7 8 9 10]
y=0:0.2:1               % Creates the vector [0 0.2 0.4 0.6 0.8 1.0]
z=[y x]
%%
% Exercise: Create a vector of numbers between 5 and -5 that skips 0
x = [];
y = [];
plot(x,y)
z=0:0.02:2;
plot(exp(z))
plot(z,exp(z))
plot(sin(z))
z = linspace(0,6*pi,50)
plot(z,sin(z))
%% Documentation
% * *help* prints help in the command window
% * *doc* shows help in documentation browser
% * Online Documentation: <http://mathworks.com/help>
% * Find relevant functions through _related functions_ at the bottom of the _Help_ page
%% Functions
% * Functions allow users to easily perform complex tasks using custom
% input and output
% * In most cases, *output=function(input)* (both are optional)
% * Call a function by typing function name followed by the desired set of arguments enclosed in parentheses,
% e.g. *sqrt(16)*
% * Parentheses are not required if function takes no arguments, e.g. *pwd*
% * Parentheses are not required if function takes a single string
% argument, e.g. *help sqrt*
% * Writing a function
%     function s = cube(x)
%           s = x.^3;
%     end
%% Logicals, INFs and NaNs
true
false
logical(5)              % All nonzero values of logical are true
logical(-17)
logical(0)
[0 1 NaN -NaN Inf -Inf 5 -Inf*Inf 5*NaN Inf*NaN]
%% Creating Matrices
zeros(4,5)              % A 4x5 matrix of zeros
ones(2,1)               % A 2x1 matrix of ones
eye(3,3)                % A 3x3 diagonal matrix of 1’s
true(2,4)               % Returns 2x4 matrix of ones
false(2)                % Returns 2x2 matrix of zeros
nan(2,3)                % Returns 2x3 matrix of NaNs (not-a-number)
inf(2,3)                % Returns 2x3 matrix of INFs
rand(5,2)               % Random numbers between 0 and 1
randn(3,2,2)            % Standard normal random numbers
randi(8,6,2)            % 6x2 matrix of random integers between 1 and 8
%%
% Exercise: create a vector of 5 random intergers between 10 and 20
%% Indices and colon operator

A = [1 3 7; 2 4 9]
A(:)
A(:)'

size(A)
length(A)

A(1,3)
A(5); 

A(:,3)

A(:,end)

A(end)

A = rand(3,4,2)

B = A(:,2,:)
size(B)
C = squeeze(B)
size(C)
%% Basic operations with strings

x='Pete'                    % Assigns an array of characters to variable x
y='Jane'              
[x y]                       % concatenation
[x;y]                       % concatenation only works because x and y are 
                            % the same size
z = ['Steve'];
[x ' and ' z]
[x;z]                       % Doesn't work: sizes do not match
x(2)                        % prints e’

strfind('abcde_cd','cd')    % finding one string within another	

str = 'Hello World!'
str = strrep(str,' ','')    % remove spaces from a string

Y = 'JANE'
strcmp(y,Y)                 % compare strings
strcmpi(y,Y)                % compare strings ignoring case
lower(Y)                    % convert to lower case
upper(y)                    % convert to upper case
name = input('What is your name?','s')
strcmpi(name,'Denis')
%% Flow control: IF, ELSEIF, ELSE
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
    % isnan(),isinf(),isnumeric(),isempty(),exist()
end
%% Flow control: Loops
% The FOR loop repeats a group of statements a fixed, predetermined number of times.
% The WHILE loop repeats a group of statements an indefinite number of times
clear x
for i = 1:20
    x(i) = sin(2*pi*i) + rand();
end
for k = [4 9 10]
    disp(k)
end
%%
clear A
for m = 1:5
    for n = 1:10
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

%% Cell Arrays
% Both cell and structure arrays allow you to store data of different types and sizes.
% Commonly used to store lists of text strings and other heterogeneous data from spreadsheets. 
% Cell arrays have rows and columns just like a matrix of numbers, except each cell can contain any object,
% e.g. numeric matrix, character array, cell array, etc.

A = cell(3,1);  % creates a 3x1 empty cell array
A{1} = 'Hello'  % assigns char array “Hello”
A(1)            % this returns a cell
A{1}            % this returns the char array

name = {'Bob'; 'Jane'; 'Mia'}
age = [42 38 21];
category = {'parent'; 'parent'; 'child'}
A = {name age category}
A{:,1}

%% Structure Arrays
% Structure arrays contain data in fields that you access by name.
B = struct('name',{'Bob' 'Jane' 'Mia'},'age',{42 38 21},...
           'category',{'parent' 'parent' 'child'})
B(2).name 	% returns string ‘Jane’
B(3).age 	% returns 21
B.category	% this field is ‘adult’ for all indices
C = struct2cell(B)

% Extracting fields from a structure array
ages = {B.age}  % a 1x3 cell
ages = [B.age]  % a 1x3 array
names = {B.name}% a 1x3 cell
names(1)        % a cell
names{1}        % a string
%% Entering/Storing Data
% Can use functions such as |csvread|, |dlmread|, or |xlsread| to read in
% the data, but it's much easier to generate appropriate code with the
% Import Wizard (Home Tab -> Import Data)
path_to_file = 'C:\Users\NetID\Desktop\demo.csv';
[num,txt,raw] = xlsread(path_to_file);
% Similarly, can use |csvwrite|, |dlmwrite|, or |xlswrite| to write data out
result_file_name = strrep(path_to_file,'demo','demo_out');
csvwrite(result_file_name,num)
xlswrite(result_file_name,raw)
% However, it is much better to save in MATLAB format.
save('C:\Users\NetID\Desktop\demo_out.mat','num','txt','raw')

%% Basic Plotting: Scatter Plot
clf
x=0:pi/20:6*pi;
y = sin(x);
plot(x,y)
xlabel('0 to 6\pi')
ylabel('sine of x')
title('Plot of Sine Function','Fontsize',14)

xlim([0 6*pi])
ylim([-1.25 1.25])
hold on
extremes = y==1 | y==-1;
plot(x(extremes),y(extremes),'ro')
legend('plot1','plot2')
%% Basic Plotting: Subplot and logarithmic plots
x = linspace(2,10,100);
y = exp(x);
figure; 

subplot(2,2,1); plot(x,y);            
xlabel('x'); ylabel('y');     legend('1','FontSize',18,'Location','NorthWest');       

subplot(2,2,2); semilogy(x,y);        
xlabel('x'); ylabel('log-y'); legend('2','FontSize',18,'Location','NorthWest')

subplot(2,2,3); semilogx(x,y);
xlabel('log-x'); ylabel('y'); legend('3','FontSize',18,'Location','NorthWest')

subplot(2,2,4); plotyy(x,y,x,log(y));
xlabel('x'); ylabel('y');     legend('4','4','FontSize',18,'Location','NorthWest')
%% Basic Plotting: Histogram
mu = 9;
sigma = 3;
v = normrnd(mu,sigma,[10000 1]);
clf
hist(v,50) % 50 bins, default is 10
%% Basic Plotting: 3D Histogram
v2 = normrnd(mu,sigma,[10000 2]);
v2(:,2) = v2(:,2)*1.5;
clf
hist3(v2,[50 50]);
%% Basic Plotting: Using the color dimension
clf
[N,C] = hist3(v2,[50 50]);
x = [C{1}(1) C{1}(end)];
y = [C{2}(1) C{2}(end)];
image(x,y,N); axis image
%% Other 3D Plotting
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
%% Geometric structures
clf;
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
% <http://www.mathworks.com/help/stats/index.html Statistics Toolbox>
close all
clear
load carsmall
y = MPG;
X = [Horsepower Weight Model_Year];
stats = regstats(y,X,'linear')
%%
mdl = LinearModel.fit(X,y)
plot(mdl)
methods(mdl)
%% STATISTICS TOOLBOX: T-TEST

% 100 random numbers from normal distribution with mean=9 and st.dev.=3
x = normrnd(9,3,[100,1]);
% 100 random numbers from normal distribution with mean=8 and st.dev.=2
y = normrnd(8,2,[100,1]);   

figure; 
subplot(2,1,1); hist(x,100); xlim([-5 20]);
subplot(2,1,2); hist(y,100); xlim([-5 20])

% independent samples t-test
[h,p,ci,stats] = ttest2(x,y); 
text(12,3.5,['t-test: p = ' sprintf('%0.4f',p)])

% non-parametric test
[p,h,stats] = ranksum(x,y); 
text(12,2.5,['rank test: p = ' sprintf('%0.4f',p)])

% test for equality of variances (independent samples)
[h,p,ci,stats] = vartest2(x,y); 
text(12,1.5,['var test: p = ' sprintf('%0.4f',p)])
%% STATISTICS TOOLBOX: Random Number Generation Tool
% Example: Get chisquare with df=10

randtool
%% STATISTICS TOOLBOX: Distribution Fitting Tool
% fit a distribution to the data from previous step

dfittool
%% CURVE-FITTING TOOLBOX

t = linspace(0,6*pi, 100)';
s = sin(t)+0.1*randn(100,1);

cftool

[fitresult, gof]=fit(t,s,fittype('fourier1'),fitoptions(fittype('fourier1')));

%% IMAGE PROCESSING TOOLBOX
close all
figure;
imdata = imread('ngc6543a.jpg');
image(imdata)
text(20,20, ['This image, taken by the Hubble Space Telescope, shows a ' ...
            'very complex planetary nebula.'],'Color','w')
text(20,40, ['It is nicknamed the "Cat''s Eye Nebula" and is about 1,000 '...
            'years old. (NASA)'],'Color','w')
set(gca,'XtickLabel',[],'YtickLabel',[]),shg
%%
% * Isolate red, green, and blue
im_r = imdata; im_r(:,:,2:3)=0;
im_g = imdata; im_g(:,:,[1 3])=0;
im_b = imdata; im_b(:,:,1:2)=0;
subplot(1,3,1), image(im_r), axis image; set(gca,'XtickLabel',[],'YtickLabel',[])
subplot(1,3,2), image(im_g), axis image; set(gca,'XtickLabel',[],'YtickLabel',[])
subplot(1,3,3), image(im_b), axis image; set(gca,'XtickLabel',[],'YtickLabel',[])
%%
% * Convert to grayscale
im_gr = rgb2gray(imdata);
subplot(1,2,1); imshow(imdata);
subplot(1,2,2); imshow(im_gr);
%%
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
clear cns; 
for k=1:No 
    cns(k,:) = stats(k).Centroid;
    areas(k,:) = stats(k).Area; 
end
hold on; plot(cns(:,1),cns(:,2),'r*')
subplot(2,2,4); hist(areas)
%% Additional resources
% * <http://nyu.libguides.com/content.php?pid=38898&sid=1554472 Data Services Training page>
% * Data Services Staff <data.services@nyu.edu> or <http://bit.ly/datameeting make an
% appointment>
% * Author contributed files at <http://www.mathworks.com/matlabcentral/fileexchange/ MATLAB File
% Exchange>
%% Follow-up Survey
web('http://bit.ly/IntroMatlab')

