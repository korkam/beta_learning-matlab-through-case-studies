function [crr,slope,npts] = nancorr(x,y)
%%
% compute correlation between vectors x and y ignoring NaNs in both
% x and y must have the same number of elements; if either is a matrix it
% is converted into a vector
% returns correlation coefficient, slope of y/x and number of non-NaN points used
% $\textrm{Correlation } \textrm{coefficient: }  \rho = \frac{cov(x,y)}{\sigma _{x} \sigma _{y}}$
if numel(x) ~= numel(y)
    disp('Inputs must have the same number of elements.')
    return
end
nns = logical(~isnan(x(:)).*~isnan(y(:)));
x = x(nns);
y = y(nns);
npts = size(x,1);
mx2 = mean(x.^2,1);
mx  = mean(x,1);
mxy = mean(x.*y,1);
my = mean(y,1);
covxy = (mxy-mx.*my);
vx = (mx2-mx.^2);
slope = covxy./vx;  % slope = cov(X,Y)/var(X)
my2 = mean(y.^2,1);
vy = (my2-my.^2);
crr = covxy./sqrt(vx.*vy);