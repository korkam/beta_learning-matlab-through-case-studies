% im_phantom: example of an imaging app
clear

P=phantom('Modified Shepp-Logan');

figure                              % Depict P
imagesc(P)
title('Shepp-Logan Original')

% Create Projections
theta=0:1:180;                      % steps of theta
R=radon(P,theta);                   % radon transform
figure; imagesc(R);                 % show radon transform
title('Radon Transform')

figure;
message = ('Pls. wait......')
for step=1:20;
    theta=0:step:180;
    Rtemp=R(:,theta+1);
    p=iradon(Rtemp,theta);          %perform filtered backprojection 
                                    %NOTE: the iradon tranform includes high pass filtering
    imagesc(p);                     %show result
    t=['Step size (1-20 degrees) = ' num2str(step) ' degree(s) PLS. PRESS Enter KEY'];
    title(t);
    drawnow
    message = ('Pls press Enter key and wait for the next result')
    pause
end;
