% Exercise 6.2.6. Circular Modulation.

%   Copyright 2012-2016, Ilias S. Konsoulas.

%% Workspace Initialization.

clc; clear; close all;

%% Step (a). Generate a 64-point sequence x[n].
n = 0:63;
x0 = [ones(1,16) zeros(1,48)];
x1 = (-1).^n.*x0;
x2 = 1i.^n.*x0;
x3 = (-1i).^n.*x0;
x = [x0; x1; x2; x3;]; % Place them altogether in a single matrix for ease of manipulation.

title_strings = ['         x_0[n]      ';
                         'x_1[n] = (-1)^nx_0[n]';
                         'x_2[n] = j^nx_0[n]   ';
                         'x_3[n] = (-j)^nx_0[n]';];

%% Step (b). Evaluate the four 64-point DFT's.
% Now compute the 64-point DFTs of x0[n] to x4[n]:
X = zeros(4,64);
for i=1:4
     X(i,:) = my_DFT(x(i,:));
end
 
figure('Name','Exercise 6.2.6. Circular Modulation');
% Plot the DFT magnitudes of x0[n] to x3[n]:
for i=1:4
    
    if i<=2
        subplot(4,3,3*i-2);
        stem(n,x(i,:),'b.');
        title(title_strings(i,:));
        xlabel('Sample Number n');
        axis tight;
        grid on;
    else
        subplot(4,3,3*i-2);
        stem3(n,real(x(i,:)),imag(x(i,:)),'b.');
        title(title_strings(i,:));
        xlabel('Sample Number n');
        axis tight;
        grid on;
    end

    subplot(4,3,3*i-1);
    stem(n,abs(X(i,:)),'r.');
    title(['|X_',int2str(i-1),'[k]|']);  
    xlabel('Sample Number k');
    axis tight;
    grid on;

    % Plot the DFT phases of x[n] and y[n]:
    subplot(4,3,3*i);
    stem(n,angle(X(i,:)),'.k');
    title(['\angleX_',int2str(i-1),'[k]']);
    xlabel('Sample Number k');
    axis tight;
    grid on;

end
