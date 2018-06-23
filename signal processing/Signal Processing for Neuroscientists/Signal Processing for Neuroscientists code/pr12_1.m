% pr12_1.m
% Filter Implementations for Impulse and Step response

clear
figure; hold;
% The basis is an analysis of a low-pass RC circuit
% we use R=10k and C=3.3uF
R=10e3;
C=3.3e-6;
RC=R*C;

%				 UNIT IMPULSE 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The analysis compares different approaches to obtain an
% impulse response

% Compared are:
%   1. 	The analog continuous time approach using the Laplace transform
%       	for the impulse response we obtain: 1=RCsH(s)+ H(s)
%       	after the inverse transform this is: h(t)=(1/RC)*exp(-t/RC)
%       	to compare with later discrete time approached we assume:
sample_rate=1000;
dt=1/sample_rate;
time=0.1;

i=1;
for t=dt:dt:time;
    yh(i)=(1/RC)*exp(-t/RC);
    i=i+1;
end;
plot(yh,'k')

%   2. 	The difference equation mode
%       	The difference equation: x(n*dt)=RC[(y(n*dt)-y(n*dt-1*dt))/dt] + y(n*dt)
%       	for the algorithm we set n*dt to n and obtain x(n)=[RC/dt]*[(y(n)-y(n-1))]+y(n)

A=RC/dt;
x=zeros(1,100);x(1)=1/dt;      % the input is an impulse at t=0 we correct the input            
                                                % with 1/dt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To be able to directly compare the analog and discrete impulse response, we have to 
% correct the amplitude of the impulse.  In case of a sampled signal we can assume the 
% impulse to be of duration dt and amplitude 1/dt. Therefore either the input (i.e. the 
% impulse) or the output (i.e. the impulse response) must be corrected for the amplitude % of 1/dt!!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y_previous=0;

for n=1:100;
    y(n)=(A*y_previous+x(n))/(A+1);
    y_previous=y(n);
end;
plot(y,'r') 

% 3. The z-domain solution
%       Set the equation in (2) above to the z-domain
%                               X(z)=(A+1)Y(z)-(A/z)Y(z)
%                               Y(z)=1/[(A+1)-A/z]
%       Transformed: y(n)=A^n/(A+1)^(n+1)
for n=1:100;
    yz(n)=A^n/(A+1)^(n+1);
end;
yz=yz/dt;       		% Because we calculated yz on the basis of the 
                                    % discrete impulse, we correct the output with 1/dt
plot(yz,'g')
title('Unit Impulse Response of a Low-Pass Filter')
xlabel('sample#')
ylabel('Amplitude')

%				 UNIT STEP 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure; hold;
% Compared are:
% 1. The analog continuous time approach using the Laplace transform
%       for the impulse response we obtain: 1=RCsH(s)+ H(s)
%       after the inverse transform this is: h(t)=(1/RC)*exp(-t/RC)
%       to compare with later discrete time approached we assume:
sample_rate=1000;
dt=1/sample_rate;
time=0.1;

i=1;
for t=dt:dt:time;
    yh(i)=1-exp(-t/RC);
    i=i+1;
end;
plot(yh,'k')

% 2. The difference equation mode
%       The difference equation: x(n*dt)=RC[(y(n*dt)-y(n*dt-1*dt))/dt] + y(n*dt)
%       for the algorithm we set n*dt to n and obtain x(n)=[RC/dt]*[(y(n)-y(n-1))]+y(n)
A=RC/dt;
x=ones(1,100);
y_previous=0;

for n=1:100;
    y(n)=(A*y_previous+x(n))/(A+1);
    y_previous=y(n);
end;
plot(y,'r') 
title('Unit Step Response of a Low-Pass Filter')
xlabel('sample#')
ylabel('Amplitude')
