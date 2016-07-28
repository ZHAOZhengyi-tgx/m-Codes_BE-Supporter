function aft_plot_sine_sweep_cross_effect(stGroupSineSweepCfg, astGroupSineSweepResp, matFreqArrayCrossResponse)
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

%%% 1, 2, 3: Excite Axis: X, Y, Z
%%% 
matErrorLine_ExResp = [0, 1000, 1100; 120, 0, 1800; 2, 10, 0];
matRefLine_ExResp =   [0, 600,  800;  32,  0, 1200; 0, 7,  0];

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
                if stGroupSineSweepCfg.iPlotFlag >= DEF_PLOT_LEVEL_SAVE_FIG
                    iFigId = idxExciteAxis * 100 + idxResponseAxis * 10;
                    figure(iFigId); %clf;
                    subplot(3,1,1);
                    strTextTitle = sprintf('Cross Effect From %s to %s', char(stAppName.astAppNameByCtrlBdAxis(iExciteAppAxis)), char(stAppName.astAppNameByCtrlBdAxis(iRespAppAxis)));
                    semilogx(matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).fFreqHz(idxStartFreq:end), ...
                        matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).afMagnitudeAtFreq(idxStartFreq:end));
                    title(strTextTitle, 'FontSize', 18);
                    ylabel('Rel Mag.', 'FontSize', 16);
                    grid on;
                    if stGroupSineSweepCfg.iPlotFlag >= DEF_PLOT_LEVEL_SAVE_FIG
                        hold on;  %%% FLEXI
                    end
                    subplot(3,1,2); 
                    semilogx(matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).fFreqHz(idxStartFreq:end), ...
                        matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.afRatioExpMaxAcc_Peak2PeakVel_si(idxStartFreq:end));
                    ylabel('Rel P2P-F_bV', 'FontSize', 16);
                    grid on;
                    if stGroupSineSweepCfg.iPlotFlag >= DEF_PLOT_LEVEL_SAVE_FIG
                        hold on;  %%% FLEXI
                    end
                    subplot(3,1,3); 
                    semilogx(matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).fFreqHz(idxStartFreq:end), ...
                        matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.afRatioExpMaxAcc_RmsVel_si(idxStartFreq:end));
                    ylabel('Rel RMS-F_bV', 'FontSize', 16);
                    grid on;
                    if stGroupSineSweepCfg.iPlotFlag >= DEF_PLOT_LEVEL_SAVE_FIG
                        hold on;  %%% FLEXI
                    end

                    strSaveFilename_jpg = sprintf('%sCrossEffect_EX%s_Resp%s.jpg', stGroupSineSweepCfg.stFilePath.strPathname, ...
                        char(stAppName.astAppNameByCtrlBdAxis(iExciteAppAxis)), char(stAppName.astAppNameByCtrlBdAxis(iRespAppAxis)));
                    strSaveFilename_fig = sprintf('%sCrossEffect_EX%s_Resp%s.fig', stGroupSineSweepCfg.stFilePath.strPathname, ...
                        char(stAppName.astAppNameByCtrlBdAxis(iExciteAppAxis)), char(stAppName.astAppNameByCtrlBdAxis(iRespAppAxis)));

                    if stGroupSineSweepCfg.iPlotFlag >= DEF_PLOT_LEVEL_SAVE_FIG
                        saveas(gcf, strSaveFilename_fig, 'fig');
                    end
                    saveas(gcf, strSaveFilename_jpg, 'jpg');
                end
                %%%%%%%, DEF_PLOT_LEVEL_CROSS_EFFECT, compared by Relative ExFbPosn
                if stGroupSineSweepCfg.iPlotFlag >= 0 %DEF_PLOT_LEVEL_CROSS_EFFECT  %% DEF_PLOT_LEVEL_SAVE_FIG                
                    %%% ExFbPosn
                    iFigId = idxExciteAxis * 1000 + idxResponseAxis * 100;
                    figure(iFigId); 
                    if stGroupSineSweepCfg.iPlotFlag >= 0 %DEF_PLOT_LEVEL_SAVE_FIG
                    else
                        clf;
                    end
                    subplot(2,1,1);
                    strTextTitle = sprintf('Cross Effect From %s to %s, by ExFbPosn', char(stAppName.astAppNameByCtrlBdAxis(iExciteAppAxis)), char(stAppName.astAppNameByCtrlBdAxis(iRespAppAxis)));
                    plot(matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).fFreqHz(idxStartFreq:end), ...
                        matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomainToExcitePosn.afRatioExFbPosn_Peak2PeakVel_si(idxStartFreq:end));
                    %% donot use semilogx
                    grid on;
                    if stGroupSineSweepCfg.iPlotFlag >= 0 %DEF_PLOT_LEVEL_SAVE_FIG
                        hold on;
                    end
                    plot([0,500], ...
                        [matErrorLine_ExResp(iExciteAppAxis, iRespAppAxis), matErrorLine_ExResp(iExciteAppAxis, iRespAppAxis)], ...
                        'r', 'LineWidth', 5);
                    plot([0,500], ...
                        [matRefLine_ExResp(iExciteAppAxis, iRespAppAxis), matRefLine_ExResp(iExciteAppAxis, iRespAppAxis)], ...
                        'r', 'LineWidth', 3, 'LineStyle', '-.');
                    title(strTextTitle, 'FontSize', 18);
                    ylabel('Rel P2P-F_bV', 'FontSize', 16);
                    subplot(2,1,2); 
                    plot(matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).fFreqHz(idxStartFreq:end), ...
                        matFreqArrayCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomainToExcitePosn.afRatioExFbPosn_RmsVel_si(idxStartFreq:end));
                    ylabel('Rel RMS-F_bV', 'FontSize', 16);
                    xlabel('Hz');
                    grid on;
                    if stGroupSineSweepCfg.iPlotFlag >= DEF_PLOT_LEVEL_SAVE_FIG
                        hold on;  %%% FLEXI
                    end

                    %%% 
                    strSaveFilename_jpg = sprintf('%sCrossEffect_EX%s_Resp%s_byExFbPosn.jpg', stGroupSineSweepCfg.stFilePath.strPathname, ...
                        char(stAppName.astAppNameByCtrlBdAxis(iExciteAppAxis)), char(stAppName.astAppNameByCtrlBdAxis(iRespAppAxis)));
                    strSaveFilename_fig = sprintf('%sCrossEffect_EX%s_Resp%s_byExFbPosn.fig', stGroupSineSweepCfg.stFilePath.strPathname, ...
                        char(stAppName.astAppNameByCtrlBdAxis(iExciteAppAxis)), char(stAppName.astAppNameByCtrlBdAxis(iRespAppAxis)));

                    if stGroupSineSweepCfg.iPlotFlag >= DEF_PLOT_LEVEL_SAVE_FIG
                        saveas(gcf, strSaveFilename_fig, 'fig');
                    end
                    saveas(gcf, strSaveFilename_jpg, 'jpg');
                end
            end
        end
    end
end

