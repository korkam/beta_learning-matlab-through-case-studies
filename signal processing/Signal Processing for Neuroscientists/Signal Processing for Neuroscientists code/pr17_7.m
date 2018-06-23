% pr17_7.m
 clear;
 le=400;
 figure;
 
for k=1:le;x(k)=sin(k/(le/le-3));end;                                                   % Sine map
subplot(6,2,1); plot(x,'k');axis('off');                                                % time series
subplot(6,2,2); hold;for n=2:length(x); plot(x(n-1),x(n),'k.');end; axis('off');        % phase space
for k=1:le;x(k)=rand(1);end;                                                            % Random map
subplot(6,2,3); plot(x,'k');axis('off');                                                % time series
subplot(6,2,4); hold;for n=2:length(x);plot(x(n-1),x(n),'k.');end; axis('off');         % phase space
x(1)=.397; for k=2:le;x(k)=4*x(k-1)*(1-x(k-1));end;                                     % Logistic map
subplot(6,2,5); plot(x,'k');axis('off');                                                % time series
subplot(6,2,6); hold;for n=2:length(x);plot(x(n-1),x(n),'k.');end; axis('off');         % phase space
x(1)=0; y(1)=0;for k=2:le;x(k)=y(k-1)+1-1.4*x(k-1)^2;y(k)=0.3*x(k-1);end;               % Henon map 1 for x(1)=0
subplot(6,2,7); plot(x,'k');axis('off');                                                % time series
subplot(6,2,8); hold;for n=2:length(x);plot(x(n-1),x(n),'k.');end; axis('off');         % phase space
xx(1)=1e-5; y(1)=0;for k=2:le;xx(k)=y(k-1)+1-1.4*xx(k-1)^2;y(k)=0.3*xx(k-1);end;        % Henon map 2 for xx(1)=1e-5
subplot(6,2,9); plot(xx,'k');axis('off');                                               % time series
subplot(6,2,10); hold;for n=2:length(xx);plot(xx(n-1),xx(n),'k.');end; axis('off');     % phase space
xxx=xx-x;                                                                               % Effect initial condition
subplot(6,2,11); plot(xxx,'k');axis('off');                                             % time series
subplot(6,2,12); hold;for n=2:length(xxx);plot(xxx(n-1),xxx(n),'k.');end; axis('off');  % phase space