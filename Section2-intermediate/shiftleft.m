function [s1,s2] = shiftleft(R,C)
% shiftleft(4,3)
% shiftleft(1e3,1e3);
% shiftleft(1e5,1e2);
% shiftleft(1e2,1e5);
x=rand(R,C); x(x<0.8)=NaN;

tic
    i=reshape(1:numel(x),size(x));
    nx = ~isnan(x);
    
    i1 = rem(i(nx)-1, R) + 1; % Alternatively, [i1,~] = ind2sub(size(x),i(nx));
    i2 = cumsum(nx,2);
    i2 = i2(nx);              % Alternatively, i2 = nonzeros(cumsum(nx,2).*nx);
    
    s1 = nan(size(x));
    s1(sub2ind(size(x),i1,i2)) = x(nx);
toc

s2 = naiveshift(x);
s3 = naiveshift1(x);

% all(sort(s1(~isnan(s1)))==sort(x(nx)))
% all(s1(~isnan(s1))==s2(~isnan(s2)))

end

function x = naiveshift(x)
tic
for k=1:size(x,1)
    row = x(k,:);
    row = [row(~isnan(row)) row(isnan(row))];
    x(k,:) = row;
end
toc
end

function x = naiveshift1(x)
tic
for k=1:size(x,1)
    row = x(k,:);
    nr = isnan(row);
    row = [row(~nr) row(nr)];
    x(k,:) = row;
end
toc
end