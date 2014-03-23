%% Session 2: MATLAB Basics 2
% a gentle introduction (adapted from Kendrick Kay)

%% 6. Indexing into matrices 
% - To access the elements of a matrix, we use indexing. Indexing is accomplished through the use 
% of positive integers referring to the various positions in a matrix. MATLAB's convention is to 
% use 1-indexing, meaning that the first element is indexed by 1. For example, b(5,[1 3]) 
% refers to the first and third elements in the fifth row of b; when evaluated, the expression 
% returns a row vector with two elements. 
% - The colon (:) is a special symbol that means all indices along a given dimension. 
% - The keyword end is a shortcut for the index of the last element along a given dimension. - For the purposes of indexing, MATLAB can automatically treat a matrix as a vector. For 
% example, b(100) refers to the 100th element of b (regardless of the dimensionality of b). The 
% order of indexing is row-first. For example, suppose a = [1 2; 3 4]. Then, a(2) is equal 
% to 3. 
% - Indexing can also be used to selectively modify the contents of a matrix. This is done by using 
% indexing on the left-hand side of an assignment. For example, b(3,:) = [1 2 3] changes 
% the contents of the third row of b. 
% - A special indexing shortcut is b(:) which returns all of the elements of b as a column vector. 
% - It is possible to assign a scalar to multiple elements. This is because MATLAB automatically 
% repeats the scalar for you. For example, b(3,:) = 7 is a valid command that sets all 
% elements in the third row of b to 7. 

%%  7. Useful matrix-manipulation operations 
% size - return the dimensionality of a matrix size([1 2 3]) à [1 3] 
% length - return the number of elements in a vector length([1 2 3]) à 3 
% reshape - change the dimensionality of a matrix without altering its contents reshape([1 2 3 4],[2 2]) à [1 3; 2 4] 
% permute - change the order of dimensions of a matrix permute([1 2 3 4],[2 1]) à [1; 2; 3; 4] 
% ' - swap the dimensions of a 2D matrix [1 2 3 4]' à [1; 2; 3; 4] 
% repmat - replicate the contents of a matrix, forming a larger matrix repmat([1 2],[1 3]) à [1 2 1 2 1 2] 
% bsxfun - automatically apply repmat as required by certain function calls bsxfun(@plus,[1 2 3],[5 5 5; 6 6 6]) à [6 7 8; 7 8 9] 
% find - convert logical indices into integer indices find([2 5 6 2]==2) à [1 4] 

%%  8. Basic mathematical operations 
% + - * / ^ - add, subtract, multiply, divide, exponentiate 1+1 à 2 
%  2*[4 6] à [8 12] 2^3 à 8 
% sqrt - square root sqrt([4 25]) à [2 5] 
% exp - exponential exp(1) à 2.718 
% log, log10 - natural logarithm, base-10 logarithm log10(100) à 2 
% abs - absolute value abs(-3) à 3 
% .+ .- .* ./ .^ - apply operations element-wise [2 4 6].*[3 1 2] à [6 4 12] 
% round, floor, ceil - convert decimals to integers floor(5.1) à 5 
% min, max - find the minimum or maximum min([10 2 5]) à 2 
% sum - add all elements sum([1 2 3]) à 6 

%%   9. Other operations 
% < > <= >= == ~= - various logical comparisons 5 > 4 à 1 [10 0 1] == 10 à [1 0 0] 
% : - construct a series of equally spaced numbers 1:.5:3 à [1 1.5 2 2.5 3] 5:-1:1 à [5 4 3 2 1] 5:8 à [5 6 7 8] 
% mean, median, std, var, prctile - statistical operations median([1 2 3]) à 2 prctile([1 2 3],50) à 2 
% sort, union - list operations sort([3 1 2 2]) à [1 2 2 3] union([1 2],[4 2 2 1]) à [1 2 4] 
% rand, randn, randperm - randomization operations randn(1,5) à [1.368 0.656 1.931 1.826 -1.206] randperm(5) à [2 4 5 3 1] 
% fprintf, sprintf - text-printing operations fprintf('%.5f',pi) à '3.14159' is written to the command window fprintf('The answer is %d.',10) à 'The answer is 10.' is written to the command window 
% isempty, isnan, isfinite - data-checking operations isempty([]) à 1 isnan([1 NaN 10]) à [0 1 0] isfinite([1 2 Inf NaN]) à [1 1 0 0] 
% fopen, fclose - file-manipulation operations fid = fopen('test.txt','w'); fprintf(fid,'%d %d %d',1,2,3); fclose(fid); à '1 2 3' is written to a file called 'test.txt' 
%  