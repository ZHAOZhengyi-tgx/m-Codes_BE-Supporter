function stGroupPrbs = aft_load_group_prbs_cfg(strFileFullName)
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
%% 20160722         For ACS SC
if ~exist('strFileFullName')
    [strFilename, strPathname, filterindex] = uigetfile('*.txt', 'Pick an txt-file for group PRBS config');
    strFileFullName = strcat(strPathname, strFilename);
else
    aList = strfind(strFileFullName, '\');
    strPathname = strFileFullName(1: aList(end));
    strFilename = strFileFullName(aList(end) + 1: end);    
end

stGroupPrbs.iPlotFlag = 0;

strFileFullName
fptr = fopen(strFileFullName, 'r');
strReadLine = fgetl(fptr);
fFreqBasic = sscanf(strReadLine, 'fFreqBasic = %f', 1);

strReadLine = fgetl(fptr);
nTotalCaseGroupPrbs = sscanf(strReadLine, 'nTotalCaseGroupPrbs = %d;', 1);

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
stGroupPrbs.iMachineType = iFlagMachineType;

strHeadGroupPrbsCase = '% SpectrumTest - Case';
for ii = 1:1:nTotalCaseGroupPrbs
    if feof(fptr)
        break;
    end
    strHeadGroupPrbsCaseTitle = sprintf('%% SpectrumTest - Case %d',  ii - 1);
    nLenStrHead = length(strHeadGroupPrbsCaseTitle);
    if iFlagLegacyRead ~= 1
        strReadLine = fgetl(fptr);
    end
%     strReadLine
    if strcmp(strReadLine(1:nLenStrHead), strHeadGroupPrbsCaseTitle)
        strReadLine = fgetl(fptr);
        TotalAxis = sscanf(strReadLine, 'TotalAxis = %d;', 1);
        
        strReadFormat = 'aAxisPositions = [';
        for jj = 1:1:(TotalAxis - 1)
            strReadFormat = strcat(strReadFormat, '%d,');
        end
        strReadFormat = strcat(strReadFormat, '%d];');
        strReadLine = fgetl(fptr);
%%        aAxisPositions = sscanf(strReadLine, 'aAxisPositions = [%d, %d];', 2);
        aAxisPositions = sscanf(strReadLine, strReadFormat, TotalAxis);

        strReadFormat = ' aAxisInCtrl = [';
        for jj = 1:1:(TotalAxis - 1)
            strReadFormat = strcat(strReadFormat, '%d,');
        end
        strReadFormat = strcat(strReadFormat, '%d];');
        strReadLine = fgetl(fptr);
%%        aAxisInCtrl = sscanf(strReadLine, ' aAxisInCtrl = [%d, %d];', 2);
        aAxisInCtrl = sscanf(strReadLine, strReadFormat, TotalAxis);
        
        strReadLine = fgetl(fptr);
        iExciteAxis = sscanf(strReadLine, ' iExcitingAxis = %d;', 1);

        strReadLine = fgetl(fptr);
        iSeedRandomNumber = sscanf(strReadLine, 'iSeedRandomNumber = %d;', 1);

        strReadLine = fgetl(fptr);
        usBinaryAmplitude = sscanf(strReadLine, 'usBinaryAmplitude = %d;', 1);

        strReadLine = fgetl(fptr);
        usSpectrumLength = sscanf(strReadLine, 'usSpectrumLength = %d;', 1);

        strReadLine = fgetl(fptr);
        usFrequencyFactor = sscanf(strReadLine, 'usFrequencyFactor = %d;', 1);

        astPrbsTestOnceInput(ii).TotalAxis = TotalAxis;
        astPrbsTestOnceInput(ii).aAxisPositions = aAxisPositions;
        astPrbsTestOnceInput(ii).aAxisInCtrl = aAxisInCtrl;
        astPrbsTestOnceInput(ii).iExciteAxis = iExciteAxis;
        astPrbsTestOnceInput(ii).iSeedRandomNumber = iSeedRandomNumber;
        astPrbsTestOnceInput(ii).usBinaryAmplitude = usBinaryAmplitude;
        astPrbsTestOnceInput(ii).usSpectrumLength = usSpectrumLength;
        astPrbsTestOnceInput(ii).usFrequencyFactor = usFrequencyFactor;

        strReadLine = fgetl(fptr);
        
        if iFlagLegacyRead == 1
            strReadLine = fgetl(fptr);
        end
    end
end

%% iPlotFlag = 0;
while ~feof(fptr)
    strReadLine = fgetl(fptr);
    strReadLine = strcat(strReadLine, 'ADD_CHARACTER_FOR_MINIMUM_LENGTH_COMP');
    if strcmp(strReadLine(1:length('iPlotFlag')), 'iPlotFlag')
%        strReadLine
        stGroupPrbs.iPlotFlag = sscanf(strReadLine, 'iPlotFlag = %d;', 1);
    end
end

fclose(fptr);

stGroupPrbs.fFreqBasic = fFreqBasic;
stGroupPrbs.nTotalCaseGroupPrbs = nTotalCaseGroupPrbs;
stGroupPrbs.astPrbsTestOnceInput = astPrbsTestOnceInput;
stGroupPrbs.stFilePath.strFilename = strFilename; 
stGroupPrbs.stFilePath.strPathname = strPathname;
stGroupPrbs.stFilePath.strFileFullName = strFileFullName;

stGroupPrbs.aAxisInCtrl = aAxisInCtrl; %% 20160722 
iFound_axis_2_acs_sc = find(aAxisInCtrl == 2);
if length(iFound_axis_2_acs_sc) >= 1 %% 20160722 stGroupPrbs.fFreqBasic >= 2500
    aiArrayMappingCtrlId = [0, 1, 2, 3];
else
    aiArrayMappingCtrlId = [0, 1, 4, 5];
end
stGroupPrbs.aiArrayMappingCtrlId = aiArrayMappingCtrlId;
