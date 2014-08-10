%Implement a model of Pyramidal-Interneuron Network Gamma (PING).
%Use Hodgkin-Huxley equations for individual neurons.
%Use Borgers et al, PNAS, 2008 to model the synapses
%  (see http://www.pnas.org/content/105/46/18023.abstract).

%INPUTS:
%  I0p = Injected current to P-cell.
%  gP  = strength of synapses P-to-I.
%  gI  = strength of synapses I-to-P.
%  tauI= decay time of inhibitory synapse.
%  T0  = total time of simulation [s].

%OUTPUTS:
%  VP = voltage of P-cell.
%  sP = excitatory synapse.
%  VI = voltage of I-cell.
%  sI = inhibitory synapse.
%   t = time axis vector (useful for plotting).

function [VP,sP,VI,sI,t] = ping(I0p,gP,gI,tauI,T0)

  dt = 0.01;                        %The time step.
  T  = ceil(T0/dt);
  gNa = 120;  ENa=115;              %Sodium max conductance and reversal.    
  gK = 36;  EK=-12;                 %Potassium max conductance and reversal.
  gL=0.3;  ERest=10.6;              %Leak max conductance and reversal
  I0i=5;

  t = (1:T)*dt;                     %Define time axis vector (useful for plotting).
  
  VP = zeros(T,1);                  %Make empty variables to hold P-cell results
  mP = zeros(T,1);
  hP = zeros(T,1);
  nP = zeros(T,1);
  
  VI = zeros(T,1);                  %Make empty variables to hold I-cell results.
  mI = zeros(T,1);
  hI = zeros(T,1);
  nI = zeros(T,1);
  
  sP = zeros(T,1);                  %Make empty variables to hold the synapse results
  sI = zeros(T,1);
  
  VP(1)=-70.0;                      %Set the initial conditions for P-cell, I-cell, and synapses/
  mP(1)=0.05;
  hP(1)=0.54;
  nP(1)=0.34;
  VI(1)=-70.0;
  mI(1)=0.05;
  hI(1)=0.54;
  nI(1)=0.34;
  sP(1)=0.0;
  sI(1)=0.0;
  
  for i=1:T-1                       %Integrate the equations.
      
      %P-cell dynamics - NOTE the sI synaptic current!
      VP(i+1) = VP(i) + dt*(gNa*mP(i)^3*hP(i)*(ENa-(VP(i)+65)) + gK*nP(i)^4*(EK-(VP(i)+65)) + gL*(ERest-(VP(i)+65)) + I0p ...
          +gI*sI(i)*(-80-VP(i)));                                                                            %Update I-cell voltage.
      mP(i+1) = mP(i) + dt*(alphaM(VP(i))*(1-mP(i)) - betaM(VP(i))*mP(i));                                    %Update m.
      hP(i+1) = hP(i) + dt*(alphaH(VP(i))*(1-hP(i)) - betaH(VP(i))*hP(i));                                    %Update h.
      nP(i+1) = nP(i) + dt*(alphaN(VP(i))*(1-nP(i)) - betaN(VP(i))*nP(i));                                    %Update n.
      sP(i+1) = sP(i) + dt*(((1+tanh(VP(i)/10))/2)*(1-sP(i))/0.2 - sP(i)/2);                                  %Update sP.

      %I-cell dynamics - NOTE the sP synaptic current!
      VI(i+1) = VI(i) + dt*(gNa*mI(i)^3*hI(i)*(ENa-(VI(i)+65)) + gK*nI(i)^4*(EK-(VI(i)+65)) + gL*(ERest-(VI(i)+65)) + I0i ...
          +gP*sP(i)*(0-VI(i)));                                                                              %Update P-cell voltage.
      mI(i+1) = mI(i) + dt*(alphaM(VI(i))*(1-mI(i)) - betaM(VI(i))*mI(i));                                    %Update m.
      hI(i+1) = hI(i) + dt*(alphaH(VI(i))*(1-hI(i)) - betaH(VI(i))*hI(i));                                    %Update h.
      nI(i+1) = nI(i) + dt*(alphaN(VI(i))*(1-nI(i)) - betaN(VI(i))*nI(i));                                    %Update n.
      sI(i+1) = sI(i) + dt*(((1+tanh(VI(i)/10))/2)*(1-sI(i))/0.5 - sI(i)/tauI);
      
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
