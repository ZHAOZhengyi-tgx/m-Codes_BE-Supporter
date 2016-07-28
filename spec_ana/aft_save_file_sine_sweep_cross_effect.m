function aft_save_file_sine_sweep_cross_effect(stGroupSineSweepCfg, astGroupSineSweepResp, matFreqArrayCrossResponse)
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

global DEF_PLOT_LEVEL_SAVE_FIG;
global DEF_PLOT_LEVEL_CROSS_EFFECT;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%% plot, relative amp, no unit 
for idxExciteAxis = 1:1:3
    for idxResponseAxis = 1:1:3

        iResponseAxisCtrlId = aiArrayMappingCtrlId(idxResponseAxis);
        iRespAppAxis = wb_map_axis_acs_2_app(iResponseAxisCtrlId, stGroupSineSweepCfg.iMachineType);
        iExciteAppAxis = wb_map_axis_acs_2_app(iExciteAxisCtrlCard, stGroupSineSweepCfg.iMachineType); 

        if idxExciteAxis ~= idxResponseAxis
            if isempty(astGroupSineSweepResp(1).matCrossResponse(idxExciteAxis, idxResponseAxis).aExciteDrvCmd)
            else
                %%%%%%%, DEF_PLOT_LEVEL_CROSS_EFFECT, compared by Relative ExFbPosn
                if stGroupSineSweepCfg.iPlotFlag >= 0 % DEF_PLOT_LEVEL_CROSS_EFFECT  %% DEF_PLOT_LEVEL_SAVE_FIG                
                    %%% ExFbPosn
                    strXlsOutFullFilename = sprintf('%sCrossEffectFrom_%s.xls', ...
                        stGroupSineSweepCfg.stFilePath.strPathname, ...
                        char(stAppName.astAppNameByCtrlBdAxis(iExciteAppAxis))); %%char(stAppName.astAppNameByCtrlBdAxis(iRespAppAxis)))

                    strSheetname = sprintf('From_%s_to_%s', char(stAppName.astAppNameByCtrlBdAxis(iExciteAppAxis)), ...
                        char(stAppName.astAppNameByCtrlBdAxis(iRespAppAxis)));
                    strStartCell = 'C3';

                    nRows = length(matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).fFreqHz(idxStartFreq:end));
                    for ii = 1:1:nRows

                        cellVeLoopStatisticXls(ii, 1) =  matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).fFreqHz(idxStartFreq + ii - 1);
                        cellVeLoopStatisticXls(ii, 2) =  matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomainToExcitePosn.afRatioExFbPosn_Peak2PeakVel_si(idxStartFreq + ii - 1);
                        cellVeLoopStatisticXls(ii, 3) =  matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomainToExcitePosn.afRatioExFbPosn_RmsVel_si(idxStartFreq + ii - 1);
                    end

                    xlswrite(strXlsOutFullFilename, cellVeLoopStatisticXls, strSheetname, strStartCell);

                end
            end
        end
    end
end

