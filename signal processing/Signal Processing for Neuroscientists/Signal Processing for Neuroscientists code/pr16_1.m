% pr16_1.m
% cwt analysis (continuous wavelet transform) using 
% CONVOLUTION and CORRELATION
% using a Mexican hat wavelet (MHW)

clear;
msg=('Pls. wait and MAXIMIZE COLOR PLOTS!')

N=2048;                         % # of points
maxlag=N/2;                     % here maxlag is used to zoom in on the correct part of C
C=zeros(128,2*N-1);             % initialize  convolution array
CC=zeros(128,2*maxlag+1);       % initialize correlation array
figure

% Input signal with m from 0 - 1
for n=1:N;
    m=(n-1)/(N-1);  
    tg(n)=m;
    g(n)=sin(40*pi*m)*exp(-100*pi*(m-0.2)^2)+(sin(40*pi*m)+2*cos(160*pi*m))*exp(-50*pi*(m-0.5)^2)+2*sin(160*pi*m)*exp(-100*pi*(m-0.8)^2);
end; 

% Mexican Hat, a symmetrical real function
w=1/8;                  % NOTE:  standard deviation parm w=1/8 
index=1;

for k=0:128;            % Use 8 octaves and 16 voices 8 x 16 = 128 
    s=2^(-k/16);        % 16 voices per octave
                        % Note that the scale decreases with k
    for n=1:N;
        % Mexican hat from -½ to ½ 
        m=(n-1)/(N-1)-1/2;              % time parameter
        if (k == 0)
            tmh(n)=m;                   % time axis for the plot
        end;
        mh(n)=2*pi*(1/sqrt(s*w))*(1-2*pi*(m/(s*w))^2)*exp(-pi*(m/(s*w))^2);
    end;
    
    if (k == 0)                           % plot wavelet example
    
        subplot(2,1,1), plot(tmh,mh,'k'); axis('tight')
        ylabel ('Amplitude');
        title(' Mexican Hat');
    
    end;
        
    % save the inverted scales 
    scale(index)=1/s;
    
    % convolution of the wavelet and the signal
    C(index,:)=conv(g,mh);
    % Correlate the wavelet and the signal
    CC(index,:)=xcorr(g,mh,maxlag);
    
    index=index+1;

end;

% Plot the results
subplot(2,1,2), plot(tg,g,'r'); axis('tight')
xlabel ('Time ');
ylabel ('Amplitude');
title(' Original Signal containing 20 Hz and 80 Hz components');

figure
pcolor(C(:,maxlag:5:2*N-maxlag).^2);
xlabel ('Time (Sample#/5)');
ylabel ('1/Scale#');
ttl=[' Convolution based Scalogram NOTE:Maxima of the CWT are around the 1/scale # (70) and (38). Ratio = ' num2str(scale(70)/scale(38))];
title(ttl);

figure
pcolor(CC(:,1:5:2*maxlag+1).^2);
xlabel ('Time (Sample#/5)');
ylabel ('1/Scale#');
ttl=[' Correlation based Scalogram NOTE: Maxima of the CWT are around the scale # (70) and (38). Ratio = ' num2str(scale(70)/scale(38))];
title(ttl);
