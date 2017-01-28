function test_group_make_wb_bh_waveform_mstr(strPathTargetFolder)

global iPlotFlag;
iPlotFlag = 2;

%strPathTargetFolder = 'I:\BE_WB_Data_Spectrum\BH_study\071_BH\71-1\'
strWbWaveformFolderHeader = '*WbParaWaveform_*';
strWbWaveformFileHeader = '*Wvfm*.m';  %% WvfmB*.m or ErrWvfm_*.m
strWbPerformIndexFileHeader = 'W*.txt';  % WvfmBond_*.txt or Wb_*.txt

chdir(strPathTargetFolder);
strFindFolderString = dir(strWbWaveformFolderHeader);
nNumFolder = length(strFindFolderString);

astOutputAnaWbWaveform = [];
for ii = 1:1:nNumFolder
    
    strPathname = sprintf('%s\\%s\\', strPathTargetFolder, strFindFolderString(ii).name);
    try
        chdir(strPathname);
    catch
        strErrMessage = sprintf('Folder NOT exist: %s', strPathname);
        disp('strErrMessage');
        continue;
    end

%     ii
    strFindFileString = dir(strWbWaveformFileHeader);
    nNumFile = length(strFindFileString);
    for jj = 1:1:nNumFile
        strFullFilename = sprintf('%s', strPathname, strFindFileString(jj).name);
        disp(strFullFilename)
        [stOutputWbPerformIndex, stDesireVoltage] = test_ana_wb_waveform(strFullFilename);
        astOutputAnaWbWaveform(ii).stOutputWbPerformIndex = stOutputWbPerformIndex;
        astOutputAnaWbWaveform(ii).stDesireVoltage = stDesireVoltage;
        close all; 
    end
%    
    chdir(strPathTargetFolder)
end

test_group_get_wb_bh_wvfrm_perfrm_index_save_xls(strPathTargetFolder, astOutputAnaWbWaveform);

