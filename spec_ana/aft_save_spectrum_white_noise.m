function aft_save_spectrum_white_noise(stGroupPrbs, stGroupPrbsResp)
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
% , strTitle
%iExcitingAxisCtrlId = 

stAppName = stGroupPrbs.stAppName;

iExcitingAxisCtrlId = 0;
if aft_spec_count_total_num_excite_per_axis(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId) >= 1
    aft_save_self_spectrum_white_noise(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId);
else
    iAppAxis = wb_map_axis_acs_2_app(iExcitingAxisCtrlId, stGroupPrbs.iMachineType);
    if iAppAxis == 1 
        close 11; close 110;
    else
        close 22; close 220;
    end
end
iExcitingAxisCtrlId = 1;
if aft_spec_count_total_num_excite_per_axis(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId) >= 1
    aft_save_self_spectrum_white_noise(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId);
else
    iAppAxis = wb_map_axis_acs_2_app(iExcitingAxisCtrlId, stGroupPrbs.iMachineType);
    if iAppAxis == 1 
        close 11; close 110;
    else
        close 22; close 220;
    end    
end

aAxisInCtrl = stGroupPrbs.aAxisInCtrl; %% 20160722 
iFound_axis_2_acs_sc = find(aAxisInCtrl == 2);
if length(iFound_axis_2_acs_sc) >= 1 % 20160722 stGroupPrbs.fFreqBasic >= 2500
    iExcitingAxisCtrlId = 2; 
else
    iExcitingAxisCtrlId = 4;
end

if aft_spec_count_total_num_excite_per_axis(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId) >= 1
    aft_save_self_spectrum_white_noise(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId);
else
    iAppAxis = wb_map_axis_acs_2_app(iExcitingAxisCtrlId, stGroupPrbs.iMachineType);
    close 33; close 330;
end

if stGroupPrbs.iPlotFlag >= 2
    %% Cross-Spectrum Save to file
    aft_save_cross_spectrum_white_noise(stGroupPrbs, stGroupPrbsResp, 0, 1);
    aft_save_cross_spectrum_white_noise(stGroupPrbs, stGroupPrbsResp, 0, iExcitingAxisCtrlId);

    aft_save_cross_spectrum_white_noise(stGroupPrbs, stGroupPrbsResp, 1, 0);
    aft_save_cross_spectrum_white_noise(stGroupPrbs, stGroupPrbsResp, 1, iExcitingAxisCtrlId);

    aft_save_cross_spectrum_white_noise(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId, 0);
    aft_save_cross_spectrum_white_noise(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId, 1);
end
