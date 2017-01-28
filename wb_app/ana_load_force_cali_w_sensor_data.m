function stOutput = ana_load_force_cali_w_sensor_data(strFileFullName)

stOutput = [];

% aContactForceControlData
strLabelStartTrajData = ' aContactForceControlData =';
nlenLabelTrajData = length(strLabelStartTrajData);

aBackSlash = strfind(strFileFullName, '\');
aSrchHt = strfind(strFileFullName(aBackSlash(end-1):aBackSlash(end)), 'Ht');

if prod(size(aSrchHt)) == 0 %[]
    fSrchHt_um = 200;
else
    fSrchHt_um = sscanf(strFileFullName(aBackSlash(end-1)+aSrchHt(1) - 1:aBackSlash(end)), 'Ht%d_');
end

fptr = fopen(strFileFullName);

while ~feof(fptr)
    strLine = fgets(fptr);
    if length(strLine) >= nlenLabelTrajData
        if strLine(1:nlenLabelTrajData) == strLabelStartTrajData
            break;
        else
            eval(strLine);
        end
    else
        eval(strLine);
    end
end

if ~exist('fSampleTime_ms')
    fSampleTime_ms = 0.5;
end

%WB_Waveform(1,:) = sscanf(strLine, 'WB_Waveform = [%f, %f, %f, %f, %f, %f, %f, %f;');
ii = 0;
while ~feof(fptr)
    strLine = fgetl(fptr);
    ii = ii + 1;
    if strLine(1:2) == '];'
        break;
    else
        aContactForceControlData(ii,:) = sscanf(strLine, '%f, %f, %f, %f, %f, %f, %f;');
    end
end
fclose(fptr);

stOutput.aContactForceControlData = aContactForceControlData;
stForceCaliSetting.dPositionFactor = dPositionFactor;
stForceCaliSetting.dCtrlOutOffset = dCtrlOutOffset;
stForceCaliSetting.iCountactPositionReg = iCountactPositionReg;
stForceCaliSetting.fInitForceCommandReadBack = iCountactPositionReg;
% Force Command Block Information
stForceCaliSetting.aRampCountSeg = aRampCountSeg;
stForceCaliSetting.aLevelCountSeg = aLevelCountSeg;
stForceCaliSetting.afLevelAmplitude = afLevelAmplitude;
stForceCaliSetting.nNumSeg = length(aRampCountSeg); % nNumSeg;
stForceCaliSetting.fSearchSpd_cnt_per_ms = SearchSpd;
stForceCaliSetting.fDetectionThPE  = DetectionThPE ;
stForceCaliSetting.iDetectionFlag = DetectionFlag;
stForceCaliSetting.iCountactPositionReg = iCountactPositionReg;
stForceCaliSetting.fInitForceCommandReadBack = fInitForceCommandReadBack;
stForceCaliSetting.fSrchHt_um = fSrchHt_um;
stForceCaliSetting.fDampCtrl = iDampACS;
%%% 75 K-ohm
stForceCaliSetting.fForceFbK_GramPerAin = 0.15; % 0.0604; % 0.0405; %0.1516854;
stForceCaliSetting.fBondHeadEncoderCountPerMM = 1000;

stForceCaliSetting.fSampleTime_ms = 0.5;

stOutput.stForceCaliSetting = stForceCaliSetting;


