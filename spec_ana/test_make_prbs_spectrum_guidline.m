function [stGroupPrbs, stGroupPrbsResp] = test_make_prbs_spectrum_guidline(astGroupCases)
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

stAppName.astAppNameByCtrlBdAxis(1) = {'TblX'};
stAppName.astAppNameByCtrlBdAxis(2) = {'TblY'};
stAppName.astAppNameByCtrlBdAxis(3) = {'BndZ'};
stAppName.astAppNameByCtrlBdAxis(4) = {'WClmp'};

stGroupPrbs = aft_load_group_prbs_cfg();

nTotalCaseGroupPrbs = stGroupPrbs.nTotalCaseGroupPrbs;
stGroupPrbs.nMovAveHalfLen = 10;
iPlotFlag = 0;

for ii = 1:1:nTotalCaseGroupPrbs
    strFilenamePrbsTestResp = sprintf('%sPrbsRespAryCase_%d.m', stGroupPrbs.stFilePath.strPathname, ii - 1);
    [stPrbsInput, matRespPRBS, aRespRawDataSP] = aft_load_one_test_prbs_data(strFilenamePrbsTestResp);

    stSpectrumPrbs = aft_get_plant_spectrum( stGroupPrbs, stPrbsInput, matRespPRBS, iPlotFlag);
    
    stTestCondition = aft_judge_vel_dcom_pwn(stPrbsInput, matRespPRBS);
    
    stGroupPrbsResp.astCase(ii).stTestCondition = stTestCondition;
    stGroupPrbsResp.astCase(ii).stPrbsInput = stPrbsInput;
    stGroupPrbsResp.astCase(ii).stSpectrumPrbs = stSpectrumPrbs;
    stGroupPrbsResp.astCase(ii).aRespRawDataSP = aRespRawDataSP;
    if mod(ii, 4) == 0
        strTextShow = sprintf('%d / %d', ii, nTotalCaseGroupPrbs);
        disp(strTextShow);
    end
end

    
for ii=1:1:nTotalCaseGroupPrbs
    stGroupPrbsResp.astCase(ii).stSpectrumPrbs.astRespPrbs = rmfield(stGroupPrbsResp.astCase(ii).stSpectrumPrbs.astRespPrbs, 'aFdVelMean0');
    stGroupPrbsResp.astCase(ii).stSpectrumPrbs.astRespPrbs = rmfield(stGroupPrbsResp.astCase(ii).stSpectrumPrbs.astRespPrbs, 'aFdVel');
    stGroupPrbsResp.astCase(ii).stSpectrumPrbs.astRespPrbs = rmfield(stGroupPrbsResp.astCase(ii).stSpectrumPrbs.astRespPrbs, 'aFreqFdVel');
    stGroupPrbsResp.astCase(ii).stSpectrumPrbs.astRespPrbs = rmfield(stGroupPrbsResp.astCase(ii).stSpectrumPrbs.astRespPrbs, 'aFreqFdPosn');
    stGroupPrbsResp.astCase(ii).stSpectrumPrbs.astRespPrbs = rmfield(stGroupPrbsResp.astCase(ii).stSpectrumPrbs.astRespPrbs, 'aFdPosnMean0');
end
stGroupPrbsResp.astCase = rmfield(stGroupPrbsResp.astCase, 'aRespRawDataSP');
stGroupPrbsResp.aiArrayMappingCtrlId = stGroupPrbs.aiArrayMappingCtrlId;

%%%%
stGroupPrbsResp.strReleaseTime = datestr(clock);
%stGroupPrbsResp.strReleaseNotes = 'Ver 1.2, X New Bearing with higher stiffness, BndZ: Tama-4212, WireClamp3';
%stGroupPrbsResp.strReleaseNotes = 'Top Bonder XY table Ver 1.1, Dual-motor Y table, X-Center Bottom, BndZ: Tama-4212, WireClamp3';
%%stGroupPrbsResp.strReleaseNotes = 'Top Bonder XY table Ver 1.1 - 2011Nov29, (X: MagnetHousing, CoilBracket), Dual-motor Y table, X-Center Bottom, BndZ: Tama-4212, WireClamp3';
stGroupPrbsResp.strReleaseNotes = 'BonderHead Spectrum on BH-Station Rubber Ver 1.0 - 2011Dec26, BndZ: Tama-4212, WireClamp3';

stGroupPrbsResp.stThresholdVelWarningFail.stTableXSelf.fWarningUpper = 0.5;
stGroupPrbsResp.stThresholdVelWarningFail.stTableXSelf.fErrorUpper = 1.0;
stGroupPrbsResp.stThresholdVelWarningFail.stTableXSelf.fErrorLower = 1.0;

stGroupPrbsResp.stThresholdVelWarningFail.stOtherSelf.fWarningUpper = 0.1;
stGroupPrbsResp.stThresholdVelWarningFail.stOtherSelf.fErrorUpper = 0.3;
stGroupPrbsResp.stThresholdVelWarningFail.stOtherSelf.fErrorLower = 1.5;

stGroupPrbsResp.stThresholdVelWarningFail.stCross.fWarningUpper = 0.1;
stGroupPrbsResp.stThresholdVelWarningFail.stCross.fErrorUpper = 0.3;
stGroupPrbsResp.stThresholdVelWarningFail.stCross.fErrorLower = 1.5;

%%% 20110924
stGroupPrbsResp.iMachineType = stGroupPrbs.iMachineType; 

%chdir()
if exist('astGroupCases') == 0
    load 'D:\WbData\astGroupCases.mat'
end

[matAxis2AxisPrbsGuideLine] = make_spectrum_guideline_by_group_statistic(astGroupCases, stGroupPrbs); %% astGroupCases

%%%%
stGroupPrbsRespGuidLine = stGroupPrbsResp;
stGroupPrbsRespGuidLine.matAxis2AxisPrbsGuideLine = matAxis2AxisPrbsGuideLine;
stGroupPrbsRespGuidLine.aiArrayMappingCtrlId = stGroupPrbs.aiArrayMappingCtrlId;

save 'BE_WB_SpectrumGuideLine' stGroupPrbsRespGuidLine;

% write spectrum data pass-fail specification to *.dat files
% read 
% aft_plot_group_spectrum_amplitude_freq(stGroupPrbs, stGroupPrbsResp, stTestCondition);
