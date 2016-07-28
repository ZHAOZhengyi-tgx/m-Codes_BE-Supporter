function strTitle = spec_get_title_by_excite_resp_axis(iExcitingAxisCtrlId, iRespAxis, stTestCondition)
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
iAppAxis = wb_map_axis_acs_2_app(iExcitingAxisCtrlId, stTestCondition.iMachineType);
iAppRespAxis = wb_map_axis_acs_2_app(iRespAxis, stTestCondition.iMachineType);


strAppName = char(stAppName.astAppNameByCtrlBdAxis(iAppAxis));
strRespAppName = char(stAppName.astAppNameByCtrlBdAxis(iAppRespAxis));
if stTestCondition.iFlagIsOpenLoop == 1
    strTitle = sprintf('%s to %s - OpenLoop DriveCmd Exciting, Fb Velocity Spectrum', strAppName, strRespAppName);  %% PRBS
else
    strTitle = sprintf('%s to %s - Velocity Cmd Exciting, Fb Velocity Spectrum', strAppName, strRespAppName);  %% PRBS
end
