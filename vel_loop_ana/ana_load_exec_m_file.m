function stOutput = ana_load_exec_m_file(strFileFullName)


%% for default
stApplication(1).strName = 'TableX';
stApplication(2).strName = 'TableY';
stApplication(3).strName = 'BndZ';

fptr = fopen(strFileFullName);
iMachineType = 2; %% Default 13T

while ~feof(fptr)
    try
        strLine = fgets(fptr);
        eval(strLine);
    catch
        disp(strcat('Error Execute: ', strLine));
        continue;
    end    
end
stOutput.stVelStepGroupTestOut = stVelStepGroupTestOut;
stOutput.fEncResolution_mm = fEncResolution_mm;
stOutput.iFlagSaveWaveform = iFlagSaveWaveform;
stOutput.iMachineType = iMachineType; %% 20120901
stOutput.stApplication = stApplication;
