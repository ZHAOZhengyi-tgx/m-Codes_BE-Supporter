function contact_force_group_save_xls(nNumFolder,strPathTargetFolder,astStatisticAllSettingContactForce)

%%%%
strXlsOutFullFilename = sprintf('%s\\XlsOutBhContactForce1Set_.xls', strPathTargetFolder);
%%%%%%
cellWbBH_GroupintTitle(10, 1) = {'1stImpForce'};
cellWbBH_GroupintTitle(15, 1) = {'PosnRippleP2P'};
cellWbBH_GroupintTitle(20, 1) = {'VelFbSettleTime'};
cellWbBH_GroupintTitle(25, 1) = {'PeakImpF'};
cellWbBH_GroupintTitle(31, 1) = {'F-Sensor Static Noise Gram'};
cellWbBH_GroupintTitle(36, 1) = {'F-Sensor Static Noise ADC'};

strSheetname = 'SrV_1stImp';
cellWbBH_ContactForceXlsMasterSrVImpF(1, 1) = {'AbsSrchVel'};
cellWbBH_ContactForceXlsMasterSrVImpF(1, 2) = {'x 10 um/ms'};
cellWbBH_ContactForceXlsMasterSrVImpF(2, 1) = {'PE-Th'};
cellWbBH_ContactForceXlsMasterSrVImpF(2, 2) = {'um'};
cellWbBH_ContactForceXlsMasterSrVImpF(3, 1) = {'SrchHt'};
cellWbBH_ContactForceXlsMasterSrVImpF(3, 2) = {'um'};
cellWbBH_ContactForceXlsMasterSrVImpF(4, 1) = {'Damp'};
cellWbBH_ContactForceXlsMasterSrVImpF(4, 2) = {''};
cellWbBH_ContactForceXlsMasterSrVImpF(5, 1) = {'VK[P,I], PKP'};
cellWbBH_ContactForceXlsMasterSrVImpF(5, 2) = {''};
cellWbBH_ContactForceXlsMasterSrVImpF(6, 1) = {'PreImpF'};
cellWbBH_ContactForceXlsMasterSrVImpF(6, 2) = {''};
cellWbBH_ContactForceXlsMasterSrVImpF(10, 1) = {'Min'};
cellWbBH_ContactForceXlsMasterSrVImpF(10, 2) = {'gram'};
cellWbBH_ContactForceXlsMasterSrVImpF(11, 1) = {'Max'};
cellWbBH_ContactForceXlsMasterSrVImpF(11, 2) = {'gram'};
cellWbBH_ContactForceXlsMasterSrVImpF(12, 1) = {'Std'};
cellWbBH_ContactForceXlsMasterSrVImpF(12, 2) = {'gram'};
cellWbBH_ContactForceXlsMasterSrVImpF(13, 1) = {'Average'};
cellWbBH_ContactForceXlsMasterSrVImpF(13, 2) = {'gram'};
cellWbBH_ContactForceXlsMasterSrVImpF(14, 1) = {'Range'};
cellWbBH_ContactForceXlsMasterSrVImpF(14, 2) = {'gram'};

cellWbBH_ContactForceXlsMasterSrVImpF(15, 1) = {'Min'};
cellWbBH_ContactForceXlsMasterSrVImpF(15, 2) = {'um'};
cellWbBH_ContactForceXlsMasterSrVImpF(16, 1) = {'Max'};
cellWbBH_ContactForceXlsMasterSrVImpF(16, 2) = {'um'};
cellWbBH_ContactForceXlsMasterSrVImpF(17, 1) = {'Std'};
cellWbBH_ContactForceXlsMasterSrVImpF(17, 2) = {'um'};
cellWbBH_ContactForceXlsMasterSrVImpF(18, 1) = {'Average'};
cellWbBH_ContactForceXlsMasterSrVImpF(18, 2) = {'um'};
cellWbBH_ContactForceXlsMasterSrVImpF(19, 1) = {'Range'};
cellWbBH_ContactForceXlsMasterSrVImpF(19, 2) = {'um'};

cellWbBH_ContactForceXlsMasterSrVImpF(20, 1) = {'Min'};
cellWbBH_ContactForceXlsMasterSrVImpF(20, 2) = {'ms'};
cellWbBH_ContactForceXlsMasterSrVImpF(21, 1) = {'Max'};
cellWbBH_ContactForceXlsMasterSrVImpF(21, 2) = {'ms'};
cellWbBH_ContactForceXlsMasterSrVImpF(22, 1) = {'Std'};
cellWbBH_ContactForceXlsMasterSrVImpF(22, 2) = {'ms'};
cellWbBH_ContactForceXlsMasterSrVImpF(23, 1) = {'Average'};
cellWbBH_ContactForceXlsMasterSrVImpF(23, 2) = {'ms'};
cellWbBH_ContactForceXlsMasterSrVImpF(24, 1) = {'Range'};
cellWbBH_ContactForceXlsMasterSrVImpF(24, 2) = {'ms'};

%cellWbBH_ContactForceXlsMasterSrVImpF(25, 1) = {'PeakImpF'};
%cellWbBH_ContactForceXlsMasterSrVImpF(25, 2) = {''};
cellWbBH_ContactForceXlsMasterSrVImpF(25, 1) = {'Min'};
cellWbBH_ContactForceXlsMasterSrVImpF(25, 2) = {'gram'};
cellWbBH_ContactForceXlsMasterSrVImpF(26, 1) = {'Max'};
cellWbBH_ContactForceXlsMasterSrVImpF(26, 2) = {'gram'};
cellWbBH_ContactForceXlsMasterSrVImpF(27, 1) = {'Std'};
cellWbBH_ContactForceXlsMasterSrVImpF(27, 2) = {'gram'};
cellWbBH_ContactForceXlsMasterSrVImpF(28, 1) = {'Average'};
cellWbBH_ContactForceXlsMasterSrVImpF(28, 2) = {'gram'};
cellWbBH_ContactForceXlsMasterSrVImpF(29, 1) = {'Range'};
cellWbBH_ContactForceXlsMasterSrVImpF(29, 2) = {'gram'};

cellWbBH_ContactForceXlsMasterSrVImpF(31, 1) = {'Min'};
cellWbBH_ContactForceXlsMasterSrVImpF(31, 2) = {'gram'};
cellWbBH_ContactForceXlsMasterSrVImpF(32, 1) = {'Max'};
cellWbBH_ContactForceXlsMasterSrVImpF(32, 2) = {'gram'};
cellWbBH_ContactForceXlsMasterSrVImpF(33, 1) = {'Std'};
cellWbBH_ContactForceXlsMasterSrVImpF(33, 2) = {'gram'};
cellWbBH_ContactForceXlsMasterSrVImpF(34, 1) = {'Average'};
cellWbBH_ContactForceXlsMasterSrVImpF(34, 2) = {'gram'};
cellWbBH_ContactForceXlsMasterSrVImpF(35, 1) = {'Range'};
cellWbBH_ContactForceXlsMasterSrVImpF(35, 2) = {'gram'};

cellWbBH_ContactForceXlsMasterSrVImpF(36, 1) = {'Min'};
cellWbBH_ContactForceXlsMasterSrVImpF(36, 2) = {'ADC'};
cellWbBH_ContactForceXlsMasterSrVImpF(37, 1) = {'Max'};
cellWbBH_ContactForceXlsMasterSrVImpF(37, 2) = {'ADC'};
cellWbBH_ContactForceXlsMasterSrVImpF(38, 1) = {'Std'};
cellWbBH_ContactForceXlsMasterSrVImpF(38, 2) = {'ADC'};
cellWbBH_ContactForceXlsMasterSrVImpF(39, 1) = {'Average'};
cellWbBH_ContactForceXlsMasterSrVImpF(39, 2) = {'ADC'};
cellWbBH_ContactForceXlsMasterSrVImpF(40, 1) = {'Range'};
cellWbBH_ContactForceXlsMasterSrVImpF(40, 2) = {'ADC'};

for ii = 1:1:nNumFolder
    if prod(size(astStatisticAllSettingContactForce(ii).astOutputAnaWbContactForce)) == 0
        continue;
    end
    stForceCaliSetting = ...
        astStatisticAllSettingContactForce(ii).astOutputAnaWbContactForce(1).stForceCaliOutput.stForceCaliSetting;
    
    stContactForceStatistic1Set = astStatisticAllSettingContactForce(ii).stContactForceStatistic1Set;
    cellWbBH_ContactForceXlsMasterSrVImpF(1, ii+3) = ...
        {abs(stForceCaliSetting.fSearchSpd_cnt_per_ms / stForceCaliSetting.fBondHeadEncoderCountPerMM/10)};
    cellWbBH_ContactForceXlsMasterSrVImpF(2, ii+3) = ...
        {stForceCaliSetting.fDetectionThPE};
    cellWbBH_ContactForceXlsMasterSrVImpF(3, ii+3) = ...
        {stForceCaliSetting.fSrchHt_um};
    cellWbBH_ContactForceXlsMasterSrVImpF(4, ii+3) = ...
        {stForceCaliSetting.fDampCtrl};
    cellWbBH_ContactForceXlsMasterSrVImpF(10, ii+3) = ...
        {stContactForceStatistic1Set.st1stImpactForce.fMin};
    cellWbBH_ContactForceXlsMasterSrVImpF(11, ii+3) = ...
        {stContactForceStatistic1Set.st1stImpactForce.fMax};
    cellWbBH_ContactForceXlsMasterSrVImpF(12, ii+3) = ...
        {stContactForceStatistic1Set.st1stImpactForce.fStd};
    cellWbBH_ContactForceXlsMasterSrVImpF(13, ii+3) = ...
        {stContactForceStatistic1Set.st1stImpactForce.fAverage};
    cellWbBH_ContactForceXlsMasterSrVImpF(14, ii+3) = ...
        {stContactForceStatistic1Set.st1stImpactForce.fMax - stContactForceStatistic1Set.st1stImpactForce.fMin};

    cellWbBH_ContactForceXlsMasterSrVImpF(15, ii+3) = ...
        {stContactForceStatistic1Set.stPosnRippleP2P.fMin};
    cellWbBH_ContactForceXlsMasterSrVImpF(16, ii+3) = ...
        {stContactForceStatistic1Set.stPosnRippleP2P.fMax};
    cellWbBH_ContactForceXlsMasterSrVImpF(17, ii+3) = ...
        {stContactForceStatistic1Set.stPosnRippleP2P.fStd};
    cellWbBH_ContactForceXlsMasterSrVImpF(18, ii+3) = ...
        {stContactForceStatistic1Set.stPosnRippleP2P.fAverage};
    cellWbBH_ContactForceXlsMasterSrVImpF(19, ii+3) = ...
        {stContactForceStatistic1Set.stPosnRippleP2P.fMax - stContactForceStatistic1Set.stPosnRippleP2P.fMin};
    
    % stVelFbSettleTime_ms
    cellWbBH_ContactForceXlsMasterSrVImpF(20, ii+3) = ...
        {stContactForceStatistic1Set.stVelFbSettleTime_ms.fMin};
    cellWbBH_ContactForceXlsMasterSrVImpF(21, ii+3) = ...
        {stContactForceStatistic1Set.stVelFbSettleTime_ms.fMax};
    cellWbBH_ContactForceXlsMasterSrVImpF(22, ii+3) = ...
        {stContactForceStatistic1Set.stVelFbSettleTime_ms.fStd};
    cellWbBH_ContactForceXlsMasterSrVImpF(23, ii+3) = ...
        {stContactForceStatistic1Set.stVelFbSettleTime_ms.fAverage};
    cellWbBH_ContactForceXlsMasterSrVImpF(24, ii+3) = ...
        {stContactForceStatistic1Set.stVelFbSettleTime_ms.fMax - stContactForceStatistic1Set.stVelFbSettleTime_ms.fMin};
    
    %% Peak Impact Force
    cellWbBH_ContactForceXlsMasterSrVImpF(25, ii+3) = ...
        {stContactForceStatistic1Set.stPeakImpactForce.fMin};
    cellWbBH_ContactForceXlsMasterSrVImpF(26, ii+3) = ...
        {stContactForceStatistic1Set.stPeakImpactForce.fMax};
    cellWbBH_ContactForceXlsMasterSrVImpF(27, ii+3) = ...
        {stContactForceStatistic1Set.stPeakImpactForce.fStd};
    cellWbBH_ContactForceXlsMasterSrVImpF(28, ii+3) = ...
        {stContactForceStatistic1Set.stPeakImpactForce.fAverage};
    cellWbBH_ContactForceXlsMasterSrVImpF(29, ii+3) = ...
        {stContactForceStatistic1Set.stPeakImpactForce.fMax - stContactForceStatistic1Set.stPeakImpactForce.fMin};

    %% Force Sensor Static Noise, Gram
    cellWbBH_ContactForceXlsMasterSrVImpF(31, ii+3) = ...
        {stContactForceStatistic1Set.stForceSensorStaticNoise_gram.fMin};
    cellWbBH_ContactForceXlsMasterSrVImpF(32, ii+3) = ...
        {stContactForceStatistic1Set.stForceSensorStaticNoise_gram.fMax};
    cellWbBH_ContactForceXlsMasterSrVImpF(33, ii+3) = ...
        {stContactForceStatistic1Set.stForceSensorStaticNoise_gram.fStd};
    cellWbBH_ContactForceXlsMasterSrVImpF(34, ii+3) = ...
        {stContactForceStatistic1Set.stForceSensorStaticNoise_gram.fAverage};
    cellWbBH_ContactForceXlsMasterSrVImpF(35, ii+3) = ...
        {stContactForceStatistic1Set.stForceSensorStaticNoise_gram.fMax - ...
        stContactForceStatistic1Set.stForceSensorStaticNoise_gram.fMin};

    %% stForceSensorStaticNoise_ADC
    cellWbBH_ContactForceXlsMasterSrVImpF(36, ii+3) = ...
        {stContactForceStatistic1Set.stForceSensorStaticNoise_ADC.fMin};
    cellWbBH_ContactForceXlsMasterSrVImpF(37, ii+3) = ...
        {stContactForceStatistic1Set.stForceSensorStaticNoise_ADC.fMax};
    cellWbBH_ContactForceXlsMasterSrVImpF(38, ii+3) = ...
        {stContactForceStatistic1Set.stForceSensorStaticNoise_ADC.fStd};
    cellWbBH_ContactForceXlsMasterSrVImpF(39, ii+3) = ...
        {stContactForceStatistic1Set.stForceSensorStaticNoise_ADC.fAverage};
    cellWbBH_ContactForceXlsMasterSrVImpF(40, ii+3) = ...
        {stContactForceStatistic1Set.stForceSensorStaticNoise_ADC.fMax - ...
        stContactForceStatistic1Set.stForceSensorStaticNoise_ADC.fMin};
end

strStartCell = 'C3';
xlswrite(strXlsOutFullFilename, cellWbBH_ContactForceXlsMasterSrVImpF, strSheetname, strStartCell);

strStartCell = 'B3';
xlswrite(strXlsOutFullFilename, cellWbBH_GroupintTitle, strSheetname, strStartCell);

