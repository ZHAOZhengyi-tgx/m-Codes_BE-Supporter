function astStatisticAllSettingContactForce = test_group_make_wb_bh_contact_force_mstr(strPathTargetFolder)

astStatisticAllSettingContactForce = [];

global iPlotFlag;

iPlotFlag = 2;

%strPathTargetFolder = 'I:\BE_WB_Data_Spectrum\BH_study\071_BH\71-1\'
strWbContactForceFolderHeader = '*ContactForce_*';
strWbContactForceFileHeader = '*ContactForceControl_*.m';  %% WvfmB*.m or ErrWvfm_*.m

chdir(strPathTargetFolder);
strFindFolderString = dir(strWbContactForceFolderHeader);
nNumFolder = length(strFindFolderString)

%astOutputAnaWbContactForce = [];
for ii = 1:1:nNumFolder
    
    strPathname = sprintf('%s\\%s\\', strPathTargetFolder, strFindFolderString(ii).name);
    try
        chdir(strPathname);
    catch
        strErrMessage = sprintf('Folder NOT exist: %s', strPathname);
        disp(strErrMessage);
        continue;
    end

    astOutputAnaWbContactForce = [];
%     ii
    strFindFileString = dir(strWbContactForceFileHeader);
    nNumFile = length(strFindFileString)
    for jj = 1:1:nNumFile
        strFullFilename = sprintf('%s', strPathname, strFindFileString(jj).name);
        disp(strFullFilename)
        stForceCaliOutput = test_force_control(strFullFilename);
        astOutputAnaWbContactForce(jj).stForceCaliOutput = stForceCaliOutput;
        astOutputAnaWbContactForce(jj).strPathname = strPathname;
        astOutputAnaWbContactForce(jj).strFilename = strFindFileString(jj).name;
        close all; 
    end
%    
    chdir(strPathTargetFolder)
    stContactForceStatistic1Set = test_group_contact_force_index_save_xls(strPathTargetFolder, astOutputAnaWbContactForce, ii);
    %%%
    astStatisticAllSettingContactForce(ii).astOutputAnaWbContactForce = astOutputAnaWbContactForce;
    astStatisticAllSettingContactForce(ii).stContactForceStatistic1Set = stContactForceStatistic1Set;
end


contact_force_group_save_xls(nNumFolder,strPathTargetFolder,astStatisticAllSettingContactForce);