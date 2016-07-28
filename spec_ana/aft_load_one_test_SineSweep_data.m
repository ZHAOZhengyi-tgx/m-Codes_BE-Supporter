function [stSineSweepInput, matRespSineSweep] = aft_load_one_test_SineSweep_data(strFilenameSineSweepTestResp, usExciteLength)
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

fptr = fopen(strFilenameSineSweepTestResp);
aRespDataSP = [];

if ~exist('usExciteLength')
    usSpectrumLength = 4096;
else
    usSpectrumLength = usExciteLength;
end

while ~feof(fptr)
    strReadLine = fgetl(fptr);
    strReadLine = strcat(strReadLine, 'ADD_CHARACTER_FOR_MINIMUM_LENGTH_COMP');
    
    if strcmp(strReadLine(1:length('iExcitingAxis')), 'iExcitingAxis')
%        strReadLine
        stSineSweepInput.iExcitingAxisCtrlId = sscanf(strReadLine, 'iExcitingAxis = %d;', 1);
    elseif strcmp(strReadLine(1:length('iFlagVelLoopExcite')), 'iFlagVelLoopExcite') 
%        strReadLine
        stSineSweepInput.iSeedRandomNumber = sscanf(strReadLine, 'iFlagVelLoopExcite = %d;', 1);
    elseif strcmp(strReadLine(1:length('fAmplitude')), 'fAmplitude') 
%        strReadLine
        stSineSweepInput.fAmplitude = sscanf(strReadLine, 'fAmplitude = %f;', 1);
    elseif strcmp(strReadLine(1:length('dFreq_Hz')), 'dFreq_Hz') 
        stSineSweepInput.dFreq_Hz = sscanf(strReadLine, 'dFreq_Hz = %d;', 1);
%        usSpectrumLength = stSineSweepInput.usSpectrumLength;
    elseif strcmp(strReadLine(1:length('dActuralSamplePeriod_ms')), 'dActuralSamplePeriod_ms')
        stSineSweepInput.dActuralSamplePeriod_ms = sscanf(strReadLine, 'dActuralSamplePeriod_ms = %d;', 1);
    elseif strcmp(strReadLine(1:length('dCTIME_ms')), 'dCTIME_ms')
        stSineSweepInput.dCTIME_ms = sscanf(strReadLine, 'dCTIME_ms = %f;', 1);
% dCTIME_ms        
%     elseif strcmp(strReadLine(1:length('dCTIME_ms')), 'dCTIME_ms')
%         stSineSweepInput.f_CTimeMPU_ms = sscanf(strReadLine, 'dCTIME_ms = %f;', 1);
    elseif strcmp(strReadLine(1:length('matRespPRBS')), 'matRespPRBS')
        break;
    end
end

% stSineSweepInput.dActuralSamplePeriod_ms
% usSpectrumLength = floor(stSineSweepInput.dActuralSamplePeriod_ms / stSineSweepInput.dCTIME_ms);
% stSineSweepInput
matRespSineSweep(1,:) = sscanf(strReadLine, 'matRespPRBS = [%f, %f, %f, %f, %f, %f, %f;');
for ii = 1:1:usSpectrumLength - 1
    strReadLine = fgetl(fptr);
    if ii == usSpectrumLength - 1
        matRespSineSweep(ii + 1,:) = sscanf(strReadLine, '%f, %f, %f, %f, %f, %f, %f];');
    else
        matRespSineSweep(ii + 1,:) = sscanf(strReadLine, '%f, %f, %f, %f, %f, %f, %f;');
    end
    if (ii == 50) && (sum(abs(matRespSineSweep(ii, :) )) == 0)
        break;
    end
end
while strReadLine(end-1) ~= ']'
    strReadLine = fgetl(fptr);
end

fclose(fptr);
