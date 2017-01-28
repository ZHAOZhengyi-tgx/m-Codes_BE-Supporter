function test_group_get_wb_bh_wvfrm_perfrm_index_save_xls(strPathTargetFolder, astOutputAnaWbWaveform)

strWbPerformIndexFileHeader = 'W*.txt';  % WvfmBond_*.txt or Wb_*.txt
strWbWaveformFolderHeader = '*WbParaWaveform_*';

chdir(strPathTargetFolder);
strFindFolderString = dir(strWbWaveformFolderHeader);
nNumFolder = length(strFindFolderString);

%%% get performance index Wb*.txt
nTotalCasePerformIdx = 0;
for ii = 1:1:nNumFolder
    
    strPathname = sprintf('%s\\%s\\', strPathTargetFolder, strFindFolderString(ii).name);
    try
        chdir(strPathname);
    catch
        strErrMessage = sprintf('Folder NOT exist: %s', strPathname);
        disp('strErrMessage');
        continue;
    end
    strFindFileString = dir(strWbPerformIndexFileHeader);
    nNumFile = length(strFindFileString);
    for jj = 1:1:nNumFile
        strFullFilename = sprintf('%s%s', strPathname, strFindFileString(jj).name);
        disp(strFullFilename)
        nTotalCasePerformIdx = nTotalCasePerformIdx + 1;
        stWbPeformance = ana_wb_wvfrm_read_peform_idx(strFullFilename); %%%%
        
        strXlsOutFullFilename = sprintf('XlsOut_%s.xls', strFindFileString(jj).name);
        
        nLocationPathSeparater = strfind(strFindFileString(jj).name, '\');
        cellStrFileTitle = {strcat(strPathname, strFindFileString(jj).name)};
        strSheetname = 'BH';
        strStartCell = 'C2';
        %%c     xlswrite(strXlsOutFullFilename, cellStrFileTitle, strSheetname, strStartCell); 

        astPerformIdxCase(nTotalCasePerformIdx).stWbPeformance = stWbPeformance;
        astPerformIdxCase(nTotalCasePerformIdx).cellStrFileTitle = cellStrFileTitle;
        
        strSheetname = 'BH';
        strStartCell = 'C3';
        cellWbWaveformStatisticXls(1, 1) = {'af1stSrchPosnErr'};
        for kk = 1:1:length(stWbPeformance.stPerformanceBH.af1stSrchPosnErr)
            cellWbWaveformStatisticXls(1, 1 + kk) = {stWbPeformance.stPerformanceBH.af1stSrchPosnErr(kk)};
        end
        
        cellWbWaveformStatisticXls(2, 1) = {'af1stSrchVelErr'};
%        cellWbWaveformStatisticXls(2, 2) = stWbPeformance.stPerformanceBH.af1stSrchVelErr;
        for kk = 1:1:length(stWbPeformance.stPerformanceBH.af1stSrchVelErr)
            cellWbWaveformStatisticXls(2, 1 + kk) = {stWbPeformance.stPerformanceBH.af1stSrchVelErr(kk)};
        end
        cellWbWaveformStatisticXls(3, 1) = {'af2ndSrchPosnErr'};
%        cellWbWaveformStatisticXls(3, 2) = stWbPeformance.stPerformanceBH.af2ndSrchPosnErr;
        for kk = 1:1:length(stWbPeformance.stPerformanceBH.af2ndSrchPosnErr)
            cellWbWaveformStatisticXls(3, 1 + kk) = {stWbPeformance.stPerformanceBH.af2ndSrchPosnErr(kk)};
        end
        cellWbWaveformStatisticXls(4, 1) = {'af2ndSrchVelErr'};
%        cellWbWaveformStatisticXls(4, 2) = stWbPeformance.stPerformanceBH.af2ndSrchVelErr;
        for kk = 1:1:length(stWbPeformance.stPerformanceBH.af2ndSrchVelErr)
            cellWbWaveformStatisticXls(4, 1 + kk) = {stWbPeformance.stPerformanceBH.af2ndSrchVelErr(kk)};
        end
        cellWbWaveformStatisticXls(5, 1) = {'aTimeDeform_DrvInBond_1stB'};
%        cellWbWaveformStatisticXls(5, 2) = stWbPeformance.stPerformanceBH.aTimeDeform_DrvInBond_1stB;
        for kk = 1:1:length(stWbPeformance.stPerformanceBH.aTimeDeform_DrvInBond_1stB)
            cellWbWaveformStatisticXls(5, 1 + kk) = {stWbPeformance.stPerformanceBH.aTimeDeform_DrvInBond_1stB(kk)};
        end
        cellWbWaveformStatisticXls(6, 1) = {'aTimeDeform_DrvInBond_2ndB'};
%        cellWbWaveformStatisticXls(6, 2) = stWbPeformance.stPerformanceBH.aTimeDeform_DrvInBond_2ndB;
        for kk = 1:1:length(stWbPeformance.stPerformanceBH.aTimeDeform_DrvInBond_2ndB)
            cellWbWaveformStatisticXls(6, 1 + kk) = {stWbPeformance.stPerformanceBH.aTimeDeform_DrvInBond_2ndB(kk)};
        end
        %%c     xlswrite(strXlsOutFullFilename, cellWbWaveformStatisticXls, strSheetname, strStartCell);

%%%%        
        %%%% Table
        strStartCell = 'C3';
        strSheetname = 'Table';
        cellWbTblWaveformStatisticXls(1, 1) = {'afPosnErrTblX_Contact1B_P2P_MaxAbs'};
        if isfield(stWbPeformance.stPerformanceTable, 'afPosnErrTblX_Contact1B_P2P_MaxAbs')  == 1
            for kk = 1:1:length(stWbPeformance.stPerformanceTable.afPosnErrTblX_Contact1B_P2P_MaxAbs)
                cellWbTblWaveformStatisticXls(1, 1 + kk) = {stWbPeformance.stPerformanceTable.afPosnErrTblX_Contact1B_P2P_MaxAbs(kk)};
            end
        end
        cellWbTblWaveformStatisticXls(2, 1) = {'afPosnErrTblX_Contact2B_P2P_MaxAbs'};
        if isfield(stWbPeformance.stPerformanceTable, 'afPosnErrTblX_Contact2B_P2P_MaxAbs')  == 1
            for kk = 1:1:length(stWbPeformance.stPerformanceTable.afPosnErrTblX_Contact2B_P2P_MaxAbs)
                cellWbTblWaveformStatisticXls(2, 1 + kk) = {stWbPeformance.stPerformanceTable.afPosnErrTblX_Contact2B_P2P_MaxAbs(kk)};
            end
        end
        %% Y
        cellWbTblWaveformStatisticXls(3, 1) = {'afPosnErrTblY_Contact1B_P2P_MaxAbs'};
        if isfield(stWbPeformance.stPerformanceTable, 'afPosnErrTblY_Contact1B_P2P_MaxAbs') == 1
            for kk = 1:1:length(stWbPeformance.stPerformanceTable.afPosnErrTblY_Contact1B_P2P_MaxAbs)
                cellWbTblWaveformStatisticXls(3, 1 + kk) = {stWbPeformance.stPerformanceTable.afPosnErrTblY_Contact1B_P2P_MaxAbs(kk)};
            end
        end
        cellWbTblWaveformStatisticXls(4, 1) = {'afPosnErrTblY_Contact2B_P2P_MaxAbs'};
        if isfield(stWbPeformance.stPerformanceTable, 'afPosnErrTblY_Contact2B_P2P_MaxAbs') == 1
            for kk = 1:1:length(stWbPeformance.stPerformanceTable.afPosnErrTblY_Contact2B_P2P_MaxAbs)
                cellWbTblWaveformStatisticXls(4, 1 + kk) = {stWbPeformance.stPerformanceTable.afPosnErrTblY_Contact2B_P2P_MaxAbs(kk)};
            end
        end
        %%c     xlswrite(strXlsOutFullFilename, cellWbTblWaveformStatisticXls, strSheetname, strStartCell);

%%%% BH - dObj
        strStartCell = 'C20';
        strSheetname = 'BH';
        cellWbObjBndHeadXls(1,1) = {'Bh-Section'};
        cellWbObjBndHeadXls(2,1) = {'ObjVal'};
        cellWbObjBndHeadXls(1,2) = {'Jog1stSrch'};
        cellWbObjBndHeadXls(2,2) = {stWbPeformance.stPerformanceBH.dObjJogIn1stSearch};
        af1stSrchPosnErrWind4ms = stWbPeformance.stPerformanceBH.af1stSrchPosnErr(8:end-2)/9;
        af1stSrchVelErrWind4ms = stWbPeformance.stPerformanceBH.af1stSrchVelErr(8:end-2)/2;
        fReCalcObj1stSrch = sqrt((af1stSrchPosnErrWind4ms) * (af1stSrchPosnErrWind4ms)' / length(af1stSrchPosnErrWind4ms)) ...
            + sqrt(( af1stSrchVelErrWind4ms)  * (af1stSrchVelErrWind4ms)' / length(af1stSrchVelErrWind4ms));
%%        cellWbObjBndHeadXls(2,2) = {fReCalcObj1stSrch};
        astPerformIdxCase(ii).stWbPeformance.stPerformanceBH.fReCalcObj1stSrch = fReCalcObj1stSrch;
        
        cellWbObjBndHeadXls(1,3) = {'Move1stSrch'};
        cellWbObjBndHeadXls(2,3) = {stWbPeformance.stPerformanceBH.dObjMove1stSrchHt};
        cellWbObjBndHeadXls(1,5) = {'Traj2ndSrch'};
        cellWbObjBndHeadXls(2,5) = {stWbPeformance.stPerformanceBH.dObjTraj2ndB};
        cellWbObjBndHeadXls(1,6) = {'MoveTail'};
        cellWbObjBndHeadXls(2,6) = {stWbPeformance.stPerformanceBH.dObjMoveTail};
        cellWbObjBndHeadXls(1,7) = {'Reset'};
        cellWbObjBndHeadXls(2,7) = {stWbPeformance.stPerformanceBH.dObjMoveReset};
        cellWbObjBndHeadXls(1,8) = {'Jog2ndSrch'};
        cellWbObjBndHeadXls(2,8) = {stWbPeformance.stPerformanceBH.dObjJogIn2ndSearch};
        af2ndSrchPosnErrWind4ms = stWbPeformance.stPerformanceBH.af2ndSrchPosnErr(8:(end -2))/9;
        af2ndSrchVelErrWind4ms = stWbPeformance.stPerformanceBH.af2ndSrchVelErr(8:(end -2))/2;
        fReCalcOb2ndSrch = sqrt((af2ndSrchPosnErrWind4ms) * (af2ndSrchPosnErrWind4ms)' / length(af2ndSrchPosnErrWind4ms)) ...
            + sqrt(( af2ndSrchVelErrWind4ms)  * (af2ndSrchVelErrWind4ms)' / length(af2ndSrchVelErrWind4ms));
        astPerformIdxCase(ii).stWbPeformance.stPerformanceBH.fReCalcOb2ndSrch = fReCalcOb2ndSrch;
%%        cellWbObjBndHeadXls(2,8) = {fReCalcOb2ndSrch};
        
        %%c     xlswrite(strXlsOutFullFilename, cellWbObjBndHeadXls, strSheetname, strStartCell);

    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% to master xls -file
cellWbMasterTblWaveformStatisticXls(1, 2) = {'afPosnErrTblX_Contact1B_P2P_MaxAbs'};
cellWbMasterTblWaveformStatisticXls(1, 4) = {'afPosnErrTblX_Contact2B_P2P_MaxAbs'};
cellWbMasterTblWaveformStatisticXls(1, 6) = {'afPosnErrTblY_Contact1B_P2P_MaxAbs'};
cellWbMasterTblWaveformStatisticXls(1, 8) = {'afPosnErrTblY_Contact2B_P2P_MaxAbs'};
cellWbMasterTblWaveformStatisticXls(1, 10) = {'MaxAcc'};
cellWbMasterTblWaveformStatisticXls(1, 11) = {'MaxJerk'};
cellWbMasterTblWaveformStatisticXls(1, 12) = {'DesireBusVoltage'};
cellWbMasterTblWaveformStatisticXls(1, 13) = {'MaxAcc'};
cellWbMasterTblWaveformStatisticXls(1, 14) = {'MaxJerk'};
cellWbMasterTblWaveformStatisticXls(1, 15) = {'DesireBusVoltage'};

for ii= 1:1:nTotalCasePerformIdx
    stWbPeformance = astPerformIdxCase(ii).stWbPeformance;
    cellStrFileTitle = astPerformIdxCase(ii).cellStrFileTitle;

    cellWbMasterTblWaveformStatisticXls(ii+1,1) = cellStrFileTitle;
    
    cellWbMasterTblWaveformStatisticXls(ii + 1, 2) = {stWbPeformance.stPerformanceTable.afPosnErrTblX_Contact1B_P2P_MaxAbs(1)};
    cellWbMasterTblWaveformStatisticXls(ii + 1, 3) = {stWbPeformance.stPerformanceTable.afPosnErrTblX_Contact1B_P2P_MaxAbs(2)};
    cellWbMasterTblWaveformStatisticXls(ii + 1, 4) = {stWbPeformance.stPerformanceTable.afPosnErrTblX_Contact2B_P2P_MaxAbs(1)};
    cellWbMasterTblWaveformStatisticXls(ii + 1, 5) = {stWbPeformance.stPerformanceTable.afPosnErrTblX_Contact2B_P2P_MaxAbs(2)};
    cellWbMasterTblWaveformStatisticXls(ii + 1, 6) = {stWbPeformance.stPerformanceTable.afPosnErrTblY_Contact1B_P2P_MaxAbs(1)};
    cellWbMasterTblWaveformStatisticXls(ii + 1, 7) = {stWbPeformance.stPerformanceTable.afPosnErrTblY_Contact1B_P2P_MaxAbs(2)};
    cellWbMasterTblWaveformStatisticXls(ii + 1, 8) = {stWbPeformance.stPerformanceTable.afPosnErrTblY_Contact2B_P2P_MaxAbs(1)};
    cellWbMasterTblWaveformStatisticXls(ii + 1, 9) = {stWbPeformance.stPerformanceTable.afPosnErrTblY_Contact2B_P2P_MaxAbs(2)};
    %% 
    
end

for ii=1:1:nNumFolder
    if prod(size(astOutputAnaWbWaveform(ii).stDesireVoltage)) == 0
        continue;
    end
    cellStrFileTitle = {strFindFolderString(ii).name};
    cellWbMasterTblWaveformStatisticXls(ii+1,1) = cellStrFileTitle;
    
    cellWbMasterTblWaveformStatisticXls(ii + 1, 10)= ...
        {astOutputAnaWbWaveform(ii).stDesireVoltage.fMaxAccX};
    cellWbMasterTblWaveformStatisticXls(ii + 1, 11)= ...
        {astOutputAnaWbWaveform(ii).stDesireVoltage.fMaxJerkX};
    cellWbMasterTblWaveformStatisticXls(ii + 1, 12)= ...
        {astOutputAnaWbWaveform(ii).stDesireVoltage.fMaxDesiredVcc_X};

    cellWbMasterTblWaveformStatisticXls(ii + 1, 13)= ...
        {astOutputAnaWbWaveform(ii).stDesireVoltage.fMaxAccY};
    cellWbMasterTblWaveformStatisticXls(ii + 1, 14)= ...
        {astOutputAnaWbWaveform(ii).stDesireVoltage.fMaxJerkY};
    cellWbMasterTblWaveformStatisticXls(ii + 1, 15)= ...
        {astOutputAnaWbWaveform(ii).stDesireVoltage.fMaxDesiredVcc_Y};
end

strXlsOutFullFilename = sprintf('%s\\MasterXlsOutWbPerformIdx_.xls', strPathTargetFolder);
strSheetname = 'Table';
strStartCell = 'C3';
xlswrite(strXlsOutFullFilename, cellWbMasterTblWaveformStatisticXls, strSheetname, strStartCell);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cellWbBndHeadWaveformStatisticXls(1, 1) = {'FilePathName'};
cellWbBndHeadWaveformStatisticXls(1, 2) = {'1stBond DriveIn Deform'};
cellWbBndHeadWaveformStatisticXls(1, 6) = {'2ndBond DriveIn Deform'};
cellWbBndHeadWaveformStatisticXls(1, 11) = {'Jog1stSrch'};
cellWbBndHeadWaveformStatisticXls(1, 12) = {'Move1stSrch'};
cellWbBndHeadWaveformStatisticXls(1, 14) = {'Traj2ndSrch'};
cellWbBndHeadWaveformStatisticXls(1, 15) = {'MoveTail'};
cellWbBndHeadWaveformStatisticXls(1, 16) = {'Reset'};
cellWbBndHeadWaveformStatisticXls(1, 17) = {'Jog2ndSrch'};
for ii= 1:1:nTotalCasePerformIdx
    stWbPeformance = astPerformIdxCase(ii).stWbPeformance;
    cellStrFileTitle = astPerformIdxCase(ii).cellStrFileTitle;

        cellWbBndHeadWaveformStatisticXls(ii+1,1) = cellStrFileTitle;
        for kk = 1:1:length(stWbPeformance.stPerformanceBH.aTimeDeform_DrvInBond_1stB)
            cellWbBndHeadWaveformStatisticXls(ii+1, 1 + kk) = {stWbPeformance.stPerformanceBH.aTimeDeform_DrvInBond_1stB(kk)};
        end
        for kk = 1:1:length(stWbPeformance.stPerformanceBH.aTimeDeform_DrvInBond_2ndB)
            cellWbBndHeadWaveformStatisticXls(ii+1, 5 + kk) = {stWbPeformance.stPerformanceBH.aTimeDeform_DrvInBond_2ndB(kk)};
        end
    
        cellWbBndHeadWaveformStatisticXls(ii+1,11) = {stWbPeformance.stPerformanceBH.dObjJogIn1stSearch}; % fReCalcObj1stSrch
        cellWbBndHeadWaveformStatisticXls(ii+1,12) = {stWbPeformance.stPerformanceBH.dObjMove1stSrchHt};
        cellWbBndHeadWaveformStatisticXls(ii+1,14) = {stWbPeformance.stPerformanceBH.dObjTraj2ndB};
        cellWbBndHeadWaveformStatisticXls(ii+1,15) = {stWbPeformance.stPerformanceBH.dObjMoveTail};
        cellWbBndHeadWaveformStatisticXls(ii+1,16) = {stWbPeformance.stPerformanceBH.dObjMoveReset};
        cellWbBndHeadWaveformStatisticXls(ii+1,17) = {stWbPeformance.stPerformanceBH.dObjJogIn2ndSearch};  % fReCalcOb2ndSrch
    
    
end
strXlsOutFullFilename = sprintf('%s\\MasterXlsOutWbPerformIdx_.xls', strPathTargetFolder);
strSheetname = 'BH';
strStartCell = 'C3';
xlswrite(strXlsOutFullFilename, cellWbBndHeadWaveformStatisticXls, strSheetname, strStartCell);

