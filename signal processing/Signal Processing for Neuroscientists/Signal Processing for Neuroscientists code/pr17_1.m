% pr17_1.m
% Feigenbaum Diagram

% NOTE: THIS PROGRAM REQUIRES 
% A SEVERAL MINUTES EXECUTION TIME!

msg=('Pls. wait several minutes')
clear;

xn=0.01;
figure; 
hold;
for a=2.5:.02:4;                % range for coefficient a
    for k=1:.1:200              % iterate for 200 steps
        xn=a*xn*(1-xn);         % logistic equation
         if (k>100)             % Do not show initial values <100
            plot(a,xn,'k.');    % Plot the data points
        end;
    end;
end;
xlabel('a')                     % Provide labels and title
ylabel('state')
title('Feigenbaum Diagram Logistic Equation')
