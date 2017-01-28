function test_group_make_spectrum_mstr(strPathTargetFolder)

%strPathTargetFolder = 'I:\BE_WB_Data_Spectrum\BH_study\071_BH\71-1'
strSpectrumFolderHeader = 'Spec_*';

chdir(strPathTargetFolder);
strFindFolderString = dir(strSpectrumFolderHeader);
nNumFolder = length(strFindFolderString);

%% for
parfor ii = 1:1:nNumFolder
    strPathname = sprintf('%s\\%s\\', strPathTargetFolder, strFindFolderString(ii).name);
    strFullFilename = sprintf('%sPrbsGroupTestCases.txt', strPathname);
    stStringFullFilename = dir(strFullFilename);
    if length(stStringFullFilename) < 1
        continue;
    end        
%    ii
    [stGroupPrbs, stGroupPrbsResp] = test_ana_prbs_response(strFullFilename);
    astGroupCases(ii).stGroupPrbs = stGroupPrbs;
    astGroupCases(ii).stGroupPrbsResp = stGroupPrbsResp;
    close all; 
end

save -v7.3 astGroupCases;
%test_save_group_spectrum_xls_by_load_matrix(astGroupCases, strPathTargetFolder);

