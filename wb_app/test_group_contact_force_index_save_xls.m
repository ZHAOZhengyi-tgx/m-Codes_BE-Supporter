function stContactForceStatistic1Set = test_group_contact_force_index_save_xls(strPathTargetFolder, astOutputAnaWbContactForce, iiFolder)


stForceCaliSetting = astOutputAnaWbContactForce(1).stForceCaliOutput.stForceCaliSetting;

%%% get performance index Wb*.txt
%nTotalCasePerformIdx = 0;
nNumFile = length(astOutputAnaWbContactForce)
    for jj = 1:1:nNumFile
        fForce1stImpact_gram = astOutputAnaWbContactForce(jj).stForceCaliOutput.a1stImpactForceGram_IdxTime(1);
        stBhContactForcePeformance.a1stImpactForce(jj) = ...
            fForce1stImpact_gram; % astOutputAnaWbContactForce(jj).stForceCaliOutput.a1stImpactForceGram_IdxTime(1) * ...
        
        stBhContactForcePeformance.aPeakImpactForce(jj) = ...
            astOutputAnaWbContactForce(jj).stForceCaliOutput.aPeakImpactForceGram_IdxTime(1);
        stBhContactForcePeformance.aPosnRippleByVelP2P(jj) = astOutputAnaWbContactForce(jj).stForceCaliOutput.fPosnRippleByVelP2P;
        
        stBhContactForcePeformance.aSettlingTimeVelFb_ms(jj) = astOutputAnaWbContactForce(jj).stForceCaliOutput.tVelSettleTime_ms; %% 20121220
        
        %%% 20130111
        stBhContactForcePeformance.aForceSensorStaticNoise_ADC(jj) = ...
            astOutputAnaWbContactForce(jj).stForceCaliOutput.stForceSensorNoiseNonContact.fStdAdc;
        stBhContactForcePeformance.aForceSensorStaticNoise_gram(jj) = ...
            astOutputAnaWbContactForce(jj).stForceCaliOutput.stForceSensorNoiseNonContact.fStdGram;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cellWbBndHeadContactForceXlsOneSetting(1, 1) = {'Loop#'};
cellWbBndHeadContactForceXlsOneSetting(1, 2) = {'1stImpactForce'};
cellWbBndHeadContactForceXlsOneSetting(1, 3) = {'PosnRippleP2P'};
cellWbBndHeadContactForceXlsOneSetting(1, 4) = {'VelFbSettleTime'};
cellWbBndHeadContactForceXlsOneSetting(1, 5) = {'PeakImpactForce'};
cellWbBndHeadContactForceXlsOneSetting(1, 6) = {'ForceSensorNoise-ADC'};
cellWbBndHeadContactForceXlsOneSetting(1, 7) = {'ForceSensorNoise-Gram'};

cellWbBndHeadContactForceXlsOneSetting(nNumFile + 3, 1) = {'Minimum'};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 4, 1) = {'Maximum'};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 5, 1) = {'Std'};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 6, 1) = {'Average'};

% cellWbBndHeadContactForceXlsOneSetting(1, 11) = ;
% cellWbBndHeadContactForceXlsOneSetting(1, 12) = ;
% cellWbBndHeadContactForceXlsOneSetting(1, 14) = ;
% cellWbBndHeadContactForceXlsOneSetting(1, 15) = ;
% cellWbBndHeadContactForceXlsOneSetting(1, 16) = ;
% cellWbBndHeadContactForceXlsOneSetting(1, 17) = ;
%        cellWbBndHeadContactForceXlsOneSetting(ii+1,1) = cellStrFileTitle;

stContactForceStatistic1Set.stCondition.fSrchVel = ...
    stForceCaliSetting.fSearchSpd_cnt_per_ms;
stContactForceStatistic1Set.stCondition.fDetectionThPE = ...
    stForceCaliSetting.fDetectionThPE;
stContactForceStatistic1Set.stCondition.iDetectionFlag = ...
    stForceCaliSetting.iDetectionFlag;
stContactForceStatistic1Set.stCondition.iCountactPositionReg = ...
    stForceCaliSetting.iCountactPositionReg;
stContactForceStatistic1Set.stCondition.fInitForceCommandReadBack = ...
    stForceCaliSetting.fInitForceCommandReadBack;
stContactForceStatistic1Set.stCondition.fSrchHt_um = ...
    stForceCaliSetting.fSrchHt_um;

%%%% Calculate Statistic
stContactForceStatistic1Set.st1stImpactForce.fMin = min(stBhContactForcePeformance.a1stImpactForce);
stContactForceStatistic1Set.st1stImpactForce.fMax = max(stBhContactForcePeformance.a1stImpactForce);
stContactForceStatistic1Set.st1stImpactForce.fStd = std(stBhContactForcePeformance.a1stImpactForce);
stContactForceStatistic1Set.st1stImpactForce.fAverage = mean(stBhContactForcePeformance.a1stImpactForce);

stContactForceStatistic1Set.stPeakImpactForce.fMin = min(stBhContactForcePeformance.aPeakImpactForce);
stContactForceStatistic1Set.stPeakImpactForce.fMax = max(stBhContactForcePeformance.aPeakImpactForce);
stContactForceStatistic1Set.stPeakImpactForce.fStd = std(stBhContactForcePeformance.aPeakImpactForce);
stContactForceStatistic1Set.stPeakImpactForce.fAverage = mean(stBhContactForcePeformance.aPeakImpactForce);

stContactForceStatistic1Set.stPosnRippleP2P.fMin = min(stBhContactForcePeformance.aPosnRippleByVelP2P);
stContactForceStatistic1Set.stPosnRippleP2P.fMax = max(stBhContactForcePeformance.aPosnRippleByVelP2P);
stContactForceStatistic1Set.stPosnRippleP2P.fStd = std(stBhContactForcePeformance.aPosnRippleByVelP2P);
stContactForceStatistic1Set.stPosnRippleP2P.fAverage = mean(stBhContactForcePeformance.aPosnRippleByVelP2P);

%%%% 20121220
stContactForceStatistic1Set.stVelFbSettleTime_ms.fMin = min(stBhContactForcePeformance.aSettlingTimeVelFb_ms); 
stContactForceStatistic1Set.stVelFbSettleTime_ms.fMax = max(stBhContactForcePeformance.aSettlingTimeVelFb_ms);
stContactForceStatistic1Set.stVelFbSettleTime_ms.fStd = std(stBhContactForcePeformance.aSettlingTimeVelFb_ms);
stContactForceStatistic1Set.stVelFbSettleTime_ms.fAverage = mean(stBhContactForcePeformance.aSettlingTimeVelFb_ms);

%%%% 20130111
stContactForceStatistic1Set.stForceSensorStaticNoise_ADC.fMin = min(stBhContactForcePeformance.aForceSensorStaticNoise_ADC); 
stContactForceStatistic1Set.stForceSensorStaticNoise_ADC.fMax = max(stBhContactForcePeformance.aForceSensorStaticNoise_ADC);
stContactForceStatistic1Set.stForceSensorStaticNoise_ADC.fStd = std(stBhContactForcePeformance.aForceSensorStaticNoise_ADC);
stContactForceStatistic1Set.stForceSensorStaticNoise_ADC.fAverage = mean(stBhContactForcePeformance.aForceSensorStaticNoise_ADC);

stContactForceStatistic1Set.stForceSensorStaticNoise_gram.fMin = min(stBhContactForcePeformance.aForceSensorStaticNoise_gram); 
stContactForceStatistic1Set.stForceSensorStaticNoise_gram.fMax = max(stBhContactForcePeformance.aForceSensorStaticNoise_gram);
stContactForceStatistic1Set.stForceSensorStaticNoise_gram.fStd = std(stBhContactForcePeformance.aForceSensorStaticNoise_gram);
stContactForceStatistic1Set.stForceSensorStaticNoise_gram.fAverage = mean(stBhContactForcePeformance.aForceSensorStaticNoise_gram);


for kk = 1:1:nNumFile % length(stBhContactForcePeformance.a1stImpactForce)
    cellWbBndHeadContactForceXlsOneSetting(kk+1, 2) = ...
        {stBhContactForcePeformance.a1stImpactForce(kk)};
    cellWbBndHeadContactForceXlsOneSetting(kk+1, 1) = {kk};
    
    cellWbBndHeadContactForceXlsOneSetting(kk+1, 5) = ...   %%% 2012Dec27
        {stBhContactForcePeformance.aPeakImpactForce(kk)};
    
    cellWbBndHeadContactForceXlsOneSetting(kk+1, 6) = ...   %%% 2013Jan11
        {stBhContactForcePeformance.aForceSensorStaticNoise_ADC(kk)};
    cellWbBndHeadContactForceXlsOneSetting(kk+1, 7) = ...   %%% 2013Jan11
        {stBhContactForcePeformance.aForceSensorStaticNoise_gram(kk)};
end


cellWbBndHeadContactForceXlsOneSetting(nNumFile + 3, 2) = {stContactForceStatistic1Set.st1stImpactForce.fMin};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 4, 2) = {stContactForceStatistic1Set.st1stImpactForce.fMax};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 5, 2) = {stContactForceStatistic1Set.st1stImpactForce.fStd};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 6, 2) = {stContactForceStatistic1Set.st1stImpactForce.fAverage};


cellWbBndHeadContactForceXlsOneSetting(nNumFile + 3, 5) = {stContactForceStatistic1Set.stPeakImpactForce.fMin};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 4, 5) = {stContactForceStatistic1Set.stPeakImpactForce.fMax};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 5, 5) = {stContactForceStatistic1Set.stPeakImpactForce.fStd};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 6, 5) = {stContactForceStatistic1Set.stPeakImpactForce.fAverage};

%%%% 20130111
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 3, 6) = {stContactForceStatistic1Set.stForceSensorStaticNoise_ADC.fMin};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 4, 6) = {stContactForceStatistic1Set.stForceSensorStaticNoise_ADC.fMax};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 5, 6) = {stContactForceStatistic1Set.stForceSensorStaticNoise_ADC.fStd};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 6, 6) = {stContactForceStatistic1Set.stForceSensorStaticNoise_ADC.fAverage};

cellWbBndHeadContactForceXlsOneSetting(nNumFile + 3, 7) = {stContactForceStatistic1Set.stForceSensorStaticNoise_gram.fMin};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 4, 7) = {stContactForceStatistic1Set.stForceSensorStaticNoise_gram.fMax};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 5, 7) = {stContactForceStatistic1Set.stForceSensorStaticNoise_gram.fStd};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 6, 7) = {stContactForceStatistic1Set.stForceSensorStaticNoise_gram.fAverage};



for kk = 1:1:nNumFile % length(stBhContactForcePeformance.aPosnRippleByVelP2P)
    cellWbBndHeadContactForceXlsOneSetting(kk+1, 3) = ...
        {stBhContactForcePeformance.aPosnRippleByVelP2P(kk)};
end
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 3, 3) = {stContactForceStatistic1Set.stPosnRippleP2P.fMin};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 4, 3) = {stContactForceStatistic1Set.stPosnRippleP2P.fMax};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 5, 3) = {stContactForceStatistic1Set.stPosnRippleP2P.fStd};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 6, 3) = {stContactForceStatistic1Set.stPosnRippleP2P.fAverage};

for kk = 1:1:nNumFile % length(.aPosnRippleByVelP2P)
    cellWbBndHeadContactForceXlsOneSetting(kk+1, 4) = ...
        {stBhContactForcePeformance.aSettlingTimeVelFb_ms(kk)};
end
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 3, 4) = {stContactForceStatistic1Set.stVelFbSettleTime_ms.fMin};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 4, 4) = {stContactForceStatistic1Set.stVelFbSettleTime_ms.fMax};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 5, 4) = {stContactForceStatistic1Set.stVelFbSettleTime_ms.fStd};
cellWbBndHeadContactForceXlsOneSetting(nNumFile + 6, 4) = {stContactForceStatistic1Set.stVelFbSettleTime_ms.fAverage};

strPathname = astOutputAnaWbContactForce(1).strPathname;
strSheetnameSrchV = sprintf('SrV%2.1fPETh%dHt%d_%d', ...
    round(stContactForceStatistic1Set.stCondition.fSrchVel/1000.0)/10, ...
    round(stContactForceStatistic1Set.stCondition.fDetectionThPE), ...
    round(stForceCaliSetting.fSrchHt_um),  ...
    iiFolder);

strXlsOutFullFilename = sprintf('%s\\XlsOutBhContactForce1Set_.xls', strPathTargetFolder);
strSheetname = strSheetnameSrchV;
strStartCell = 'C3';
xlswrite(strXlsOutFullFilename, cellWbBndHeadContactForceXlsOneSetting, strSheetname, strStartCell);

cellWbBndHeadContactForceSetting(1,1) = {'SrchVel (x 10 um/ms)'};
cellWbBndHeadContactForceSetting(1,2) = {stForceCaliSetting.fSearchSpd_cnt_per_ms};
cellWbBndHeadContactForceSetting(1,3) = {'PE-TH (um)'};
cellWbBndHeadContactForceSetting(1,4) = {stForceCaliSetting.fDetectionThPE};

cellWbBndHeadContactForceSetting(1,5) = {'Kv (Gram/AIN):'};
cellWbBndHeadContactForceSetting(1,6) = {stForceCaliSetting.fForceFbK_GramPerAin};

cellWbBndHeadContactForceSetting(1,7) = {'SrchHt(um):'};
cellWbBndHeadContactForceSetting(1,8) = {stForceCaliSetting.fSrchHt_um};


strStartCell = 'C1';
xlswrite(strXlsOutFullFilename, cellWbBndHeadContactForceSetting, strSheetname, strStartCell);

