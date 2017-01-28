function plot_group_vel_test_guideline(astVelStepGroupTestAnalyze)

nTotalAxis = length(astVelStepGroupTestAnalyze);
nTotalCase = length(astVelStepGroupTestAnalyze(1).astExcitePosn); %(iCurrTotalCase).aPosn
for ii = 1:1:nTotalAxis
    iAxisCtrl_IdACS = astVelStepGroupTestAnalyze(ii).iAxisId;
    figure(ii * 10 +1);
    if iAxisCtrl_IdACS == 0
        fExpectMinAcc_SI = 38;
        fExpectMaxAcc_SI = 45;
    elseif iAxisCtrl_IdACS == 1
        fExpectMinAcc_SI = 31;
        fExpectMaxAcc_SI = 38;
    elseif iAxisCtrl_IdACS == 4
        fExpectMinAcc_SI = 900;
        fExpectMaxAcc_SI = 1400;
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
        fExpectMinRiseTime_ms = 4;
        fExpectMaxRiseTime_ms = 7.5;
    elseif iAxisCtrl_IdACS == 1
        fExpectMinRiseTime_ms = 5.5;
        fExpectMaxRiseTime_ms = 8;
    elseif iAxisCtrl_IdACS == 4
        fExpectMinRiseTime_ms = 0.5;
        fExpectMaxRiseTime_ms = 1.5;
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
        fExpectMinSettleTime_ms = 4;
        fExpectMaxSettleTime_ms = 7.5;
    elseif iAxisCtrl_IdACS == 1
        fExpectMinSettleTime_ms = 11;
        fExpectMaxSettleTime_ms = 16;
    elseif iAxisCtrl_IdACS == 4
        fExpectMinSettleTime_ms = 6.5;
        fExpectMaxSettleTime_ms = 21;
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
        fExpectMinStdDrv_pc = 0.39;
        fExpectMaxStdDrv_pc = 0.51;
    elseif iAxisCtrl_IdACS == 1
        fExpectMinStdDrv_pc = 0.2;
        fExpectMaxStdDrv_pc = 0.6;
    elseif iAxisCtrl_IdACS == 4
        fExpectMinStdDrv_pc = 0.4;
        fExpectMaxStdDrv_pc = 1.7;
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