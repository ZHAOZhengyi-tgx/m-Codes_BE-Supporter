function aft_save_self_spectrum_white_noise(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId)
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

stAppName = stGroupPrbs.stAppName;
iPlotFlag = stGroupPrbs.iPlotFlag;

%figure(idxAppAxisExcite * 100 + idxAppAxisExcite * 10);

%% Self-Spectrum  %% Save to file
iAppAxis = wb_map_axis_acs_2_app(iExcitingAxisCtrlId, stGroupPrbs.iMachineType);
figure(iAppAxis * 100 + iAppAxis *10);
set (gcf, 'Units', 'normalized', 'Position', [0, 0, 0.95, 0.95]);  %% 20120507, maximize current figure to whole window

aCurrentClock = clock;
strClockString = sprintf('%d-%d-%d-%d-%d-%d', aCurrentClock(1), aCurrentClock(2), aCurrentClock(3), aCurrentClock(4), aCurrentClock(5), floor(aCurrentClock(6)));
if stGroupPrbsResp.astCase(1).stTestCondition.iFlagIsOpenLoop == 1
    strSaveFilename_jpg = sprintf('%s%s_OL_%s.jpg', stGroupPrbs.stFilePath.strPathname, char(stAppName.astAppNameByCtrlBdAxis(iAppAxis)), strClockString);
    strSaveFilename_fig = sprintf('%s%s_OL_%s.fig', stGroupPrbs.stFilePath.strPathname, char(stAppName.astAppNameByCtrlBdAxis(iAppAxis)), strClockString);
else
    strSaveFilename_jpg = sprintf('%s%s_VL_%s.jpg', stGroupPrbs.stFilePath.strPathname, char(stAppName.astAppNameByCtrlBdAxis(iAppAxis)), strClockString);
    strSaveFilename_fig = sprintf('%s%s_VL_%s.fig', stGroupPrbs.stFilePath.strPathname, char(stAppName.astAppNameByCtrlBdAxis(iAppAxis)), strClockString);
end

global DEF_PLOT_LEVEL_SAVE_FIG;
if iPlotFlag >= DEF_PLOT_LEVEL_SAVE_FIG
    saveas(gcf, strSaveFilename_fig, 'fig');
end
saveas(gcf, strSaveFilename_jpg, 'jpg');

%%% Self-Spectrum, Scaled to Ref %%%% 20120108
%% Self-Spectrum  %% Save to file
iAppAxis = wb_map_axis_acs_2_app(iExcitingAxisCtrlId, stGroupPrbs.iMachineType);
figure(iAppAxis * 10 + iAppAxis *1);
set (gcf, 'Units', 'normalized', 'Position', [0, 0, 0.95, 0.95]); %% 20120507, maximize current figure to whole window

aCurrentClock = clock;
strClockString = sprintf('%d-%d-%d-%d-%d-%d', aCurrentClock(1), aCurrentClock(2), aCurrentClock(3), aCurrentClock(4), aCurrentClock(5), floor(aCurrentClock(6)));
if stGroupPrbsResp.astCase(1).stTestCondition.iFlagIsOpenLoop == 1
    strSaveFilename_jpg = sprintf('%s%s_OL_%s.jpg', stGroupPrbs.stFilePath.strPathname, char(stAppName.astAppNameByCtrlBdAxis(iAppAxis)), strClockString);
    strSaveFilename_fig = sprintf('%s%s_OL_%s.fig', stGroupPrbs.stFilePath.strPathname, char(stAppName.astAppNameByCtrlBdAxis(iAppAxis)), strClockString);
else
    strSaveFilename_jpg = sprintf('%sScaleRef_%s_VL_%s.jpg', stGroupPrbs.stFilePath.strPathname, char(stAppName.astAppNameByCtrlBdAxis(iAppAxis)), strClockString);
    strSaveFilename_fig = sprintf('%sScaleRef_%s_VL_%s.fig', stGroupPrbs.stFilePath.strPathname, char(stAppName.astAppNameByCtrlBdAxis(iAppAxis)), strClockString);
end

global DEF_PLOT_LEVEL_SAVE_FIG;
if iPlotFlag >= DEF_PLOT_LEVEL_SAVE_FIG
    saveas(gcf, strSaveFilename_fig, 'fig');
end
saveas(gcf, strSaveFilename_jpg, 'jpg');
%set (gcf, 'Units', 'normalized');