% pr13_1.m
% image filter to enhance contrast
% using a matrix of lena

clear;
load lena_double;               % load the 512 x 512 matrix
lena=mat2gray(lena_double);     % convert the matrix to a gray scaled image
imshow(lena)                    % show the picture
title('Lena - Original')

% Assume we want to find contrasting areas in the horizontal direction.
% We use a high-pass filter to find sudden vertical transitions(edges) and to 
% remove gradual changes in the image 
[b,a]=butter(1,100/256,'high');         % make a high-pass filter based on 
                                        % a sample rate of 1 pixel and Nyquist of
                                        % 256
lenah=lena_double; 
for k=1:512;
    lenah(k,:)=filtfilt(b,a,lenah(k,:));    % use filtfilt to prevent phase shift
end;

lenahh=mat2gray(lenah);
figure
imshow(lenahh)
title('Lena - Horizontal Filter to Find Predominantly Vertical Edges')

% The same for the Vertical direction
lenav=lena_double; 
for k=1:512;
    lenav(:,k)=filtfilt(b,a,lenav(:,k));
end;

lenavv=mat2gray(lenav);
figure
imshow(lenavv)
title('Lena - Vertical Filter to Find Predominantly Horizontal Edges')

% Add the two
lena_edge=lenah+lenav;
lena_ee=mat2gray(lena_edge);
figure
imshow(lena_ee)
title('Lena - Edges')

% Add the Edges to the original
lena_enhanced=lena_double+lena_edge;
lena_enh=mat2gray(lena_enhanced);
figure
imshow(lena_enh)
title('Lena - Enhanced')



