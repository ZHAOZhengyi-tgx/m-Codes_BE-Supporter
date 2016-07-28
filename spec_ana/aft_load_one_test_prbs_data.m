function [stPrbsInput, matRespPRBS, aRespDataSP] = aft_load_one_test_prbs_data(strFilenamePrbsTestResp)
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

% strFilenamePrbsTestResp
fptr = fopen(strFilenamePrbsTestResp);
aRespDataSP = [];

usSpectrumLength = 4096;
stPrbsInput.fActualSamplePeriod_ms = 1;
stPrbsInput.f_CTimeMPU_ms = 1.0;
%iFlagVelLoopExcite
stPrbsInput.iFlagVelLoopExcite = 1; %% by default  20110406

while ~feof(fptr)
    strReadLine = fgetl(fptr);
    strReadLine = strcat(strReadLine, 'ADD_CHARACTER_FOR_MINIMUM_LENGTH_COMP');
    
    if strcmp(strReadLine(1:length('iExcitingAxis')), 'iExcitingAxis')
%        strReadLine
        stPrbsInput.iExcitingAxisCtrlId = sscanf(strReadLine, 'iExcitingAxis = %d;', 1);
    elseif strcmp(strReadLine(1:length('iSeedRandomNumber')), 'iSeedRandomNumber') 
%        strReadLine
        stPrbsInput.iSeedRandomNumber = sscanf(strReadLine, 'iSeedRandomNumber = %d;', 1);
    elseif strcmp(strReadLine(1:length('usBinaryAmplitude')), 'usBinaryAmplitude') 
%        strReadLine
        stPrbsInput.usBinaryAmplitude = sscanf(strReadLine, 'usBinaryAmplitude = %d;', 1);
    elseif strcmp(strReadLine(1:length('usSpectrumLength')), 'usSpectrumLength') 
        stPrbsInput.usSpectrumLength = sscanf(strReadLine, 'usSpectrumLength = %d;', 1);
        usSpectrumLength = stPrbsInput.usSpectrumLength;
    elseif strcmp(strReadLine(1:length('usFrequencyFactor')), 'usFrequencyFactor')
        stPrbsInput.usFrequencyFactor = sscanf(strReadLine, 'usFrequencyFactor = %d;', 1);
    elseif strcmp(strReadLine(1:length('dActuralSamplePeriod_ms')), 'dActuralSamplePeriod_ms')
        stPrbsInput.fActualSamplePeriod_ms = sscanf(strReadLine, 'dActuralSamplePeriod_ms = %f;', 1);
%% FlagVelocityLoop 20110406
    elseif strcmp(strReadLine(1:length('iFlagVelLoopExcite')), 'iFlagVelLoopExcite') 
%        strReadLine
        stPrbsInput.iFlagVelLoopExcite = sscanf(strReadLine, 'iFlagVelLoopExcite = %d;', 1);
%%% 20110406
% dCTIME_ms        
    elseif strcmp(strReadLine(1:length('dCTIME_ms')), 'dCTIME_ms')
        stPrbsInput.f_CTimeMPU_ms = sscanf(strReadLine, 'dCTIME_ms = %f;', 1);
    elseif strcmp(strReadLine(1:length('matRespPRBS')), 'matRespPRBS')
        break;
    end
end
% stPrbsInput
matRespPRBS(1,:) = sscanf(strReadLine, 'matRespPRBS = [%f, %f, %f, %f, %f, %f;');
for ii = 1:1:usSpectrumLength - 1
    strReadLine = fgetl(fptr);
    if ii == usSpectrumLength - 1
        matRespPRBS(ii + 1,:) = sscanf(strReadLine, '%f, %f, %f, %f, %f, %f];');
    else
        matRespPRBS(ii + 1,:) = sscanf(strReadLine, '%f, %f, %f, %f, %f, %f;');
    end
    if (ii == 50) && (sum(abs(matRespPRBS(ii, :) )) == 0)
        break;
    end
end
while strReadLine(end-1) ~= ']'
    strReadLine = fgetl(fptr);
end

if (sum(abs(matRespPRBS(50, :) )) == 0)
end
strLabelNamePosn = 'adRespPosnSP';
strLabelNameVel = 'adRespVelSP';
iFlagGetLabel = 1;

if ~feof(fptr)
    usLenDataSP = 5000; %% First 5000 will do
    strReadLine = fgetl(fptr);
    if strReadLine(1:length(strLabelNamePosn)) == strLabelNamePosn
        aRespDataSP(1) = sscanf(strReadLine, 'adRespPosnSP = [ %f;');
    elseif strReadLine(1:length(strLabelNameVel)) == strLabelNameVel
        aRespDataSP(1) = sscanf(strReadLine, 'adRespVelSP = [ %f;');
    else
        iFlagGetLabel = 0;
    end
    
    if iFlagGetLabel == 1
        for ii = 1:1:usLenDataSP - 1
            strReadLine = fgetl(fptr);
            if ii == usLenDataSP
                aRespDataSP(ii + 1) = sscanf(strReadLine, '%f];');
            else
                aRespDataSP(ii + 1) = sscanf(strReadLine, '%f;');
            end
        end
    end
end

fclose(fptr);
