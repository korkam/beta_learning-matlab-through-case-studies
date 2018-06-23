% pr2_1.m
% Aliasing
% example signal
t=0:0.001:1;                    % A 1 sec signal calculated every msec
f=20;                           % frequency in Hertz
signal=sin(2*pi*f*t);

% Simulate different sample rates and plot
figure;

for skip=2:5:50;
    plot(t,signal,'r'); hold;   % The Original Signal
    plot(t(1:skip:1000),signal(1:skip:1000));
    tt=['Sine' num2str(f) ' Hz: space bar to continue: SAMPLE RATE = ' num2str(1000/skip)];
    title(tt);
    drawnow
    pause;
    clf;
end;