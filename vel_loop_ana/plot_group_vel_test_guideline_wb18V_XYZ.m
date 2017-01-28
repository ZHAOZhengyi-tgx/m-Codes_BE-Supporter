function plot_group_vel_test_guideline_wb18V_XYZ(astVelStepGroupTestAnalyze)

nTotalAxis = length(astVelStepGroupTestAnalyze);
nTotalCase = length(astVelStepGroupTestAnalyze(1).astExcitePosn); %(iCurrTotalCase).aPosn
for ii = 1:1:nTotalAxis
    iAxisCtrl_IdACS = astVelStepGroupTestAnalyze(ii).iAxisId;
    figure(ii * 10 +1);
    if iAxisCtrl_IdACS == 0  % Table.Y
        fExpectMinAcc_SI = 25;
        fExpectMaxAcc_SI = 35
    elseif iAxisCtrl_IdACS == 1  % Table.X
        fExpectMinAcc_SI = 98;
        fExpectMaxAcc_SI = 110;
    elseif iAxisCtrl_IdACS == 4
        fExpectMinAcc_SI = 990;
        fExpectMaxAcc_SI = 1600;
    end
    
    subplot(2,2,1);
    hold on;
    plot([0, nTotalCase + 1], [fExpectMinAcc_SI, fExpectMinAcc_SI], 'r-', 'LineWidth', 3 );
    plot([0, nTotalCase + 1], [fExpectMaxAcc_SI, fExpectMaxAcc_SI], 'r-.', 'LineWidth', 3 );
    subplot(2,2,2);
    hold on;
    plot([0, nTotalCase + 1], [fExpectMinAcc_SI, fExpectMinAcc_SI], 'r-', 'LineWidth', 3 );
    plot([0, nTotalCase + 1], [fExpectMaxAcc_SI, fExpectMaxAcc_SI], 'r-.', 'LineWidth', 3 );
end

for ii = 1:1:nTotalAxis
    iAxisCtrl_IdACS = astVelStepGroupTestAnalyze(ii).iAxisId;
    figure(ii * 10 +2);
%%% Rise Time
    if iAxisCtrl_IdACS == 0
        fExpectMinRiseTime_ms = 2.73;
        fExpectMaxRiseTime_ms = 4.22;
    elseif iAxisCtrl_IdACS == 1
        fExpectMinRiseTime_ms = 4.2;
        fExpectMaxRiseTime_ms = 5.92;
    elseif iAxisCtrl_IdACS == 4
        fExpectMinRiseTime_ms = 1.0;
        fExpectMaxRiseTime_ms = 2.0;
    end
    
    subplot(2,2,3);
    hold on;
    plot([0, nTotalCase + 1], [fExpectMinRiseTime_ms, fExpectMinRiseTime_ms], 'r-', 'LineWidth', 3 );
    plot([0, nTotalCase + 1], [fExpectMaxRiseTime_ms, fExpectMaxRiseTime_ms], 'r-.', 'LineWidth', 3 );
    subplot(2,2,4);
    hold on;
    plot([0, nTotalCase + 1], [fExpectMinRiseTime_ms, fExpectMinRiseTime_ms], 'r-', 'LineWidth', 3 );
    plot([0, nTotalCase + 1], [fExpectMaxRiseTime_ms, fExpectMaxRiseTime_ms], 'r-.', 'LineWidth', 3 );
    
%%% Settling Time    
    if iAxisCtrl_IdACS == 0
        fExpectMinSettleTime_ms = 12;
        fExpectMaxSettleTime_ms = 5;
    elseif iAxisCtrl_IdACS == 1
        fExpectMinSettleTime_ms = 9.4;
        fExpectMaxSettleTime_ms = 6.8;
    elseif iAxisCtrl_IdACS == 4
        fExpectMinSettleTime_ms = 12;
        fExpectMaxSettleTime_ms = 6.5;
    end
    
    subplot(2,2,1);
    hold on;
    plot([0, nTotalCase + 1], [fExpectMinSettleTime_ms, fExpectMinSettleTime_ms], 'r-', 'LineWidth', 3 );
    plot([0, nTotalCase + 1], [fExpectMaxSettleTime_ms, fExpectMaxSettleTime_ms], 'r-.', 'LineWidth', 3 );
    subplot(2,2,2);
    hold on;
    plot([0, nTotalCase + 1], [fExpectMinSettleTime_ms, fExpectMinSettleTime_ms], 'r-', 'LineWidth', 3 );
    plot([0, nTotalCase + 1], [fExpectMaxSettleTime_ms, fExpectMaxSettleTime_ms], 'r-.', 'LineWidth', 3 );
end

%%% Friction
for ii = 1:1:nTotalAxis
    iAxisCtrl_IdACS = astVelStepGroupTestAnalyze(ii).iAxisId;
    figure(ii * 10 +3);
    if iAxisCtrl_IdACS == 0
        fExpectMinStdDrv_pc = 0.17;
        fExpectMaxStdDrv_pc = 0.67;
    elseif iAxisCtrl_IdACS == 1
        fExpectMinStdDrv_pc = 0.33;
        fExpectMaxStdDrv_pc = 0.63;
    elseif iAxisCtrl_IdACS == 4
        fExpectMinStdDrv_pc = 0.48;
        fExpectMaxStdDrv_pc = 1.31;
    end
    
    subplot(2,2,3);
    hold on;
    plot([0, nTotalCase + 1], [fExpectMinStdDrv_pc, fExpectMinStdDrv_pc], 'r-', 'LineWidth', 3 );
    plot([0, nTotalCase + 1], [fExpectMaxStdDrv_pc, fExpectMaxStdDrv_pc], 'r-.', 'LineWidth', 3 );
    subplot(2,2,4);
    hold on;
    plot([0, nTotalCase + 1], [fExpectMinStdDrv_pc, fExpectMinStdDrv_pc], 'r-', 'LineWidth', 3 );
    plot([0, nTotalCase + 1], [fExpectMaxStdDrv_pc, fExpectMaxStdDrv_pc], 'r-.', 'LineWidth', 3 );
end

for ii = 1:1:nTotalAxis
    iAxisCtrl_IdACS = astVelStepGroupTestAnalyze(ii).iAxisId;
    figure(ii * 10 +3);
    if iAxisCtrl_IdACS == 0
        fExpectMinAveDrv_pc = 0.7;
        fExpectMaxAveDrv_pc = 2.1;
    elseif iAxisCtrl_IdACS == 1
        fExpectMinAveDrv_pc = 0.9;
        fExpectMaxAveDrv_pc = 2.0;
    elseif iAxisCtrl_IdACS == 4
        fExpectMinAveDrv_pc = -0.5;
        fExpectMaxAveDrv_pc = 0.7;
    end
    
    subplot(2,2,1);
    hold on;
    plot([0, nTotalCase + 1], [fExpectMinAveDrv_pc, fExpectMinAveDrv_pc], 'r-', 'LineWidth', 3 );
    plot([0, nTotalCase + 1], [fExpectMaxAveDrv_pc, fExpectMaxAveDrv_pc], 'r-.', 'LineWidth', 3 );
    
    
    if iAxisCtrl_IdACS == 0
        fExpectMinAveDrv_pc = -2.1;
        fExpectMaxAveDrv_pc = -0.7;
    elseif iAxisCtrl_IdACS == 1
        fExpectMinAveDrv_pc = -2.0;
        fExpectMaxAveDrv_pc = -0.9;
    elseif iAxisCtrl_IdACS == 4
        fExpectMinAveDrv_pc = -0.5;
        fExpectMaxAveDrv_pc = 0.7;
    end
    subplot(2,2,2);
    hold on;
    plot([0, nTotalCase + 1], [fExpectMinAveDrv_pc, fExpectMinAveDrv_pc], 'r-', 'LineWidth', 3 );
    plot([0, nTotalCase + 1], [fExpectMaxAveDrv_pc, fExpectMaxAveDrv_pc], 'r-.', 'LineWidth', 3 );
end