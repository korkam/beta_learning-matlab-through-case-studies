function [Voptimal Ioptimal] = solar_panel_optimal(illum)

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

illum_table = [500 0.21; 600 0.3; 700 0.4; 800 0.5; 900 0.6; 1000 0.6; 1100 0.7; 1200 0.8; 1300 0.9; 1400 1.1;];

illum_current = 0; i=1;
while (~illum_current)
    if (illum_table(i,1) == illum)
        illum_current = illum_table(i,2);
    end
    i=i+1;
end
Voptimal = 1.5*0.026*(log(illum_current/(0.6*10^-6))+1)-0.093;
Ioptimal = illum_current-0.6*(10^-6)*(exp(Voptimal/(1.5*0.026))-1);
end

