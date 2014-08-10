%Implement a model of the sparse Pyramidal-Interneuron Network Gamma (sparse PING).
%Use Hodgkin-Huxley equations for individual neurons.
%Use Borgers et al, PNAS, 2008 to model the synapses
%  (see http://www.pnas.org/content/105/46/18023.abstract).

%INPUTS:
%  I0p = Injected current to P-cells.
%  gP  = strength of synapses P-to-I.
%  gI  = strength of synapses I-to-P.
%  tauI= decay time of inhibitory synapses.
%  eps = noise level to P- and I-cells.
%  T0  = total time of simulation [s].

%OUTPUTS:
%  VP = voltage of P-cells.
%  sP = excitatory synapses.
%  VI = voltage of I-cells.
%  sI = inhibitory synapses.
%   t = time axis vector (useful for plotting).

function [VP,sP,VI,sI,t] = sparse_ping(I0p,gP,gI,tauI,eps,T0)

  dt = 0.01;                        %The time step.
  T  = ceil(T0/dt);
  gNa = 120;  ENa=115;              %Sodium max conductance and reversal.    
  gK = 36;  EK=-12;                 %Potassium max conductance and reversal.
  gL=0.3;  ERest=10.6;              %Leak max conductance and reversal
  I0i=-10;                          %Drive to I-cells (fixed).
  LP=40;                            %# of P-cells.
  LI=10;                            %# of I-cells.

  t = (1:T)*dt;                     %Define time axis vector (useful for plotting).
  
  VP = zeros(T,LP);                 %Make empty matrices to hold P-cell results.
  mP = zeros(T,LP);
  hP = zeros(T,LP);
  nP = zeros(T,LP);
  
  VI = zeros(T,LI);                 %Make empty matrices to hold I-cell results.
  mI = zeros(T,LI);
  hI = zeros(T,LI);
  nI = zeros(T,LI);
  
  sP = zeros(T,LP);                 %Make empty matrices to hold the synapse results.
  sI = zeros(T,LI);
  
  VP(1,:)=-70.0 + 10*rand(1,LP);    %Set the initial conditions for P-cells, I-cells, and synapses.
  mP(1,:)=0.05 + 0.1*rand(1,LP);
  hP(1,:)=0.54 + 0.1*rand(1,LP);
  nP(1,:)=0.34 + 0.1*rand(1,LP);
  VI(1,:)=-70.0 + 10*rand(1,LI);
  mI(1,:)=0.05 + 0.1*rand(1,LI);
  hI(1,:)=0.54 + 0.1*rand(1,LI);
  nI(1,:)=0.34 + 0.1*rand(1,LI);
  sP(1,:)=0.0 + 0.1*rand(1,LP);
  sI(1,:)=0.0 + 0.1*rand(1,LI);
  
  for i=1:T-1                       %Integrate the equations.

      %P-cell dynamics - NOTE the sI synaptic current!
      VP(i+1,:) = VP(i,:) + dt*(gNa*mP(i,:).^3.*hP(i,:).*(ENa-(VP(i,:)+65)) + gK*nP(i,:).^4.*(EK-(VP(i,:)+65)) + gL*(ERest-(VP(i,:)+65)) + I0p ...
          +gI*sum(sI(i,:),2)*(-80-VP(i,:))) + eps*randn(1,LP)*sqrt(dt);                                                                          %Update I-cell voltage.
      mP(i+1,:) = mP(i,:) + dt*(alphaM(VP(i,:)).*(1-mP(i,:)) - betaM(VP(i,:)).*mP(i,:));                                    %Update m.
      hP(i+1,:) = hP(i,:) + dt*(alphaH(VP(i,:)).*(1-hP(i,:)) - betaH(VP(i,:)).*hP(i,:));                                    %Update h.
      nP(i+1,:) = nP(i,:) + dt*(alphaN(VP(i,:)).*(1-nP(i,:)) - betaN(VP(i,:)).*nP(i,:));                                    %Update n.
      sP(i+1,:) = sP(i,:) + dt*(((1+tanh(VP(i,:)/10))/2).*(1-sP(i,:))/0.2 - sP(i,:)/2);                                     %Update sP.

      %I-cell dynamics - NOTE the sP synaptic current!
      VI(i+1,:) = VI(i,:) + dt*(gNa*mI(i,:).^3.*hI(i,:).*(ENa-(VI(i,:)+65)) + gK*nI(i,:).^4.*(EK-(VI(i,:)+65)) + gL*(ERest-(VI(i,:)+65)) + I0i ...
          +gP*sum(sP(i,:),2)*(0-VI(i,:))) + eps*randn(1,LI)*sqrt(dt);                                                                                  %Update P-cell voltage.
      mI(i+1,:) = mI(i,:) + dt*(alphaM(VI(i,:)).*(1-mI(i,:)) - betaM(VI(i,:)).*mI(i,:));                                    %Update m.
      hI(i+1,:) = hI(i,:) + dt*(alphaH(VI(i,:)).*(1-hI(i,:)) - betaH(VI(i,:)).*hI(i,:));                                    %Update h.
      nI(i+1,:) = nI(i,:) + dt*(alphaN(VI(i,:)).*(1-nI(i,:)) - betaN(VI(i,:)).*nI(i,:));                                    %Update n.
      sI(i+1,:) = sI(i,:) + dt*(((1+tanh(VI(i,:)/10))/2).*(1-sI(i,:))/0.5 - sI(i,:)/tauI);
      
  end
  
end

%Below, define the auxiliary functions alpha & beta for each gating variable.

function aM = alphaM(V)
aM = (2.5-0.1*(V+65)) ./ (exp(2.5-0.1*(V+65)) -1);
end

function bM = betaM(V)
bM = 4*exp(-(V+65)/18);
end

function aH = alphaH(V)
aH = 0.07*exp(-(V+65)/20);
end

function bH = betaH(V)
bH = 1./(exp(3.0-0.1*(V+65))+1);
end

function aN = alphaN(V)
aN = (0.1-0.01*(V+65)) ./ (exp(1-0.1*(V+65)) -1);
end

function bN = betaN(V)
bN = 0.125*exp(-(V+65)/80);
end
