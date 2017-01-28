function stStatisticAcsWB_Waveform = test_group_plot_wb_bh_force_acs_waveform(strPathTargetFolder)

stStatisticAcsWB_Waveform = [];

global iPlotFlag;
iPlotFlag = 2;

%strPathTargetFolder = 'I:\BE_WB_Data_Spectrum\BH_study\071_BH\71-1\'
%strWbContactForceFolderHeader = '*.sgn';
strWbContactForceAcsWaveformFileHeader = '*.sgn';  %% WvfmB*.m or ErrWvfm_*.m

chdir(strPathTargetFolder);
strFindFileString = dir(strWbContactForceAcsWaveformFileHeader);
nNumFolder = length(strFindFileString);

astOutputAnaWbContactForce = [];
for ii = 1:1:nNumFolder
    strFullFilename = sprintf('%s\\%s', strPathTargetFolder, strFindFileString(ii).name);
    disp(strFindFileString(ii).name);
    stWbForceAcsWaveformOutput = acs_load_waveform(strFullFilename);
    
    if iPlotFlag >= 1
        figure(1)
        for jj = 1:1:4
            subplot(2,2,jj);
            plot(stWbForceAcsWaveformOutput.astChannelAcsScope(jj).afDataInScope);
            legend(stWbForceAcsWaveformOutput.astChannelAcsScope(jj).strVariableName);
            grid on;
        end    
    end
    
    if iPlotFlag >= 2
        aLocDot = strfind(strFindFileString(ii).name, '.');
        strSaveFilename_jpg = sprintf('%s\\%s_.jpg', strPathTargetFolder, strFindFileString(ii).name(1: aLocDot(end) -1));
        saveas(gcf, strSaveFilename_jpg, 'jpg');
    end    
    %%
    stStatisticAcsWB_Waveform.astWbForceAcsWaveformOutput(ii) = stWbForceAcsWaveformOutput;

end

