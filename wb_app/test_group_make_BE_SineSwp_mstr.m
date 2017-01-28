function test_group_make_BE_SineSwp_mstr(strPathTargetFolder)

%strPathTargetFolder = 'I:\BE_WB_Data_Spectrum\BH_study\071_BH\71-1'
strBE_SineSwpFolderHeader = '*_SineSwp*';

chdir(strPathTargetFolder);
strFindFolderString = dir(strBE_SineSwpFolderHeader);
nNumFolder = length(strFindFolderString)

%% for
parfor ii = 1:1:nNumFolder
    strPathname = sprintf('%s\\%s\\', strPathTargetFolder, strFindFolderString(ii).name);
    strFullFilename = sprintf('%sMasterSineSwp_*.txt', strPathname);
    stStringFullFilename = dir(strFullFilename);
    if length(stStringFullFilename) < 1
        continue;
    else
        strFullFilename = sprintf('%s%s', strPathname, stStringFullFilename.name);
    end        
%    ii
    [stGroupSineSweepCfg, astGroupSineSweepResp, stBodeOutput] = test_ana_SineSweep_response(strFullFilename);
    astGroupCases(ii).stGroupSineSweepCfg = stGroupSineSweepCfg;
    astGroupCases(ii).astGroupSineSweepResp = astGroupSineSweepResp;
    astGroupCases(ii).stBodeOutput = stBodeOutput;
    close all; 
end

%save astGroupCases;
%test_save_group_spectrum_xls_by_load_matrix(astGroupCases,
%strPathTargetFolder);

