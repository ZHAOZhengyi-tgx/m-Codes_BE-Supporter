function stGroupSineSweep = aft_load_group_SineSweep_cfg(strFileFullName)
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

%% 20090704   Zhengyi Add aiArrayMappingCtrlId = [0, 1, 4, 5];

if ~exist('strFileFullName')
    [strFilename, strPathname, filterindex] = uigetfile('*.txt', 'Pick a txt-file for group SineSweep config');
    strFileFullName = strcat(strPathname, strFilename);
else
    aiPosnBackSlash = strfind(strFileFullName, '\');
    iPosnLastBackSlash = aiPosnBackSlash(end);
    strPathname = strFileFullName(1:iPosnLastBackSlash); %% , 
    strFilename = strFileFullName((iPosnLastBackSlash+1):end);    
end

stGroupSineSweep.iPlotFlag = 0;

strFileFullName
fptr = fopen(strFileFullName, 'r');

strLabelSineSweepCfg = 'stSineSweepCfg';
nLenSineSweepCfg = length(strLabelSineSweepCfg);
strReadLine = fgetl(fptr);
while strReadLine(1:nLenSineSweepCfg) == strLabelSineSweepCfg
    eval(strReadLine);
    strReadLine = fgetl(fptr);
end

stGroupSineSweep.stSineSweepCfg = stSineSweepCfg;

%% Mapping CtrlAxisId
aiArrayMappingCtrlId = [0, 1, 4, 5];
stGroupSineSweep.aiArrayMappingCtrlId = aiArrayMappingCtrlId;

%strReadLine = fgetl(fptr);
stGroupSineSweep.iExciteAxisCtrlCard = sscanf(strReadLine, 'iExciteAxisCtrlCard = %d', 1);

strReadLine = fgetl(fptr);
stGroupSineSweep.fSampleTime_ms = sscanf(strReadLine, 'fBasicSampleTime_ms = %f', 1);

strReadLine = fgetl(fptr);
stGroupSineSweep.nTotalCaseGroupSineSweep = sscanf(strReadLine, 'nTotalCaseSineSweep = %d;', 1);

%%%%
    iFlagMachineType = 1;
    iFlagLegacyRead = 1;

strReadLine = fgetl(fptr);
if strReadLine(1:11) == 'MachineType'
    iFlagMachineType = sscanf(strReadLine, 'MachineType = %d;', 1);
    iFlagLegacyRead = 0;
else
    iFlagMachineType = 1;
    iFlagLegacyRead = 1;
end


%iFlagLegacyRead
stGroupSineSweep.iMachineType = iFlagMachineType;
aiArrayMappingCtrlId = [0, 1, 4, 5];
stGroupSineSweep.aiArrayMappingCtrlId = aiArrayMappingCtrlId;
%
strLabelSineSweepCase = 'astSineSweepCase';
nLenLabelSineSweepCase = length(strLabelSineSweepCase);

strHeadGroupSineSweepCase = '% SineSweepTest - Case';
for ii = 1:1:stGroupSineSweep.nTotalCaseGroupSineSweep
    if feof(fptr)
        break;
    end
    strHeadGroupSineSweepCaseTitle = sprintf('%% SineSweepTest - Case %d',  ii - 1);
    nLenStrHead = length(strHeadGroupSineSweepCaseTitle);
%    if iFlagLegacyRead ~= 1
        strReadLine = fgetl(fptr);
        strReadLineExt = sprintf('%s%%_FURTHER_EXTEND_FOR_MIN_COMPARISON', strReadLine);
%    end
    if strcmp(strReadLineExt(1:nLenStrHead), strHeadGroupSineSweepCaseTitle)
        % 1
        strReadLine = fgetl(fptr);        
        strReadLineExt = sprintf('%s%%_FURTHER_EXTEND_FOR_MIN_COMPARISON', strReadLine);
        if strcmp(strReadLineExt(1:nLenLabelSineSweepCase), strLabelSineSweepCase)
            eval(strReadLine)
        end
        % 2
        strReadLine = fgetl(fptr);        
        strReadLineExt = sprintf('%s%%_FURTHER_EXTEND_FOR_MIN_COMPARISON', strReadLine);
        if strcmp(strReadLineExt(1:nLenLabelSineSweepCase), strLabelSineSweepCase)
            eval(strReadLine);
        end
        % 3
        strReadLine = fgetl(fptr);        
        strReadLineExt = sprintf('%s%%_FURTHER_EXTEND_FOR_MIN_COMPARISON', strReadLine);
        if strcmp(strReadLineExt(1:nLenLabelSineSweepCase), strLabelSineSweepCase)
            eval(strReadLine);
        end
        % 4
        strReadLine = fgetl(fptr);        
        strReadLineExt = sprintf('%s%%_FURTHER_EXTEND_FOR_MIN_COMPARISON', strReadLine);
        if strcmp(strReadLineExt(1:nLenLabelSineSweepCase), strLabelSineSweepCase)
            eval(strReadLine);
        end
        % 5
        strReadLine = fgetl(fptr);        
        strReadLineExt = sprintf('%s%%_FURTHER_EXTEND_FOR_MIN_COMPARISON', strReadLine);
        if strcmp(strReadLineExt(1:nLenLabelSineSweepCase), strLabelSineSweepCase)
            eval(strReadLine);
        end
        
    end
%    if iFlagLegacyRead == 1
        strReadLine = fgetl(fptr);
%         strReadLine = fgetl(fptr);
%         strReadLineExt = sprintf('%s%%_FURTHER_EXTEND_FOR_MIN_COMPARISON', strReadLine);
%    end
end

stGroupSineSweep.astSineSweepCase = astSineSweepCase;

%% iPlotFlag = 0;
while ~feof(fptr)
    strReadLine = fgetl(fptr);
    strReadLine = strcat(strReadLine, 'ADD_CHARACTER_FOR_MINIMUM_LENGTH_COMP');
    if strcmp(strReadLine(1:length('iPlotFlag')), 'iPlotFlag')
%        strReadLine
        stGroupSineSweep.iPlotFlag = sscanf(strReadLine, 'iPlotFlag = %d;', 1);
    end
end

fclose(fptr);

% stGroupSineSweep.fSampleTime_ms = fSampleTime_ms;
% stGroupSineSweep.nTotalCaseGroupSineSweep = nTotalCaseGroupSineSweep;
% stGroupSineSweep.astSineSweepTestOnceInput = astSineSweepTestOnceInput;
stGroupSineSweep.stFilePath.strFilename = strFilename; 
stGroupSineSweep.stFilePath.strPathname = strPathname;
stGroupSineSweep.stFilePath.strFileFullName = strFileFullName;

