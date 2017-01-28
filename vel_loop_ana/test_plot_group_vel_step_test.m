function stOneGroupVelTestOut = test_plot_group_vel_step_test(strFileFullName)

%close all;

if ~exist('strFileFullName')
    [Filename, Pathname] = uigetfile('*.m', 'Pick an m file as output from VelocityStep Group Test');
    strFileFullName = strcat(Pathname , Filename);
else
    aList = strfind(strFileFullName, '\');
    Pathname = strFileFullName(1: aList(end));
    Filename = strFileFullName(aList(end) + 1: end);
end

stOneGroupVelTestOut.astVelStepGroupTestAnalyze = [];
stOneGroupVelTestOut.stTestInfo = [];

stOutputLoadFile = ana_load_exec_m_file(strFileFullName);

stVelStepGroupTestOut = stOutputLoadFile.stVelStepGroupTestOut;
fEncResolution_mm = stOutputLoadFile.fEncResolution_mm;
iFlagSaveWaveform= stOutputLoadFile.iFlagSaveWaveform;
iMachineType = stOutputLoadFile.iMachineType; %% 20120901
stApplication = stOutputLoadFile.stApplication;
%% iExciteAxis

[astVelStepGroupTestAnalyze, nTotalAxis, nTotalCase] = ana_vel_step_group_test_out(stVelStepGroupTestOut);
%astrApplicationName = [{'Table-X'}, {'Table-Y'}, {'Bond-Z'}];
for ii = 1:1:nTotalAxis
    astrApplicationName(ii) = {stApplication(ii).strName};
end
for ii = 1:1:nTotalAxis
    astVelStepGroupTestAnalyze(ii).fEncResolution_mm = fEncResolution_mm(ii);
end
stTestInfo.strFileFullName = strFileFullName;
stTestInfo.strPathname = Pathname;
stTestInfo.astrApplicationName = astrApplicationName;
stTestInfo.iFlagSaveWaveform = iFlagSaveWaveform;

try
    plot_group_vel_step_out(astVelStepGroupTestAnalyze, stTestInfo);
catch
    disp('Error plot bar-chart');
    return;
end
stOneGroupVelTestOut.astVelStepGroupTestAnalyze = astVelStepGroupTestAnalyze;
stOneGroupVelTestOut.stTestInfo = stTestInfo;

% plot_spec_vel_step_out();
if (isempty(strfind(stOutputLoadFile.stApplication(1).strName, 'X')) == 0 && astVelStepGroupTestAnalyze(1).iAxisId == 1) ...
        || (isempty(strfind(stOutputLoadFile.stApplication(1).strName, 'Y')) == 0 && astVelStepGroupTestAnalyze(1).iAxisId == 0)
    %% Only TopBonder Configuration
    switch iMachineType 
        case 2
            plot_group_vel_test_guideline_wb13_Hori_XYZ(astVelStepGroupTestAnalyze);  % plot_group_vel_test_guideline
%         case 10:
%             plot_group_vel_test_guideline_wb18V_XYZ(astVelStepGroupTestAnalyze);  % plot_group_vel_test_guideline
%         case 11:
%             plot_group_vel_test_guideline_wb20T_XYZ(astVelStepGroupTestAnalyze);  % plot_group_vel_test_guideline
    end
%elseif (isempty(strfind(stOutputLoadFile.stApplication(1).strName, 'Y')) == 0 && astVelStepGroupTestAnalyze(1).iAxisId == 4)
    
else    
    plot_group_vel_test_guideline_wb13V_XYZ(astVelStepGroupTestAnalyze);  % plot_group_vel_test_guideline
end

%%
if stTestInfo.iFlagSaveWaveform >= 0.5
    save_group_vel_step_out(astVelStepGroupTestAnalyze, stTestInfo);
end

group_vel_test_save_xls(astVelStepGroupTestAnalyze, stTestInfo);

