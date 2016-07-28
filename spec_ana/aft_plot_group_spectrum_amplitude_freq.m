function aft_plot_group_spectrum_amplitude_freq(stGroupPrbs, stGroupPrbsResp, stTestCondition)
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

global DEF_PLOT_LEVEL_CROSS_EFFECT;

stTestCondition.iMachineType = stGroupPrbs.iMachineType;

%% Freq Response for Pseudo-White Noise test,
iExcitingAxisCtrlId = 0; strTitle = spec_get_title_by_excite_axis(iExcitingAxisCtrlId, stTestCondition);
if aft_spec_count_total_num_excite_per_axis(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId) >= 1
    aft_plot_group_spectrm_loglog(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId, strTitle);
    aft_plot_self_scaled_spectrm_semilogy_(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId, strTitle);

    if stGroupPrbs.iPlotFlag >= DEF_PLOT_LEVEL_CROSS_EFFECT
        %%% Excite by X
        iExcitingAxisCtrlId = 0; iResponseAxisCtrlId = 1; strTitle = spec_get_title_by_excite_resp_axis(iExcitingAxisCtrlId, iResponseAxisCtrlId, stTestCondition);
        aft_plot_group_cross_spectrm_loglog(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId, iResponseAxisCtrlId, strTitle)

        iExcitingAxisCtrlId = 0; 
        if stGroupPrbs.fFreqBasic >= 2500
            iResponseAxisCtrlId = 2; 
        else
            iResponseAxisCtrlId = 4; 
        end
        strTitle = spec_get_title_by_excite_resp_axis(iExcitingAxisCtrlId, iResponseAxisCtrlId, stTestCondition);
        aft_plot_group_cross_spectrm_loglog(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId, iResponseAxisCtrlId, strTitle)
    end
end


%%%%%% Excite by Y
iExcitingAxisCtrlId = 1; strTitle = spec_get_title_by_excite_axis(iExcitingAxisCtrlId, stTestCondition);
if aft_spec_count_total_num_excite_per_axis(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId) >= 1
    aft_plot_group_spectrm_loglog(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId, strTitle);
    aft_plot_self_scaled_spectrm_semilogy_(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId, strTitle);

    %% Group Spectrum
    if stGroupPrbs.iPlotFlag >= DEF_PLOT_LEVEL_CROSS_EFFECT
        if stGroupPrbs.iPlotFlag >= 3
            input('Any key to proceed display spectrum for next axis')    
        end
        %%% Excite by Y
        iExcitingAxisCtrlId = 1; iResponseAxisCtrlId = 0; strTitle = spec_get_title_by_excite_resp_axis(iExcitingAxisCtrlId, iResponseAxisCtrlId, stTestCondition);
        aft_plot_group_cross_spectrm_loglog(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId, iResponseAxisCtrlId, strTitle)

        iExcitingAxisCtrlId = 1; 
        if stGroupPrbs.fFreqBasic >= 2500
            iResponseAxisCtrlId = 2; 
        else
            iResponseAxisCtrlId = 4; 
        end
        strTitle = spec_get_title_by_excite_resp_axis(iExcitingAxisCtrlId, iResponseAxisCtrlId, stTestCondition);
        aft_plot_group_cross_spectrm_loglog(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId, iResponseAxisCtrlId, strTitle)
    end
end

%%%%%%% Excite by Z
aAxisInCtrl = stGroupPrbs.aAxisInCtrl; %% 20160722 
iFound_axis_2_acs_sc = find(aAxisInCtrl == 2);
if length(iFound_axis_2_acs_sc) >= 1 % 20160722 stGroupPrbs.fFreqBasic >= 2500
    iExcitingAxisCtrlId = 2; 
else
    iExcitingAxisCtrlId = 4; 
end
strTitle = spec_get_title_by_excite_axis(iExcitingAxisCtrlId, stTestCondition);

if aft_spec_count_total_num_excite_per_axis(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId) >= 1
    aft_plot_group_spectrm_loglog(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId, strTitle);
    aft_plot_self_scaled_spectrm_semilogy_(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId, strTitle);

    %% Group Spectrum
    if stGroupPrbs.iPlotFlag >= DEF_PLOT_LEVEL_CROSS_EFFECT
        if stGroupPrbs.iPlotFlag >= 3
            input('Any key to proceed display spectrum for next axis')
        end
        %%% Excite by Z
        if stGroupPrbs.fFreqBasic >= 2500
            iExcitingAxisCtrlId = 2; 
        else
            iExcitingAxisCtrlId = 4;
        end
        iResponseAxisCtrlId = 0; strTitle = spec_get_title_by_excite_resp_axis(iExcitingAxisCtrlId, iResponseAxisCtrlId, stTestCondition);
        aft_plot_group_cross_spectrm_loglog(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId, iResponseAxisCtrlId, strTitle);

        if stGroupPrbs.fFreqBasic >= 2500
            iExcitingAxisCtrlId = 2; 
        else
            iExcitingAxisCtrlId = 4;
        end        
        iResponseAxisCtrlId = 1; strTitle = spec_get_title_by_excite_resp_axis(iExcitingAxisCtrlId, iResponseAxisCtrlId, stTestCondition);
        aft_plot_group_cross_spectrm_loglog(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId, iResponseAxisCtrlId, strTitle);

    end
end

