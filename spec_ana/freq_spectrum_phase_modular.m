function afPhaseOut_deg = freq_spectrum_phase_modular(afPhaseIn)
% The MIT License (MIT)
% 
% Copyright (c) 2016 ZHAOZhengyi-tgx
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%
% Zhengyi John ZHAO <zzytgx@gmail.com>
%

nLen = length(afPhaseIn);

for ii = 1:1:nLen
    if afPhaseIn(ii) > 180
        afPhaseOut_deg(ii) = afPhaseIn(ii) - 360;
    elseif afPhaseIn(ii) < -360
        afPhaseOut_deg(ii) = afPhaseIn(ii) + 360;
    elseif afPhaseIn(ii) < -180
        afPhaseOut_deg(ii) = afPhaseIn(ii) + 360;
    else
        afPhaseOut_deg(ii) = afPhaseIn(ii);
    end
           
end