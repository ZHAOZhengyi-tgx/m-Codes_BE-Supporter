function stOutput = calc_acc_jerk_req_volt(stMotorMechaTronicSetting, aVel)


Bemf = stMotorMechaTronicSetting.Bemf;
Lc = stMotorMechaTronicSetting.Lc;
Rc = stMotorMechaTronicSetting.Rc;
fEncRes = stMotorMechaTronicSetting.fEncRes;
fMassOverKf = stMotorMechaTronicSetting.fMassOverKf;
fSampleTime_ms = stMotorMechaTronicSetting.fSampleTime_ms;

aAcc = [diff(aVel)] * 1000/fSampleTime_ms; aAcc(end + 1) = 0;
aJerk = [diff(aAcc)] * 1000/fSampleTime_ms; aJerk(end + 1) = 0;
aReqVoltage = sqrt(3) * ...
    (aVel * Bemf + Rc * fMassOverKf *aAcc * sqrt(3)/2 + Lc * fMassOverKf * aJerk * sqrt(3)/2); % /2/1.414 /sqrt(2)

%% By Boaz
%aReqVoltage = aVel * Bemf + Rc * fMassOverKf *aAcc * sqrt(3)/2 + Lc * fMassOverKf * ...
%    aJerk * sqrt(3)/2; % /2/1.414 /sqrt(2)

stOutput.aAcc = aAcc;
stOutput.aJerk = aJerk;
stOutput.aReqVoltage = aReqVoltage;
