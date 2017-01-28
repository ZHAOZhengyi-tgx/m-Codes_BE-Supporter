function batch_save_xls_group_vel_step_test(astOneGroupVelTestOut)

%% astOneGroupVelTestOut(1).astVelStepGroupTestAnalyze(1).MaxPosAccEstimateFullDAC

nTotalCases = length(astOneGroupVelTestOut);
%stOneGroupVelTestOut.stTestInfo.strPathname
%astOneGroupVelTestOut(cc).strCaseName  %% 'Two48VDC-Feb16'

idxRow = 1;
parfor cc = 1:1:nTotalCases
%    cellVeLoopTestTitleXls(idxRow, 1) = {astOneGroupVelTestOut(cc).strCaseName};  %% 20120217

    nTotalGroups = length(astOneGroupVelTestOut(cc).stOneGroupVelTestOut);
    for gg = 1:1:nTotalGroups
        
        stOneGroupVelTestOut = astOneGroupVelTestOut(cc).stOneGroupVelTestOut(gg);

        nTotalAxis = length(stOneGroupVelTestOut.astVelStepGroupTestAnalyze);
        astVelStepGroupTestAnalyze = stOneGroupVelTestOut.astVelStepGroupTestAnalyze;

        nTotalCase = length(astVelStepGroupTestAnalyze(1).astExcitePosn); %(iCurrTotalCase).aPosn
        %%%% 
        for aa = 1:1:nTotalAxis
            iAxisCtrl_IdACS = astVelStepGroupTestAnalyze(aa).iAxisId;
            if iAxisCtrl_IdACS == 0
                iSheetId = 1;
                stXlsDataOutSheet(iSheetId).strSheetname = 'AcsAxis-0';
            elseif iAxisCtrl_IdACS == 1
                iSheetId = 2;
                stXlsDataOutSheet(iSheetId).strSheetname = 'AcsAxis-1';
            elseif iAxisCtrl_IdACS == 4
                iSheetId = 3;
                stXlsDataOutSheet(iSheetId).strSheetname = 'AcsAxis-4';
            end

            stXlsDataColTitle(1,1)  = {'PeakExpAcc in m/s^2'};
            stXlsDataColTitle(2,1)  = {'Positive'};
            stXlsDataColTitle(2,5)  = {'Negative'};
            stXlsDataColTitle(3,1)  = {'Max'};  stXlsDataColTitle(3,5)  = {'Max'};
            stXlsDataColTitle(3,2)  = {'Min'};  stXlsDataColTitle(3,6)  = {'Min'};
            stXlsDataColTitle(3,3)  = {'Std'};  stXlsDataColTitle(3,7)  = {'Std'};
            stXlsDataColTitle(3,4)  = {'Ave'};  stXlsDataColTitle(3,8)  = {'Ave'};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,1) = {max(astVelStepGroupTestAnalyze(aa).MaxPosAccEstimateFullDAC)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,2) = {min(astVelStepGroupTestAnalyze(aa).MaxPosAccEstimateFullDAC)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,3) = {std(astVelStepGroupTestAnalyze(aa).MaxPosAccEstimateFullDAC)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,4) = {mean(astVelStepGroupTestAnalyze(aa).MaxPosAccEstimateFullDAC)};
            %% Neg
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,5) = {max(astVelStepGroupTestAnalyze(aa).MaxNegAccEstimateFullDAC)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,6) = {min(astVelStepGroupTestAnalyze(aa).MaxNegAccEstimateFullDAC)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,7) = {std(astVelStepGroupTestAnalyze(aa).MaxNegAccEstimateFullDAC)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,8) = {mean(astVelStepGroupTestAnalyze(aa).MaxNegAccEstimateFullDAC)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,9) = {' '};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,10) = {' '};

            %%%%%% Friction-1
            stXlsDataColTitle(1,11)  = {'Friction in StdDrv in %% Full'};
            stXlsDataColTitle(2,11)  = {'Positive'};
            stXlsDataColTitle(2,15)  = {'Negative'};
            stXlsDataColTitle(3,11)  = {'Max'};  stXlsDataColTitle(3,15)  = {'Max'};
            stXlsDataColTitle(3,12)  = {'Min'};  stXlsDataColTitle(3,16)  = {'Min'};
            stXlsDataColTitle(3,13)  = {'Std'};  stXlsDataColTitle(3,17)  = {'Std'};
            stXlsDataColTitle(3,14)  = {'Ave'};  stXlsDataColTitle(3,18)  = {'Ave'};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,11) = {max(astVelStepGroupTestAnalyze(aa).fPositiveStdDrvCmd_pc)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,12) = {min(astVelStepGroupTestAnalyze(aa).fPositiveStdDrvCmd_pc)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,13) = {std(astVelStepGroupTestAnalyze(aa).fPositiveStdDrvCmd_pc)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,14) = {mean(astVelStepGroupTestAnalyze(aa).fPositiveStdDrvCmd_pc)};
            % Neg
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,15) = {max(astVelStepGroupTestAnalyze(aa).fNegativeStdDrvCmd_pc)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,16) = {min(astVelStepGroupTestAnalyze(aa).fNegativeStdDrvCmd_pc)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,17) = {std(astVelStepGroupTestAnalyze(aa).fNegativeStdDrvCmd_pc)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,18) = {mean(astVelStepGroupTestAnalyze(aa).fNegativeStdDrvCmd_pc)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,19) = {' '};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,20) = {' '};

            %%%%%% Overshoot
            stXlsDataColTitle(1,21)  = {'Overshoot in %%'};
            stXlsDataColTitle(2,21)  = {'Positive'};
            stXlsDataColTitle(2,25)  = {'Negative'};
            stXlsDataColTitle(3,21)  = {'Max'};  stXlsDataColTitle(3,25)  = {'Max'};
            stXlsDataColTitle(3,22)  = {'Min'};  stXlsDataColTitle(3,26)  = {'Min'};
            stXlsDataColTitle(3,23)  = {'Std'};  stXlsDataColTitle(3,27)  = {'Std'};
            stXlsDataColTitle(3,24)  = {'Ave'};  stXlsDataColTitle(3,28)  = {'Ave'};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,21) = {max(astVelStepGroupTestAnalyze(aa).fPositiveStepPercentOS)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,22) = {min(astVelStepGroupTestAnalyze(aa).fPositiveStepPercentOS)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,23) = {std(astVelStepGroupTestAnalyze(aa).fPositiveStepPercentOS)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,24) = {mean(astVelStepGroupTestAnalyze(aa).fPositiveStepPercentOS)};
            % Neg
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,25) = {max(astVelStepGroupTestAnalyze(aa).fNegativeStepPercentOS)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,26) = {min(astVelStepGroupTestAnalyze(aa).fNegativeStepPercentOS)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,27) = {std(astVelStepGroupTestAnalyze(aa).fNegativeStepPercentOS)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,28) = {mean(astVelStepGroupTestAnalyze(aa).fNegativeStepPercentOS)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,29) = {' '};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,30) = {' '};

            %%%%%% Settle Time
            stXlsDataColTitle(1,31)  = {'SettleTime in ms'};
            stXlsDataColTitle(2,31)  = {'Positive'};
            stXlsDataColTitle(2,35)  = {'Negative'};
            stXlsDataColTitle(3,31)  = {'Max'};  stXlsDataColTitle(3,35)  = {'Max'};
            stXlsDataColTitle(3,32)  = {'Min'};  stXlsDataColTitle(3,36)  = {'Min'};
            stXlsDataColTitle(3,33)  = {'Std'};  stXlsDataColTitle(3,37)  = {'Std'};
            stXlsDataColTitle(3,34)  = {'Ave'};  stXlsDataColTitle(3,38)  = {'Ave'};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,31) = {max(astVelStepGroupTestAnalyze(aa).fPositiveStepSettleTime)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,32) = {min(astVelStepGroupTestAnalyze(aa).fPositiveStepSettleTime)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,33) = {std(astVelStepGroupTestAnalyze(aa).fPositiveStepSettleTime)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,34) = {mean(astVelStepGroupTestAnalyze(aa).fPositiveStepSettleTime)};
            % Neg
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,35) = {max(astVelStepGroupTestAnalyze(aa).fNegativeStepSettleTime)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,36) = {min(astVelStepGroupTestAnalyze(aa).fNegativeStepSettleTime)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,37) = {std(astVelStepGroupTestAnalyze(aa).fNegativeStepSettleTime)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,38) = {mean(astVelStepGroupTestAnalyze(aa).fNegativeStepSettleTime)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,39) = {' '};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,40) = {' '};

            %%%%%% Rise Time
            stXlsDataColTitle(1,41)  = {'RiseTime in ms'};
            stXlsDataColTitle(2,41)  = {'Positive'};
            stXlsDataColTitle(2,45)  = {'Negative'};
            stXlsDataColTitle(3,41)  = {'Max'};  stXlsDataColTitle(3,45)  = {'Max'};
            stXlsDataColTitle(3,42)  = {'Min'};  stXlsDataColTitle(3,46)  = {'Min'};
            stXlsDataColTitle(3,43)  = {'Std'};  stXlsDataColTitle(3,47)  = {'Std'};
            stXlsDataColTitle(3,44)  = {'Ave'};  stXlsDataColTitle(3,48)  = {'Ave'};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,41) = {max(astVelStepGroupTestAnalyze(aa).fPositiveStepRiseTime)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,42) = {min(astVelStepGroupTestAnalyze(aa).fPositiveStepRiseTime)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,43) = {std(astVelStepGroupTestAnalyze(aa).fPositiveStepRiseTime)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,44) = {mean(astVelStepGroupTestAnalyze(aa).fPositiveStepRiseTime)};
            % Neg
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,45) = {max(astVelStepGroupTestAnalyze(aa).fNegativeStepRiseTime)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,46) = {min(astVelStepGroupTestAnalyze(aa).fNegativeStepRiseTime)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,47) = {std(astVelStepGroupTestAnalyze(aa).fNegativeStepRiseTime)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,48) = {mean(astVelStepGroupTestAnalyze(aa).fNegativeStepRiseTime)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,49) = {' '};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,50) = {' '};

            %%%%%% Friction-2
            stXlsDataColTitle(1,51)  = {'Friction-2 in AveDrv %%'};
            stXlsDataColTitle(2,51)  = {'Positive'};
            stXlsDataColTitle(2,55)  = {'Negative'};
            stXlsDataColTitle(3,51)  = {'Max'};  stXlsDataColTitle(3,55)  = {'Max'};
            stXlsDataColTitle(3,52)  = {'Min'};  stXlsDataColTitle(3,56)  = {'Min'};
            stXlsDataColTitle(3,53)  = {'Std'};  stXlsDataColTitle(3,57)  = {'Std'};
            stXlsDataColTitle(3,54)  = {'Ave'};  stXlsDataColTitle(3,58)  = {'Ave'};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,51) = {max(astVelStepGroupTestAnalyze(aa).fPositiveMeanDrvCmd_pc)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,52) = {min(astVelStepGroupTestAnalyze(aa).fPositiveMeanDrvCmd_pc)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,53) = {std(astVelStepGroupTestAnalyze(aa).fPositiveMeanDrvCmd_pc)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,54) = {mean(astVelStepGroupTestAnalyze(aa).fPositiveMeanDrvCmd_pc)};
            % Neg
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,55) = {max(astVelStepGroupTestAnalyze(aa).fNegativeMeanDrvCmd_pc)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,56) = {min(astVelStepGroupTestAnalyze(aa).fNegativeMeanDrvCmd_pc)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,57) = {std(astVelStepGroupTestAnalyze(aa).fNegativeMeanDrvCmd_pc)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,58) = {mean(astVelStepGroupTestAnalyze(aa).fNegativeMeanDrvCmd_pc)};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,59) = {' '};
            stXlsDataOutSheet(iSheetId).cellVeLoopStatisticXls(idxRow,60) = {' '};
            
        end

        cellVeLoopTestTitleXls(idxRow, 2) = {stOneGroupVelTestOut.stTestInfo.strPathname}; %% 20120217
        
        idxRow = idxRow + 1;
        
    end
    idxRow = idxRow + 1;
end

nTotalSheet = length(stXlsDataOutSheet);
strXlsOutFullFilename = sprintf('_XlsGroupOut.xls');
strStartCell = 'D8'; 
for ss = 1:1:nTotalSheet
    if isempty(stXlsDataOutSheet(ss).strSheetname) == 1
        continue;
    else
        xlswrite(strXlsOutFullFilename, stXlsDataColTitle,  stXlsDataOutSheet(ss).strSheetname, 'D5');
        xlswrite(strXlsOutFullFilename, cellVeLoopTestTitleXls, stXlsDataOutSheet(ss).strSheetname, 'B8');
        xlswrite(strXlsOutFullFilename, stXlsDataOutSheet(ss).cellVeLoopStatisticXls, stXlsDataOutSheet(ss).strSheetname, strStartCell);
    end
end


