% RES = innerProd(MTX)
%
% Compute (MTX' * MTX) efficiently (i.e., without copying the matrix)

function res = innerProd(mtx)

res = mtx' * mtx;
