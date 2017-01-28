nDataGroup = length(stPosnCmpn);
for ii = 1:1:nDataGroup
    PosnFb(ii) = mean(stPosnCmpn(ii).Data(1:200, 1));
end

nLenDrvOut = 500;
for ii = 1:1:nDataGroup
    %% Add PWM-noise rejection
    afDrvOutRaw = stPosnCmpn(ii).Data(1:nLenDrvOut, 2);
    fMeanDrvOutRaw = mean(afDrvOutRaw);
    fMaxDrvOutRaw = max(afDrvOutRaw);
    fMinDrvOutRaw = min(afDrvOutRaw);
    
    nValidData = 0;
    afValidDrvOut = [];

    for jj = 1:1:nLenDrvOut
        fCurrDrvOut = stPosnCmpn(ii).Data(jj, 2);
        fDistToMean = abs(fCurrDrvOut - fMeanDrvOutRaw);
        fDistToMax = abs(fCurrDrvOut - fMaxDrvOutRaw);
        fDistToMin = abs(fCurrDrvOut - fMinDrvOutRaw);
        if((fDistToMean < fDistToMax ) && (fDistToMean < fDistToMin))
            nValidData = nValidData + 1;
            afValidDrvOut(nValidData) = fCurrDrvOut;
        end
    end
    anLenValidData(ii) = nValidData;
    CtrlOut(ii) = mean(afValidDrvOut);
end

figure(2);
plot(PosnFb, CtrlOut)
hold on;
plot(PosnFb, CtrlOut, '*')
Matrix(:,1) = PosnFb';
Matrix(:,2) = ones(size(PosnFb'));
PosnCompensatePara = Matrix\CtrlOut';
PosnFactor = PosnCompensatePara(1)
Offset = PosnCompensatePara(2)

% Calculation By C Library
PosnFactorByC =  -0.045674
OffsetByC = 286.234936
