function stAnalyzeOneWire = ana_wb_waveform_one_wire_idx(stWaveformData, stStartOneWireTimeInfo)

idxStartOneWireZ = stStartOneWireTimeInfo.idxStartOneWireZ;
idxStartOneWireXY = stStartOneWireTimeInfo.idxStartOneWireXY;

tLen = stWaveformData.tLen;
fRefPosnX	=	stWaveformData.fRefPosnX'	;
fFeedPosnX	=	stWaveformData.fFeedPosnX'	;
fRefPosnY	=	stWaveformData.fRefPosnY'	;
fFeedPosnY	=	stWaveformData.fFeedPosnY'	;
fRefPosnZ	=	stWaveformData.fRefPosnZ'	;
fFeedPosnZ	=	stWaveformData.fFeedPosnZ'	;
fRefVelX	=	stWaveformData.fRefVelX'	;
fFeedVelX	=	stWaveformData.fFeedVelX'	;
fRefVelY	=	stWaveformData.fRefVelY'	;
fFeedVelY	=	stWaveformData.fFeedVelY'	;
fRefVelZ	=	stWaveformData.fRefVelZ'	;
fFeedVelZ	=	stWaveformData.fFeedVelZ'	;

stAnalyzeOneWire.iFlagHasWireInfo = 0;

%% FireLevel_Z
%% 1stSrchHeight_Z
%% 1stBondReverseHeight
%% 1stBondKinkHeight
%% 1stBondLoopTop
%% TrajectoryEndHeight_Z = 2ndBond_Search_Height
%% 2ndBondEndTailHeight
%% 2ndBondEndFireLevel
idxStartMove1stBondSearchHeight = 0;
idxEndMove1stBondSearchHeight = 0;
idxStart1stBondForceCtrl = 0;
idxEnd1stBondForceCtrl = 0;
idxStartReverseHeight = 0;
idxEndReverseHeight = 0;
idxStartKinkHeight = 0;
idxEndKinkHeight = 0;
idxStartMoveLoopTop = 0;
idxEndMoveLoopTop = 0;
idxStartTrajectory = 0;
idxEndTrajectory2ndBondSearchHeight = 0;
idxStart2ndBondForceCtrl = 0;
idxEnd2ndBondForceCtrl = 0;
idxStartTail = 0;
idxEndTail = 0;
idxStartFireLevel = 0;
idxEndFireLevel = 0;
idxStart2ndBondSearchContact = 0;
iFlagDryRun = 0;
%%% Only compare first 900 points, avoid over-indexing , 20121008
%%% tLen-100
for ii = idxStartOneWireZ:1:tLen-100
    if fRefVelZ(ii)==0 &&  fRefVelZ(ii+1) < 0 && idxStartMove1stBondSearchHeight == 0
        idxStartMove1stBondSearchHeight = ii;
        fStartFireLevel_Z = fRefPosnZ(ii);
    end
    
    if ((fRefVelZ(ii) == 0 && fRefVelZ(ii+1) == 0 && fRefVelZ(ii+2) == 0 && fRefVelZ(ii+3) == 0 && fRefVelZ(ii+4) == 0 && fRefVelZ(ii+5) == 0 && fRefVelZ(ii+6) == 0 && fRefVelZ(ii+7) == 0) ...
            || abs(fRefPosnZ(ii) - fFeedPosnZ(ii))<0.5 && abs(fRefPosnZ(ii+1) - fFeedPosnZ(ii+1))<0.5 && abs(fRefPosnZ(ii+2) - fFeedPosnZ(ii+2))<0.5 && abs(fRefPosnZ(ii+3) - fFeedPosnZ(ii+3))<0.5 ) ...
            && idxStartMove1stBondSearchHeight ~= 0 && idxStart1stBondForceCtrl == 0
        if (fRefVelZ(ii) == 0 && fRefVelZ(ii+1) == 0 && fRefVelZ(ii+2) == 0 && fRefVelZ(ii+3) == 0 && fRefVelZ(ii+4) == 0 && fRefVelZ(ii+5) == 0 && fRefVelZ(ii+6) == 0 && fRefVelZ(ii+7) == 0)
            iFlagDryRun = 1;
        else
            iFlagDryRun = 0;
        end
        idxStart1stBondForceCtrl = ii;
        f1stBondContactPosn_Z = (fRefPosnZ(ii) + fRefPosnZ(ii+1) + fRefPosnZ(ii+2) + fRefPosnZ(ii+3))/4;
    end        

    if ((iFlagDryRun == 0) && (abs(fFeedPosnZ(ii) - fRefPosnZ(ii)) < 0.5) && (abs(fFeedPosnZ(ii +1) - fRefPosnZ(ii +1)) > 0.5) && (abs(fFeedPosnZ(ii +2) - fRefPosnZ(ii +2)) > 0.5) ...
            || (iFlagDryRun == 1 && fRefVelZ(ii) == 0 && fRefVelZ(ii+1) > 0 && fRefVelZ(ii+2) > 0 && fRefVelZ(ii+3) > 0 ) ...
            )  ...
             && (idxStart1stBondForceCtrl > 0) && (idxEnd1stBondForceCtrl == 0)
         %% && (fRefVelZ(ii+1) > 0) && (fRefVelZ(ii+2) > 0)
        idxEnd1stBondForceCtrl = ii;

    end

     %% idxEndTrajectory2ndBondSearchHeight
     %% 
     %% fRefVelZ(ii+3) == 0 && fRefVelZ(ii+4) == 0)
    if  ( (abs(fRefPosnZ(ii) - fFeedPosnZ(ii))>0.5 && abs(fRefPosnZ(ii+1) - fFeedPosnZ(ii+1))<0.5 && abs(fRefPosnZ(ii+2) - fFeedPosnZ(ii+2))<0.5 && abs(fRefPosnZ(ii+3) - fFeedPosnZ(ii+3))<0.5 )  ...
          || (fRefVelZ(ii) == 0 && fRefVelZ(ii+1) == 0 && fRefVelZ(ii+2) == 0 && fRefVelZ(ii+3) == 0 && fRefVelZ(ii+4) == 0 && fRefVelZ(ii+5) == 0 && fRefVelZ(ii+6) == 0 && fRefVelZ(ii+7) == 0 && fRefVelZ(ii+8) == 0 && fRefVelZ(ii+9) == 0 && fRefVelZ(ii+10) == 0 && fRefVelZ(ii+11) == 0 && fRefVelZ(ii+12) == 0 && fRefVelZ(ii+13) == 0 && fRefVelZ(ii+14) == 0 && fRefVelZ(ii+15) == 0 && fRefVelZ(ii+16) == 0 && fRefVelZ(ii+17) == 0 && fRefVelZ(ii+18) == 0 && fRefVelZ(ii+19) == 0 && fRefVelZ(ii+20) == 0 )...
              ) ...
            &&  (idxEnd1stBondForceCtrl > 0) && (idxStart2ndBondForceCtrl == 0 ) 
        
        if (abs(fRefPosnZ(ii) - fFeedPosnZ(ii))>0.5 && abs(fRefPosnZ(ii+1) - fFeedPosnZ(ii+1))<0.5 && abs(fRefPosnZ(ii+2) - fFeedPosnZ(ii+2))<0.5 && abs(fRefPosnZ(ii+3) - fFeedPosnZ(ii+3))<0.5 )
            iFlagDryRun = 0;
        else
            iFlagDryRun = 1;
        end
        idxStart2ndBondForceCtrl = ii;
        f2ndBondContactPosn_Z =  (fRefPosnZ(ii) + fRefPosnZ(ii+1) + fRefPosnZ(ii+2) + fRefPosnZ(ii+3))/4;
    end
    if ((fFeedPosnZ(ii) == fRefPosnZ(ii)) && (fFeedPosnZ(ii +1) ~= fRefPosnZ(ii +1) && iFlagDryRun == 1) ...
            || (fRefVelZ(ii) == 0 && fRefVelZ(ii+1) > 0 && fRefVelZ(ii+2) > 0) ...
        )...
            && idxStart2ndBondForceCtrl ~= 0 && idxEnd2ndBondForceCtrl == 0
        idxEnd2ndBondForceCtrl = ii;
        stAnalyzeOneWire.iFlagHasWireInfo = 1;
    end

    if fRefVelZ(ii)>0 && fRefVelZ(ii+1)==0 && idxEnd2ndBondForceCtrl~= 0  && abs(fRefPosnZ(ii+1) - fStartFireLevel_Z) <=0.5
        idxEndFireLevel = ii+1;
        break;
    end
    
%     if fRefVelZ(ii) ~=0 && (fRefVelZ(ii+1) == 0 || (abs(fRefVelZ(ii+1) - fRefVelZ(ii)) < 0.01)) ...
%             && idxStartMove1stBondSearchHeight ~= 0 && idxEndMove1stBondSearchHeight == 0
%         idxEndMove1stBondSearchHeight = ii;
%         f1stBondSearchHeight_Z = fRefPosnZ(ii);
%     end
%     if (fFeedPosnZ(ii) ~= fRefPosnZ(ii)) && (fFeedPosnZ(ii +1) == fRefPosnZ(ii +1)) && idxEndMove1stBondSearchHeight ~= 0 && idxStart1stBondForceCtrl == 0
%         idxStart1stBondForceCtrl = ii;
%         f1stBondContactPosn_Z = fRefPosnZ(ii);
%     end
%     if fRefVelZ(ii) ~=0 && ( fRefVelZ(ii+1) == fRefVelZ(ii)) && idxEnd1stBondForceCtrl ~= 0 && idxStart2ndBondSearchContact == 0
%         idxStart2ndBondSearchContact = ii;
%         f2ndBondStartSearchContact_Z = fRefPosnZ(ii);
%     end
end

stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxStartMove1stBondSearchHeight = idxStartMove1stBondSearchHeight;
stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxEndMove1stBondSearchHeight = idxEndMove1stBondSearchHeight;
stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxStart1stBondForceCtrl = idxStart1stBondForceCtrl;
stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxEnd1stBondForceCtrl = idxEnd1stBondForceCtrl;
stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxStartReverseHeight = idxStartReverseHeight;
stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxEndReverseHeight = idxEndReverseHeight;
stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxStartKinkHeight = idxStartKinkHeight;
stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxEndKinkHeight = idxEndKinkHeight;
stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxStartMoveLoopTop = idxStartMoveLoopTop;
stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxEndMoveLoopTop = idxEndMoveLoopTop;
stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxStartTrajectory = idxStartTrajectory;
stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxEndTrajectory2ndBondSearchHeight = idxEndTrajectory2ndBondSearchHeight;
stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxStart2ndBondForceCtrl = idxStart2ndBondForceCtrl;
stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxEnd2ndBondForceCtrl = idxEnd2ndBondForceCtrl;
stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxStartTail = idxStartTail;
stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxEndTail = idxEndTail;
stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxStartFireLevel = idxStartFireLevel;
stAnalyzeOneWire.stTimePointsOfBondHeadZ.idxEndFireLevel = idxEndFireLevel;
stAnalyzeOneWire.idxEndOneWireZ = idxEndFireLevel;

if stAnalyzeOneWire.iFlagHasWireInfo == 0

else
    stAnalyzeOneWire.stPosnsOfBondHeadZ.fStartFireLevel_Z = fStartFireLevel_Z;
    %stAnalyzeOneWire.stPosnsOfBondHeadZ.f1stBondSearchHeight_Z = f1stBondSearchHeight_Z;
    stAnalyzeOneWire.stPosnsOfBondHeadZ.f1stBondContactPosn_Z = f1stBondContactPosn_Z;
    %stAnalyzeOneWire.stPosnsOfBondHeadZ.fReverseHeightPosn_Z = fReverseHeightPosn_Z;
    %stAnalyzeOneWire.stPosnsOfBondHeadZ.fKinkHeightPosn_Z = fKinkHeightPosn_Z;
    %stAnalyzeOneWire.stPosnsOfBondHeadZ.fLoopTopPosn_Z = fLoopTopPosn_Z;
    %stAnalyzeOneWire.stPosnsOfBondHeadZ.f2ndBondSearchHeightPosn_Z = f2ndBondSearchHeightPosn_Z;
    stAnalyzeOneWire.stPosnsOfBondHeadZ.f2ndBondContactPosn_Z = f2ndBondContactPosn_Z;
    %stAnalyzeOneWire.stPosnsOfBondHeadZ.fTailPosn_Z = fTailPosn_Z;
    %stAnalyzeOneWire.stPosnsOfBondHeadZ.fEndFireLevel_Z = fEndFireLevel_Z;
    %stAnalyzeOneWire.stPosnsOfBondHeadZ.f2ndBondStartSearchContact_Z = f2ndBondStartSearchContact_Z;
    
    
end