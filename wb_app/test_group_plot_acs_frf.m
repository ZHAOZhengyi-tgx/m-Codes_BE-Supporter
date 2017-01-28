function test_group_plot_acs_frf(strPathTargetFolder)

strACS_FRF_FileExt = '*.frf';

chdir(strPathTargetFolder);
strFindFolderString = dir(strACS_FRF_FileExt)
nNumFile = length(strFindFolderString);

astCurveSetting(1).strFont = 'r-';
astCurveSetting(2).strFont = 'b.';
astCurveSetting(3).strFont = 'm+';
astCurveSetting(4).strFont = 'go';

%% for
for ii = 1:1:nNumFile
    strFullFilename = sprintf('%s\\%s', strPathTargetFolder, strFindFolderString(ii).name);
    stStringFullFilename = dir(strFullFilename);
    if length(stStringFullFilename) < 1
        continue;
    end        
%    ii
    test_plot_acs_frf_output(strFullFilename, astCurveSetting(ii).strFont);
%    close all; 
end

%save astGroupCases;
%test_save_group_spectrum_xls_by_load_matrix(astGroupCases, strPathTargetFolder);

