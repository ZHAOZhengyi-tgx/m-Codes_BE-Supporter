function aft_save_cross_spectrum_white_noise(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId, iResponseAxisCtrlId)
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

iAppAxis = wb_map_axis_acs_2_app(iExcitingAxisCtrlId, stGroupPrbs.iMachineType); iRespAppAxis = wb_map_axis_acs_2_app(iResponseAxisCtrlId, stGroupPrbs.iMachineType);

figure(iAppAxis * 100 + iRespAppAxis *10);

aCurrentClock = clock;
strClockString = sprintf('%d-%d-%d-%d-%d-%d', aCurrentClock(1), aCurrentClock(2), aCurrentClock(3), aCurrentClock(4), aCurrentClock(5), floor(aCurrentClock(6)));
if stGroupPrbsResp.astCase(1).stTestCondition.iFlagIsOpenLoop == 1
    strSaveFilename_jpg = sprintf('%s_EX%s_OL_Resp%s_%s.jpg', stGroupPrbs.stFilePath.strPathname, ...
        char(stAppName.astAppNameByCtrlBdAxis(iAppAxis)), char(stAppName.astAppNameByCtrlBdAxis(iRespAppAxis)), strClockString);
    strSaveFilename_fig = sprintf('%s_EX%s_OL_Resp%s_%s.fig', stGroupPrbs.stFilePath.strPathname, ...
        char(stAppName.astAppNameByCtrlBdAxis(iAppAxis)), char(stAppName.astAppNameByCtrlBdAxis(iRespAppAxis)), strClockString);
else
    strSaveFilename_jpg = sprintf('%s_EX%s_VL_Resp%s_%s.jpg', stGroupPrbs.stFilePath.strPathname, ...
        char(stAppName.astAppNameByCtrlBdAxis(iAppAxis)), char(stAppName.astAppNameByCtrlBdAxis(iRespAppAxis)), strClockString);
    strSaveFilename_fig = sprintf('%s_EX%s_VL_Resp%s_%s.fig', stGroupPrbs.stFilePath.strPathname, ...
        char(stAppName.astAppNameByCtrlBdAxis(iAppAxis)), char(stAppName.astAppNameByCtrlBdAxis(iRespAppAxis)), strClockString);
end

global DEF_PLOT_LEVEL_SAVE_FIG;
if iPlotFlag >= DEF_PLOT_LEVEL_SAVE_FIG
    saveas(gcf, strSaveFilename_fig, 'fig');
end
saveas(gcf, strSaveFilename_jpg, 'jpg');
