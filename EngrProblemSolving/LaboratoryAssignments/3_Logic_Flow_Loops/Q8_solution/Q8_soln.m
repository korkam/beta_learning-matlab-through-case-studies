
% Copyright (c) 2012, S. Hsu
% All rights reserved.

% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%     * Redistributions of source code must retain the above copyright
%       notice, this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright
%       notice, this list of conditions and the following disclaimer in the
%       documentation and/or other materials provided with the distribution.
%     * Neither the name of the University of California, Davis nor the
%       names of its contributors may be used to endorse or promote products
%       derived from this software without specific prior written permission.

% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
% ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
% WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
% DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
% (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
% ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
% SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

clear all

% % Import all variables
load question8.mat


%%
Nrow = 35;
Ncol = 1;
    
figure(1)
hold

% Iterate through all time points.
for i=1:length(load_profile),
    
    % Look-up the current that corresponds to the illumination condition
    for j=1:length(illumination),
        if(illumination(j,1) == illumination_profile(i))            
            % Calculate the average current.
             i_Light = 0;
             for k=2:6,
                 i_Light = i_Light + illumination(j,k);
             end
             i_Light = i_Light/length(k);
        end
    end
    
    % At this point, we have 'i_Light', which is the current that corresponds 
    % to the current illumination condition, 'illumination_profile(i)'

    % Calculate Vmp and Imp that corresponds to i_Light
    % -- This is the maximum amount of power available from the solar
    % panel under illumination that gives 'i_Light'.
    [vmp imp] = panel_mpp(i_Light, Nrow, Ncol);

    % Calculate what is actually delivered.
    vpd = pd( i_Light )*Nrow;
    ipd = vpd / load_profile(i);    
    
    plot(i,vpd*ipd,'r*');
    plot(i,vmp*imp,'b*');
end
hold




