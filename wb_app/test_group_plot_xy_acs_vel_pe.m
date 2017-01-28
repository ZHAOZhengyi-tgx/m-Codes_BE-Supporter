function stStatisticAcsWB_Waveform = test_group_plot_xy_acs_vel_pe(strPathTargetFolder)

stStatisticAcsWB_Waveform = [];

global iPlotFlag;
iPlotFlag = 0;

%strPathTargetFolder = 'I:\BE_WB_Data_Spectrum\BH_study\071_BH\71-1\'
%strWbContactForceFolderHeader = '*.sgn';
strWbContactForceAcsWaveformFileHeader = '*.sgn';  %% WvfmB*.m or ErrWvfm_*.m

chdir(strPathTargetFolder);
strFindFileString = dir(strWbContactForceAcsWaveformFileHeader);
nNumFolder = length(strFindFileString);

%stMotorMechaTronicSetting = load_motor_mechatronics_setting_20T_x_DX50B(); %load_motor_mechatronics_setting_20T_xy_DX50TC51_12_C4S();
stMotorMechaTronicSetting = load_motor_mechatronics_setting_20T_xy_DX50TC51_12_C4S();
fVoltageTh = 250;
%();
%stMotorMechaTronicSetting = load_motor_mechatronics_setting_20T_x_dx50C4P();

astOutputAnaWbContactForce = [];
for ii = 1:1:nNumFolder
    strFullFilename = sprintf('%s\\%s', strPathTargetFolder, strFindFileString(ii).name);
    disp(strFindFileString(ii).name);
    stWbForceAcsWaveformOutput = acs_load_waveform(strFullFilename);
    
    afVelCmd = stWbForceAcsWaveformOutput.astChannelAcsScope(1).afDataInScope;
    nLen = length(afVelCmd); nStopCmd = nLen;
    for kk = 1:1:(nLen -1000)
        if( std(abs([afVelCmd(kk:(kk+900))])) <= 1.0)
            nStopCmd = kk
            break;
        end
    end
    
    %%%%%% Table-X
    aVelX = stWbForceAcsWaveformOutput.astChannelAcsScope(1).afDataInScope(1:nStopCmd) * ...
        stMotorMechaTronicSetting.fEncRes;
    stMotorMechaTronicSetting.fSampleTime_ms = stWbForceAcsWaveformOutput.astChannelAcsScope(1).fSampleTime_ms;
    fSampleTime_ms = stMotorMechaTronicSetting.fSampleTime_ms;
    
    stCalcAccJerkVoltX = calc_acc_jerk_req_volt(stMotorMechaTronicSetting, aVelX);
%    [stCalcSpeedOutVoltage] = mtn_calc_mech
    aAccX = stCalcAccJerkVoltX.aAcc;  % [diff(aVelX), 0] * 1000/fSampleTime_ms;
    aJerkX = stCalcAccJerkVoltX.aJerk; % [diff(aAccX), 0] * 1000/fSampleTime_ms;
    aReqVoltageTblX = stCalcAccJerkVoltX.aReqVoltage; %(aVelX * Bemf + Rc * fMassOverKf *aAccX + Lc * fMassOverKf * aJerkX)/2/1.414;
    stWbForceAcsWaveformOutput.aVelX = aVelX;
    stWbForceAcsWaveformOutput.aAccX = aAccX;
    stWbForceAcsWaveformOutput.aJerkX = aJerkX;
    stWbForceAcsWaveformOutput.aReqVoltageTblX = aReqVoltageTblX;

    %%%%% Table-Y
    aVelY = stWbForceAcsWaveformOutput.astChannelAcsScope(3).afDataInScope(1:nStopCmd) * ...
        stMotorMechaTronicSetting.fEncRes;
    stMotorMechaTronicSetting.fSampleTime_ms = stWbForceAcsWaveformOutput.astChannelAcsScope(3).fSampleTime_ms;

    stCalcAccJerkVoltY = calc_acc_jerk_req_volt(stMotorMechaTronicSetting, aVelY);
    aAccY = stCalcAccJerkVoltY.aAcc; %[diff(aVelY), 0] * 1000/fSampleTime_ms;
    aJerkY = stCalcAccJerkVoltY.aJerk; %[diff(aAccY), 0] * 1000/fSampleTime_ms;
    aReqVoltageTblY = stCalcAccJerkVoltY.aReqVoltage; %(aVelY * Bemf + Rc * fMassOverKf *aAccY + Lc * fMassOverKf * aJerkY)/2/1.414;
    stWbForceAcsWaveformOutput.aVelY = aVelY;
    stWbForceAcsWaveformOutput.aAccY = aAccY;
    stWbForceAcsWaveformOutput.aJerkY = aJerkY;
    stWbForceAcsWaveformOutput.aReqVoltageTblY = aReqVoltageTblY;
    
    if iPlotFlag >= 1
        figure(1); clf;
        for jj = 1:1:4
            subplot(2,2,jj);
            plot(stWbForceAcsWaveformOutput.astChannelAcsScope(jj).afDataInScope);
            legend(stWbForceAcsWaveformOutput.astChannelAcsScope(jj).strVariableName);
            grid on;
        end    
        
        aTimeLine_ms = fSampleTime_ms * [1:nStopCmd];
        aPosnErrX = stWbForceAcsWaveformOutput.astChannelAcsScope(2).afDataInScope(1:nStopCmd);
        figure(2); clf;
        subplot(2,2,1); plot(aTimeLine_ms, aPosnErrX); title('Position Error (count)'); grid on;
        subplot(2,2,2); plot(aTimeLine_ms, aAccX); title('Acc (m/s/s)');grid on;
        subplot(2,2,3); plot(aTimeLine_ms, aJerkX); title('Jerk (m/s/s/s)');grid on;
        subplot(2,2,4); plot(aTimeLine_ms, aReqVoltageTblX); title('Voltage (V)');grid on; 
            hold on; plot(aTimeLine_ms, fVoltageTh * ones(size(aTimeLine_ms)), 'r.');
            hold on; plot(aTimeLine_ms, -fVoltageTh * ones(size(aTimeLine_ms)), 'r.');
        xlabel('ms');
        
        figure(3); clf;
        subplot(2,2,2); plot(aTimeLine_ms, aAccY); title('Acc (m/s/s)'); grid on;
        subplot(2,2,3); plot(aTimeLine_ms, aJerkY); title('Jerk (m/s/s/s)'); grid on;
        subplot(2,2,4); plot(aTimeLine_ms, aReqVoltageTblY); title('Voltage (V)'); grid on; 
            hold on; plot(aTimeLine_ms, fVoltageTh * ones(size(aTimeLine_ms)), 'r.');
            hold on; plot(aTimeLine_ms, -fVoltageTh * ones(size(aTimeLine_ms)), 'r.');
        if nStopCmd < length(stWbForceAcsWaveformOutput.astChannelAcsScope(4).afDataInScope)
            aPosnErrY = stWbForceAcsWaveformOutput.astChannelAcsScope(4).afDataInScope(1:nStopCmd);
        else
            aPosnErrY = stWbForceAcsWaveformOutput.astChannelAcsScope(4).afDataInScope;
            nStopCmd = length(aPosnErrY);
            aTimeLine_ms = fSampleTime_ms * [1:nStopCmd];            
        end
        subplot(2,2,1); plot(aTimeLine_ms, aPosnErrY); title('Position Error (count)'); grid on;
        xlabel('ms');
    end
    
    if iPlotFlag >= 2
        aLocDot = strfind(strFindFileString(ii).name, '.');
        figure(1);
        strSaveFilename_jpg = sprintf('%s\\%s_.jpg', strPathTargetFolder, strFindFileString(ii).name(1: aLocDot(end) -1));
        saveas(gcf, strSaveFilename_jpg, 'jpg');
        figure(2);
        strSaveFilename_jpg = sprintf('%s\\%s_LimitX.jpg', strPathTargetFolder, strFindFileString(ii).name(1: aLocDot(end) -1));
        saveas(gcf, strSaveFilename_jpg, 'jpg');
        figure(3);
        strSaveFilename_jpg = sprintf('%s\\%s_LimitY.jpg', strPathTargetFolder, strFindFileString(ii).name(1: aLocDot(end) -1));
        saveas(gcf, strSaveFilename_jpg, 'jpg');
    end    
    %%
    stStatisticAcsWB_Waveform.astWbForceAcsWaveformOutput(ii) = stWbForceAcsWaveformOutput;

end

group_save_xls_xy_acs_vel_pe(stStatisticAcsWB_Waveform);

