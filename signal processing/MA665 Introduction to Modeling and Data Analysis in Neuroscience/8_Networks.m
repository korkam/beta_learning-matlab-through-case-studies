%%  MA665 - Lab 8:  Networks.
%   In this lab we will explore some techniques to create and analyze
%   networks.  Our focus will center on general properties of networks that
%   could apply to biological networks, computer networks, social networks,
%   etc.

%%  Preliminaries.
%   Text preceded by a '%' indicates a 'comment'.  This text should appear
%   green on the screen.  I will use comments to explain what we're doing 
%   and to ask you questions.  Also, comments are useful in your own code
%   to note what you've done (so it makes sense when you return to the code
%   in the future).  It's a good habit to *always* comment your code.  I'll
%   try to set a good example, but won't always . . . 

%%  NOTES - Challenge Problems.
%   You'll find 6 challange problems below.  Your task --- answer
%   at least 1 of them.  Present your results to me in whatever format you think is
%   appropriate.  Your solutions should include figures (with axes labeled
%   and captions) and explanatory text.  Also, please include any
%   MATLAB code you write;  remember to include comments in the
%   code.  The comments should be detailed enough that you could share your
%   code with any of your classmates / colleagues.  Watch out for *Extreme*
%   Challenge problems --- they're tricky.  If you email me your solutions
%   please send as PDF.
%
%   IMPORTANT NOTE:  I need to submit grades for MA665 on Saturday - so
%   submit this assignment by Saturday afternoon.

%%  Part 1:  Constructing simple networks.  
%   In class, we discussed examples of simple 5-node networks, and a
%   variety of measures applied to these networks.  Here we will construct
%   these networks in MATLAB, and apply analysis functions to these
%   networks.  Let's start by considering the network drawn here,
%
%   http://makramer.info/MA665/net1.jpg
%
%   This network consists of five nodes (N=5) and 4 edges.  We can represent
%   the edges between nodes in multiple ways.  For example, we can list all
%   pairs of nodes that possess edges, 
%
%   (1,2)  (1,3)  (1,4)  (1,5)
%
%   Note that we could just have well as written,
%
%   (2,1)  (3,1)  (4,1)  (5,1)
%
%   The order of the nodes is irrelevant;  an edge that connects node 1 to
%   node 2 also connects node 2 to node 1.
%
%   We can also create a *matrix* to represent these results.  To
%   do so, let's first define an empty matrix with the number of rows and
%   columns equal to the number of nodes,

A = zeros(5,5);

%   Each row and column now represents an individual node;  for example,
%   the first row and first column represents node 1, the second row and
%   second column represents node 2, and so on.  Now, let's add values to
%   this matrix that represent the *edges*.  To do so, we place the value
%   >>1<< in the appropriate (row,column) of the matrix to represent each
%   edge.  For example, to represent the edge that connects node 1 to node
%   2, we update A:

A(1,2) = 1;

%   Our matrix "A" now indicates the location of one edge, between node 1
%   and node 2.  We must also update the matrix to indicate the edge
%   between node 2 and node 1 (the opposite of the above),

A(2,1) = 1;

%   Let's now repeat this procedure for all edges in our network,

A(1,3) = 1;
A(3,1) = 1;
A(1,4) = 1;
A(4,1) = 1;
A(1,5) = 1;
A(5,1) = 1;

%   Now, we have completely specified the edges in our network using the
%   matrix "A".  It's useful to visualize "A", and we can do so in two
%   ways.  First, simply type "A" at the command line and look at the
%   output,

A

%Q:  Does the output at the command line make sense?  Can you look at this
%matrix printout and see that node 1 connects to all other nodes (except itself)?

%   Another way to examine "A" is through the following command,

spy(A)
xlabel('Node #');  ylabel('Node #')

%Q:  Again, can you examine this figure and quickly determine which node
%pairs possess edges?

%   The matrix "A" is called the *adjacency matrix*.  A value of 1 in this
%   matrix indicates that two nodes share an edge (i.e., that the two nodes
%   are "adjacent").  A value of 0 indicates no edge between the choosen
%   node pair.  In our case, the matrix is always *symmetric*, or
%
%       A(i,j) = A(j,i)
%
%   This always occurs for binary, undirected networks --- if node "i"
%   connects to node "j", then node "j" connects to node "i".

%%  Part 2:  Network measures.
%   The reason to construct the adjacency matrix is that we can now perform
%   operations on this matrix.  Namely, we can compute interesting
%   quantities, like the degree of each node, the path length between
%   nodes, and the clustering coefficient.  Let's do so now, starting with
%   the degree.

%%  Part 2a:  Degree:  The number of edges that touch a node.
%
%   If we print or plot "A", we can count the number of edges that touch
%   each node --- we simply count the number of 1's we see in each row.
%   Let's look at row #1 of A,

A(1,:)

%   There are four 1's (remember that node 1 connects to all other nodes).
%   Therefore, the degree of node 1 is 4.  We can do the same for row #2,

A(2,:)

%   And we find that the degree of node 2 is 1.  We can repeat this
%   procedure for each node, but printing "A" and counting 1's by hand is
%   boring.  There's a easier way to do this, using built in routines in
%   MATLAB.  Namely, let's define a new variable "deg" that
%   holds the >>sum<< of "A" over columns,

deg = sum(A,2);

%Q:  Examine the variable "deg".  Does it match your expectations for the
%degree of each node?  [Have you seen the command "sum" before?  If not,
%check out MATLAB Help.]

%   As a summary measure for the entire network, it's useful to compute the
%   *average* degree of all nodes.  Again, that's easy to do using simple
%   commands in MATLAB,

avg_deg = mean(deg);

%Q:  Examine the average degree.  Does the value make sense for this
%network?

%%  Part 2b:  Clustering coefficient:  The number of completed triangles in
%   a network (i.e., are my friends also friends?).
%
%   To compute the clustering coefficient for our network, we'll first need
%   to download a MATLAB function.  Please visit this website,
%
%   https://sites.google.com/site/bctnet/measures/list
%
%   And download the function titled:  "clustering_coef_bu.m"
%
%   If you're interested, open this function in the MATLAB Editor and see
%   what's inside.  Can you make sense of this code?  This function
%   (implemented by Olaf Sporns and colleagues) takes as input our
%   adjacency matrix "A" and computes the clustering coefficient of each
%   node.  It's simple to use,

cc = clustering_coef_bu(A);

%Q:  Examine the output variable "cc".  This returns the clustering
%coefficient for each node.  Do the values it returns make sense (are there
%*any* completed triangles in this network)?

%   To summarize the clustering coefficent of the entire network, it's
%   useful to compute the *average* clustering coefficient of the entire
%   network as follows,

avg_cc = mean(cc);

%Q:  Again, examine the value that results.  Does it make sense?

%%  Part 2c:  Path length:  The number of edges traveled from node to node.
%
%   The final measure we'll consider is the path length between all pairs
%   of nodes.  To compute it, we'll need one more MATLAB function, found
%   here,
%
%   https://sites.google.com/site/bctnet/measures/list
%
%   Download the function:  "distance_bin.m"
%
%   If you're interested, open this function in the MATLAB Editor and try to
%   make sense of it.  This function (again implemented by Olaf Sporns and
%   colleagues) takes as input our adjacency matrix and returns the distance
%   (i.e., the number of edges travelled) between each node pair.  It's
%   also easy to use:

dist = distance_bin(A);

%Q:  Type "dist" at the command line and look at it.  Compare it to the
%picture of the network and our results we computed for the path length in
%class.  Does it make sense?  Also, notice that "dist" is symmetric:  the
%distance from node i to node j is the same as the distance from node j to
%node i.

%  Having computed the path length between each node pair, let's now
%  compute the *average path length*.  This is a bit complicated ...
%  there's some redundancy in "dist", and we don't want to count the
%  distance from node i-to-j *and* from node j-to-i.  So what we'll do is
%  sum up all values of "dist" and then divide by 2 (to account for the
%  redundancy):

apl = sum(dist(:))/2;

%  One last thing --- we need to scale this sum by the number of possible
%  node pairs.  The forumla for this that we wrote in class is:
%
%       # possible node pairs = N*(N-1)/2
%
%  In our case, N=5, so (finally) we can compute the average path length,
%  scaled appropriately,

N=5;
apl = sum(dist(:))/2   /   (N*(N-1)/2);

%Q:  Examine the value you compute for the average path length.  Does it
%seem reasonable?  Does it match the value we found in class?

%%  Part 2-Summary.
%   We've now implemented three network measures:
%       1)  Average degree
%       2)  Average clustering coefficient
%       3)  Average path length
%   These measures are useful because each provides a simple (single
%   number) summary of the network structure.  Such summary measures are
%   especially important as networks become more and more complicated.
%
%   Let's now apply these measures to some additional networks.
%
%Q (Challenge #1):  Visit the following link and examine the network,
%
%       http://makramer.info/MA665/net2.jpg
%
%Construct an adjancy matrix "A" for this network.  Then compute the
%average degree, average clustering coefficient, and average path length
%for this network using the MATLAB routines examined above.  Compare these
%results to those found for the 5-node network we analyzed in Part 2.  How
%do the values of each measure change?

%Q (Challenge #2):  Visit the following link,
%
%       https://sites.google.com/site/bctnet/datasets
%
%And download the data set "macaque71.mat".  The downloaded file contains a
%matrix (CIJ) that represents the connectivity of macaque cortex.  It
%consists of 71 nodes (which matches the matrix dimensions).  Notice that
%this matrix is *NOT* symmetric;  the network in this case is DIRECTED.  In
%other words, if node i connects to j, then node j does *not* necessarily
%connect to node i.  So we'll first make a simplifying assumption here and
%force the network to be symmetric, like this,
%
%       CIJ = CIJ + transpose(CIJ);
%       CIJ = heaviside(CIJ-0.5);       <--- Trickery here.  Make sense?
%
%After these manipulations, we've thrown out all direction information.
%The new matrix CIJ simply indicates that two nodes (i,j) connect, not the
%direction of the connection.
%
%Analyze this updated (now undirected) matrix CIJ.  Compute the average
%degree, average path length, and average clustering coefficient.

%Q (Challenge #3):  Find a binary, undirected network in the real world.  Compute
%its average degree, average path length, and average clustering coefficient.
%For some real-world networks, you might look here,
%
%   http://netwiki.amath.unc.edu/SharedData/SharedData
%   http://math.bu.edu/people/kolaczyk/datasets.html

%Q (Nearly impossible challenge):  Try *not* to waste an infinite amount of
%time here,
%
%   http://oracleofbacon.org/

%%  Part 3:  Regular network.
%   So far, we've developed a simple network (consisting of 5 nodes) with a
%   pre-specified connectivity pattern. Let's now develop some more
%   complicated networks.  We'll start with a *regular* network.  What
%   makes a network "regular" is the mesh-like connections between
%   neighboring nodes.  To develop this network, first we'll specify the
%   number of nodes (N) and the number of neighbors of each node (k):

N=200;      %There are 200 nodes.
c=5;        %Each node has 2*c neighbors (i.e., k=2c).

%   Then to create the network, execute the following commands:

r = zeros(1,N);  r(2:c+1)=1;  r(N-c+1:N)=1;
A = toeplitz(r);

%   A lot happens in the previous two lines.  In the first, we define the
%   edges that touch node 1.  This node has N possible edges (if we allow
%   self connections), so make a vector of zeros to hold these edges (r).
%   Then, connect node 1 to it's c-neighbors on the right (nodes 2,3,4,5,6)
%   and it's c-neighbors on the left (196,197,198,199,200).  Notice that
%   the connectivity "wraps around" from low node numbers to high node
%   numbers;  we can think of the nodes as living on a circle.  Imagine
%   moving in a clockwise direction around the circle.  Eventually 
%   the angle increases from 357 degrees, to 358 degrees, to 359 degrees,
%   and we return to 0 degrees, then increase to 1 degrees, 2 degrees, and
%   so on.  In this sense, we continue to "wrap around" the circle.  In the
%   second line of code, we use a shifted-version of the vector "r" to define
%   each row of "A".

%   Let's plot this matrix and see what it looks like,

spy(A)
title(['Regular Graph with ' num2str(sum(A(:))) ' edges'])
xlabel('Node #');  ylabel('Node #')

%   Notice the structure of the connections;  almost all of the connections
%   lie along the main diagonal.  That's always the case for a regular
%   network --- node i connects to node i+1, i-1, i+2, i-2, and so on
%   (depending on c).  Also notice that node 1 connects to node 200.  In
%   this case, the regular network is a *ring*;  we can walk from
%   1-2-3-...199-200-1-2-3-...

%%  Part 4:  Random graph.  
%   Next, let's define a random graph.  To do so, we'll fix the probability
%   (p) of including an edge between each node pair.  Then, for each node
%   pair we'll flip a (biased) coin, and if the coin flip results in
%   success include an edge between the node pair.  Here is the code:

N = 200;                                %Define the number of nodes.
p = 0.1;                                %Define the probability of success.
A = zeros(N);                           %Define A (initially with no edges)
for i=1:N                               %For each node i,
    for j=i+1:N                         %  and each node j>i
        if poissrnd(p)                  %    flip the biased coin 
            A(i,j)=1;                   %      if success, an edge i->j
            A(j,i)=1;                   %      and an edge j->i
        end
    end
end

%Q (Challenge #4):  Fix N=200 and construct a regular network and random
%network.  For the *regular* network, fix c=10.  For the *random* network
%fix p=0.1.  For each network compute the average degree, average
%clustering coefficient, and average path length.  Compare your results to
%the formulas we wrote for each quantity in class.

%%  Part 5:  Small world networks.
%   Next, let's construct a small world network.  We discussed in class why
%   small world networks are an appealing model for the brain.  These
%   networks possess short path lengths (so information travels quickly)
%   and high clustering coefficients (or high connectivity between
%   neighbors).  To create a small world network, first download from the
%   course website the function,
%
%       make_small_world.m
%
%   Examine this code and see if you can make sense of it.  Then execute this
%   function as follows,

N = 200;        %Fix the number of nodes.
c = 5;          %We start with a *regular* network with 2*c edges per node.
p = 0.1;        %Then rewire these edges with probability p.

A = make_small_world(N,c,p);

%Q (Challenge #5):  Examine the network A created in the line above.  First
%plot it (e.g., "spy").  Can you see the shortcuts?  Then compute the average
%degree, average path length, and average clustering coefficient for "A".
%Compare these results to the values you expect for a regular and random
%network (use the formulas we derived in class!).

%Q (Difficult Challenge #6):  Fix N=200 and c=5.  Vary p from values near 0
%(e.g., 0.00001) to values near 1.  For each value of p, compute the
%average clustering coefficient <cc> and average path length <pl>.  Scale
%both values by the values expected for a *regular* network (HINT:  Use the
%formulas we derived in class).  Finally, plot the scaled <cc> and scaled
%<pl> versus "p".  Can you reproduce the figure we drew in lab?
