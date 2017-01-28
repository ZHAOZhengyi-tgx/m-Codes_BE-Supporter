function stOutput = ana_load_one_vel_step_test_m_file(strFileFullName)

strLabelStartTrajData = 'TrajData';
nlenLabelTrajData = length(strLabelStartTrajData);

fptr = fopen(strFileFullName);

while ~feof(fptr)
    strLine = fgets(fptr);
    if length(strLine) >= 8
        if strLine(1:nlenLabelTrajData) == strLabelStartTrajData
            break;
        else
            eval(strLine);
        end
    end
end

TrajData(1,:) = sscanf(strLine, 'TrajData = [%f, %f, %f, %f, %f');
ii = 0;
while ~feof(fptr)
    strLine = fgetl(fptr);
    ii = ii + 1;
    if strLine(end) == ';'
        TrajData(ii + 1,:) = sscanf(strLine, '%f, %f, %f, %f, %f];');
    else
        TrajData(ii + 1,:) = sscanf(strLine, '%f, %f, %f, %f, %f');
    end
end
fclose(fptr);

stOutputCalcByLibC.MaxPosAccEstimateFullDAC = MaxPosAccEstimateFullDAC; %    32.8 %(m/s/s) 
stOutputCalcByLibC.MaxNegAccEstimateFullDAC = MaxNegAccEstimateFullDAC; %    22.5 %(m/s/s) 
stOutputCalcByLibC.MaxAccEstimateFullDAC =  MaxAccEstimateFullDAC;%   27.6 %(m/s/s) 
stOutputCalcByLibC.MaxFbAcc = MaxFbAcc; %    27.6 %(m/s/s) 
stOutputCalcByLibC.ExpAccAtRMS = ExpAccAtRMS; %    13.8 %(m/s/s) 

%Velocity Performance 
stOutputCalcByLibC.fPositiveStepOverShoot = fPositiveStepOverShoot; %175368.2 
stOutputCalcByLibC.fPositiveStepPercentOS =  fPositiveStepPercentOS; %  0.297 
stOutputCalcByLibC.fPositiveStepSettleTime = fPositiveStepSettleTime; %   203.0 
stOutputCalcByLibC.fPositiveStepRiseTime = fPositiveStepRiseTime; %    11.0 
stOutputCalcByLibC.fNegativeStepOverShoot = fNegativeStepOverShoot; %-195173.3 
stOutputCalcByLibC.fNegativeStepPercentOS = fNegativeStepPercentOS; %  -0.387 
stOutputCalcByLibC.fNegativeStepSettleTime = fNegativeStepSettleTime; %   107.0 
stOutputCalcByLibC.fNegativeStepRiseTime =  fNegativeStepRiseTime; %   14.0 
stOutputCalcByLibC.afMeanDrvCmd_PosiNegConstVel = fMeanDrvCmd_PosiNegConstVel; % [   142.3,   -251.5] 
stOutputCalcByLibC.afStdDrvCmd_PosiNegConstVel = fStdDrvCmd_PosiNegConstVel; % [   296.6,    328.1] 

stOutputCalcByLibC.idxMaxDrvCmd = idxMaxDrvCmd; % 338; 
stOutputCalcByLibC.idxMaxFdAcc = idxMaxFdAcc; % 340; 
stOutputCalcByLibC.idxMinDrvCmd = idxMinDrvCmd; % 118; 
stOutputCalcByLibC.idxMinFdAcc = idxMinFdAcc; % 118; 
stOutputCalcByLibC.idxPositiveStepCmdStart = idxPositiveStepCmdStart; % 337; 
stOutputCalcByLibC.idxNegativeStepCmdStart = idxNegativeStepCmdStart; % 112; 
stOutputCalcByLibC.fPositiveLevel = fPositiveLevel; % 110000.0; 
stOutputCalcByLibC.fNegativeLevel = fNegativeLevel; % -110000.0; 
stOutputCalcByLibC.nLengthPositiveCmd = nLengthPositiveCmd; % 227;
stOutputCalcByLibC.nLengthNegativeCmd = nLengthNegativeCmd; % 225; 
stOutputCalcByLibC.idxOnePeriod = idxOnePeriod; % 564; 
stOutputCalcByLibC.idxPositivePeakTime = idxPositivePeakTime; % 348;
stOutputCalcByLibC.idxNegativePeakTime = idxNegativePeakTime; % 126; 

stOutput.stOutputCalcByLibC = stOutputCalcByLibC;
stOutput.TrajData = TrajData;
