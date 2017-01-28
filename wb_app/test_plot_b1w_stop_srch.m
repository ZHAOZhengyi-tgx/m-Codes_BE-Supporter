function stOutput = test_plot_b1w_stop_srch(strFileFullName)

%close all;
iFlagPlot1stSrch = 1;
iFlagPlotResetMotion = 0;
fPosnSettlingTH1stSrch = 10;

if(~exist('strFileFullName'))
    [strFilename, strPathname, filterindex] = uigetfile('*.m', 'Pick an m-file for B1W StopSrch Waveform');
    strFileFullName = strcat(strPathname, strFilename);
end

dSampleTime_s = 0.5E-3;
dEncoderRes_m = 1E-6;

strDisplayLabelX = sprintf('Sample Time(ms): %4.2f', dSampleTime_s * 1000);

%% run(strFileFullName);
aTuneB1W_StopSrch = ana_load_wb_b1w_tune_data(strFileFullName);

afRefPosn = aTuneB1W_StopSrch(:, 1);
afPE = aTuneB1W_StopSrch(:, 2);
afRefVel = aTuneB1W_StopSrch(:, 3);
afFeedVel = aTuneB1W_StopSrch(:, 4);
afFeedPosn = afRefPosn - afPE;

afFeedVel = afFeedVel * dEncoderRes_m; %% velocity unit from ACS: count per sec
afRefVel = afRefVel * dEncoderRes_m;

nTotalLen = length(afFeedPosn);

nPlotLen = 300;
% for ii = nTotalLen: (-1): 1
%     if abs(afRefVel(ii)) > 0.0001 
%         nPlotLen = ii
%         break;
%     end
% end
aIdxTime = 1:1:nPlotLen + 20;

figure(1); clf;
plot(aIdxTime, afRefPosn(aIdxTime), aIdxTime, afFeedPosn(aIdxTime));
legend('afRefPosn', 'afFeedPosn', 'Location', 'North');
xlabel(strDisplayLabelX);
ylabel('Enc Count');
grid on;
 
figure(2); clf;
plot(aIdxTime, afPE(aIdxTime), aIdxTime, afRefVel(aIdxTime) * 1000, aIdxTime, afFeedVel(aIdxTime)* 1000);
legend('PE', 'RefVel', 'FeedVel', 'Location', 'North');
xlabel(strDisplayLabelX);
ylabel('um/ms');
grid on;

afRefAcc = [diff(afRefVel); 0] /dSampleTime_s;
afFeedAcc = [diff(afFeedVel); 0] /dSampleTime_s;
figure(3); clf;
subplot(2,1,1);
plot(aIdxTime, afPE(aIdxTime), aIdxTime, afRefAcc(aIdxTime), aIdxTime, afFeedAcc(aIdxTime));
legend('PE', 'RefAcc', 'FeedAcc');
ylabel('m/s^2')
grid on;


afRefJerk = [diff(afRefAcc); 0] /dSampleTime_s / 1000;
afFeedJerk = [diff(afFeedAcc); 0] /dSampleTime_s /1000;
figure(3); clf;
subplot(2,1,2);
plot(aIdxTime, afPE(aIdxTime), aIdxTime, afRefJerk(aIdxTime), aIdxTime, afFeedJerk(aIdxTime));
legend('PE', 'RefJerk', 'FeedJerk');
ylabel('km/s^3')
xlabel(strDisplayLabelX);
grid on;

stWaveform.afRefPosn = afRefPosn;
stWaveform.afPE = afPE;
stWaveform.afRefVel = afRefVel;
stWaveform.afFeedVel = afFeedVel;
stWaveform.afFeedPosn = afFeedPosn;
stWaveform.afRefAcc = afRefAcc;
stWaveform.afFeedAcc = afFeedAcc;
stWaveform.afRefJerk = afRefJerk;
stWaveform.afFeedJerk = afFeedJerk;

stOutput.stWaveform = stWaveform;
idxEndMoveReset = 150;
for ii = 150:-1:1
    if afRefVel(ii) > 0
        idxEndMoveReset = ii;
        break;
    end
end
idxStartMoveReset = idxEndMoveReset;
for ii = idxEndMoveReset:-1:1
    if afRefVel(ii) == 0
        idxStartMoveReset = ii;
        break;
    end
end

for ii = 1:1:150
    if afRefVel(ii) < 0
        idxStartMove1stSrch = ii;
        break;
    end
end
idxEndMove1stSrch = idxStartMove1stSrch;
for ii = idxStartMove1stSrch:1:150
    if afRefVel(ii+1) == afRefVel(ii)
        idxEndMove1stSrch = ii;
        break;
    end
end
idxStartMoveReversHt = idxEndMove1stSrch;
for ii = idxEndMove1stSrch:1:150
    if afRefVel(ii+1) > 0
        idxStartMoveReversHt = ii;
        break;
    end    
end

for ii = idxStartMoveReversHt:(-1):idxEndMove1stSrch
    if abs(afPE(ii)) > fPosnSettlingTH1stSrch
        idxTimePosnSettle1stSrch = ii;
        break;
    end
end

stTimeIndex.idxStartMoveReset = idxStartMoveReset;
stTimeIndex.idxEndMoveReset = idxEndMoveReset;
stTimeIndex.idxStartMove1stSrch = idxStartMove1stSrch;
stTimeIndex.idxEndMove1stSrch = idxEndMove1stSrch;
stTimeIndex.idxStartMoveReversHt = idxStartMoveReversHt;
stTimeIndex.idxTimePosnSettle1stSrch = idxTimePosnSettle1stSrch;

tSettleTime1stSrch_ms = abs(idxTimePosnSettle1stSrch - idxEndMove1stSrch)/2;
tMotionMove1stSrch_ms = abs(idxEndMove1stSrch - idxStartMove1stSrch)/2;
fActualPeakAcc1stSrch = max(abs(afFeedAcc(idxStartMove1stSrch : idxEndMove1stSrch)));
fActualPeakJerk1stSrch = max(abs(afFeedJerk(idxStartMove1stSrch : idxEndMove1stSrch)));
a1stSrch_Time_ActAcc_Jerk_SettleT = [tMotionMove1stSrch_ms, fActualPeakAcc1stSrch, fActualPeakJerk1stSrch, tSettleTime1stSrch_ms];
afPosnSettlingMove1stSrch = afPE(idxEndMove1stSrch : (idxEndMove1stSrch + 20))';

if iFlagPlot1stSrch == 1
    a1stSrch_Time_ActAcc_Jerk_SettleT
    afPosnSettlingMove1stSrch
    afFeedbackPosnAfterMove1stSrch = afFeedPosn(idxEndMove1stSrch:idxTimePosnSettle1stSrch)'
end

tMotionReset_ms = abs(idxStartMoveReset - idxEndMoveReset)/2;
fActualPeakAccReset = max(abs(afFeedAcc(idxStartMoveReset : idxEndMoveReset)));
Time_ActualAccReset = [tMotionReset_ms, fActualPeakAccReset];

afPosnSettlingReset = afPE(idxEndMoveReset : (idxEndMoveReset + 20))';
fMaxPosnErr = max(afPosnSettlingReset);
fMinPosnErr = min(afPosnSettlingReset);
fPosnErrCmdEnd = afPE(idxEndMoveReset);
afPE_ResetCmdEnd_P2P = [fPosnErrCmdEnd, fMaxPosnErr, fMinPosnErr];

if iFlagPlotResetMotion == 1
    afPosnSettlingReset
    afPE_ResetCmdEnd_P2P
end

stPeformance.tMotionReset_ms = tMotionReset_ms;
stPeformance.fActualPeakAccReset = fActualPeakAccReset;
stPeformance.afPosnSettlingReset = afPosnSettlingReset;
stPeformance.afPE_ResetCmdEnd_P2P = afPE_ResetCmdEnd_P2P;
stPeformance.tMotionMove1stSrch_ms = tMotionMove1stSrch_ms;
stPeformance.fActualPeakAcc1stSrch = fActualPeakAcc1stSrch;
stPeformance.fActualPeakJerk1stSrch = fActualPeakJerk1stSrch;
stPeformance.afPosnSettlingMove1stSrch = afPosnSettlingMove1stSrch;

stOutput.stPeformance = stPeformance;
stOutput.stTimeIndex = stTimeIndex;

figure(1); xlim([1,150]); set (gcf, 'Units', 'normalized', 'Position', [0, 0, 0.9, 0.9]); 
saveas(gcf, strcat(strFileFullName, '_PosnRefFb.jpg'), 'jpg');
figure(2); xlim([1,150]); set (gcf, 'Units', 'normalized', 'Position', [0, 0, 0.9, 0.9]); 
saveas(gcf, strcat(strFileFullName, '_VelRefFb.jpg'), 'jpg');
figure(3); subplot(2,1,1); xlim([1,150]); subplot(2,1,2); xlim([1,150]); set (gcf, 'Units', 'normalized', 'Position', [0, 0, 0.9, 0.9]); 
saveas(gcf, strcat(strFileFullName, '_AccJerkRefFb.jpg'), 'jpg');