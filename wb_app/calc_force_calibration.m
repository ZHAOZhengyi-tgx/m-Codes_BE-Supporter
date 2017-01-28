function [aForceCaliPara_dcom, stDebug] = calc_force_calibration(afLevelAmplitude, aPosnErr, aForceCmd, aForceFb, afRefVel, aDebCounterTeachContact)
%%% Force calibration
%%% Find the section of force control by condition s.t. PositionErr == 0

global iPlotFlag;

nDataLen = length(aPosnErr);
EPS = 1E-6;
jj = 1;
iStartIdx = 0;
iEndIdx = nDataLen;
for ii = 5:1:nDataLen - 40
    if( (abs(aPosnErr(ii)) < EPS) && (abs(aPosnErr(ii+1)) < EPS) && (abs(aPosnErr(ii+2)) < EPS) && (abs(aPosnErr(ii+3)) < EPS) && (abs(aPosnErr(ii+4)) < EPS) ...
            && (abs(aPosnErr(ii+5)) < EPS) && (abs(aPosnErr(ii+6)) < EPS) && (abs(aPosnErr(ii+7)) < EPS) && (abs(aPosnErr(ii+8)) < EPS) && (abs(aPosnErr(ii+9)) < EPS) ...
            && (abs(aPosnErr(ii+10)) < EPS) && (abs(aPosnErr(ii+11)) < EPS) && (abs(aPosnErr(ii+12)) < EPS) && (abs(aPosnErr(ii+13)) < EPS) && (abs(aPosnErr(ii+14)) < EPS) ...
            && (abs(aPosnErr(ii+15)) < EPS) && (abs(aPosnErr(ii+16)) < EPS) && (abs(aPosnErr(ii+17)) < EPS) && (abs(aPosnErr(ii+18)) < EPS) && (abs(aPosnErr(ii+19)) < EPS) ...
            && (abs(aPosnErr(ii+20)) < EPS) && (abs(aPosnErr(ii+21)) < EPS) && (abs(aPosnErr(ii+22)) < EPS) && (abs(aPosnErr(ii+23)) < EPS) && (abs(aPosnErr(ii+24)) < EPS) ...
            && (abs(aPosnErr(ii+25)) < EPS) && (abs(aPosnErr(ii+26)) < EPS) && (abs(aPosnErr(ii+27)) < EPS) && (abs(aPosnErr(ii+28)) < EPS) && (abs(aPosnErr(ii+29)) < EPS) ...
            && (abs(aPosnErr(ii+30)) < EPS) && (abs(aPosnErr(ii+31)) < EPS) && (abs(aPosnErr(ii+32)) < EPS) && (abs(aPosnErr(ii+33)) < EPS) && (abs(aPosnErr(ii+34)) < EPS) ...
            && ((abs(afRefVel(ii - 1) - afRefVel(ii-2) )> EPS) || (abs(afRefVel(ii) - afRefVel(ii-1) )> EPS) || (abs(afRefVel(ii + 1) - afRefVel(ii) )> EPS) || (abs(afRefVel(ii + 1) - afRefVel(ii+2) )> EPS) )...
            && (abs(aPosnErr(ii - 1)) > EPS)   && (iStartIdx == 0))
        iStartIdx = ii; %% & aDebCounterTeachContact(ii) >= 3
    end
    if( (abs(aPosnErr(ii-1)) <= EPS) && (abs(aPosnErr(ii)) <= EPS) && ...
            (abs(aPosnErr(ii-2)) <= EPS) && (abs(aPosnErr(ii-3)) <= EPS) && (abs(aPosnErr(ii-4)) <= EPS) && ...
            (abs(aPosnErr(ii + 1)) > EPS)  &&  iStartIdx ~= 0 && ...
            (iEndIdx == nDataLen) )
%             (abs(afRefVel(ii - 1)) < EPS) && (abs(afRefVel(ii )) < EPS) &&...
%             (abs(afRefVel(ii - 2)) < EPS) && (abs(afRefVel(ii - 3)) < EPS) &&...
%             (abs(afRefVel(ii + 1)) > 1) && ...
        iEndIdx = ii; %% & aDebCounterTeachContact(ii) >= 3
    end
end

%%% Find different force segment by condition s.t. afLevelAmplitude
nTotalForceSeg = length(afLevelAmplitude);
jj = 1;
aStartIndexPerSeg = iStartIdx * ones(1, nTotalForceSeg);
aEndIndexPerSeg = iEndIdx * ones(1, nTotalForceSeg);

for ii = (iStartIdx + 1):1: (iEndIdx - 1)
	if( (abs(aForceCmd(ii) - afLevelAmplitude(jj) ) < EPS ) ...
        & aStartIndexPerSeg(jj) == iStartIdx)
        aStartIndexPerSeg(jj) = ii; 
	end

	if( (abs(aForceCmd(ii) - afLevelAmplitude(jj) ) > EPS ) ...
        & aStartIndexPerSeg(jj) > iStartIdx)
        aEndIndexPerSeg(jj) = ii; 
        jj = jj + 1;
	end
    if jj > nTotalForceSeg
        break;
    end
end

%%%% For each force segment, find the mean value of command and feedback.
fAdcFactorGram = 0.1516854; %% 220/8191;
for jj = 1:1:nTotalForceSeg
    nCutLenIgnoreNoise = round((aEndIndexPerSeg(jj) - aStartIndexPerSeg(jj))/10);
    aForceCmdMean_dcom(jj) = mean(aForceCmd((aStartIndexPerSeg(jj) + nCutLenIgnoreNoise) : aEndIndexPerSeg(jj)));
    aForceCmdMean_dac(jj) = aForceCmdMean_dcom(jj) * 327.67;
    aForceFbMean_adc(jj) = mean(aForceFb((aStartIndexPerSeg(jj) + nCutLenIgnoreNoise) : aEndIndexPerSeg(jj)));
    aForceFbMean_gram(jj) = aForceFbMean_adc(jj) * fAdcFactorGram;
end

if iPlotFlag >=1
    figure(7)
    plot(aForceFbMean_gram, aForceCmdMean_dac, 'o');
    title('Force Calibration');
    xlabel('Gram');
    ylabel('Force Command, DAC')
end

%%% Least Square fitting,
for jj = 1:1:nTotalForceSeg
    Matrix(jj, 1) = aForceFbMean_gram(jj);
    Matrix(jj, 2) = 1;
    RHS(jj, 1) = aForceCmdMean_dac(jj);
end
aForceCaliPara = Matrix\RHS;
fForceFactor_Kf = aForceCaliPara(1);
fForce_OffsetI0 = aForceCaliPara(2);

%%% 
for jj = 1:1:nTotalForceSeg
    Matrix(jj, 1) = aForceFbMean_gram(jj);
    Matrix(jj, 2) = 1;
    RHS(jj, 1) = aForceCmdMean_dcom(jj);
end
aForceCaliPara_dcom = Matrix\RHS;
fForceFactor_Kf_dcom = aForceCaliPara_dcom(1);
fForce_OffsetI0_dcom = aForceCaliPara_dcom(2);

stDebug.MatrixSq = Matrix' * Matrix;
stDebug.aRHS_Sq = Matrix' * RHS;
stDebug.iStartIdx = iStartIdx;
stDebug.iEndIdx = iEndIdx;
stDebug.aStartIndexPerSeg = aStartIndexPerSeg;
stDebug.aEndIndexPerSeg = aEndIndexPerSeg;
stDebug.Matrix = Matrix;
stDebug.RHS = RHS;
stDebug.aForceFbMean_adc = aForceFbMean_adc;
stDebug.aForceCmdMean_dcom = aForceCmdMean_dcom;