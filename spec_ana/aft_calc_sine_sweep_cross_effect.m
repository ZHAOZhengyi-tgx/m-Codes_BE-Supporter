function matFreqArrayCrossResponse = aft_calc_sine_sweep_cross_effect(stGroupSineSweepCfg, astGroupSineSweepResp)
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


nTotalCaseGroupSineSweep = stGroupSineSweepCfg.nTotalCaseGroupSineSweep;
stAppName = stGroupSineSweepCfg.stAppName;
aiArrayMappingCtrlId = stGroupSineSweepCfg.aiArrayMappingCtrlId;
iExciteAxisCtrlCard = stGroupSineSweepCfg.iExciteAxisCtrlCard;
fMinFreqPlot_Hz = stGroupSineSweepCfg.fMinFreqPlot_Hz;

for ii = 1:1:nTotalCaseGroupSineSweep
    if stGroupSineSweepCfg.astSineSweepCase(ii).fFreqHz >= fMinFreqPlot_Hz
        idxStartFreq = ii;
        break;
    end
end

%                 matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomainToExcitePosn.fRatioExFbPosn_Peak2PeakVel_si = ...
%                     matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.fPeak2PeakFbVel_si / fPeakToPeakExAxisFbPosn_mm;
%                 matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomainToExcitePosn.fRatioExFbPosn_RmsVel_si = ...
%                     matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.fRmsFbVel_si / fPeakToPeakExAxisFbPosn_mm;
global DEF_PLOT_LEVEL_SAVE_FIG;
global DEF_PLOT_LEVEL_CROSS_EFFECT;

for idxExciteAxis = 1:1:3
    for idxResponseAxis = 1:1:3

        iResponseAxisCtrlId = aiArrayMappingCtrlId(idxResponseAxis);
        iRespAppAxis = wb_map_axis_acs_2_app(iResponseAxisCtrlId, stGroupSineSweepCfg.iMachineType);
        iExciteAppAxis = wb_map_axis_acs_2_app(iExciteAxisCtrlCard, stGroupSineSweepCfg.iMachineType); 

        if idxExciteAxis ~= idxResponseAxis
            if isempty(astGroupSineSweepResp(1).matCrossResponse(idxExciteAxis, idxResponseAxis).aExciteDrvCmd)
            else
                
                for ii=1:1:nTotalCaseGroupSineSweep
                    
                    matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).fFreqHz(ii) = stGroupSineSweepCfg.astSineSweepCase(ii).fFreqHz;
                    stGroupSineSweepRespCase = astGroupSineSweepResp(ii);
                    
                    matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).afMagnitudeAtFreq(ii) = ...
                        stGroupSineSweepRespCase.matCrossResponse(idxExciteAxis, idxResponseAxis).stBodeCrossVelToDrv.fMagnitude;
                    matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.afRatioExpMaxAcc_Peak2PeakVel_si(ii) = ...
                        stGroupSineSweepRespCase.matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.fRatioExpMaxAcc_Peak2PeakVel_si;
                    matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.afRatioExpMaxAcc_RmsVel_si(ii) = ...
                        stGroupSineSweepRespCase.matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.fRatioExpMaxAcc_RmsVel_si;
                    %%% relative to ExAxisFbPosn_mm
                    matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomainToExcitePosn.afRatioExFbPosn_Peak2PeakVel_si(ii) = ...
                        stGroupSineSweepRespCase.matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomainToExcitePosn.fRatioExFbPosn_Peak2PeakVel_si;
                    matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomainToExcitePosn.afRatioExFbPosn_RmsVel_si(ii) = ...
                        stGroupSineSweepRespCase.matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomainToExcitePosn.fRatioExFbPosn_RmsVel_si;
                    
                end        
            end
        end
    end
end
