function plot_group_vel_test_guideline_wb13V_XYZ(astVelStepGroupTestAnalyze)

nTotalAxis = length(astVelStepGroupTestAnalyze);
nTotalCase = length(astVelStepGroupTestAnalyze(1).astExcitePosn); %(iCurrTotalCase).aPosn
for ii = 1:1:nTotalAxis
    iAxisCtrl_IdACS = astVelStepGroupTestAnalyze(ii).iAxisId;
    figure(ii * 10 +1);
    if iAxisCtrl_IdACS == 0
        fExpectMinAcc_SI = 42;
        fExpectMaxAcc_SI = 60;
    elseif iAxisCtrl_IdACS == 1
        fExpectMinAcc_SI = 23;
        fExpectMaxAcc_SI = 40;
    elseif iAxisCtrl_IdACS == 4
        fExpectMinAcc_SI = 450;
        fExpectMaxAcc_SI = 1200;
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
        fExpectMinRiseTime_ms = 3.5;
        fExpectMaxRiseTime_ms = 6;
    elseif iAxisCtrl_IdACS == 1
        fExpectMinRiseTime_ms = 5.5;
        fExpectMaxRiseTime_ms = 10;
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
        fExpectMinSettleTime_ms = 4.5;
        fExpectMaxSettleTime_ms = 8.0;
    elseif iAxisCtrl_IdACS == 1
        fExpectMinSettleTime_ms = 9.0;
        fExpectMaxSettleTime_ms = 19.5;
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
        fExpectMinStdDrv_pc = 0.33;
        fExpectMaxStdDrv_pc = 0.79;
    elseif iAxisCtrl_IdACS == 1
        fExpectMinStdDrv_pc = 0.0;
        fExpectMaxStdDrv_pc = 1.0;
    elseif iAxisCtrl_IdACS == 4
        fExpectMinStdDrv_pc = 0.2;
        fExpectMaxStdDrv_pc = 1.5;
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

%%% Friction - 2 Mean value of DrvCmd
for ii = 1:1:nTotalAxis
    iAxisCtrl_IdACS = astVelStepGroupTestAnalyze(ii).iAxisId;
    figure(ii * 10 +3);
    if iAxisCtrl_IdACS == 0
        fExpectMinAveDrv_pc = -0.08;
        fExpectMaxAveDrv_pc = 1.75;
    elseif iAxisCtrl_IdACS == 1
        fExpectMinAveDrv_pc = 0;
        fExpectMaxAveDrv_pc = 3.88;
    elseif iAxisCtrl_IdACS == 4
        fExpectMinAveDrv_pc = -0.25;
        fExpectMaxAveDrv_pc = 1.4;
    end
    
    subplot(2,2,1);
    hold on;
    plot([0, nTotalCase + 1], [fExpectMinAveDrv_pc, fExpectMinAveDrv_pc], 'r-', 'LineWidth', 3 );
    plot([0, nTotalCase + 1], [fExpectMaxAveDrv_pc, fExpectMaxAveDrv_pc], 'r-.', 'LineWidth', 3 );
    
    
    if iAxisCtrl_IdACS == 0
        fExpectMinAveDrv_pc = -1.75;
        fExpectMaxAveDrv_pc = 0.08;
    elseif iAxisCtrl_IdACS == 1
        fExpectMinAveDrv_pc = -4.54;
        fExpectMaxAveDrv_pc = 0;
    elseif iAxisCtrl_IdACS == 4
        fExpectMinAveDrv_pc = -1.2;
        fExpectMaxAveDrv_pc = 0.5;
    end
    subplot(2,2,2);
    hold on;
    plot([0, nTotalCase + 1], [fExpectMinAveDrv_pc, fExpectMinAveDrv_pc], 'r-', 'LineWidth', 3 );
    plot([0, nTotalCase + 1], [fExpectMaxAveDrv_pc, fExpectMaxAveDrv_pc], 'r-.', 'LineWidth', 3 );
end