function astMotorControlInfo = aft_be_wb_get_motor_driver_spec(iMachaTronicsType)
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

switch iMachaTronicsType
    case {0, 1, 3, 4, 5, 6, 10, 11}
        astMotorControlInfo(1).fEncCnt_mm = 2000;
        astMotorControlInfo(1).fForceConst_NewtonPerAmp = 53.3;
        astMotorControlInfo(1).fDriverRatio_AmpPerDacCount = 10/32767;
        astMotorControlInfo(1).fMovingMass_kg = 10;

        astMotorControlInfo(2).fEncCnt_mm = 2000;
        astMotorControlInfo(2).fForceConst_NewtonPerAmp = 8.06;
        astMotorControlInfo(2).fDriverRatio_AmpPerDacCount = 16/32767;
        astMotorControlInfo(2).fMovingMass_kg = 3;

        astMotorControlInfo(3).fEncCnt_mm = 1000;
        astMotorControlInfo(3).fForceConst_NewtonPerAmp =9.7;
        astMotorControlInfo(3).fDriverRatio_AmpPerDacCount = 8/32767;
        astMotorControlInfo(3).fMovingMass_kg = 0.332;

        astMotorControlInfo(4).fEncCnt_mm = 0;
        astMotorControlInfo(4).fForceConst_NewtonPerAmp =9.7;
        astMotorControlInfo(4).fDriverRatio_AmpPerDacCount = 2/32767;
        astMotorControlInfo(4).fMovingMass_kg = 0.03;
    case 2,
        astMotorControlInfo(1).fEncCnt_mm = 2000;
        astMotorControlInfo(1).fForceConst_NewtonPerAmp = 106.6;
        astMotorControlInfo(1).fDriverRatio_AmpPerDacCount = 18/32767;
        astMotorControlInfo(1).fMovingMass_kg = 12;

        astMotorControlInfo(2).fEncCnt_mm = 2000;
        astMotorControlInfo(2).fForceConst_NewtonPerAmp = 32.26;
        astMotorControlInfo(2).fDriverRatio_AmpPerDacCount = 16/32767;
        astMotorControlInfo(2).fMovingMass_kg = 4;

        astMotorControlInfo(3).fEncCnt_mm = 1000;
        astMotorControlInfo(3).fForceConst_NewtonPerAmp =9.7;
        astMotorControlInfo(3).fDriverRatio_AmpPerDacCount = 8/32767;
        astMotorControlInfo(3).fMovingMass_kg = 0.332;

        astMotorControlInfo(4).fEncCnt_mm = 0;
        astMotorControlInfo(4).fForceConst_NewtonPerAmp =9.7;
        astMotorControlInfo(4).fDriverRatio_AmpPerDacCount = 2/32767;
        astMotorControlInfo(4).fMovingMass_kg = 0.03;
end        