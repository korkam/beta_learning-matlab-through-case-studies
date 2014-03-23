%% Session 1: MATLAB Basics 1
% a gentle introduction (adapted from Kendrick Kay)
 
%% 1. The MATLAB environment 
% - Variables hold things, such as numbers, matrices, strings, etc. Variable names are simple 
% alphanumeric strings (e.g. rec, ABC, or var123). 
% - The workspace is the collection of variables that currently exist. Variables can be defined by 
% the user, or can be loaded into the workspace from a file. Variables can be saved from the 
% workspace to a file. When the MATLAB session ends (i.e. MATLAB is quit), the workspace is 
% lost. 
% - The command window is where you interact with MATLAB. The command prompt (>> ) is 
% where you type a command. 
% - The GUI (graphical user interface) is all the pretty stuff that surrounds the command window 
% (menus, other windows, etc.). The GUI is helpful for various things (e.g. debugging, managing 
% files) but is not essential. You can run MATLAB without the GUI. 
% - Functions accept input and return output. There are built-in functions (e.g. inv) that have no 
% readable source code, functions that come with MATLAB (e.g. mean) that have readable 
% source code, and user-written functions. Importantly, functions cannot access nor modify the 
% workspace except through inputs and outputs. 
% - Scripts are text files that consist of a series of MATLAB commands. Scripts are similar to 
% user-written functions (which are also text files consisting of a series of MATLAB commands). 
% However, the crucial difference is that scripts do not operate on inputs and outputs. Rather, 
% scripts have direct access to the workspace, so they can freely read variables from the 
% workspace and write variables to the workspace. 
% - Functions and scripts written by the user are saved as .m files. These are text files. 
% - MATLAB saves variables into .mat files. These are binary files that can be read by MATLAB. 
  
%% 2. Interacting with MATLAB 
% - To interact with MATLAB, just type a command into the command window. 
% - If a command is not ended with ;, the result of evaluating the command is displayed in the 
% command window. 
% - If the output is not assigned to a variable, it is automatically assigned to a variable called ans. 
% - Typically, a command is either an expression (e.g. 1+1) or an assignment (e.g. a=1+1). 
  
%%  3. Basic commands for navigating the MATLAB environment 
% - whos - provide information on variables that currently exist in the workspace 
% - clear <variable name> - remove the variable from the workspace 
% - clear all - remove all variables from the workspace 
% - help <function> - get help on a function 
% - type <function> - show the code that underlies a function 
% - edit <function> - edit the code that underlies a function 
% - which <function> - show the location of the file that defines the function 
% - cd <path> - change directory 
% - pwd - print the current working directory - ls - list files in current working directory
% - load <.mat file> - load the variables contained in the .mat file into the workspace
% - save <.mat file> - save the variables in the current workspace to the .mat file 
%  
%% 4. Basic data types 
% - The double data type is the standard MATLAB data type, allowing storage of numbers in 
% double precision (e.g. 5, -1.234, 3.14159265358979). 
% - The single data type has less precision than double and takes up half as much memory 
% (e.g. 3.141593). Unless memory is an issue, you do not need to worry about using single. 
% - The logical data type consists of 0s and 1s, which mean false and true, respectively. 
% - The char data type allows characters, such as 'a', 'T', and '!'. Characters can be 
% concatenated together into strings, such as 'abc' and 'The dog'. 
% - The cell data type allows different data types to be collected together (e.g. {1 'a'}). 
% - There are also integer data types such as uint8 and int16. 
% - Most of the time, numbers will be finite. However, there are special keywords that indicate 
% non-finite numbers. These include NaN (not-a-number), Inf (infinity), and -Inf (negative 
% infinity). NaNs are often used to indicate missing values. 

%%  5. Everything is a matrix 
% - Data in MATLAB are stored as matrices (also known as arrays). The individual components 
% that compose a matrix are called elements. 
% - Matrices can be constructed from different data types. For example, you might have a double 
% matrix or a logical matrix. 
% - A single number, or scalar, is a matrix with dimensions 1 x 1 (e.g. 5). 
% - A vector is a matrix that has a dimensionality of 1 in all but one dimension. Typically, a vector 
% is a row vector (e.g. [5 6 7] which has dimensions 1 x 3) or a column vector (e.g. [5; 6; 
% 7] which has dimensions 3 x 1). 
% - Matrices are often two-dimensional (e.g. [1 2 3; 4 5 6; 7 8 9]) but can have 
% arbitrary dimensionality (e.g. zeros(10,10,10,10)). 
% - It is possible for a matrix to be empty (no elements). The empty matrix is given by []. 
% - Strings are vectors of characters (e.g. 'abc' is a char vector of length 3). 
% - Cells are matrices that consist of heterogeneous elements (e.g. {1 'abc'} is a cell vector of 
% length 2). 
% - Matrices can be created through the use of brackets ([ ]). Semicolons (;) indicate the end of a 
% row. Matrices can also be created through the use of functions, such as zeros, ones, and 
% rand. Cell matrices can be created through the use of curly brackets ({ }). 
 