function [stGroupSineSweepCfg, astGroupSineSweepResp, stBodeOutput] = test_ana_SineSweep_response(strFileFullName)
%% 20090704   Zhengyi Add aiArrayMappingCtrlId = [0, 1, 4, 5];
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

fMinFreqPlot_Hz = 10;

if exist('strFileFullName')
    stGroupSineSweepCfg = aft_load_group_SineSweep_cfg(strFileFullName);
else
    stGroupSineSweepCfg = aft_load_group_SineSweep_cfg();
end

iPlotFlag = stGroupSineSweepCfg.iPlotFlag;

nTotalCaseGroupSineSweep = stGroupSineSweepCfg.nTotalCaseGroupSineSweep;
astMotorControlInfo = aft_be_wb_get_motor_driver_spec(stGroupSineSweepCfg.iMachineType);
stGroupSineSweepCfg.astMotorControlInfo = astMotorControlInfo;
stGroupSineSweepCfg.stAppName = stAppName;
stGroupSineSweepCfg.fMinFreqPlot_Hz = fMinFreqPlot_Hz;

for ii=1:1:nTotalCaseGroupSineSweep

    astGroupSineSweepRespCase = aft_load_calc_sine_sweep_one_case(stGroupSineSweepCfg, ii);
    astGroupSineSweepResp(ii) = astGroupSineSweepRespCase;

    stBodeVelToDrv.afMagnitude(ii) = astGroupSineSweepRespCase.stBodeVelToDrv.fMagnitude;
    stBodeVelToDrv.afPhase_deg(ii) = astGroupSineSweepRespCase.stBodeVelToDrv.fPhase_deg;
    stBodeVelToDrv.afFreqHz(ii) = stGroupSineSweepCfg.astSineSweepCase(ii).fFreqHz;

    stBodePosnToDrv.afMagnitude(ii) = astGroupSineSweepRespCase.stBodePosnToDrv.fMagnitude;
    stBodePosnToDrv.afPhase_deg(ii) = astGroupSineSweepRespCase.stBodePosnToDrv.fPhase_deg;
    stBodePosnToDrv.afFreqHz(ii) = stGroupSineSweepCfg.astSineSweepCase(ii).fFreqHz;

    if mod(ii, 4) == 0
        strDispProgress = sprintf('Case %d/%d', ii, nTotalCaseGroupSineSweep);
        disp(strDispProgress);
    end
end

%%%% Bode by Self Spectrum 
stBodeOutput.stBodeVelToDrv = stBodeVelToDrv;
stBodeOutput.stBodePosnToDrv = stBodePosnToDrv;
aft_plot_sine_sweep_bode(stGroupSineSweepCfg, stBodeOutput);

for ii = 1:1:nTotalCaseGroupSineSweep
    if stBodeVelToDrv.afFreqHz(ii) >= fMinFreqPlot_Hz
        idxStartFreq = ii;
        break;
    end
end
nMaxCaseFreq = floor((idxStartFreq + nTotalCaseGroupSineSweep)/2);

fConstSLAFF = 506606;
for ii = idxStartFreq:1:nMaxCaseFreq
    aEstSLAFF(ii - idxStartFreq +1) = fConstSLAFF / (stBodePosnToDrv.afFreqHz(ii) * stBodePosnToDrv.afFreqHz(ii) * stBodePosnToDrv.afMagnitude(ii));
end
stBodeOutput.aEstSLAFF = aEstSLAFF;
nMinLinearize = floor(length(aEstSLAFF)/4);
nMaxLinearize = floor(length(aEstSLAFF)/2);
stBodeOutput.stEsimateSLAFF.fMeanEstSLAFF = mean(stBodeOutput.aEstSLAFF(nMinLinearize:nMaxLinearize));
stBodeOutput.stEsimateSLAFF.fMinEstSLAFF = min(stBodeOutput.aEstSLAFF(nMinLinearize:nMaxLinearize));
stBodeOutput.stEsimateSLAFF.fMaxEstSLAFF = max(stBodeOutput.aEstSLAFF(nMinLinearize:nMaxLinearize));

%%%% Cross Spectrum measurements
matFreqArrayCrossResponse = aft_calc_sine_sweep_cross_effect(stGroupSineSweepCfg, astGroupSineSweepResp);

aft_save_file_sine_sweep_cross_effect(stGroupSineSweepCfg, astGroupSineSweepResp, matFreqArrayCrossResponse);
aft_plot_sine_sweep_cross_effect(stGroupSineSweepCfg, astGroupSineSweepResp, matFreqArrayCrossResponse);

