function test_group_plot_b1w_stop_srch(strPathTargetFolder)

%strPathTargetFolder = 'I:\BE_WB_Data_Spectrum\BH_study\071_BH\71-1'
strTuneB1W_FolderHeader = 'TuneB1W_Bond.Z*';

chdir(strPathTargetFolder);
strFindFolderString = dir(strTuneB1W_FolderHeader);
nNumFolder = length(strFindFolderString);

%% for
parfor ii = 1:1:nNumFolder
    strPathname = sprintf('%s\\%s\\', strPathTargetFolder, strFindFolderString(ii).name);
    strFullFilename = sprintf('%sSrchContact_FinalB1W.m', strPathname)
    stStringFullFilename = dir(strFullFilename);
    if length(stStringFullFilename) < 1
        continue;
    end        
%    ii
    stB1W_TuneOutput = test_plot_b1w_stop_srch(strFullFilename);
    astGroupCasesTuneB1W(ii) = stB1W_TuneOutput;
    close all; 
end

%%%%
% strFileGenerateMaster = sprintf('TuneZ_B1W_StopSrch_master.xls');
% strFullPathnameXlsMaster = sprintf('%s\\%s', strCurrentPath, strFileGenerateMaster);  %% strPathTargetFolder
%     
% for ii = 1:1:nNumFolder
%     matXlsCellTuneB1W(idxRow:(idxRow + nLenRow -1), :) =  stCaseAxisXlsOutput.cellSpectrumMatrix;
%     idxRow = ii + 1;
%     %afSelfTuneB1WMatrix = astGroupSpectrumMcEvent(ii).stGroupPrbsResp.stCaseAxisXlsOutput(kk).afSelfSpectrumMatrix;
%     matXlsCellTuneB1W((idxRow + nLenRow), 1) = {'max'};
%     matXlsCellTuneB1W((idxRow + nLenRow + 1), 1) = {'min'};
%     matXlsCellTuneB1W((idxRow + nLenRow + 2), 1) = {'ave'};
%     matXlsCellTuneB1W((idxRow + nLenRow + 3), 1) = {'std'};
% 
% end
% xlswrite(strFullPathnameXlsMaster, matXlsCellSpectrum,  stCaseAxisXlsOutput.strXlsSheetName, 'D5');
% xlswrite(strFullPathnameXlsMaster, aCellPathname,  stCaseAxisXlsOutput.strXlsSheetName, 'C5')
