%Create a small world network.
%
%INPUTS:
%  N = # of nodes.
%  c = In the starting regular network, each node has 2*c neighbors.
%  p = the probability to rewire each edge.
%
%OUTPUTS:
%  A = the small world network.

function [A] = make_small_world(N,k,p)
  
  %First define a regular network.
  r = zeros(1,N);  r(2:k+1)=1;  r(N-k+1:N)=1;
  A = toeplitz(r);

  %Find each (i,j) pair where i>j --- that's all node pairs!
  [row, col] = find(triu(A));
  for k=1:length(row)           %For each (i,j) pair.
      i=row(k);
      j=col(k);
      if rand() < p             %Draw a random number [0,1].  If it's < p,
          A(i,j)=0;             %  then eliminate this edge (i,j),
          A(j,i)=0;             %  and eliminate (j,i).
          inew=1;
          jnew=1;               %Now find a new edge.
          while inew == jnew || A(inew,jnew) ==1        %If i==j or the edge already exists,
              ijnew = randperm(N);                      %Then guess a new (i,j) pair.
              inew = ijnew(1);                          %Repeat until we find a new possible edge.
              jnew = ijnew(2);
          end
          A(inew,jnew)=1;       %Put the new edge in the network.
          A(jnew,inew)=1;
      end
  end
  
end