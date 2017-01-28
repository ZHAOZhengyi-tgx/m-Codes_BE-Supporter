function stOutput = ana_wb_waveform(WB_Waveform)

global iPlotFlag;

astAnalyzeOneWire = []; %% stOutput
stOutput = [];

fRefPosnX = WB_Waveform(:, 1);
fFeedPosnX = WB_Waveform(:, 2);
fRefPosnY = WB_Waveform(:, 3);
fFeedPosnY = WB_Waveform(:, 4);
fRefPosnZ = WB_Waveform(:, 5);
fFeedPosnZ = WB_Waveform(:, 6);

iMFZ = WB_Waveform(:, 7);
iDWireClamp = WB_Waveform(:, 8);

fRefVelX = [diff(fRefPosnX); 0];
fFeedVelX = [diff(fFeedPosnX); 0];
fRefVelY = [diff(fRefPosnY); 0];
fFeedVelY = [diff(fFeedPosnY); 0];
fRefVelZ = [diff(fRefPosnZ); 0];
fFeedVelZ = [diff(fFeedPosnZ); 0];

tLen = length(fRefVelX);

stWaveformData.fRefPosnX	=	fRefPosnX	;
stWaveformData.fFeedPosnX	=	fFeedPosnX	;
stWaveformData.fRefPosnY	=	fRefPosnY	;
stWaveformData.fFeedPosnY	=	fFeedPosnY	;
stWaveformData.fRefPosnZ	=	fRefPosnZ	;
stWaveformData.fFeedPosnZ	=	fFeedPosnZ	;
stWaveformData.fRefVelX     =	fRefVelX	;
stWaveformData.fFeedVelX	=	fFeedVelX	;
stWaveformData.fRefVelY     =	fRefVelY	;
stWaveformData.fFeedVelY	=	fFeedVelY	;
stWaveformData.fRefVelZ     =	fRefVelZ	;
stWaveformData.fFeedVelZ	=	fFeedVelZ	;
stWaveformData.tLen = tLen;

%% nNumOfWires

%%%%%%%% Table 
nNumOfWires = 0;
idxStartOneWireZ = 1;
idxStartOneWireXY = 1;
idxExpectEndNextWireXY = 0;
idxExpectEndNextWireZ = 0;

fTableEncResolution_mm = 2000;
fBndHeadEncResolution_mm = 1000;

fRefPosnX_mm = fRefPosnX / fTableEncResolution_mm;
fRefPosnY_mm = fRefPosnY / fTableEncResolution_mm;
fRefPosnZ_mm = fRefPosnZ / fBndHeadEncResolution_mm;

fFeedPosnX_mm = fFeedPosnX / fTableEncResolution_mm;
fFeedPosnY_mm = fFeedPosnY / fTableEncResolution_mm;
fFeedPosnZ_mm = fFeedPosnZ / fBndHeadEncResolution_mm;

if iPlotFlag >= 1
    figure(31);
    hold on;
    grid on;
    figure(32);
    axis([min(fRefPosnX_mm), max(fRefPosnX_mm), min(fRefPosnY_mm), max(fRefPosnY_mm)])
    hold on;
    grid on;
    xlabel('X (mm)'); ylabel('Y (mm)');
end
aMultiWireCumTimeLooping = [];

while idxExpectEndNextWireXY < tLen && idxExpectEndNextWireZ < tLen %% && nNumOfWires < 
    
    stStartOneWireTimeInfo.idxStartOneWireZ = idxStartOneWireZ;
    stStartOneWireTimeInfo.idxStartOneWireXY = idxStartOneWireXY;
%    stAnalyzeOutputOneWire = ana_wb_waveform_one_wire(stWaveformData, stStartOneWireTimeInfo);
    stAnalyzeOneWire = ana_wb_waveform_one_wire_idx(stWaveformData, stStartOneWireTimeInfo);
    aTimeFrom1stBto2ndB = stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxEnd1stBondForceCtrl : stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxStart2ndBondForceCtrl;
    
    if stAnalyzeOneWire.iFlagHasWireInfo == 0 
        %% no wire info
        break;
    end
    
    %%%%%%%% for analyzing the loopng error
    if iPlotFlag >= 1
        figure(31);
        plot3(fRefPosnX_mm(aTimeFrom1stBto2ndB), fRefPosnY_mm(aTimeFrom1stBto2ndB), fRefPosnZ_mm(aTimeFrom1stBto2ndB));
        plot3(fFeedPosnX_mm(aTimeFrom1stBto2ndB), fFeedPosnY_mm(aTimeFrom1stBto2ndB), fFeedPosnZ_mm(aTimeFrom1stBto2ndB), 'o');
        plot3(fFeedPosnX_mm(aTimeFrom1stBto2ndB), fFeedPosnY_mm(aTimeFrom1stBto2ndB), fFeedPosnZ_mm(aTimeFrom1stBto2ndB), 'r');
        figure(32);
    end    
    
    aLoopingErrorX_mm = fRefPosnX_mm(aTimeFrom1stBto2ndB) - fFeedPosnX_mm(aTimeFrom1stBto2ndB);
    aLoopingErrorY_mm = fRefPosnY_mm(aTimeFrom1stBto2ndB) - fFeedPosnY_mm(aTimeFrom1stBto2ndB);
    aSwayError_um = [];
    for ii = 1:1:length(aLoopingErrorX_mm)
        %aSwayError(ii) = sqrt(aLoopingErrorX_mm(ii)*aLoopingErrorX_mm(ii) + aLoopingErrorY_mm(ii) * aLoopingErrorX_mm(ii));
        aSwayError_um(ii) = 1000 * calc_distance_point_to_curve_2d(fFeedPosnX_mm(aTimeFrom1stBto2ndB(ii)), fFeedPosnY_mm(aTimeFrom1stBto2ndB(ii)), fRefPosnX_mm, fRefPosnY_mm);
    end
    [fMaxSwayError, idxMaxPnt] = max(aSwayError_um);
    strTextMaxErr = sprintf('M:%4.1f(um)\r\n@[%4.3f, %4.3f]mm', fMaxSwayError, ...
        fFeedPosnX_mm(aTimeFrom1stBto2ndB(idxMaxPnt)), fFeedPosnY_mm(aTimeFrom1stBto2ndB(idxMaxPnt)));
    if iPlotFlag >= 1
        text(fRefPosnX_mm(aTimeFrom1stBto2ndB(idxMaxPnt)), fRefPosnY_mm(aTimeFrom1stBto2ndB(idxMaxPnt)), strTextMaxErr); %% 20121016
    end
    
     idxEndOneWireZ = stAnalyzeOneWire.idxEndOneWireZ;
%     idxEndOneWireXY = stAnalyzeOneWire.idxEndOneWireXY;
%     idxExpectEndNextWireXY = (idxEndOneWireXY - idxStartOneWireXY) + idxStartOneWireXY;
     idxExpectEndNextWireZ = (idxEndOneWireZ - idxStartOneWireZ) + idxEndOneWireZ;
%     
    idxStartOneWireZ = idxEndOneWireZ;
%    idxStartOneWireXY = idxEndOneWireXY;
    nNumOfWires = nNumOfWires + 1;
    
    %% add stAnalyzeOneWire 20121008
    stAnalyzeOneWire.fMaxSwayError = fMaxSwayError;
    if nNumOfWires == 1
        astAnalyzeOneWire = stAnalyzeOneWire;
        aMultiWireCumTimeLooping = aTimeFrom1stBto2ndB;
    else
        astAnalyzeOneWire(nNumOfWires) = stAnalyzeOneWire;
        aMultiWireCumTimeLooping = [aMultiWireCumTimeLooping, aTimeFrom1stBto2ndB];
    end
    stOutput = astAnalyzeOneWire; %%% assigning output

    if nNumOfWires >= 5
        break;
    end

end

% aMultiWireCumTimeLooping

    fCenterX_mm = mean(fRefPosnX_mm(aMultiWireCumTimeLooping)); fCenterY_mm = mean(fRefPosnY_mm(aMultiWireCumTimeLooping));
    fXDist = max(fRefPosnX_mm(aMultiWireCumTimeLooping)) - min(fRefPosnX_mm(aMultiWireCumTimeLooping));
    fYDist = max(fRefPosnY_mm(aMultiWireCumTimeLooping)) - min(fRefPosnY_mm(aMultiWireCumTimeLooping));
    fMaxTableDistance = max([fXDist, fYDist]); fTableDistHalf = fMaxTableDistance / 2;
    
if iPlotFlag >= 1
    figure(31);    
    axis([fCenterX_mm - fTableDistHalf, fCenterX_mm + fTableDistHalf, fCenterY_mm - fTableDistHalf, fCenterY_mm + fTableDistHalf]);
    figure(32);    
    axis([fCenterX_mm - fTableDistHalf, fCenterX_mm + fTableDistHalf, fCenterY_mm - fTableDistHalf, fCenterY_mm + fTableDistHalf]);
end