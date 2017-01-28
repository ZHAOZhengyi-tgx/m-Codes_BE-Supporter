
astOutputData = test_calc_plot_tek_scope_csv_file('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2013-Q1\Peneng_FairChild\21Feb\Normal-Prod_Data\ALL0005\');

fForceCmd1stImpact = 47;
fForceCmd1stBond = 33;
fForceFb1stImpact = mean(astOutputData(2).stOutput.aOutData(371:381));
fForceFb1stBond = mean(astOutputData(2).stOutput.aOutData(401:441)); % 421:441
fForceCmd2ndImpact = 70;
fForceCmd2ndBond = 90;
fForceFb2ndImpact = mean(astOutputData(2).stOutput.aOutData(639:644));
fForceFb2ndBond = mean(astOutputData(2).stOutput.aOutData(651:671)); % 421:441

matFromVolt2Gram(1,1) = fForceFb1stImpact;
matFromVolt2Gram(2,1) = fForceFb1stBond;
matFromVolt2Gram(3,1) = fForceFb2ndImpact;
matFromVolt2Gram(4,1) = fForceFb2ndBond;
matFromVolt2Gram(:,2) = ones(4,1);
rhsGram(1,1) = fForceCmd1stImpact;
rhsGram(2,1) = fForceCmd1stBond;
rhsGram(3,1) = fForceCmd2ndImpact;
rhsGram(4,1) = fForceCmd2ndBond;
aGramPerVolt = inv(matFromVolt2Gram' * matFromVolt2Gram) * matFromVolt2Gram' * rhsGram;
aGramPerVolt 


astOutput = test_plot_save_E60_m_4K('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2013-Q1\Peneng_FairChild\21Feb\Normal-Prod_Data\HZ4K0002.M');
aFbVel = astOutput(1).aWvfrm4K(:,1);
aRefVel = astOutput(1).aWvfrm4K(:,3);
aFilterForceFb = astOutput(1).aWvfrm4K(:,2);
aPosnErr = astOutput(1).aWvfrm4K(:,4);
aRefAcc = [diff(aRefVel); 0];

fEncRes_um = 0.4;
fSampleFreqHz = 4000;

aLen = (1:500);
aTime_ms = aLen * 1000/fSampleFreqHz;
aRefVel_si = aRefVel * fSampleFreqHz * fEncRes_um/1000000;
aRefAcc_si = aRefAcc * fSampleFreqHz * fSampleFreqHz * fEncRes_um/1000000;
figure(4001); subplot(3,1,1); plot(aTime_ms,aRefAcc_si(aLen)); title('RefAcc'); ylabel('m/s/s'); grid on; zoom on;
subplot(3,1,2); plot(aTime_ms,aRefVel_si(aLen)); title('RefVel'); ylabel('m/s'); grid on; zoom on;
subplot(3,1,3); plot(aTime_ms,aPosnErr(aLen) * fEncRes_um); strLabelY = sprintf(' um'); title('Position Error'); ylabel(strLabelY);grid on;
xlabel('ms');

aFbVel_si = aFbVel * fSampleFreqHz * fEncRes_um/1000000;
aFbAcc = [diff(aFbVel); 0];
aFbAcc_si = aFbAcc * fSampleFreqHz * fSampleFreqHz * fEncRes_um/1000000;
figure(4002);
subplot(3,1,1); plot(aTime_ms,aFbAcc_si(aLen)); title('FbAcc'); ylabel('m/s/s'); grid on; zoom on;
subplot(3,1,2); plot(aTime_ms,aFbVel_si(aLen)); title('FbVel'); ylabel('m/s'); grid on; zoom on;
subplot(3,1,3); plot(aTime_ms,aPosnErr(aLen) * fEncRes_um); strLabelY = sprintf(' um'); title('Position Error'); ylabel(strLabelY);grid on;
xlabel('ms');

fRatioAcc_Pos = abs(max(aFbAcc_si)/min(astOutputData(2).stOutput.aOutData));
fRatioAcc_Neg = abs(min(aFbAcc_si)/max(astOutputData(2).stOutput.aOutData));
fMeanAccRatio = (fRatioAcc_Pos + fRatioAcc_Neg)/2;
aRefDist_um = cumsum(aRefVel * fEncRes_um);
aFbDist_um = aRefDist_um - aPosnErr * fEncRes_um; %cumsum(aFbVel * fEncRes_um);
figure(4003);
plot(aTime_ms, aRefDist_um(aLen), aTime_ms, aFbDist_um(aLen)); grid on; zoom on;
legend('Ref', 'Fb');
title('Distance (um)');
