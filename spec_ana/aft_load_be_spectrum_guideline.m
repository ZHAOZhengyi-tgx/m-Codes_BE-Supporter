function [iFlagHasGuideLine, stGroupPrbsRespGuidLine] = aft_load_be_spectrum_guideline()
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

stGroupPrbsRespGuidLine = [];
iFlagHasGuideLine = 0;
strFileSpectrumGuideLine = 'BE_WB_SpectrumGuideLine.mat';
astNameAllFilesInPath = dir;
nTotalFiles = length(astNameAllFilesInPath);
for ii = 1:1:nTotalFiles
    if length(astNameAllFilesInPath(ii).name) == length(strFileSpectrumGuideLine)
        if strcmp(astNameAllFilesInPath(ii).name, strFileSpectrumGuideLine)
            load BE_WB_SpectrumGuideLine.mat
            iFlagHasGuideLine = 1;
        end
    end
end

iOptionGetSpecFromFile = 1;
if iFlagHasGuideLine == 0
      % 0: No
      % 1: 
    iOptionGetSpecFromFile = menu('ConfigInput', 'NoGuideLine', 'CompareGuidLine');
end
if (iOptionGetSpecFromFile == 2) && (iFlagHasGuideLine == 0)
    [strFilename, strPathname, filterindex] = uigetfile('*.mat', 'Pick an mat-file for BE group PRBS GuideLine');
    strFileFullName = strcat(strPathname, strFilename);
    strCmd = sprintf('load %s', strFileFullName);
    eval(strCmd);
    if exist('stGroupPrbsRespGuidLine')
        iFlagHasGuideLine = 1;
    end
end


