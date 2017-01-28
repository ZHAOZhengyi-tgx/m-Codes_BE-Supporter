% close all;
% clear all;

%ContactForceControl0
%ContactForceControl1
%ContactForceControl2
%ContactForceControl3
%ContactForceControl4
%ContactForceControl5
%ContactForceControl7
%ContactForceControl6
%ContactForceControl8
%ContactForceControl9
%ContactForceControl10
%ContactForceControl11
%ContactForceControl12
%ContactForceControl13
%ContactForceControl14
%ContactForceControl15
%ContactForceControl16
%ContactForceControl17_Hold5Cnt
%ContactForceControl18_Hold3Cnt
%ContactForceControl19_Hold1Cnt
%ContactForceControl20_Hold0Cnt
%ForceCalibration_ErrScope
%ForceCalibration
%ForceCalibration2;
%ContactForceControl20_Ramp0
%ContactForceControl20_Ramp5
%ContactForceControl20_Ramp6
%ContactForceControl20_Ramp7
%ContactForceControl20_Ramp8
%ContactForceControl20_Ramp9
%ContactForceControl20_Ramp10

%ForceCalibration3
%ContactForceControl21
%ContactForceControl_ScaleX10
%ForceCalibration_PassHighNoise
%WB13V_0_ContactForceControl_Y2012M11D1_H18M15
function stForceCaliOutput = test_force_control(strFileFullName)

global iPlotFlag;

if ~exist('iPlotFlag')
    iPlotFlag = 2;
elseif prod(size(iPlotFlag)) == 0 % isempty('iPlotFlag')
    iPlotFlag = 2;
end

stForceCaliOutput = [];

if ~exist('strFileFullName')
%    close all;
%    clear all;
    [Filename, Pathname] = uigetfile('*.m;*.dat', 'Pick an m file as output from force control');
    strFileFullName = strcat(Pathname , Filename);
else
    aPosnBackSlash = strfind(strFileFullName, '\');
    Pathname = strFileFullName(1: aPosnBackSlash(end));
    Filename = strFileFullName(aPosnBackSlash(end)+1 : end);
end

stOutput = ana_load_force_cali_w_sensor_data(strFileFullName);

stForceCaliSetting = stOutput.stForceCaliSetting;
aRampCountSeg = stForceCaliSetting.aRampCountSeg;
aLevelCountSeg = stForceCaliSetting.aLevelCountSeg;
afLevelAmplitude = stForceCaliSetting.afLevelAmplitude;

aContactForceControlData = stOutput.aContactForceControlData;

aFbPosn = aContactForceControlData(:, 1);
aRefPosn = aContactForceControlData(:, 2);
aPosnErr = aContactForceControlData(:, 3);
aDebCounterTeachContact = aContactForceControlData(:, 4);
aForceCmd = aContactForceControlData(:, 5);
aForceFb = aContactForceControlData(:, 6);

stRawData.aFbPosn = aFbPosn;
stRawData.aRefPosn = aRefPosn;
stRawData.aPosnErr = aPosnErr;
stRawData.aDebCounterTeachContact = aDebCounterTeachContact;
stRawData.aForceCmd = aForceCmd;
stRawData.aForceFb = aForceFb;

nDataLen = size(aContactForceControlData, 1);
nPlotLen = 3500; %length(aForceFb);
idxTime = 2:1:nPlotLen;

afRefVel = [diff(aRefPosn); 0];
afFbVel = [diff(aFbPosn); 0];

if iPlotFlag >= 1
    figure(1);
    subplot(2,3,5);
    plot(idxTime, aForceCmd(idxTime));
    title('force command')
    grid on;

    subplot(2,3,3);
    plot(idxTime, aFbPosn(idxTime), idxTime, aRefPosn(idxTime));
    legend('FbPosn', 'RefPosn', 'Location','NorthEast')
    grid on;

    subplot(2,3,2);
    plot(idxTime, aPosnErr(idxTime));
    title('Position Error')
    grid on;

    subplot(2,3,6);
    plot(idxTime, aForceFb(idxTime));
    title('Force Feedback, ADC')
    grid on;

    %figure(5);
    subplot(2,3,1);
    plot(idxTime, afRefVel(idxTime), 'r*', idxTime, afFbVel(idxTime), '-');
    legend('RefVel', 'FbVel', 'Location','SouthEast');
    title('Reference v.s. Feedback Velocity')
    grid on;

end

%aFirAdcForce = [1526          882          378           14         -210         -294         -238          -42          294];
%aFirAdcForce = [-210          140          390          540          590          540          390          140         -210];
aForceFb = aForceFb - mean(aForceFb(1:50));
aFirAdcForce = ones(1, 16);
aFirAdcForce = aFirAdcForce/sum(aFirAdcForce);
aFilterForceAdc = filter(aFirAdcForce, 1, aForceFb);
%figure(6);

if iPlotFlag >= 1
    subplot(2,3,4);
    plot(idxTime, aForceFb(idxTime), idxTime, aFilterForceAdc(idxTime), 'o');
    legend('Raw', 'Smoothed', 'Location','South')
    title('Force Feedback Raw v.s. FilteredForce')
    grid on;

end

[aForceCaliPara_dcom, stDebug] = calc_force_calibration(afLevelAmplitude, aPosnErr, aForceCmd, aForceFb, afRefVel, aDebCounterTeachContact);
iStartIdxForceCtrl = stDebug.iStartIdx;
iEndIdxForceCtrl = stDebug.iEndIdx;
aStartIndexPerSegForce = stDebug.aStartIndexPerSeg;

idx1stImpactForce = [];

nSamplePreContactSwitch = ...
    round(abs(stForceCaliSetting.fDetectionThPE/(stForceCaliSetting.fSearchSpd_cnt_per_ms/1000)) * 2.8)
aidxRange1stImpForce = (iStartIdxForceCtrl - nSamplePreContactSwitch): 1: iStartIdxForceCtrl+1;
aDiffForce = diff(aForceFb(aidxRange1stImpForce));
[fMinDiffForce, idxMinDiffForce] = min(aDiffForce);
if fMinDiffForce > 0
    idx1stImpactForce = idxMinDiffForce - 1 + iStartIdxForceCtrl - nSamplePreContactSwitch;
    f1stImpactForce = aForceFb(idx1stImpactForce);
else
    for ii = (iStartIdxForceCtrl-nSamplePreContactSwitch): 1: iStartIdxForceCtrl+2
        if (aForceFb(ii) > (aForceFb(ii-1) )) && aForceFb(ii) >= (aForceFb(ii + 1))
            f1stImpactForce = aForceFb(ii);
            idx1stImpactForce = ii;
            break;
        end
    end
end

[fPeakImpactForce, idxRel] = max(aForceFb(iStartIdxForceCtrl-5 :iStartIdxForceCtrl + 4));
idxPeakImpactForce = idxRel - 1 + iStartIdxForceCtrl-5;

if prod(size(idx1stImpactForce)) == 0
    idx1stImpactForce = idxPeakImpactForce;
    f1stImpactForce = fPeakImpactForce;
end

iFlagMaxPosition = 0;
iFlagMinPosition = 0;
fPositionRipplePositive = 0;
fPositionRippleNegative = 0;

%%%
[fPositionRipplePositive, iFlagMaxPosition] = max(aFbPosn((iStartIdxForceCtrl+1): (iStartIdxForceCtrl + 20)));
[fPositionRippleNegative, iFlagMinPosition] = min(aFbPosn((iStartIdxForceCtrl+1): (iStartIdxForceCtrl + 20)));
iFlagMaxPosition = iStartIdxForceCtrl + iFlagMaxPosition;
iFlagMinPosition = iStartIdxForceCtrl + iFlagMinPosition;

idxVelSettle = iEndIdxForceCtrl - 20;
for ii = iStartIdxForceCtrl + 1:1: iEndIdxForceCtrl - 20
    if (abs(afFbVel(ii)) <= 1.1 && abs(afFbVel(ii + 1)) <= 1.1 && abs(afFbVel(ii + 2)) <= 1.1 &&...
            abs(afFbVel(ii + 3)) <= 1.1 && abs(afFbVel(ii + 4)) <= 1.1 && abs(afFbVel(ii + 5)) <= 1.1 && ...
            abs(afFbVel(ii + 6)) <= 1.1 && abs(afFbVel(ii + 7)) <= 1.1 && abs(afFbVel(ii + 8)) <= 1.1 && ...
            abs(afFbVel(ii + 9)) <= 1.1 && abs(afFbVel(ii + 10)) <= 1.1 && abs(afFbVel(ii + 11)) <= 1.1 && ...
            abs(afFbVel(ii + 12)) <= 1.1 && abs(afFbVel(ii + 13)) <= 1.1 && abs(afFbVel(ii + 14)) <= 1.1 && ...
            abs(afFbVel(ii + 15)) <= 1.1 && abs(afFbVel(ii + 16)) <= 1.1 && abs(afFbVel(ii + 17)) <= 1.1 && ...
            abs(afFbVel(ii + 18)) <= 1.1 && abs(afFbVel(ii + 19)) <= 1.1 && abs(afFbVel(ii + 20)) <= 1.1 ...
        )
        idxVelSettle = ii;
        break;
    end
end
tVelSettleTime_ms = (idxVelSettle - iStartIdxForceCtrl) * stForceCaliSetting.fSampleTime_ms;

% for ii = iStartIdxForceCtrl + 1:1: iEndIdxForceCtrl
%     if aFbPosn(ii - 1) < aFbPosn(ii) && aFbPosn(ii + 1) <= aFbPosn(ii) && iFlagMaxPosition == 0
%         iFlagMaxPosition = ii;
%         fPositionRipplePositive = aFbPosn(ii);
%     end
%     if aFbPosn(ii - 1) > aFbPosn(ii) && aFbPosn(ii + 1) >= aFbPosn(ii) && iFlagMinPosition == 0
%         iFlagMinPosition = ii;
%         fPositionRippleNegative = aFbPosn(ii);
%     end
%     if iFlagMinPosition ~= 0 && iFlagMaxPosition ~= 0
%         break;
%     end
%     
%     
% %     if afRefVel(ii-1) <=0 && afRefVel(ii) > 0 && iFlagSumVelPositive == 0
% %         fPositionRipplePositive = fPositionRipplePositive + afRefVel(ii);
% %         iFlagSumVelPositive = 1;
% %     elseif iFlagSumVelPositive == 1 && afRefVel(ii - 1) > 0 && afRefVel(ii) > 0
% %         fPositionRipplePositive = fPositionRipplePositive + afRefVel(ii);
% %     elseif iFlagSumVelPositive == 1 && afRefVel(ii - 1) > 0 && afRefVel(ii) <= 0
% %         iFlagSumVelPositive = 2;
% %     end
% %     
% %     if afRefVel(ii-1) >=0 && afRefVel(ii) < 0 && iFlagSumVelNegative == 0
% %         fPositionRippleNegative = fPositionRippleNegative + afRefVel(ii);
% %         iFlagSumVelNegative = 1;
% %     elseif iFlagSumVelNegative == 1 && afRefVel(ii - 1) < 0 && afRefVel(ii) < 0
% %         fPositionRippleNegative = fPositionRippleNegative + afRefVel(ii);
% %     elseif iFlagSumVelNegative == 1 && afRefVel(ii - 1) < 0 && afRefVel(ii) >= 0
% %         iFlagSumVelNegative = 2;
% %     end
% %     
% %     if iFlagSumVelPositive == 2 && iFlagSumVelNegative == 2
% %         break;
% %     end
% end

aRefVelDuringSwitch = afRefVel(iStartIdxForceCtrl-1:iStartIdxForceCtrl+10);
fPosnRippleByVelP2P = fPositionRipplePositive - fPositionRippleNegative; %% max(aRefVelDuringSwitch) - min(aRefVelDuringSwitch);
fImpactForceFb = max(aFilterForceAdc(idx1stImpactForce:aStartIndexPerSegForce(1)));

format long g
Filename
a1stImpactForceGram_IdxTime = [round(f1stImpactForce * stForceCaliSetting.fForceFbK_GramPerAin), idx1stImpactForce]
aPosnRippleByVelP2P_ImpactForceFb = [fPosnRippleByVelP2P, round(fImpactForceFb * stForceCaliSetting.fForceFbK_GramPerAin)];
aPositionRippleContactStart = [fPositionRipplePositive, fPositionRippleNegative, iFlagMaxPosition, iFlagMinPosition];
aSettlingIdx_Time = [idxVelSettle, tVelSettleTime_ms];

aPeakImpactForceGram_IdxTime = [round(fPeakImpactForce * stForceCaliSetting.fForceFbK_GramPerAin), idxPeakImpactForce]

if iPlotFlag >= 1
    figure(1);
    subplot(2,3,1);
    xlim([2, iEndIdxForceCtrl]);
    subplot(2,3,2);
    xlim([2, iEndIdxForceCtrl]);
    subplot(2,3,3);
    xlim([iStartIdxForceCtrl-10, iEndIdxForceCtrl]);
    ylim([min(aRefPosn)-5, aRefPosn(iStartIdxForceCtrl-10) + 5])
    subplot(2,3,4);
    xlim([2, iEndIdxForceCtrl]);
    subplot(2,3,5);
    xlim([2, iEndIdxForceCtrl]);
    subplot(2,3,6);
    xlim([2, iEndIdxForceCtrl]);
end

if iPlotFlag >= 2
    aLocDot = strfind(Filename, '.');
    strSaveFilename_jpg = sprintf('%s\\%s_BondForceVel.jpg', Pathname, Filename(1: aLocDot(1) -1));
    saveas(gcf, strSaveFilename_jpg, 'jpg');
end

if exist('aForceFbMean_gram')
    if iPlotFlag >= 1
        figure; plot(aForceFbMean_gram(:,4), aForceFbMean_gram(:,6), '*')
        title('Calibration by C');
    end
end
%aForceCaliPara_dcom =[    -0.018946,      -0.37742]
format 

%%%% force sensor noise in static, non contact period
stForceSensorNoiseNonContact.fStdAdc = std(stRawData.aForceFb(1:floor(iStartIdxForceCtrl/2)));
stForceSensorNoiseNonContact.fStdGram = ...
    stForceSensorNoiseNonContact.fStdAdc * stForceCaliSetting.fForceFbK_GramPerAin;

%%%% output

stForceCaliOutput.aForceCaliPara_dcom = aForceCaliPara_dcom;
stForceCaliOutput.stDebug = stDebug;
stForceCaliOutput.a1stImpactForceGram_IdxTime = a1stImpactForceGram_IdxTime;
stForceCaliOutput.fPosnRippleByVelP2P = fPosnRippleByVelP2P;
stForceCaliOutput.fImpactForceFb = fImpactForceFb;
stForceCaliOutput.tVelSettleTime_ms = tVelSettleTime_ms;
stForceCaliOutput.stForceCaliSetting = stForceCaliSetting;
stForceCaliOutput.aPositionRippleContactStart = aPositionRippleContactStart;
stForceCaliOutput.stRawData = stRawData;
stForceCaliOutput.aPeakImpactForceGram_IdxTime = aPeakImpactForceGram_IdxTime;

stForceCaliOutput.stForceSensorNoiseNonContact = stForceSensorNoiseNonContact;
