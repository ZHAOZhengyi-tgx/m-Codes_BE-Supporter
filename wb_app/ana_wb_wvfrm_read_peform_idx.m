function stWbPeformance = ana_wb_wvfrm_read_peform_idx(strFullPathFilename)

stWbPeformance.stPerformanceBH = [];
stWbPeformance.stPerformanceTable = [];
stWbPeformance.stSpeedBH = [];
stWbPeformance.stSpeedXY = [];
stWbPeformance.stTimeIndex = [];

%% Bond Head Performance
strHeader1stSrchContactTH = 'f1stContactTH';  %% f1stSrchPosnErr
strHeader1stSrchPosnErr = 'af1stSrchPosnErr';

strHeader2ndSrchContactTH = 'f2ndContactTH';  %% af2ndSrchPosnErr
strHeader2ndSrchPosnErr = 'af2ndSrchPosnErr';

strHeader1stSrchVelErr = 'af1stSrchVelErr_fm_';
strHeader2ndSrchVelErr = 'af2ndSrchVelErr_fm_';

strHeaderDeform1stB = 'aTimeDeform_DrvInBond_1stB';
strHeaderDeform2ndB = 'aTimeDeform_DrvInBond_2ndB';

%%% Objs
% Mv1stSrcHt_OUS_Obj_cFrom_cTo= [ -5,  1511, -3959, -8392]; % @ Dist_um =-4433, tDur_ms = 13.0, Time [40, 66]; 
% Traj2ndB_fOUS_dObj_cFrom_cTo = [-18,  738, -6696, -7800]; % @ Dist_um =-1105, tDur_ms = 14.5, Time [166, 195]; 
% f1stSearchSpd = -15.0, aErr_P2P_AccRMS = [10.0, 7.1]; % Time [66, 94], dObj=28114.8 , tDur_ms = 14.0;
% f2ndSearch: Spd = -20.0, Err(P2P,RMS-Acc) = (22.0, 6.5); % Time [199, 220], dObj=41053.6, tDur_ms = 10.5;  
% Tail_fOUS_dObj_cFrom_cTo= [ -6, 2555, -7984.7, -7838.5]; % @ Dist_um =146, tDur_ms = 3.0, aTime =[267, 273];  
% ResetFL_fOUS_dObj_cFrom_cTo = [ 39, 828, -7838.5, -3959.0]; % @ Dist_um =3879, tDur_ms = 8.0, Time [274, 290]; 
strHeaderMv1stSrcHt = 'SrcHt_';
strHeaderTraj2ndB = 'Traj2ndB_fOUS_';
strHeader1stSearch = '1stSearchSpd =';
strHeader2ndSearch = '2ndSearch: ';
strHeaderTail = 'Tail';
strHeaderResetFL = 'ResetFL';

%% Table Performance
strHeaderSettlingTblX_1stB = 'afPosnErrTblX_Contact1B_P2P_MaxAbs';
strHeaderSettlingTblX_2ndB = 'afPosnErrTblX_Contact2B_P2P_MaxAbs';

strHeaderSettlingTblY_1stB = 'afPosnErrTblY_Contact1B_P2P_MaxAbs';
strHeaderSettlingTblY_2ndB = 'afPosnErrTblY_Contact2B_P2P_MaxAbs';

stPerformanceBH = [];
stPerformanceTable = [];
stPerformanceBH.dObjMove1stSrchHt = -1;
stPerformanceBH.dObjMoveTail = -1;
stPerformanceBH.dObjTraj2ndB = -1;
stPerformanceBH.dObjMoveReset = -1;
stPerformanceBH.aTimeDeform_DrvInBond_1stB = [-1, -1, -1, -1];
stPerformanceBH.aTimeDeform_DrvInBond_2ndB = [-1, -1, -1, -1];

fptr = fopen(strFullPathFilename);

while ~feof(fptr)
    strLine = fgets(fptr);
    if length(strLine) >= 34
        if isempty(strfind(strLine, strHeader1stSrchPosnErr)) == 0 %%strLine(1:length(strHeader1stSrchContactTH)) == strHeader1stSrchContactTH
            eval(strLine);
            stPerformanceBH.af1stSrchPosnErr = af1stSrchPosnErr;
        elseif isempty(strfind(strLine, strHeader2ndSrchPosnErr)) == 0 %% strLine(1:length(strHeader2ndSrchPosnErr)) == strHeader2ndSrchPosnErr
            eval(strLine);
            stPerformanceBH.af2ndSrchPosnErr = af2ndSrchPosnErr;
        
            %%strHeaderMv1stSrcHt = 'SrcHt_';
        elseif isempty(strfind(strLine, strHeaderMv1stSrcHt)) == 0 && isempty(strfind(strLine, 'MMS')) == 1
%             disp(strLine);
            eval(strLine);
            if(exist('Move1stSrcHt_fOUS_dObj_cFrom_cTo'))
                stPerformanceBH.dObjMove1stSrchHt = Move1stSrcHt_fOUS_dObj_cFrom_cTo(2);
            elseif  exist('Mv1stSrcHt_OUS_Obj_cFrom_cTo') 
                stPerformanceBH.dObjMove1stSrchHt = Mv1stSrcHt_OUS_Obj_cFrom_cTo(2);
            else
                stPerformanceBH.dObjMove1stSrchHt = -1;
            end
            
            %% strHeaderTraj2ndB = 'Traj2ndB';
        elseif isempty(strfind(strLine, strHeaderTraj2ndB)) == 0 && isempty(strfind(strLine, 'MMS')) == 1
             disp(strLine);
             if isempty(strfind(strLine, strHeaderTraj2ndB)) == 0
                eval(strLine);
                stPerformanceBH.dObjTraj2ndB = Traj2ndB_fOUS_dObj_cFrom_cTo(2);
             elseif isempty(strfind(strLine, 'dObjTraj2ndBond')) == 0
                eval(strLine);
                stPerformanceBH.dObjTraj2ndB = dObjTraj2ndBond;
             else
                 stPerformanceBH.dObjTraj2ndB = -1;
             end
            %% strHeader1stSearch = '1stSearch';
        elseif isempty(strfind(strLine, strHeader1stSearch)) == 0 && isempty(strfind(strLine, 'MMS')) == 1 && isempty(strfind(strLine, 'dObj')) == 0
%             disp(strLine);
            nPosnObj = strfind(strLine, 'dObj'); % eval(strLine);
            stPerformanceBH.dObjJogIn1stSearch = sscanf(strLine(nPosnObj(1): end), 'dObj=%f,');
            
            %% strHeader2ndSearch = '2ndSearch';
        elseif isempty(strfind(strLine, strHeader2ndSearch)) == 0 && isempty(strfind(strLine, 'MMS')) == 1 && isempty(strfind(strLine, 'dObj')) == 0
            nPosnObj = strfind(strLine, 'dObj'); % eval(strLine);
            stPerformanceBH.dObjJogIn2ndSearch = sscanf(strLine(nPosnObj(1): end), 'dObj=%f,');
            
            %% strHeaderTail = 'Tail';
        elseif isempty(strfind(strLine, strHeaderTail)) == 0 && isempty(strfind(strLine, 'MMS')) == 1 && isempty(strfind(strLine, 'MaxAcc')) == 1
                disp(strLine)
            if isempty(strfind(strLine, '_dObj_')) == 0
                eval(strLine);
                stPerformanceBH.dObjMoveTail = Tail_fOUS_dObj_cFrom_cTo(2);
            elseif isempty(strfind(strLine, 'dObj')) == 0
                nPosnObj = strfind(strLine, 'dObj'); % eval(strLine);
                stPerformanceBH.dObjMoveTail = sscanf(strLine(nPosnObj(1): end), 'dObj=%f,');  
            else
                stPerformanceBH.dObjMoveTail = -1;
            end
            
            %% strHeaderResetFL = 'ResetFL';
        elseif isempty(strfind(strLine, strHeaderResetFL)) == 0 && isempty(strfind(strLine, 'MMS')) == 1 
            if isempty(strfind(strLine, '_dObj_')) == 0
                eval(strLine);
                stPerformanceBH.dObjMoveReset = ResetFL_fOUS_dObj_cFrom_cTo(2);
            elseif isempty(strfind(strLine, 'dObj')) == 0
                nPosnObj = strfind(strLine, 'dObj'); % eval(strLine);
                stPerformanceBH.dObjMoveReset = sscanf(strLine(nPosnObj(1): end), 'dObj=%f,');              
            else 
                stPerformanceBH.dObjMoveReset = -1;
            end
            
        elseif strLine(1:length(strHeader1stSrchVelErr)) == strHeader1stSrchVelErr 
            nPosnEq = strfind(strLine, '=');
            for jj = length(strHeader1stSrchVelErr) + 1 : 1 : nPosnEq(1) -1
                strLine(jj) = ' ';
            end
            eval(strLine);
%             disp(strLine);
            stPerformanceBH.af1stSrchVelErr = af1stSrchVelErr_fm_;
        elseif strLine(1:length(strHeader2ndSrchVelErr)) == strHeader2ndSrchVelErr
            nPosnEq = strfind(strLine, '=');
            for jj = length(strHeader2ndSrchVelErr) + 1 : 1 : nPosnEq(1) -1
                strLine(jj) = ' ';
            end
            eval(strLine);
%             disp(strLine);
            stPerformanceBH.af2ndSrchVelErr = af2ndSrchVelErr_fm_;
%%%%%            BH deformation
        elseif strLine(1:length(strHeaderDeform1stB)) == strHeaderDeform1stB
            eval(strLine);
            stPerformanceBH.aTimeDeform_DrvInBond_1stB = aTimeDeform_DrvInBond_1stB;
        elseif strLine(1:length(strHeaderDeform2ndB)) == strHeaderDeform2ndB
            eval(strLine);
            stPerformanceBH.aTimeDeform_DrvInBond_2ndB = aTimeDeform_DrvInBond_2ndB;

%%%%%
        elseif strLine(1:length(strHeaderSettlingTblX_1stB)) == strHeaderSettlingTblX_1stB
            eval(strLine);
            stPerformanceTable.afPosnErrTblX_Contact1B_P2P_MaxAbs = afPosnErrTblX_Contact1B_P2P_MaxAbs;

        elseif strLine(1:length(strHeaderSettlingTblX_2ndB)) == strHeaderSettlingTblX_2ndB
            eval(strLine);
            stPerformanceTable.afPosnErrTblX_Contact2B_P2P_MaxAbs = afPosnErrTblX_Contact2B_P2P_MaxAbs;

%%%%%
        elseif strLine(1:length(strHeaderSettlingTblY_1stB)) == strHeaderSettlingTblY_1stB
            eval(strLine);
            stPerformanceTable.afPosnErrTblY_Contact1B_P2P_MaxAbs = afPosnErrTblY_Contact1B_P2P_MaxAbs;

        elseif strLine(1:length(strHeaderSettlingTblY_2ndB)) == strHeaderSettlingTblY_2ndB
            eval(strLine);
            stPerformanceTable.afPosnErrTblY_Contact2B_P2P_MaxAbs = afPosnErrTblY_Contact2B_P2P_MaxAbs;

        else
        end
    end
end

fclose(fptr);

stWbPeformance.stPerformanceBH = stPerformanceBH;
stWbPeformance.stPerformanceTable = stPerformanceTable;
