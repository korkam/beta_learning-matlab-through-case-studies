%% Start by creating and plotting some one-input, one-output data with 3 trials
input = [1 2 3]'
output = 0.7*input + 0.5 + randn(3,1)./4
plot(input, output,'o')
xlabel('input')
ylabel('output')
axis([0,4,0,4])

%% re-conceptualize this data in a new space, where each trial (or
% subject, or generally "observation" is a dimension, and the input
% and output are both vectors in this space.
plot3([0,input(1)], [0,input(2)], [0, input(3)], '-ob')
hold on;
plot3([0,output(1)], [0,output(2)], [0, output(3)], '-og')
legend('input', 'output')
xlabel('trial 1')
ylabel('trial 2')
zlabel('trial 3')
axis([0,4,0,4,0,4])
rotate3d on

%% using the projection formula for regression, find beta such that
% beta*input gets as close to the output as possible. We want to
% minimize the error term in output = beta*input + error
beta = dot(output,input)/dot(input,input)
prediction = beta*input
plot3([0,prediction(1)], [0,prediction(2)], [0,prediction(3)], '-ok')
legend('input', 'output', 'prediction')

%% 
% let's plot the distance from beta * input to the output. This is
% our error!
plot3([output(1),prediction(1)],[output(2),prediction(2)], ...
      [output(3),prediction(3)], '-r')

% note that error = sqrt((y(trial1)-prediction(trial1))^2 + 
%                        (y(trial2)-prediction(trial2))^2 +
%                        (y(trial3)-prediction(trial3))^2)
% Thus, thinking about this from the classical perspective, our
% error is the sqrt of the sum of squares. When the square root of
% the sum of squares is minimized, the sum of squares itself must
% also be minimized!
%%
% we can also plot this as a vector from the origin. Note that it's
% orthogonal to x.
error = output - prediction
plot3([0, error(1)], [0, error(2)], [0, error(3)], '-or')
legend('input', 'output', 'prediction', 'error')
hold off;
rotat3d off;
%%
% going back to our graphical visualization of the data, how does
% our regression line look? Note that since we have no intercept
% term, the line must pass through 0!
plot(input, output, 'o')
hold on
prediction_line_x = linspace(0,4,10)
%prediction_line_x = 0:.2:4
prediction_line_y = beta * prediction_line_x
plot(prediction_line_x, prediction_line_y, '-ok')
plot(input, prediction, 'om')
xlabel('input')
ylabel('output')
axis([0,4,0,4])


%% multiple regression
% suppose we wanted to fit a model with an intercept to our data?
% We could do this by adding a second, constant predictor, a vector
% of ones. now we have, roughly, output = beta(1)*input + beta(2)*ones() + error
constant = ones(3,1)
plot3([0,input(1)], [0,input(2)], [0, input(3)], '-ob')
hold on;
plot3([0,constant(1)], [0,constant(2)], [0, constant(3)], '-oc')
plot3([0,output(1)], [0,output(2)], [0, output(3)], '-og')
legend('input', 'constant', 'output')
xlabel('trial 1')
ylabel('trial 2')
zlabel('trial 3')
axis([0,4,0,4,0,4])
rotate3d on

%%
% using our generalized formula for regression, we can calculate
% our predictor coefficients and predictions as follows:
designmat = [input, constant];
betas = inv(designmat' * designmat)*designmat'*output;

prediction = designmat * betas;
x1component = designmat(:,1)*betas(1);
x2component = designmat(:,2)*betas(2);
%%
% now our prediction for y lives in the plane defined by the input
% and the constant term.
plot3([0,prediction(1)], [0,prediction(2)], [0,prediction(3)], 'ok')
plot3([0,x1component(1)], [0,x1component(2)], [0,x1component(3)], '-ok')
plot3([0,x2component(1)], [0,x2component(2)], [0,x2component(3)], '-ok')
legend('input', 'output', 'constant', 'prediction')


%%
plot3([output(1),prediction(1)],[output(2),prediction(2)], ...
      [output(3),prediction(3)], '-r')
error = output - prediction
plot3([0, error(1)], [0, error(2)], [0, error(3)], '-or')
legend('input', 'output', 'constant', 'prediction', '', '', 'error')
hold off;
%%
% Finally, lets plot our new regression line back in our more
% standard visualization space
plot(input, output, 'o')
hold on
prediction_line_x = linspace(0,4,10)
prediction_line_y = betas(1) * prediction_line_x + betas(2) * ones(1,10)
plot(prediction_line_x, prediction_line_y, '-k')
xlabel('input')
ylabel('output')
axis([0,4,0,4])

%%
% full scale example
%X = randn(1000,5);
%lifespan = X*[1,0.3,5,6,-2]' + randn(1000,1);
%p = inv(X'*X)*X'*lifespan

%% almost orthogonal
bloodpressure = randn(1000,1);
weight = randn(1000,1);
bloodpressure = bloodpressure - dot(bloodpressure,weight/norm(weight))*(weight/norm(weight));
lifespan = weight + 2*bloodpressure + randn(1000,1);
%%
p = dot(bloodpressure, lifespan)/dot(bloodpressure,bloodpressure)
%%
X = [bloodpressure weight];
p = inv(X'*X)*X'*lifespan
%%


%% almost colinear!
bloodpressure = weight+randn(1000,1)/100;
weight = randn(1000,1);
lifespan = 2*weight + randn(1000,1)/100;
%%
p = dot(bloodpressure, lifespan)/dot(bloodpressure, bloodpressure)
%%
X = [bloodpressure weight];
p = inv(X'*X)*X'*lifespan



