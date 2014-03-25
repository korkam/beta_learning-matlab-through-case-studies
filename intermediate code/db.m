%%
% 
% Suppose you want to create an $$10 \times 8$ array $$B$ , where each element 
% $$ b_{ij}$ is chosen randomly, with uniform distribution in [0,1]. 
% Afterwards, create an array $$ C$ , such that $$ c_{ij}=1$ if  $$ b_{ij}<\sqrt{\bar{B}}$, and $$ c_{ij}=0$ otherwise, where $$ \bar{B}$ represents the mean of the squared elements of $$B$ , i.e.  $$ \displaystyle \bar{B}=\frac{1}{mn}\sum_{i=1}^m\sum_{j=1}b_{ij}^2.$
% 
function C = db
r = 10; 
c = 8;

C=zeros(r,c);
% compute random elements of B
B=rand(r,c);

Bbar=mean(B.^2);
% Create C
for m=1:c
    for n=1:r
        if B(n,m)<sqrt(Bbar);
            C(n,m)=1;
        else
            C(n,m)=0;
        end
    end
end

% compute C in a quicker way
% Cf = getC(B);
% sum(Cf(:)-C(:))
% end
% 
% function C = getC(B)
% 
% Bbar=mean(B(:).^2);
% C = B < sqrt(Bbar);
% end

% Bbar=mean(mean(B.^2)')
