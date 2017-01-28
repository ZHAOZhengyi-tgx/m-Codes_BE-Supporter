function stAnalyzeOneWire = ana_wb_waveform_one_wire(stWaveformData, stStartOneWireTimeInfo)

idxStartOneWireZ = stStartOneWireTimeInfo.idxStartOneWireZ;
idxStartOneWireXY = stStartOneWireTimeInfo.idxStartOneWireXY;

tLen = stWaveformData.tLen;
fRefPosnX	=	stWaveformData.fRefPosnX	;
fFeedPosnX	=	stWaveformData.fFeedPosnX	;
fRefPosnY	=	stWaveformData.fRefPosnY	;
fFeedPosnY	=	stWaveformData.fFeedPosnY	;
fRefPosnZ	=	stWaveformData.fRefPosnZ	;
fFeedPosnZ	=	stWaveformData.fFeedPosnZ	;
fRefVelX	=	stWaveformData.fRefVelX	;
fFeedVelX	=	stWaveformData.fFeedVelX	;
fRefVelY	=	stWaveformData.fRefVelY	;
fFeedVelY	=	stWaveformData.fFeedVelY	;
fRefVelZ	=	stWaveformData.fRefVelZ	;
fFeedVelZ	=	stWaveformData.fFeedVelZ	;

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

for ii = idxStartOneWireZ:1:tLen-1
    if fRefVelZ(ii)==0 &&  fRefVelZ(ii+1) < 0 && idxStartMove1stBondSearchHeight == 0
        idxStartMove1stBondSearchHeight = ii;
        fStartFireLevel_Z = fRefPosnZ(ii);
    end
    
    if ((fRefVelZ(ii) == 0 && fRefVelZ(ii+1) == 0 && fRefVelZ(ii+2) == 0 && fRefVelZ(ii+3) == 0 && fRefVelZ(ii+4) == 0) ...
            || (fRefPosnZ(ii) == fFeedPosnZ(ii) && fRefPosnZ(ii+1) == fFeedPosnZ(ii+1) && fRefPosnZ(ii+2) == fFeedPosnZ(ii+2) && fRefPosnZ(ii+3) == fFeedPosnZ(ii+3))) ...
            && idxStartMove1stBondSearchHeight ~= 0 && idxStart1stBondForceCtrl == 0
        idxStart1stBondForceCtrl = ii;
        f1stBondContactPosn_Z = (fRefPosnZ(ii) + fRefPosnZ(ii+1) + fRefPosnZ(ii+2) + fRefPosnZ(ii+3))/4;
    end        

    if (fFeedPosnZ(ii) == fRefPosnZ(ii)) && (fFeedPosnZ(ii +1) ~= fRefPosnZ(ii +1)) ...
            && fRefVelZ(ii+1) > 0 && fRefVelZ(ii+2) > 0 && idxStart1stBondForceCtrl ~= 0 && idxEnd1stBondForceCtrl == 0
        idxEnd1stBondForceCtrl = ii;
    end

     %% idxEndTrajectory2ndBondSearchHeight
    if  ((fRefVelZ(ii) == 0 && fRefVelZ(ii+1) == 0 && fRefVelZ(ii+2) == 0 && fRefVelZ(ii+3) == 0 && fRefVelZ(ii+4) == 0) ...
            || (fRefPosnZ(ii) == fFeedPosnZ(ii) && fRefPosnZ(ii+1) == fFeedPosnZ(ii+1) && fRefPosnZ(ii+2) == fFeedPosnZ(ii+2) && fRefPosnZ(ii+3) == fFeedPosnZ(ii+3)) ...
            &&  idxEnd1stBondForceCtrl ~= 0 && idxStart2ndBondForceCtrl == 0  
        idxStart2ndBondForceCtrl = ii;
        f2ndBondContactPosn_Z =  (fRefPosnZ(ii) + fRefPosnZ(ii+1) + fRefPosnZ(ii+2) + fRefPosnZ(ii+3))/4;
    end
    if (fFeedPosnZ(ii) == fRefPosnZ(ii)) && (fFeedPosnZ(ii +1) ~= fRefPosnZ(ii +1)) && idxStart2ndBondForceCtrl ~= 0 && idxEnd2ndBondForceCtrl == 0
        idxEnd2ndBondForceCtrl = ii;
    end

    if fRefVelZ(ii)>0 && fRefVelZ(ii+1)==0 && idxEnd2ndBondForceCtrl~= 0  && fabs(fRefPosnZ(ii+1) - fStartFireLevel_Z) <=0.5
        idxEndFireLevel = ii+1;
        break;
    end
    
    if fRefVelZ(ii) ~=0 && (fRefVelZ(ii+1) == 0 || (abs(fRefVelZ(ii+1) - fRefVelZ(ii)) < 0.01)) ...
            && idxStartMove1stBondSearchHeight ~= 0 && idxEndMove1stBondSearchHeight == 0
        idxEndMove1stBondSearchHeight = ii;
        f1stBondSearchHeight_Z = fRefPosnZ(ii);
    end
    if (fFeedPosnZ(ii) ~= fRefPosnZ(ii)) && (fFeedPosnZ(ii +1) == fRefPosnZ(ii +1)) && idxEndMove1stBondSearchHeight ~= 0 && idxStart1stBondForceCtrl == 0
        idxStart1stBondForceCtrl = ii;
        f1stBondContactPosn_Z = fRefPosnZ(ii);
    end
    if fRefVelZ(ii) ~=0 && ( fRefVelZ(ii+1) == fRefVelZ(ii)) && idxEnd1stBondForceCtrl ~= 0 && idxStart2ndBondSearchContact == 0
        idxStart2ndBondSearchContact = ii;
        f2ndBondStartSearchContact_Z = fRefPosnZ(ii);
    end
end

%%%
if idxStartMove1stBondSearchHeight == 0 || idxEnd1stBondForceCtrl == 0  || idxStart2ndBondForceCtrl == 0 || idxEnd2ndBondForceCtrl == 0 %% 20100726
    return; % stAnalyzeOneWire;
else
    stAnalyzeOneWire.iFlagHasWireInfo = 1;
end

if (idxStart2ndBondSearchContact >= idxStart2ndBondForceCtrl || idxStart2ndBondSearchContact == 0)
    stAnalyzeOneWire.iFlagIsDryRun = 1;
    if(idxStart2ndBondSearchContact == 0)
        idxStart2ndBondSearchContact = idxStart2ndBondForceCtrl;
    end

else
    stAnalyzeOneWire.iFlagIsDryRun = 0;
end


 %%% Motion After 1st Bond and Before going to reset level
idxMotionAft1stBond = 1;
astBondHeadMotionAft1stBond(idxMotionAft1stBond).idxStartMotion = 0;
astBondHeadMotionAft1stBond(idxMotionAft1stBond).idxEndMotion = 0;
astBondHeadMotionAft1stBond(idxMotionAft1stBond).fMotionTargetPosn = 0;

for ii = idxEnd1stBondForceCtrl:1:tLen-2
    if fRefVelZ(ii)==0 && fRefVelZ(ii+1) ~= 0 && fRefVelZ(ii+2) ~= fRefVelZ(ii+1) && astBondHeadMotionAft1stBond(idxMotionAft1stBond).idxStartMotion == 0 ...
            && (ii <= idxStart2ndBondSearchContact || ii >= idxEnd2ndBondForceCtrl)
        astBondHeadMotionAft1stBond(idxMotionAft1stBond).idxStartMotion = ii;
    end
    %% either stop motion or jogging
    if fRefVelZ(ii)~=0 && (fRefVelZ(ii+1) == 0 || fRefVelZ(ii+2) == fRefVelZ(ii+1)) && ...
            astBondHeadMotionAft1stBond(idxMotionAft1stBond).idxStartMotion ~= 0 && astBondHeadMotionAft1stBond(idxMotionAft1stBond).idxEndMotion == 0 ...
               && (ii <= idxStart2ndBondSearchContact || ii >= idxEnd2ndBondForceCtrl)

        astBondHeadMotionAft1stBond(idxMotionAft1stBond).idxEndMotion = ii + 1;
        astBondHeadMotionAft1stBond(idxMotionAft1stBond).fMotionTargetPosn = fRefPosnZ(ii+1);
        %%%
        if astBondHeadMotionAft1stBond(idxMotionAft1stBond).fMotionTargetPosn == fStartFireLevel_Z
            break;
        else
            idxMotionAft1stBond = idxMotionAft1stBond + 1;
            astBondHeadMotionAft1stBond(idxMotionAft1stBond).idxStartMotion = 0;
            astBondHeadMotionAft1stBond(idxMotionAft1stBond).idxEndMotion = 0;
            astBondHeadMotionAft1stBond(idxMotionAft1stBond).fMotionTargetPosn = 0;
        end
    end
end
nBondHeadMotionAfter1stBond = idxMotionAft1stBond;
idxEndOneWireZ = astBondHeadMotionAft1stBond(nBondHeadMotionAfter1stBond).idxEndMotion;
% astBondHeadMotionAft1stBond(1)
% astBondHeadMotionAft1stBond(2)
% fStartFireLevel_Z

%%% 
for ii = idxEnd1stBondForceCtrl:1:idxEndOneWireZ-1
 %%%   
    if fRefVelZ(ii)==0 && fRefVelZ(ii+1) ~= 0 && idxEnd1stBondForceCtrl ~= 0 && idxStartReverseHeight == 0
        idxStartReverseHeight = ii;
    end
    if fRefVelZ(ii) ~=0 && fRefVelZ(ii+1) == 0 && idxStartReverseHeight ~= 0 && idxEndReverseHeight == 0
        idxEndReverseHeight = ii +1;
        fReverseHeightPosn_Z = fRefPosnZ(ii+1);
    end
    if fRefVelZ(ii)==0 && fRefVelZ(ii+1) ~= 0 && idxEndReverseHeight ~= 0 && idxStartKinkHeight == 0
        idxStartKinkHeight = ii;
    end
    if fRefVelZ(ii) ~=0 && fRefVelZ(ii+1) == 0 && idxStartKinkHeight ~= 0 && idxEndKinkHeight == 0
        idxEndKinkHeight = ii + 1;
        fKinkHeightPosn_Z = fRefPosnZ(ii+1);
    end
    if fRefVelZ(ii)==0 && fRefVelZ(ii+1) ~= 0 && idxEndKinkHeight ~= 0 && idxStartMoveLoopTop == 0
        idxStartMoveLoopTop = ii;
    end
    if fRefVelZ(ii) ~=0 && fRefVelZ(ii+1) == 0 && idxStartMoveLoopTop~= 0 && idxEndMoveLoopTop == 0
        idxEndMoveLoopTop = ii + 1;
        fLoopTopPosn_Z = fRefPosnZ(ii+1);
    end
    if fRefVelZ(ii)==0 && fRefVelZ(ii+1) ~= 0 && idxEndMoveLoopTop ~= 0 && idxStartTrajectory == 0
        if ii > idxEnd2ndBondForceCtrl
            idxStartTrajectory = idxStartMoveLoopTop;
            idxEndTrajectory2ndBondSearchHeight = idxStart2ndBondSearchContact;
            f2ndBondSearchHeightPosn_Z = fRefPosnZ(idxStart2ndBondSearchContact);
            %%%
            idxStartMoveLoopTop = idxStartKinkHeight;
            idxEndMoveLoopTop = idxEndKinkHeight;
            fLoopTopPosn_Z = fKinkHeightPosn_Z;
            %% post correction
            idxStartKinkHeight = idxEndReverseHeight;
            idxEndKinkHeight = idxEndReverseHeight;
            fKinkHeightPosn_Z = fReverseHeightPosn_Z; 
        else
            idxStartTrajectory = ii;
        end
    end
    if fRefVelZ(ii) ~=0 && (fRefVelZ(ii+1) == 0 || fRefVelZ(ii+1) == fRefVelZ(ii)) && idxStartTrajectory~=0 && idxEndTrajectory2ndBondSearchHeight == 0
        idxEndTrajectory2ndBondSearchHeight = ii;
        f2ndBondSearchHeightPosn_Z = fRefPosnZ(ii);
    end
    if fRefVelZ(ii)==0 && fRefVelZ(ii+1) ~= 0 && idxEnd2ndBondForceCtrl ~= 0 && idxEndTrajectory2ndBondSearchHeight~= 0 && idxStartTail == 0
        idxStartTail = ii;
    end
    if fRefVelZ(ii) ~=0 && fRefVelZ(ii+1) == 0 && idxStartTail~= 0 && idxEndTail == 0
        idxEndTail = ii + 1;
        fTailPosn_Z = fRefPosnZ(ii+1);
    end
    if fRefVelZ(ii)==0 && fRefVelZ(ii+1) ~= 0 && idxEndTail ~= 0 && idxStartFireLevel == 0
        idxStartFireLevel = ii;
    end
    if fRefVelZ(ii) ~=0 && fRefVelZ(ii+1) == 0 && idxStartFireLevel~= 0 && idxEndFireLevel == 0
        idxEndFireLevel = ii + 1;
        fEndFireLevel_Z = fRefPosnZ(ii+1);
    end
end

%% -1 : moving down
%% 1: Moving up
%% +: Undershoot
%% -: Overshoot
stBondHeadPerformance.f1stBondMoveToSearchHeightOverUnderShoot = (fRefPosnZ(idxEndMove1stBondSearchHeight) - fFeedPosnZ(idxEndMove1stBondSearchHeight)) * (-1);
af1stBondForceCtrlFbPosn = fFeedPosnZ(idxStart1stBondForceCtrl:idxEnd1stBondForceCtrl);
stBondHeadPerformance.f1stBondForceCtrlPosnRipplePtoP = max(af1stBondForceCtrlFbPosn) - min(af1stBondForceCtrlFbPosn);
stBondHeadPerformance.f1stBondForceCtrlPosnRippleStd = std(af1stBondForceCtrlFbPosn);
stBondHeadPerformance.af1stBondForceCtrlFbPosn = af1stBondForceCtrlFbPosn;

stBondHeadPerformance.fReverseHeightOverUnderShoot = fRefPosnZ(idxEndReverseHeight) - fFeedPosnZ(idxEndReverseHeight);
stBondHeadPerformance.fKinkHeightOverUnderShoot = (fRefPosnZ(idxEndKinkHeight) - fFeedPosnZ(idxEndKinkHeight)) * sign(fRefVelZ(idxEndKinkHeight - 1));
stBondHeadPerformance.fLoopTopOverUnderShoot = fRefPosnZ(idxEndMoveLoopTop) - fFeedPosnZ(idxEndMoveLoopTop);
stBondHeadPerformance.f2ndBondMoveToSearchHeightOverUnderShoot = (fRefPosnZ(idxEndTrajectory2ndBondSearchHeight) - fFeedPosnZ(idxEndTrajectory2ndBondSearchHeight))*(-1);
stBondHeadPerformance.fTailOverUnderShoot = fRefPosnZ(idxEndTail) - fFeedPosnZ(idxEndTail);
stBondHeadPerformance.fEndFireLevelOverUnderShoot = fRefPosnZ(idxEndFireLevel) - fFeedPosnZ(idxEndFireLevel);

af2ndBondForceCtrlFbPosn = fFeedPosnZ(idxStart2ndBondForceCtrl:idxEnd2ndBondForceCtrl);
stBondHeadPerformance.f2ndBondForceCtrlPosnRipplePtoP = max(af2ndBondForceCtrlFbPosn) - min(af2ndBondForceCtrlFbPosn);
stBondHeadPerformance.f2ndBondForceCtrlPosnRippleStd = std(af2ndBondForceCtrlFbPosn);
stBondHeadPerformance.af2ndBondForceCtrlFbPosn = af2ndBondForceCtrlFbPosn;


%%%% Table
%% StartPosition: Table_X, Table_Y
%% FireLevel_Z
%% 1stBondPosition, Table_X, Table_Y
%% 1stSrchHeight_Z
%% 1stBondReverseHeight
%% 1stBondReverseDist, 1stBondReversePosition, Table_X, Table_Y
%% 1stBondKinkHeight
%% 1stBondLoopTop
%% 1stBondMoveTo2ndBondPosition, Trajectory Table_X, Table_Y
%% TrajectoryEndHeight_Z = 2ndBond_Search_Height
%% 2ndBondEndTailHeight
%% 2ndBondEndFireLevel

idxStartMoveX1stBond = 0;
idxStartMoveY1stBond = 0;
idxEndMoveX_1stBondPosn = 0;
idxEndMoveY_1stBondPosn = 0;
idxStartReverseMoveX = 0;
idxStartReverseMoveY = 0;
idxEndReverseMoveX = 0;
idxEndReverseMoveY = 0;
idxStartTrajTo2ndBondX = 0;
idxStartTrajTo2ndBondY = 0;
idxEndTraj2ndBondPosnX = 0;
idxEndTraj2ndBondPosnY = 0;
idxStartMoveNextWirePR_X = 0;
idxStartMoveNextWirePR_X = 0;
idxEndMoveNextWirePR_X = 0;
idxEndMoveNextWirePR_X = 0;
idxStartMoveNextPR_X = 0;
idxEndMoveNextPR_X = 0;
idxStartMoveNextPR_Y = 0;
idxEndMoveNextPR_Y = 0;

fStartPosition_X	=	0;
fStartPosition_Y	=	0;
f1stBondPosition_X	=	0;
f1stBondPosition_Y	=	0;
f1stBondReversePosition_X	=	0;
f1stBondReversePosition_Y	=	0;
fTrajEnd2ndBondPosn_X	=	0;
fTrajEnd2ndBondPosn_Y	=	0;
fMoveToNextPR_Posn_X	=	0;
fMoveToNextPR_Posn_Y	=	0;

ii = idxStartOneWireXY; %% :1:idxEndOneWireZ-1
while ii < tLen && (idxEndMoveNextPR_Y == 0 || idxEndMoveNextPR_X == 0) %% idxEndOneWireZ-1
    if fRefVelX(ii) == 0 && fRefVelX(ii+1) ~= 0 && idxStartMoveX1stBond == 0
        idxStartMoveX1stBond = ii;
        fStartPosition_X = fRefPosnX(ii);
    end
    if fRefVelY(ii) == 0 && fRefVelY(ii+1) ~= 0 && idxStartMoveY1stBond == 0
        idxStartMoveY1stBond = ii;
        fStartPosition_Y = fRefPosnY(ii);
    end
    if fRefVelX(ii) ~= 0 && fRefVelX(ii+1) == 0 && idxStartMoveX1stBond ~=0 && idxEndMoveX_1stBondPosn == 0
        idxEndMoveX_1stBondPosn = ii + 1;
        f1stBondPosition_X = fRefPosnX(ii+1);
    end
    if fRefVelY(ii) ~= 0 && fRefVelY(ii+1) == 0 && idxStartMoveY1stBond ~=0 && idxEndMoveY_1stBondPosn == 0
        idxEndMoveY_1stBondPosn = ii + 1;
        f1stBondPosition_Y = fRefPosnY(ii+1);
    end
    if fRefVelX(ii) == 0 && fRefVelX(ii+1) ~= 0 && idxEndMoveX_1stBondPosn ~= 0 && idxStartReverseMoveX == 0
        idxStartReverseMoveX = ii;
    end
    if fRefVelY(ii) == 0 && fRefVelY(ii+1) ~= 0 && idxEndMoveY_1stBondPosn ~= 0 && idxStartReverseMoveY == 0
        idxStartReverseMoveY = ii;
    end
    if fRefVelX(ii) ~= 0 && fRefVelX(ii+1) == 0 && idxStartReverseMoveX ~= 0 && idxEndReverseMoveX == 0
        idxEndReverseMoveX = ii + 1;
        f1stBondReversePosition_X = fRefPosnX(ii+1);
    end
    if fRefVelY(ii) ~= 0 && fRefVelY(ii+1) == 0 && idxStartReverseMoveY ~= 0 && idxEndReverseMoveY == 0
        idxEndReverseMoveY = ii + 1;
        f1stBondReversePosition_Y = fRefPosnY(ii+1);
    end
    if fRefVelX(ii) == 0 && fRefVelX(ii+1) ~= 0 && idxEndReverseMoveX ~= 0 && idxStartTrajTo2ndBondX == 0
        idxStartTrajTo2ndBondX = ii;
    end
    if fRefVelY(ii) == 0 && fRefVelY(ii+1) ~= 0 && idxEndReverseMoveY ~= 0 && idxStartTrajTo2ndBondY == 0
        idxStartTrajTo2ndBondY = ii;
    end
    if fRefVelX(ii) ~= 0 && fRefVelX(ii+1) == 0 && idxStartTrajTo2ndBondX ~= 0 && idxEndTraj2ndBondPosnX == 0
        idxEndTraj2ndBondPosnX = ii + 1;
        fTrajEnd2ndBondPosn_X = fRefPosnX(ii+1);
    end
    if fRefVelY(ii) ~= 0 && fRefVelY(ii+1) == 0 && idxStartTrajTo2ndBondY ~= 0 && idxEndTraj2ndBondPosnY == 0
        idxEndTraj2ndBondPosnY = ii + 1;
        fTrajEnd2ndBondPosn_Y = fRefPosnY(ii+1);
    end
    if fRefVelX(ii) == 0 && fRefVelX(ii+1) ~= 0 && idxEndTraj2ndBondPosnX ~= 0 && idxStartMoveNextPR_X == 0
        idxStartMoveNextPR_X = ii;
    end
    if fRefVelY(ii) == 0 && fRefVelY(ii+1) ~= 0 && idxEndTraj2ndBondPosnY ~= 0 && idxStartMoveNextPR_Y == 0
        idxStartMoveNextPR_Y = ii;
    end
    if fRefVelX(ii) ~= 0 && fRefVelX(ii+1) == 0 && idxStartMoveNextPR_X ~= 0 && idxEndMoveNextPR_X == 0
        idxEndMoveNextPR_X = ii + 1;
        fMoveToNextPR_Posn_X = fRefPosnX(ii+1);
    end
    if fRefVelY(ii) ~= 0 && fRefVelY(ii+1) == 0 && idxStartMoveNextPR_Y ~= 0 && idxEndMoveNextPR_Y == 0
        idxEndMoveNextPR_Y = ii + 1;
        fMoveToNextPR_Posn_Y = fRefPosnY(ii+1);
    end
    ii = ii + 1;
end


%%%% Motion Performance, CEOUS: CommandEndOverUnderShoot, 
%%%% MaxDPE: Maximum Dynamic Position Error
fPosnErrX = fRefPosnX - fFeedPosnX;
stTableXPerformance.afMaxDPE_MoveTo1stBondPosn_BTO = [max(fPosnErrX(idxStartMoveX1stBond:idxEndMoveX_1stBondPosn)), min(fPosnErrX(idxStartMoveX1stBond:idxEndMoveX_1stBondPosn))];
stTableXPerformance.fCEOUS_MoveTo1stBondPosn_BTO = fPosnErrX(idxEndMoveX_1stBondPosn + 1) * sign(f1stBondPosition_X - fStartPosition_X);
stTableXPerformance.afMaxDPE_MoveToKink1 = [max(fPosnErrX(idxStartReverseMoveX:idxEndReverseMoveX)), min(fPosnErrX(idxStartReverseMoveX:idxEndReverseMoveX))];
stTableXPerformance.fCEOUS_MoveToKink1 = fPosnErrX(idxEndReverseMoveX + 1) * sign(f1stBondReversePosition_X - f1stBondPosition_X);
stTableXPerformance.afMaxDPE_TrajMoveTo2ndBond = [max(fPosnErrX(idxStartTrajTo2ndBondX:idxEndTraj2ndBondPosnX)), min(fPosnErrX(idxStartTrajTo2ndBondX:idxEndTraj2ndBondPosnX))];
stTableXPerformance.fCEOUS_TrajMoveTo2ndBond = fPosnErrX(idxEndTraj2ndBondPosnX + 1) * sign(fTrajEnd2ndBondPosn_X - f1stBondReversePosition_X);

stTableXPerformance.fStD1_StaticPE_TillEnd1stBond = std(fPosnErrX((idxEndMoveX_1stBondPosn+1):idxEnd1stBondForceCtrl), 1);
stTableXPerformance.fStD1_StaticPE_TillEnd2ndBond = std(fPosnErrX((idxEndTraj2ndBondPosnX+1):idxEnd2ndBondForceCtrl), 1);
stTableXPerformance.fStD1_StaticPE_AftMove1stBond = std(fPosnErrX((idxEndMoveX_1stBondPosn+1):(idxEndMoveX_1stBondPosn + 8)), 1);
stTableXPerformance.fStD1_StaticPE_AftMove2ndBond = std(fPosnErrX((idxEndTraj2ndBondPosnX+1):(idxEndTraj2ndBondPosnX + 8)), 1);
stTableXPerformance.fStD1_StaticPE_During1stBond = std(fPosnErrX((idxStart1stBondForceCtrl+1):idxEnd1stBondForceCtrl), 1);
stTableXPerformance.fStD1_StaticPE_During2ndBond = std(fPosnErrX((idxStart2ndBondForceCtrl+1):idxEnd2ndBondForceCtrl), 1);
stTableXPerformance.fDiffStD1_StaticPE_TillEnd1stBond = std(diff(fPosnErrX((idxEndMoveX_1stBondPosn+1):idxEnd1stBondForceCtrl)), 1);
stTableXPerformance.fDiffStD1_StaticPE_TillEnd2ndBond = std(diff(fPosnErrX((idxEndTraj2ndBondPosnX+1):idxEnd2ndBondForceCtrl)), 1);
stTableXPerformance.fDiffStD1_StaticPE_AftMove1stBond = std(diff(fPosnErrX((idxEndMoveX_1stBondPosn+1):(idxEndMoveX_1stBondPosn + 8))), 1);
stTableXPerformance.fDiffStD1_StaticPE_AftMove2ndBond = std(diff(fPosnErrX((idxEndTraj2ndBondPosnX+1):(idxEndTraj2ndBondPosnX + 8))), 1);
stTableXPerformance.fDiffStD1_StaticPE_During1stBond = std(diff(fPosnErrX((idxStart1stBondForceCtrl+1):idxEnd1stBondForceCtrl)), 1);
stTableXPerformance.fDiffStD1_StaticPE_During2ndBond = std(diff(fPosnErrX((idxStart2ndBondForceCtrl+1):idxEnd2ndBondForceCtrl)), 1);

if idxEndMoveNextPR_X ~= 0
    stTableXPerformance.afMaxDPE_MoveToNextPR = [max(fPosnErrX(idxStartMoveNextPR_X:idxEndMoveNextPR_X)), min(fPosnErrX(idxStartMoveNextPR_X:idxEndMoveNextPR_X))];
    stTableXPerformance.fCEOUS_MoveToNextPR = fPosnErrX(idxEndMoveNextPR_X + 1) * sign(fMoveToNextPR_Posn_X - fTrajEnd2ndBondPosn_X);
else
    stTableXPerformance.afMaxDPE_MoveToNextPR = [0, 0];
    stTableXPerformance.fCEOUS_MoveToNextPR = 0;
    fMoveToNextPR_Posn_X = fTrajEnd2ndBondPosn_X;
end
%%%%% Table-Y
fPosnErrY = fRefPosnY - fFeedPosnY;
stTableYPerformance.afMaxDPE_MoveTo1stBondPosn_BTO = [max(fPosnErrY(idxStartMoveY1stBond:idxEndMoveY_1stBondPosn)), min(fPosnErrY(idxStartMoveY1stBond:idxEndMoveY_1stBondPosn))];
stTableYPerformance.fCEOUS_MoveTo1stBondPosn_BTO = fPosnErrY(idxEndMoveY_1stBondPosn + 1) * sign(f1stBondPosition_Y - fStartPosition_Y);
stTableYPerformance.afMaxDPE_MoveToKink1 = [max(fPosnErrY(idxStartReverseMoveY:idxEndReverseMoveY)), min(fPosnErrY(idxStartReverseMoveY:idxEndReverseMoveY))];
stTableYPerformance.fCEOUS_MoveToKink1 = fPosnErrY(idxEndReverseMoveY + 1) * sign(f1stBondReversePosition_Y - f1stBondPosition_Y);
stTableYPerformance.afMaxDPE_TrajMoveTo2ndBond = [max(fPosnErrY(idxStartTrajTo2ndBondY:idxEndTraj2ndBondPosnY)), min(fPosnErrY(idxStartTrajTo2ndBondY:idxEndTraj2ndBondPosnY))];
stTableYPerformance.fCEOUS_TrajMoveTo2ndBond = fPosnErrY(idxEndTraj2ndBondPosnY + 1) * sign(fTrajEnd2ndBondPosn_Y - f1stBondReversePosition_Y);

stTableYPerformance.fStD1_StaticPE_AftMove1stBond = std(fPosnErrY((idxEndMoveY_1stBondPosn+1):(idxEndMoveY_1stBondPosn + 8)), 1);
stTableYPerformance.fStD1_StaticPE_AftMove2ndBond = std(fPosnErrY((idxEndTraj2ndBondPosnY+1):(idxEndTraj2ndBondPosnY + 8)), 1);
stTableYPerformance.fStD1_StaticPE_TillEnd1stBond = std(fPosnErrY((idxEndMoveY_1stBondPosn+1):idxEnd1stBondForceCtrl), 1);
stTableYPerformance.fStD1_StaticPE_TillEnd2ndBond = std(fPosnErrY((idxEndTraj2ndBondPosnY+1):idxEnd2ndBondForceCtrl), 1);
stTableYPerformance.fStD1_StaticPE_During1stBond = std(fPosnErrY((idxStart1stBondForceCtrl+1):idxEnd1stBondForceCtrl), 1);
stTableYPerformance.fStD1_StaticPE_During2ndBond = std(fPosnErrY((idxStart2ndBondForceCtrl+1):idxEnd2ndBondForceCtrl), 1);

if idxEndMoveNextPR_Y ~= 0
    stTableYPerformance.afMaxDPE_MoveToNextPR = [max(fPosnErrY(idxStartMoveNextPR_Y:idxEndMoveNextPR_Y)), min(fPosnErrY(idxStartMoveNextPR_Y:idxEndMoveNextPR_Y))];
    stTableYPerformance.fCEOUS_MoveToNextPR = fPosnErrY(idxEndMoveNextPR_Y + 1) * sign(fMoveToNextPR_Posn_Y - fTrajEnd2ndBondPosn_Y);
else
    stTableYPerformance.afMaxDPE_MoveToNextPR = [0, 0];
    stTableYPerformance.fCEOUS_MoveToNextPR = 0;
    fMoveToNextPR_Posn_Y = fTrajEnd2ndBondPosn_Y;
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

stAnalyzeOneWire.stPosnsOfBondHeadZ.fStartFireLevel_Z = fStartFireLevel_Z;
stAnalyzeOneWire.stPosnsOfBondHeadZ.f1stBondSearchHeight_Z = f1stBondSearchHeight_Z;
stAnalyzeOneWire.stPosnsOfBondHeadZ.f1stBondContactPosn_Z = f1stBondContactPosn_Z;
stAnalyzeOneWire.stPosnsOfBondHeadZ.fReverseHeightPosn_Z = fReverseHeightPosn_Z;
stAnalyzeOneWire.stPosnsOfBondHeadZ.fKinkHeightPosn_Z = fKinkHeightPosn_Z;
stAnalyzeOneWire.stPosnsOfBondHeadZ.fLoopTopPosn_Z = fLoopTopPosn_Z;
stAnalyzeOneWire.stPosnsOfBondHeadZ.f2ndBondSearchHeightPosn_Z = f2ndBondSearchHeightPosn_Z;
stAnalyzeOneWire.stPosnsOfBondHeadZ.f2ndBondContactPosn_Z = f2ndBondContactPosn_Z;
stAnalyzeOneWire.stPosnsOfBondHeadZ.fTailPosn_Z = fTailPosn_Z;
stAnalyzeOneWire.stPosnsOfBondHeadZ.fEndFireLevel_Z = fEndFireLevel_Z;
stAnalyzeOneWire.stPosnsOfBondHeadZ.f2ndBondStartSearchContact_Z = f2ndBondStartSearchContact_Z;

stAnalyzeOneWire.astBondHeadMotionAft1stBond = astBondHeadMotionAft1stBond;

stAnalyzeOneWire.stBondHeadPerformance = stBondHeadPerformance;

stAnalyzeOneWire.stPosnsOfTable.fStartPosition_X = fStartPosition_X;
stAnalyzeOneWire.stPosnsOfTable.fStartPosition_Y = fStartPosition_Y;
stAnalyzeOneWire.stPosnsOfTable.f1stBondPosition_X = f1stBondPosition_X;
stAnalyzeOneWire.stPosnsOfTable.f1stBondPosition_Y = f1stBondPosition_Y;
stAnalyzeOneWire.stPosnsOfTable.f1stBondReversePosition_X = f1stBondReversePosition_X;
stAnalyzeOneWire.stPosnsOfTable.f1stBondReversePosition_Y = f1stBondReversePosition_Y;
stAnalyzeOneWire.stPosnsOfTable.fTrajEnd2ndBondPosn_X = fTrajEnd2ndBondPosn_X;
stAnalyzeOneWire.stPosnsOfTable.fTrajEnd2ndBondPosn_Y = fTrajEnd2ndBondPosn_Y;
stAnalyzeOneWire.stPosnsOfTable.fMoveToNextPR_Posn_X = fMoveToNextPR_Posn_X;
stAnalyzeOneWire.stPosnsOfTable.fMoveToNextPR_Posn_Y = fMoveToNextPR_Posn_Y;

stAnalyzeOneWire.stTimePointsOfTable.idxStartMoveX1stBond = idxStartMoveX1stBond;
stAnalyzeOneWire.stTimePointsOfTable.idxStartMoveY1stBond = idxStartMoveY1stBond;
stAnalyzeOneWire.stTimePointsOfTable.idxEndMoveX_1stBondPosn = idxEndMoveX_1stBondPosn;
stAnalyzeOneWire.stTimePointsOfTable.idxEndMoveY_1stBondPosn = idxEndMoveY_1stBondPosn;
stAnalyzeOneWire.stTimePointsOfTable.idxStartReverseMoveX = idxStartReverseMoveX;
stAnalyzeOneWire.stTimePointsOfTable.idxStartReverseMoveY = idxStartReverseMoveY;
stAnalyzeOneWire.stTimePointsOfTable.idxEndReverseMoveX = idxEndReverseMoveX;
stAnalyzeOneWire.stTimePointsOfTable.idxEndReverseMoveY = idxEndReverseMoveY;
stAnalyzeOneWire.stTimePointsOfTable.idxStartTrajTo2ndBondX = idxStartTrajTo2ndBondX;
stAnalyzeOneWire.stTimePointsOfTable.idxStartTrajTo2ndBondY = idxStartTrajTo2ndBondY;
stAnalyzeOneWire.stTimePointsOfTable.idxEndTraj2ndBondPosnX = idxEndTraj2ndBondPosnX;
stAnalyzeOneWire.stTimePointsOfTable.idxEndTraj2ndBondPosnY = idxEndTraj2ndBondPosnY;

stAnalyzeOneWire.stTimePointsOfTable.idxStartMoveNextPR_X = idxStartMoveNextPR_X;
stAnalyzeOneWire.stTimePointsOfTable.idxEndMoveNextPR_X = idxEndMoveNextPR_X;
stAnalyzeOneWire.stTimePointsOfTable.idxStartMoveNextPR_Y = idxStartMoveNextPR_Y;
stAnalyzeOneWire.stTimePointsOfTable.idxEndMoveNextPR_Y = idxEndMoveNextPR_Y;


stAnalyzeOneWire.stTableXPerformance = stTableXPerformance;
stAnalyzeOneWire.stTableYPerformance = stTableYPerformance;
stAnalyzeOneWire.idxEndOneWireZ = idxEndOneWireZ;
stAnalyzeOneWire.idxEndOneWireXY = idxEndTraj2ndBondPosnX;
