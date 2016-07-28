function iFigId = wb_spec_get_fig_id_scaled_semilogy_by_mc_type_app_axis(idxAppExcite, idxAppResp, iMachineType)
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

% if iMachineType 

if iMachineType == 2
    switch (idxAppExcite)
        case 1
            idxFigExcite = 2;
        case 2
            idxFigExcite = 1;
        case 3
            idxFigExcite = 3;
        case 4
            idxFigExcite = 4;
        otherwise
    end
    switch (idxAppResp)
        case 1
            idxFigResp = 2;
        case 2
            idxFigResp = 1;
        case 3
            idxFigResp = 3;
        case 4
            idxFigResp = 4;
        otherwise
    end
    
else  %% default
    idxFigExcite = idxAppExcite;
    idxFigResp = idxAppResp;
end

iFigId = idxFigExcite * 10 + idxFigResp * 1;
