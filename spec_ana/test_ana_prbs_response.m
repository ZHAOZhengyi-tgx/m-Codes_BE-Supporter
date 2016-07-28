function [stGroupPrbs, stGroupPrbsResp] = test_ana_prbs_response(strFileFullName)
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
global stAppName;
global astErrorMsgId;
global astrErrorMessage;

global DEF_PLOT_LEVEL_SAVE_FIG;
global DEF_PLOT_LEVEL_CROSS_EFFECT;
global DEF_PLOT_LEVEL_RELEASE;
global DEF_PLOT_LEVEL_DEBUG_ALL;

DEF_PLOT_LEVEL_RELEASE = 0;
DEF_PLOT_LEVEL_CROSS_EFFECT = 1;
DEF_PLOT_LEVEL_SAVE_FIG = 2;
DEF_PLOT_LEVEL_DEBUG_ALL = 3;
%%%%%%%%% 
stAppName.astAppNameByCtrlBdAxis(1) = {'TblX'};
stAppName.astAppNameByCtrlBdAxis(2) = {'TblY'};
stAppName.astAppNameByCtrlBdAxis(3) = {'BndZ'};
stAppName.astAppNameByCtrlBdAxis(4) = {'WClmp'};

astrErrorMessage(1).strErrMsgText = 'Too little cases';
astErrorMsgId(1).strMsgId = 'Spec-1';
astrErrorMessage(2).strErrMsgText = 'Error Format of guide-line file';
astErrorMsgId(2).strMsgId = 'Spec-2';

iPlotFlag = 0;
%% 0: Only output and save released jpg
%% 1: output cross spectrum, white noise, sinesweep, NOT save
%% 2: save fig, save cross spectrum jpg, 
%% 3: more debug

stGroupPrbsResp = [];

matMultiAxisGuideLine = [];
[iFlagHasGuideLine, stGroupPrbsRespGuidLine] = aft_load_be_spectrum_guideline();

if ~exist('strFileFullName')
    stGroupPrbs = aft_load_group_prbs_cfg();
else
    stGroupPrbs = aft_load_group_prbs_cfg(strFileFullName);    
end

iPlotFlag = stGroupPrbs.iPlotFlag;
stGroupPrbs.stAppName = stAppName;

nTotalCaseGroupPrbs = stGroupPrbs.nTotalCaseGroupPrbs;
stGroupPrbs.nMovAveHalfLen = 15;

% convert DOS LF '\' to Unix/Linux LF '/'
% aiPosnStr = strfind(stGroupPrbs.stFilePath.strPathname, '\');
% for ii = 1:1:length(aiPosnStr)
%     stGroupPrbs.stFilePath.strPathname(aiPosnStr(ii)) = '/';
% end
% stGroupPrbs.stFilePath.strPathname

strPrbsDataFileForSearch = sprintf('%sPrbsRespAryCase*.m', stGroupPrbs.stFilePath.strPathname);
astFilename = dir(strPrbsDataFileForSearch);
nActualCaseSpectrum = length(astFilename);  %% 20120722
if nActualCaseSpectrum < nTotalCaseGroupPrbs  
    disp('Warning: data files, CANNOT perform all the spectrum test cases')
    if nActualCaseSpectrum == 0
        disp('Error: 0 input files')
        return;
    end
    % return;
end
stGroupPrbs.nActualCaseSpectrum = nActualCaseSpectrum;

for ii = 1:1:nActualCaseSpectrum  % nTotalCaseGroupPrbs %% 20120722
    strFilenamePrbsTestResp = sprintf('%sPrbsRespAryCase_%d.m', stGroupPrbs.stFilePath.strPathname, ii - 1);
%    run(strFilenamePrbsTestResp);
%    stPrbsInput.iExcitingAxisCtrlId = iExcitingAxis; %% TBA, 20090704
%    stPrbsInput.iSeedRandomNumber = iSeedRandomNumber;
%    stPrbsInput.usBinaryAmplitude = usBinaryAmplitude;
%    stPrbsInput.usSpectrumLength = usSpectrumLength;
%    stPrbsInput.usFrequencyFactor = usFrequencyFactor;
    [stPrbsInput, matRespPRBS, aRespRawDataSP] = aft_load_one_test_prbs_data(strFilenamePrbsTestResp);
    stGroupPrbs.fActualSamplePeriod_ms = stPrbsInput.fActualSamplePeriod_ms;
    stGroupPrbs.iFlagVelLoopExcite = stPrbsInput.iFlagVelLoopExcite;
    
    stPrbsInput.usBinaryAmplitude = stGroupPrbs.astPrbsTestOnceInput(ii).usBinaryAmplitude;

    if ii <= 3
%        usBinaryAmplitude = stPrbsInput.usBinaryAmplitude
%        iPlotFlag = 4;
    else
        iPlotFlag = stGroupPrbs.iPlotFlag;
    end
    if(sum(abs(matRespPRBS(50, :) )) <= 1.0)
        iFlagHasRespDataMPU = 0;
    else
        iFlagHasRespDataMPU = 1;
    end
    if isempty(aRespRawDataSP)
        stGroupPrbsResp.astCase(ii).iFlagHasDataSP = 0;
    elseif(abs(aRespRawDataSP(50)) <= 1.0)
        stGroupPrbsResp.astCase(ii).iFlagHasDataSP = 0;
    else
        stGroupPrbsResp.astCase(ii).iFlagHasDataSP = 1;
    end
    
    if iFlagHasRespDataMPU == 1
        stSpectrumPrbs = aft_get_plant_spectrum( stGroupPrbs, stPrbsInput, matRespPRBS, iPlotFlag);
    else
        stSpectrumPrbs = [];
    end
    stTestCondition = aft_judge_vel_dcom_pwn(stPrbsInput, matRespPRBS);
    
    stGroupPrbsResp.astCase(ii).stTestCondition = stTestCondition;
    stGroupPrbsResp.astCase(ii).stPrbsInput = stPrbsInput;
    stGroupPrbsResp.astCase(ii).stSpectrumPrbs = stSpectrumPrbs;
    stGroupPrbsResp.astCase(ii).aRespRawDataSP = aRespRawDataSP;
    if mod(ii, 4) == 0
        strTextShow = sprintf('%d / %d', ii, nActualCaseSpectrum);  %% nTotalCaseGroupPrbs
        disp(strTextShow);
    end
end
%% Get the spectrum of spdatad
if stGroupPrbsResp.astCase(1).iFlagHasDataSP == 1
    astRespPrbsSpData = aft_get_plant_sp_spectrum(stGroupPrbs, stGroupPrbsResp);
end    %% Plot Freq Response for Pseudo-White Noise test,

if iFlagHasRespDataMPU == 1
    aft_plot_group_spectrum_amplitude_freq(stGroupPrbs, stGroupPrbsResp, stTestCondition);
    %% plot guideline after the spectrum
%    iFlagHasGuideLine
    if iFlagHasGuideLine == 1
        matMultiAxisGuideLine = aft_calc_group_spectrum_statistic(stGroupPrbsRespGuidLine, iPlotFlag);
    end
end

aft_save_spectrum_white_noise(stGroupPrbs, stGroupPrbsResp);

astCaseAxisXlsOutput = [];
try
    astCaseAxisXlsOutput = aft_save_spectrum_xls(stGroupPrbs, stGroupPrbsResp);
catch
    strErrMessage = sprintf('Error happens when you try to save as XLS file: %s', stGroupPrbs.stFilePath.strPathname);
    disp(strErrMessage);
end
%% Plot the guid-line
stGroupPrbsResp.matMultiAxisGuideLine = matMultiAxisGuideLine;
stGroupPrbsResp.astCaseAxisXlsOutput = astCaseAxisXlsOutput;