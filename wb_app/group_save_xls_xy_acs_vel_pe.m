function group_save_xls_xy_acs_vel_pe(stStatisticAcsWB_Waveform)

nFiles = length(stStatisticAcsWB_Waveform.astWbForceAcsWaveformOutput);

cellMasterVoltageSpeedLimit(1,1) = {'Filename'};
cellMasterVoltageSpeedLimit(1,10) = {'MaxAccX'};
cellMasterVoltageSpeedLimit(1,11) = {'MaxJerkX'};
cellMasterVoltageSpeedLimit(1,12) = {'MinDesireVoltageX'};

cellMasterVoltageSpeedLimit(1,15) = {'MaxAccY'};
cellMasterVoltageSpeedLimit(1,16) = {'MaxJerkY'};
cellMasterVoltageSpeedLimit(1,17) = {'MinDesireVoltageY'};

for ii = 1:1:nFiles
    stWbAcsWaveformOutput = stStatisticAcsWB_Waveform.astWbForceAcsWaveformOutput(ii);
    
    fMaxAccX = max(abs(stWbAcsWaveformOutput.aAccX(1:floor(end*0.95))));
    fMaxJerkX = max(abs(stWbAcsWaveformOutput.aJerkX(1:floor(end*0.95))));
    fMaxDesiredVcc_X = max(abs(stWbAcsWaveformOutput.aReqVoltageTblX(1:floor(end*0.95))));
    
    fMaxAccY = max(abs(stWbAcsWaveformOutput.aAccY(1:floor(end*0.95))));
    fMaxJerkY = max(abs(stWbAcsWaveformOutput.aJerkY(1:floor(end*0.95))));
    fMaxDesiredVcc_Y = max(abs(stWbAcsWaveformOutput.aReqVoltageTblY(1:floor(end*0.95))));

    cellStrFileTitle = {stWbAcsWaveformOutput.strFilename};
    cellMasterVoltageSpeedLimit(ii+1,1) = cellStrFileTitle;
    
    cellMasterVoltageSpeedLimit(ii + 1, 10)= ...
        {fMaxAccX};
    cellMasterVoltageSpeedLimit(ii + 1, 11)= ...
        {fMaxJerkX};
    cellMasterVoltageSpeedLimit(ii + 1, 12)= ...
        {fMaxDesiredVcc_X};

    cellMasterVoltageSpeedLimit(ii + 1, 15)= ...
        {fMaxAccY};
    cellMasterVoltageSpeedLimit(ii + 1, 16)= ...
        {fMaxJerkY};
    cellMasterVoltageSpeedLimit(ii + 1, 17)= ...
        {fMaxDesiredVcc_Y};
    
end

strXlsOutFullFilename = sprintf('%s\\MasterXlsOutSpeedVoltageLimit.xls', stWbAcsWaveformOutput.strPathname);
strSheetname = 'Table';
strStartCell = 'C3';
xlswrite(strXlsOutFullFilename, cellMasterVoltageSpeedLimit, strSheetname, strStartCell);
