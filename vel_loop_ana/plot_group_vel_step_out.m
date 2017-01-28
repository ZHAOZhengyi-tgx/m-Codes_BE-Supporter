function plot_group_vel_step_out(astVelStepGroupTestAnalyze, stTestInfo)

astrApplicationName = stTestInfo.astrApplicationName ;
iFlagSaveWaveform   = stTestInfo.iFlagSaveWaveform ;
strFileFullName = stTestInfo.strFileFullName;
strPathname = stTestInfo.strPathname;

nTotalAxis = length(astVelStepGroupTestAnalyze);
 %%%% 
nTotalCase = length(astVelStepGroupTestAnalyze(1).astExcitePosn); %(iCurrTotalCase).aPosn

for ii = 1:1:nTotalAxis
    afEncResolution_mm(ii) = astVelStepGroupTestAnalyze(ii).fEncResolution_mm;
end

for ii = 1:1:nTotalAxis
    for cc = 1:1:nTotalCase
        for jj = 1:1:nTotalAxis
            astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(jj) = astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aPosn(jj)/afEncResolution_mm(jj);
        end
%        astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(2) = astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aPosn(2)/afEncResolution_mm(2);
%        astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(3) = astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aPosn(3)/afEncResolution_mm(3);
    end
end

%nTotalAxis;
%size(astVelStepGroupTestAnalyze);
for ii = 1:1:nTotalAxis
    figure(ii * 10 +1); clf;
    subplot(2,2,1);
    bar(astVelStepGroupTestAnalyze(ii).MaxPosAccEstimateFullDAC, 'r');
    
%    iAxisCtrl_IdACS = astVelStepGroupTestAnalyze(ii).iAxisId;
%    if iAxisCtrl_IdACS == 0
        title(astrApplicationName(ii), 'FontSize', 12);
%    elseif iAxisCtrl_IdACS == 1
%        title(astrApplicationName(2), 'FontSize', 12);
%     elseif iAxisCtrl_IdACS == 4
%         title(astrApplicationName(3), 'FontSize', 12);
%     end
       
    legend('PosFbAcc');
    ylabel('m/{s^2}');
    subplot(2,2,2);
    bar(astVelStepGroupTestAnalyze(ii).MaxNegAccEstimateFullDAC, 'r');
    legend('NegFbAcc');
    ylabel('m/{s^2}');
    subplot(2,2,3);
    bar(astVelStepGroupTestAnalyze(ii).fPositiveStepPercentOS * 100, 'g');
    ylabel('%');
    legend('Pos.O.S.%');
    subplot(2,2,4);
    bar(astVelStepGroupTestAnalyze(ii).fNegativeStepPercentOS * 100, 'g');
    legend('Neg.O.S.%');
    ylabel('%');
    xlabel('Cases', 'FontSize', 12);
%     if iFlagSaveWaveform >= 0.5
%         saveas(gcf, strcat(strPathname, char(strcat(astrApplicationName(ii), '_1.jpg'))), 'jpg');
%     end
    
    figure(ii * 10 +2); clf;
    subplot(2,2,1);
    bar(astVelStepGroupTestAnalyze(ii).fPositiveStepSettleTime, 'b');
    title(astrApplicationName(ii), 'FontSize', 12);
%     iAxisCtrl_IdACS = astVelStepGroupTestAnalyze(ii).iAxisId;
%     if iAxisCtrl_IdACS == 0
%         title(astrApplicationName(1), 'FontSize', 12);
%     elseif iAxisCtrl_IdACS == 1
%         title(astrApplicationName(2), 'FontSize', 12);
%     elseif iAxisCtrl_IdACS == 4
%         title(astrApplicationName(3), 'FontSize', 12);
%     end

    legend('Pos.S.T.');
    ylabel('milliSec');
    subplot(2,2,2);
    bar(astVelStepGroupTestAnalyze(ii).fNegativeStepSettleTime, 'b');
    legend('Neg.S.T.');
    ylabel('milliSec');
    subplot(2,2,3);
    bar(astVelStepGroupTestAnalyze(ii).fPositiveStepRiseTime, 'y');
    legend('Pos.R.T.');
    ylabel('milliSec');
    subplot(2,2,4);
    bar(astVelStepGroupTestAnalyze(ii).fNegativeStepRiseTime, 'y');
    legend('Neg.R.T.');
    ylabel('milliSec');
    xlabel('Cases', 'FontSize', 12);
%     if iFlagSaveWaveform >= 0.5
%         saveas(gcf, strcat(strPathname, char(strcat(astrApplicationName(ii), '_2.jpg'))), 'jpg');
%     end
    
    figure(ii * 10 +3); clf;
    subplot(2,2,1);
    bar(astVelStepGroupTestAnalyze(ii).fPositiveMeanDrvCmd_pc, 'm');
    title(astrApplicationName(ii), 'FontSize', 12);
%     iAxisCtrl_IdACS = astVelStepGroupTestAnalyze(ii).iAxisId;
%     if iAxisCtrl_IdACS == 0
%         title(astrApplicationName(1), 'FontSize', 12);
%     elseif iAxisCtrl_IdACS == 1
%         title(astrApplicationName(2), 'FontSize', 12);
%     elseif iAxisCtrl_IdACS == 4
%         title(astrApplicationName(3), 'FontSize', 12);
%     end

    ylabel('% Full');
    legend('PosMeanDrv');
    subplot(2,2,2);
    bar(astVelStepGroupTestAnalyze(ii).fNegativeMeanDrvCmd_pc, 'm');
    ylabel('% Full');
    subplot(2,2,3);
    bar(astVelStepGroupTestAnalyze(ii).fPositiveStdDrvCmd_pc, 'c');
    ylabel('% Full');
    legend('PosStdDrv');
    subplot(2,2,4);
    bar(astVelStepGroupTestAnalyze(ii).fNegativeStdDrvCmd_pc, 'c');
    legend('NegStdDrv');
    xlabel('Cases', 'FontSize', 12);
%     if iFlagSaveWaveform >= 0.5
%         saveas(gcf, strcat(strPathname, char(strcat(astrApplicationName(ii), '_3.jpg'))), 'jpg');
%     end

    figure(ii * 10 + 4); clf;
    subplot(2,2,1);
    strTextPosi = sprintf('Pos, M:%4.1f, m:%4.1f, Std:%4.1f', ...
        max(astVelStepGroupTestAnalyze(ii).MaxPosAccEstimateFullDAC), ...
        min(astVelStepGroupTestAnalyze(ii).MaxPosAccEstimateFullDAC), ...
        std(astVelStepGroupTestAnalyze(ii).MaxPosAccEstimateFullDAC));
    strTextNega = sprintf('Neg, M:%4.1f, m:%4.1f, Std:%4.1f', ...
        max(astVelStepGroupTestAnalyze(ii).MaxNegAccEstimateFullDAC), ...
        min(astVelStepGroupTestAnalyze(ii).MaxNegAccEstimateFullDAC), ...
        std(astVelStepGroupTestAnalyze(ii).MaxNegAccEstimateFullDAC));
    
    title(astrApplicationName(ii), 'FontSize', 12);
%     iAxisCtrl_IdACS = astVelStepGroupTestAnalyze(ii).iAxisId;
%     if iAxisCtrl_IdACS == 0
%         strTextTitle = strcat(astrApplicationName(1), ': FbAcc m/{s^2}');
%     elseif iAxisCtrl_IdACS == 1
%         strTextTitle = strcat(astrApplicationName(2), ': FbAcc m/{s^2}');
%     elseif iAxisCtrl_IdACS == 4
%         strTextTitle = strcat(astrApplicationName(3), ': FbAcc m/{s^2}');
%     end
    strTextTitle = strcat(astrApplicationName(ii), ': FbAcc m/{s^2}');
    
    fig_scatter_with_case_id(astVelStepGroupTestAnalyze(ii).MaxPosAccEstimateFullDAC, astVelStepGroupTestAnalyze(ii).MaxNegAccEstimateFullDAC, ...
        strTextPosi, strTextNega, nTotalCase, strTextTitle);
    subplot(2,2,2);
    fig_scatter_with_case_id(astVelStepGroupTestAnalyze(ii).fPositiveStepPercentOS, astVelStepGroupTestAnalyze(ii).fNegativeStepPercentOS, ...
        'Pos.O.S %', 'Neg.O.S. %', nTotalCase, 'Overshoot: % of Step');
    
    subplot(2,2,3);
    %%% Settling Time statistics
    strTextPosi = sprintf('Pos, M:%4.1f, m:%4.1f, Std:%4.1f', ...
        max(astVelStepGroupTestAnalyze(ii).fPositiveStepSettleTime), ...
        min(astVelStepGroupTestAnalyze(ii).fPositiveStepSettleTime), ...
        std(astVelStepGroupTestAnalyze(ii).fPositiveStepSettleTime));
    strTextNega = sprintf('Neg, M:%4.1f, m:%4.1f, Std:%4.1f', ...
        max(astVelStepGroupTestAnalyze(ii).fNegativeStepSettleTime), ...
        min(astVelStepGroupTestAnalyze(ii).fNegativeStepSettleTime), ...
        std(astVelStepGroupTestAnalyze(ii).fNegativeStepSettleTime));
    fig_scatter_with_case_id(astVelStepGroupTestAnalyze(ii).fPositiveStepSettleTime, astVelStepGroupTestAnalyze(ii).fNegativeStepSettleTime, ...
        strTextPosi, strTextNega,  nTotalCase, 'Settle Time: (ms)');

    subplot(2,2,4);
    %%% Rising Time statistics
    strTextPosi = sprintf('Pos, M:%4.1f, m:%4.1f, Std:%4.1f', ...
        max(astVelStepGroupTestAnalyze(ii).fPositiveStepRiseTime), ...
        min(astVelStepGroupTestAnalyze(ii).fPositiveStepRiseTime), ...
        std(astVelStepGroupTestAnalyze(ii).fPositiveStepRiseTime));
    strTextNega = sprintf('Neg, M:%4.1f, m:%4.1f, Std:%4.1f', ...
        max(astVelStepGroupTestAnalyze(ii).fNegativeStepRiseTime), ...
        min(astVelStepGroupTestAnalyze(ii).fNegativeStepRiseTime), ...
        std(astVelStepGroupTestAnalyze(ii).fNegativeStepRiseTime));
    fig_scatter_with_case_id(astVelStepGroupTestAnalyze(ii).fPositiveStepRiseTime, astVelStepGroupTestAnalyze(ii).fNegativeStepRiseTime, ...
        strTextPosi, strTextNega, nTotalCase, 'Rise Time: (ms)');
     
%     if iFlagSaveWaveform >= 0.5
%         if iAxisCtrl_IdACS == 0
%             saveas(gcf, strcat(strPathname, char(strcat(astrApplicationName(1), '_4.jpg'))), 'jpg');
%         elseif iAxisCtrl_IdACS == 1
%             saveas(gcf, strcat(strPathname, char(strcat(astrApplicationName(2), '_4.jpg'))), 'jpg');
%         elseif iAxisCtrl_IdACS == 4
%             saveas(gcf, strcat(strPathname, char(strcat(astrApplicationName(3), '_4.jpg'))), 'jpg');
%         end
%     end

    figure(ii * 10 + 5); clf;
    subplot(2,1,1);
    %%% Settling Time statistics
    strTextPosi = sprintf('Pos, M:%4.1f, m:%4.1f, Std:%4.1f', ...
        max(astVelStepGroupTestAnalyze(ii).fPositiveMeanDrvCmd_pc), ...
        min(astVelStepGroupTestAnalyze(ii).fPositiveMeanDrvCmd_pc), ...
        std(astVelStepGroupTestAnalyze(ii).fPositiveMeanDrvCmd_pc));
    strTextNega = sprintf('Neg, M:%4.1f, m:%4.1f, Std:%4.1f', ...
        max(astVelStepGroupTestAnalyze(ii).fNegativeMeanDrvCmd_pc), ...
        min(astVelStepGroupTestAnalyze(ii).fNegativeMeanDrvCmd_pc), ...
        std(astVelStepGroupTestAnalyze(ii).fNegativeMeanDrvCmd_pc));
    fig_scatter_with_case_id(astVelStepGroupTestAnalyze(ii).fPositiveMeanDrvCmd_pc, astVelStepGroupTestAnalyze(ii).fNegativeMeanDrvCmd_pc, ...
        strTextPosi, strTextNega,  nTotalCase, 'Mean Drv Command % in full');

    subplot(2,1,2);
    %%% Settling Time statistics
    strTextPosi = sprintf('Pos, M:%4.1f, m:%4.1f, Std:%4.1f', ...
        max(astVelStepGroupTestAnalyze(ii).fPositiveStdDrvCmd_pc), ...
        min(astVelStepGroupTestAnalyze(ii).fPositiveStdDrvCmd_pc), ...
        std(astVelStepGroupTestAnalyze(ii).fPositiveStdDrvCmd_pc));
    strTextNega = sprintf('Neg, M:%4.1f, m:%4.1f, Std:%4.1f', ...
        max(astVelStepGroupTestAnalyze(ii).fNegativeStdDrvCmd_pc), ...
        min(astVelStepGroupTestAnalyze(ii).fNegativeStdDrvCmd_pc), ...
        std(astVelStepGroupTestAnalyze(ii).fNegativeStdDrvCmd_pc));
    fig_scatter_with_case_id(astVelStepGroupTestAnalyze(ii).fPositiveStdDrvCmd_pc, astVelStepGroupTestAnalyze(ii).fNegativeStdDrvCmd_pc, ...
        strTextPosi, strTextNega, nTotalCase, 'StDev Drv Command');
%     if iFlagSaveWaveform >= 0.5
%         saveas(gcf, strcat(strPathname, char(strcat(astrApplicationName(ii), '_5.jpg'))), 'jpg');
%     end
    
    if ii == 1 && nTotalAxis >= 2
        figure(ii * 10 + 6); clf;
    %    hold on;
        nTotalCase = length(astVelStepGroupTestAnalyze(ii).astExcitePosn); %(iCurrTotalCase).aPosn

        grid on;
        nDim = nTotalAxis; %% length(astVelStepGroupTestAnalyze(ii).astExcitePosn(1).aPosn);
        MaxPosnX=0;MinPosnX=0;MaxPosnY=0;MinPosnY=0;MaxPosnZ=0;MinPosnZ=0;
        for cc = 1:1:nTotalCase
                if MaxPosnX < astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(1)
                    MaxPosnX = astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(1);
                end
                if MinPosnX > astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(1)
                    MinPosnX = astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(1);
                end
                if MaxPosnY < astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(2)
                    MaxPosnY = astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(2);
                end
                if MinPosnY > astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(2)
                    MinPosnY = astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(2);
                end
            if nDim == 3
                if MaxPosnZ < astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(3)
                    MaxPosnZ = astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(3);
                end
                if MinPosnZ > astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(3)
                    MinPosnZ = astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(3);
                end
                
                if MaxPosnZ == MinPosnZ
                    MaxPosnZ = MinPosnZ + 0.5;
                    MinPosnZ = MinPosnZ - 0.5;
                end
            end

        end
        if nDim == 2
            axis([MinPosnX, MaxPosnX, MinPosnY, MaxPosnY]);
        elseif nDim == 3
            strTestingRange = sprintf('TESTING POSITION RANGE: [%4.1f, %4.1f, %4.1f, %4.1f, %4.1f, %4.1f]', MinPosnX, MaxPosnX, MinPosnY, MaxPosnY, MinPosnZ, MaxPosnZ);
            disp(strTestingRange);
            axis([MinPosnX, MaxPosnX, MinPosnY, MaxPosnY, MinPosnZ, MaxPosnZ]);
        end
        hold on;
        MeanPosnZ = mean([MinPosnZ, MaxPosnZ]);
        if nDim == 3
            for cc = 1:1:nTotalCase
                aPosnX(cc) = astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(1);
                aPosnY(cc) = astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(2);
                aPosnZ(cc) = astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(3);
            end
            aMeshPosnX = linspace(min(aPosnX), max(aPosnX), 3);
            aMeshPosnY = linspace(min(aPosnY), max(aPosnY), 3);
            matMeshPosnZ1 = min(aPosnZ) * ones(length(aMeshPosnX), length(aMeshPosnY));
            matMeshPosnZ2 = max(aPosnZ) * ones(length(aMeshPosnX), length(aMeshPosnY));

            mesh(aMeshPosnX, aMeshPosnY, matMeshPosnZ1);
            mesh(aMeshPosnX, aMeshPosnY, matMeshPosnZ2);
        end

        for cc = 1:1:nTotalCase
            if nDim == 2
                PosnX = astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(1);
                PosnY = astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(2);
                strText = sprintf('C%d', cc);
                text(PosnX, PosnY, strText);
            else
                PosnX = astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(1);
                PosnY = astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(2);
                PosnZ = astVelStepGroupTestAnalyze(ii).astExcitePosn(cc).aTestPosn_mm(3);
                strText = sprintf('C%d', cc);
                if PosnZ > MeanPosnZ
                    text(PosnX, PosnY, PosnZ, strText); %, 'r');
                else
                    text(PosnX, PosnY, PosnZ, strText); %, 'g');
                end                
            end
        end
        xlabel(strcat(char(astrApplicationName(1)), ' in mm'));
        ylabel(strcat(char(astrApplicationName(2)), ' in mm'));
       if nDim == 3
           zlabel(strcat(char(astrApplicationName(3)), ' in mm'));
       end
        
        if iFlagSaveWaveform >= 0.5
            saveas(gcf, strcat(strPathname, 'CasesPosn.jpg'), 'jpg');
        end
    end
end