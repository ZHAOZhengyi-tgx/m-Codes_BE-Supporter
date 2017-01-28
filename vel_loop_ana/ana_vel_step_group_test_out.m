function [astVelStepTestExcitingAxis, nTotalAxis, nTotalCase] = ana_vel_step_group_test_out(stVelStepGroupTestOut)

nTotalCase = length(stVelStepGroupTestOut);

aAxisId = stVelStepGroupTestOut(1).aAxisId;
nTotalEnvolveAxis = length(aAxisId);
for ii = 1:1:nTotalEnvolveAxis
    astVelStepGroupTestAnalyze(ii).iAxisId = aAxisId(ii);
    astVelStepGroupTestAnalyze(ii).nTotalCases = 0;
end

for ii = 1:1:nTotalCase
    for jj = 1:1:nTotalEnvolveAxis
        if stVelStepGroupTestOut(ii).iExciteAxis == astVelStepGroupTestAnalyze(jj).iAxisId
            astVelStepGroupTestAnalyze(jj).nTotalCases = astVelStepGroupTestAnalyze(jj).nTotalCases + 1;
            iCurrentAxis = jj;
        end
    end
    iCurrTotalCase = astVelStepGroupTestAnalyze(iCurrentAxis).nTotalCases;
    astVelStepGroupTestAnalyze(iCurrentAxis).MaxPosAccEstimateFullDAC(iCurrTotalCase) = stVelStepGroupTestOut(ii).MaxPosAccEstimateFullDAC;
    astVelStepGroupTestAnalyze(iCurrentAxis).MaxNegAccEstimateFullDAC(iCurrTotalCase) = stVelStepGroupTestOut(ii).MaxNegAccEstimateFullDAC;
    astVelStepGroupTestAnalyze(iCurrentAxis).fPositiveStepPercentOS(iCurrTotalCase) = stVelStepGroupTestOut(ii).fPosiNegStepPercentOS(1);
    astVelStepGroupTestAnalyze(iCurrentAxis).fNegativeStepPercentOS(iCurrTotalCase) = stVelStepGroupTestOut(ii).fPosiNegStepPercentOS(2);
    astVelStepGroupTestAnalyze(iCurrentAxis).fPositiveStepSettleTime(iCurrTotalCase) = stVelStepGroupTestOut(ii).fPosiNegStepSettleTime(1);
    astVelStepGroupTestAnalyze(iCurrentAxis).fNegativeStepSettleTime(iCurrTotalCase) = stVelStepGroupTestOut(ii).fPosiNegStepSettleTime(2);
    astVelStepGroupTestAnalyze(iCurrentAxis).fPositiveStepRiseTime(iCurrTotalCase) = stVelStepGroupTestOut(ii).fPosiNegStepRiseTime(1);
    astVelStepGroupTestAnalyze(iCurrentAxis).fNegativeStepRiseTime(iCurrTotalCase) = stVelStepGroupTestOut(ii).fPosiNegStepRiseTime(2);
    astVelStepGroupTestAnalyze(iCurrentAxis).fPositiveMeanDrvCmd(iCurrTotalCase) = stVelStepGroupTestOut(ii).fMeanDrvCmd_PosiNegConstVel(1);
    astVelStepGroupTestAnalyze(iCurrentAxis).fNegativeMeanDrvCmd(iCurrTotalCase) = stVelStepGroupTestOut(ii).fMeanDrvCmd_PosiNegConstVel(2);
    astVelStepGroupTestAnalyze(iCurrentAxis).fPositiveStdDrvCmd(iCurrTotalCase) = stVelStepGroupTestOut(ii).fStdDrvCmd_PosiNegConstVel(1);
    astVelStepGroupTestAnalyze(iCurrentAxis).fNegativeStdDrvCmd(iCurrTotalCase) = stVelStepGroupTestOut(ii).fStdDrvCmd_PosiNegConstVel(2);
    
    astVelStepGroupTestAnalyze(iCurrentAxis).astExcitePosn(iCurrTotalCase).aPosn = stVelStepGroupTestOut(ii).aAxisPosn;
end

nTotalAxis = 0;
for ii = 1:1:nTotalEnvolveAxis
    if(astVelStepGroupTestAnalyze(ii).nTotalCases > 0)
        nTotalAxis = nTotalAxis + 1;
        astVelStepTestExcitingAxis(nTotalAxis) = astVelStepGroupTestAnalyze(ii);
    end
end
    
for ii = 1:1:nTotalAxis
    astVelStepTestExcitingAxis(ii).fPositiveMeanDrvCmd_pc = astVelStepTestExcitingAxis(ii).fPositiveMeanDrvCmd / 327.67;
    astVelStepTestExcitingAxis(ii).fNegativeMeanDrvCmd_pc = astVelStepTestExcitingAxis(ii).fNegativeMeanDrvCmd / 327.67;
    astVelStepTestExcitingAxis(ii).fPositiveStdDrvCmd_pc = astVelStepTestExcitingAxis(ii).fPositiveStdDrvCmd / 327.67;
    astVelStepTestExcitingAxis(ii).fNegativeStdDrvCmd_pc = astVelStepTestExcitingAxis(ii).fNegativeStdDrvCmd / 327.67;
end
