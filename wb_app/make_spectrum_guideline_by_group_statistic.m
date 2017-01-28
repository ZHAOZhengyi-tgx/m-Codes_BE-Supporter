function [matAxis2AxisPrbsGuideLine] = make_spectrum_guideline_by_group_statistic(astGroupSpectrumMcEvent, stGroupPrbs)

global stAppName;

if exist('stGroupPrbs') == 0
    stGroupPrbs = aft_load_group_prbs_cfg();
end

stAppName.astAppNameByCtrlBdAxis(1) = {'TblX'};
stAppName.astAppNameByCtrlBdAxis(2) = {'TblY'};
stAppName.astAppNameByCtrlBdAxis(3) = {'BndZ'};
stAppName.astAppNameByCtrlBdAxis(4) = {'WClmp'};

nTotalAxis = length(astGroupSpectrumMcEvent(1).stGroupPrbsResp.astCaseAxisXlsOutput)
nNumCases_GroupTest = length(astGroupSpectrumMcEvent)

for kk = 1:1:nTotalAxis  %% total axis {X, Y, Z, ...}
    for ii = 1:1:nNumCases_GroupTest  %% total cases of spectrum test

        stCaseAxisXlsOutput = astGroupSpectrumMcEvent(ii).stGroupPrbsResp.astCaseAxisXlsOutput(kk);
        [nLenRow, nLenCol] = size(stCaseAxisXlsOutput.cellSpectrumMatrix);

        for jj = 2:1:nLenCol
            stSpectrumStatistic.astAxis(kk).astGroupCase(ii).afFreqMax(jj) =  max(stCaseAxisXlsOutput.afSelfSpectrumMatrix(2:end, jj));
            stSpectrumStatistic.astAxis(kk).astGroupCase(ii).afFreqMin(jj) =  min(stCaseAxisXlsOutput.afSelfSpectrumMatrix(2:end, jj));
            stSpectrumStatistic.astAxis(kk).astGroupCase(ii).afFreqMean(jj) =  mean(stCaseAxisXlsOutput.afSelfSpectrumMatrix(2:end, jj));
            stSpectrumStatistic.astAxis(kk).astGroupCase(ii).afFreqStd(jj) =  std(stCaseAxisXlsOutput.afSelfSpectrumMatrix(2:end, jj));
        end
        
    end
    
end
% stSpectrumStatistic.aFreqAxisDataLowFreqCutOff = stCaseAxisXlsOutput.aFreqAxisDataLowFreqCutOff;

for jj = 2:1:nLenCol %% for each frequency (in Hz)
    for kk = 1:1:nTotalAxis  %% total axis {X, Y, Z, ...}
        
        fMaxOfMax = stSpectrumStatistic.astAxis(kk).astGroupCase(ii).afFreqMax(1);
        fSumOfMean = 0;
        fMinOfMin = stSpectrumStatistic.astAxis(kk).astGroupCase(ii).afFreqMin(2);
        fSumSqOfStd = 0;
    
        for ii = 1:1:nNumCases_GroupTest  %% total cases of spectrum test
            
            if fMaxOfMax < stSpectrumStatistic.astAxis(kk).astGroupCase(ii).afFreqMax(jj)
                fMaxOfMax = stSpectrumStatistic.astAxis(kk).astGroupCase(ii).afFreqMax(jj);
            end
            if (fMinOfMin > stSpectrumStatistic.astAxis(kk).astGroupCase(ii).afFreqMin(jj)) ...
                && (stSpectrumStatistic.astAxis(kk).astGroupCase(ii).afFreqMin(jj) > 0.0001)
                fMinOfMin = stSpectrumStatistic.astAxis(kk).astGroupCase(ii).afFreqMin(jj);
            end
            fSumOfMean = fSumOfMean + stSpectrumStatistic.astAxis(kk).astGroupCase(ii).afFreqMean(jj);
            fSumSqOfStd = fSumSqOfStd + ...
                stSpectrumStatistic.astAxis(kk).astGroupCase(ii).afFreqStd(jj) * stSpectrumStatistic.astAxis(kk).astGroupCase(ii).afFreqStd(jj);
        end
        
        fRMS_OfStd = sqrt(fSumSqOfStd/nNumCases_GroupTest);
        matAxis2AxisPrbsGuideLine(kk,kk).aFreqFdVelErrorUppBound(jj) = fMaxOfMax + 2 * fRMS_OfStd;
        matAxis2AxisPrbsGuideLine(kk,kk).aFreqFdVelExpectIdeal(jj) = fSumOfMean/nNumCases_GroupTest;
        matAxis2AxisPrbsGuideLine(kk,kk).aFreqFdVelWarningUppBound(jj) = fSumOfMean/nNumCases_GroupTest + fRMS_OfStd; 
        matAxis2AxisPrbsGuideLine(kk,kk).aFreqFdVelWarningLowBound(jj) = fMinOfMin;
    end
end

for kk = 1:1:nTotalAxis
    matAxis2AxisPrbsGuideLine(kk,kk).aFreqFdVelErrorUppBound = smooth_move_ave(matAxis2AxisPrbsGuideLine(kk,kk).aFreqFdVelErrorUppBound, 49);
    matAxis2AxisPrbsGuideLine(kk,kk).aFreqFdVelExpectIdeal = smooth_move_ave(matAxis2AxisPrbsGuideLine(kk,kk).aFreqFdVelExpectIdeal, 49);
    matAxis2AxisPrbsGuideLine(kk,kk).aFreqFdVelWarningUppBound = smooth_move_ave(matAxis2AxisPrbsGuideLine(kk,kk).aFreqFdVelWarningUppBound, 49);
    matAxis2AxisPrbsGuideLine(kk,kk).aFreqFdVelWarningLowBound = smooth_move_ave(matAxis2AxisPrbsGuideLine(kk,kk).aFreqFdVelWarningLowBound, 49);
end
 
%%%%
stGroupPrbsRespGuidLine.iMachineType = stGroupPrbs.iMachineType;
stGroupPrbsRespGuidLine.matAxis2AxisPrbsGuideLine = matAxis2AxisPrbsGuideLine;
stGroupPrbsRespGuidLine.aiArrayMappingCtrlId = stGroupPrbs.aiArrayMappingCtrlId;
%% stGroupPrbsRespGuidLine.aFreqAxisDataLowFreqCutOff = stSpectrumStatistic.aFreqAxisDataLowFreqCutOff;

%%% Add one field to output
save 'matAxis2AxisPrbsGuideLine' matAxis2AxisPrbsGuideLine;
