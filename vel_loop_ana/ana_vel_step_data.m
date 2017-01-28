function [stOutputAccDrvCmd, stOutputVelStepTimePerform] = ana_vel_step_data(TrajData)


%% RPOS(%d)\rFVEL(%d)\rRVEL(%d)\rFACC(%d)\rDOUT(%d)
nLenTime_ms = size(TrajData, 1);
tIndexTime_ms = 1:nLenTime_ms;
aDriveCmd = TrajData(:,5);
FdVel = TrajData(:,2);
RefVel = TrajData(:,3);
RefPosn = TrajData(:,1);
aFdAcc = TrajData(:,4);

figure(20); clf;
plot(tIndexTime_ms, FdVel, tIndexTime_ms, RefVel);
legend('FdVel', 'RefVel')
xlabel('milli-sec')
grid on; zoom on;

figure(21); clf;
plot(tIndexTime_ms, aDriveCmd);
title('Drive Command')
xlabel('milli-sec')
grid on; zoom on;

figure(22); clf;
plot(tIndexTime_ms, RefPosn);
title('RefPosn');
xlabel('milli-sec')
grid on; zoom on;

figure(23); clf;
plot(tIndexTime_ms, aFdAcc);
title('Feed Acc')
xlabel('milli-sec')
grid on; zoom on;

[stOutputAccDrvCmd] = calc_max_acc_drv_cmd(aDriveCmd, aFdAcc);
MaxMinFdAcc = stOutputAccDrvCmd.MaxMinFdAcc
idxMaxMinFdAcc = stOutputAccDrvCmd.idxMaxMinFdAcc
MaxMinDrvCmd = stOutputAccDrvCmd.MaxMinDrvCmd
idxMaxMinDrvCmd = stOutputAccDrvCmd.idxMaxMinDrvCmd

%% calculate over-undershoot
fErrorThresholdSettleTime = 0.05;
%% debug 20120710
 stOutputVelStepTimePerform = []; % calc_vel_test_os_st_rt(RefVel, FdVel, aDriveCmd, fErrorThresholdSettleTime);
%stOutput