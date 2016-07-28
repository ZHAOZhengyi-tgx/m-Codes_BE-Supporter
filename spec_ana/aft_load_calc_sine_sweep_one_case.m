function astGroupSineSweepRespCase = aft_load_calc_sine_sweep_one_case(stGroupSineSweepCfg, iCase)
% The MIT License (MIT)
% 
% Copyright (c) 2016 ZHAOZhengyi-tgx
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%
% Zhengyi John ZHAO <zzytgx@gmail.com>
%

global DEF_PLOT_LEVEL_DEBUG_ALL;

iPlotFlag = stGroupSineSweepCfg.iPlotFlag;

    strSineSweepCaseFilepathName = strcat(stGroupSineSweepCfg.stFilePath.strPathname, stGroupSineSweepCfg.astSineSweepCase(iCase).strOneExcitationResponse);
    [stSineSweepInput, matRespSineSweep] = aft_load_one_test_SineSweep_data(strSineSweepCaseFilepathName, stGroupSineSweepCfg.astSineSweepCase(iCase).usExciteLength);
    astGroupSineSweepRespCase.stSineSweepInput = stSineSweepInput;
    astGroupSineSweepRespCase.matRespSineSweep = matRespSineSweep;
    

iExciteAxisCtrlCard = stGroupSineSweepCfg.iExciteAxisCtrlCard;
aiArrayMappingCtrlId = stGroupSineSweepCfg.aiArrayMappingCtrlId;
astMotorControlInfo = stGroupSineSweepCfg.astMotorControlInfo;
iExciteAppAxis = wb_map_axis_acs_2_app(iExciteAxisCtrlCard, stGroupSineSweepCfg.iMachineType); 
fRatioFromDrvCmdToExpectPeakAcc_ExciteAxis = astMotorControlInfo(iExciteAppAxis).fDriverRatio_AmpPerDacCount * astMotorControlInfo(iExciteAppAxis).fForceConst_NewtonPerAmp ...
    / astMotorControlInfo(iExciteAppAxis).fMovingMass_kg;

if iExciteAxisCtrlCard == 0
    aExciteDrvCmd = astGroupSineSweepRespCase.matRespSineSweep(:,4);
    aRespFbVelCurrAxis = astGroupSineSweepRespCase.matRespSineSweep(:,1);
elseif iExciteAxisCtrlCard == 1
    aExciteDrvCmd = astGroupSineSweepRespCase.matRespSineSweep(:,5);
    aRespFbVelCurrAxis = astGroupSineSweepRespCase.matRespSineSweep(:,2);
elseif iExciteAxisCtrlCard == 4
    aExciteDrvCmd = astGroupSineSweepRespCase.matRespSineSweep(:,6);
    aRespFbVelCurrAxis = astGroupSineSweepRespCase.matRespSineSweep(:,3);
else
end
astGroupSineSweepRespCase.stSineSweepExciteResponse.astRespAxis(1).aFbVel = astGroupSineSweepRespCase.matRespSineSweep(:,1);
astGroupSineSweepRespCase.stSineSweepExciteResponse.astRespAxis(2).aFbVel = astGroupSineSweepRespCase.matRespSineSweep(:,2);
astGroupSineSweepRespCase.stSineSweepExciteResponse.astRespAxis(3).aFbVel = astGroupSineSweepRespCase.matRespSineSweep(:,3);
aRespFbPosn = astGroupSineSweepRespCase.matRespSineSweep(:,7);

fExcitAxisRatioFromEncToMM = 1/astMotorControlInfo(iExciteAppAxis).fEncCnt_mm;
aRespFbPosnExAxis_mm = aRespFbPosn * fExcitAxisRatioFromEncToMM;
fPeakToPeakExAxisFbPosn_mm = max(aRespFbPosnExAxis_mm) - min(aRespFbPosnExAxis_mm);

astGroupSineSweepRespCase.stSineSweepExciteResponse.aRespFbPosnExAxis_mm = aRespFbPosnExAxis_mm; 
astGroupSineSweepRespCase.stSineSweepExciteResponse.aExciteDrvCmd = aExciteDrvCmd; 
astGroupSineSweepRespCase.stSineSweepExciteResponse.aRespFbVelCurrAxis = aRespFbVelCurrAxis; 

aRespFbVel_cnt_sample = aRespFbVelCurrAxis/1000 * stGroupSineSweepCfg.fSampleTime_ms;
aRespFbPosnByVel = cumsum(aRespFbVel_cnt_sample); % + aRespFbPosn(1);
astGroupSineSweepRespCase.stSineSweepExciteResponse.aRespFbPosnByVel = aRespFbPosnByVel; %% use velocity reconstruct position, may has better resolution
astGroupSineSweepRespCase.stSineSweepExciteResponse.aRespFbVel_cnt_sample = aRespFbVel_cnt_sample;

fFreqHz = stGroupSineSweepCfg.astSineSweepCase(iCase).fFreqHz;
fSampleTime_ms = stGroupSineSweepCfg.fSampleTime_ms;
[stFourierOutExciteDrvCmd] = aft_calc_discrete_fourier_sine_cosine_amp_phase(aExciteDrvCmd, fFreqHz, fSampleTime_ms);
[stFourierOutRespFbPosn] = aft_calc_discrete_fourier_sine_cosine_amp_phase(aRespFbPosnByVel, fFreqHz, fSampleTime_ms); % aRespFbPosnExAxis_mm, aRespFbPosn
[stFourierOutRespFbVelCurrAxis] = aft_calc_discrete_fourier_sine_cosine_amp_phase(aRespFbVel_cnt_sample, fFreqHz, fSampleTime_ms); %% aRespFbVelCurrAxis

astGroupSineSweepRespCase.stFourierOutExciteDrvCmd = stFourierOutExciteDrvCmd;
astGroupSineSweepRespCase.stFourierOutRespFbPosn = stFourierOutRespFbPosn;
astGroupSineSweepRespCase.stFourierOutRespFbVelCurrAxis = stFourierOutRespFbVelCurrAxis;

stBodeVelToDrv.fMagnitude = stFourierOutRespFbVelCurrAxis.fAmplitude / stFourierOutExciteDrvCmd.fAmplitude;
fPhase_deg = stFourierOutRespFbVelCurrAxis.fPhaseInSine_deg - stFourierOutExciteDrvCmd.fPhaseInSine_deg;
stBodeVelToDrv.fPhase_deg = freq_spectrum_phase_modular(fPhase_deg);
astGroupSineSweepRespCase.stBodeVelToDrv = stBodeVelToDrv;

stBodePosnToDrv.fMagnitude = stFourierOutRespFbPosn.fAmplitude / stFourierOutExciteDrvCmd.fAmplitude;
fPhase_deg = stFourierOutRespFbPosn.fPhaseInSine_deg - stFourierOutExciteDrvCmd.fPhaseInSine_deg;
stBodePosnToDrv.fPhase_deg = freq_spectrum_phase_modular(fPhase_deg);
astGroupSineSweepRespCase.stBodePosnToDrv = stBodePosnToDrv;

%%%% 
aIdxTimeOri = 1:length(astGroupSineSweepRespCase.stSineSweepExciteResponse.aExciteDrvCmd);
aIdxTimeRestruct = 1:length(stFourierOutExciteDrvCmd.afReconstructArray);
if iPlotFlag >= DEF_PLOT_LEVEL_DEBUG_ALL && mod(iCase, 8) == 0
    figure(iCase); 
    subplot(3,1,3); plot(aIdxTimeOri, astGroupSineSweepRespCase.stSineSweepExciteResponse.aRespFbVel_cnt_sample, ...  %% aRespFbVelCurrAxis
        aIdxTimeRestruct, stFourierOutRespFbVelCurrAxis.afReconstructArray);
    strTextAxisX = sprintf('Sample at %5.1f Hz', 1000/stGroupSineSweepCfg.fSampleTime_ms);   xlabel(strTextAxisX);
    ylabel('FbVel');
    strTextTitleVel = sprintf('Mag: %6.1f, Phase: %4.1f deg', stBodeVelToDrv.fMagnitude, stBodeVelToDrv.fPhase_deg);    title(strTextTitleVel);
    subplot(3,1,2); plot(aIdxTimeOri, astGroupSineSweepRespCase.stSineSweepExciteResponse.aRespFbPosnByVel, ...  %% aRespFbPosnExAxis_mm
        aIdxTimeRestruct, stFourierOutRespFbPosn.afReconstructArray);    ylabel('FbPosn');
    strTextTitlePosn = sprintf('Mag: %6.1f, Phase: %4.1f deg, P2P: %6.4fmm', stBodePosnToDrv.fMagnitude, stBodePosnToDrv.fPhase_deg, fPeakToPeakExAxisFbPosn_mm);    
    title(strTextTitlePosn);
    subplot(3,1,1); plot(aIdxTimeOri, astGroupSineSweepRespCase.stSineSweepExciteResponse.aExciteDrvCmd, ...
        aIdxTimeRestruct, stFourierOutExciteDrvCmd.afReconstructArray);    ylabel('DrvCmd');
    strTextTitle = sprintf('at %5.1f Hz', stGroupSineSweepCfg.astSineSweepCase(iCase).fFreqHz); title(strTextTitle);
end

%%% construct the template for cross-spectrum 
for idxExciteAxis = 1:1:3
    for idxResponseAxis = 1:1:3
        if idxExciteAxis ~= idxResponseAxis
            matCrossResponse(idxExciteAxis, idxResponseAxis).aExciteDrvCmd = [];
            matCrossResponse(idxExciteAxis, idxResponseAxis).aResponseVelFb = [];
            matCrossResponse(idxExciteAxis, idxResponseAxis).stFourierOutExciteDrvCmd = [];
        end
    end
end

if iExciteAxisCtrlCard == 0
    matCrossResponse(1, 2).aExciteDrvCmd = aExciteDrvCmd;
    matCrossResponse(1, 2).aResponseVelFb = astGroupSineSweepRespCase.matRespSineSweep(:,2);
    
    matCrossResponse(1, 3).aExciteDrvCmd = aExciteDrvCmd;
    matCrossResponse(1, 3).aResponseVelFb = astGroupSineSweepRespCase.matRespSineSweep(:,3);
elseif iExciteAxisCtrlCard == 1
    matCrossResponse(2, 1).aExciteDrvCmd = aExciteDrvCmd;
    matCrossResponse(2, 1).aResponseVelFb = astGroupSineSweepRespCase.matRespSineSweep(:,1);
    
    matCrossResponse(2, 3).aExciteDrvCmd = aExciteDrvCmd;
    matCrossResponse(2, 3).aResponseVelFb = astGroupSineSweepRespCase.matRespSineSweep(:,3);
elseif iExciteAxisCtrlCard == 4
    matCrossResponse(3, 1).aExciteDrvCmd = aExciteDrvCmd;
    matCrossResponse(3, 1).aResponseVelFb = astGroupSineSweepRespCase.matRespSineSweep(:,1);
    
    matCrossResponse(3, 2).aExciteDrvCmd = aExciteDrvCmd;
    matCrossResponse(3, 2).aResponseVelFb = astGroupSineSweepRespCase.matRespSineSweep(:,2);
else
end



for idxExciteAxis = 1:1:3
    for idxResponseAxis = 1:1:3
        if idxExciteAxis ~= idxResponseAxis
            iResponseAxisCtrlId = aiArrayMappingCtrlId(idxResponseAxis);
            iRespAppAxis = wb_map_axis_acs_2_app(iResponseAxisCtrlId, stGroupSineSweepCfg.iMachineType);
            fRatioFbVel_mm_p_sec = 1/astMotorControlInfo(iRespAppAxis).fEncCnt_mm;
            
            if isempty(matCrossResponse(idxExciteAxis, idxResponseAxis).aExciteDrvCmd)
            else
                matCrossResponse(idxExciteAxis, idxResponseAxis).stFourierOutExciteDrvCmd = stFourierOutExciteDrvCmd;

                %%%% Normlize to ExpectPeakAcc
                aExciteDrvCmd_at_ExpPeakAcc = aExciteDrvCmd * fRatioFromDrvCmdToExpectPeakAcc_ExciteAxis;
                stFourierOutExciteDrvCmd_ExpPeakAcc = aft_calc_discrete_fourier_sine_cosine_amp_phase(aExciteDrvCmd_at_ExpPeakAcc, fFreqHz, fSampleTime_ms); %stFourierOutExciteDrvCmd.
                matCrossResponse(idxExciteAxis, idxResponseAxis).aExciteDrvCmd_at_ExpPeakAcc = aExciteDrvCmd_at_ExpPeakAcc;
                matCrossResponse(idxExciteAxis, idxResponseAxis).stFourierOutExciteDrvCmd_ExpPeakAcc = stFourierOutExciteDrvCmd_ExpPeakAcc;
                
                aResponseNormVelFb_si = matCrossResponse(idxExciteAxis, idxResponseAxis).aResponseVelFb * fRatioFbVel_mm_p_sec;
                matCrossResponse(idxExciteAxis, idxResponseAxis).aResponseNormVelFb_si = aResponseNormVelFb_si;
                matCrossResponse(idxExciteAxis, idxResponseAxis).stFourierOutCrossRespVelFb_si = ...
                    aft_calc_discrete_fourier_sine_cosine_amp_phase(aResponseNormVelFb_si, fFreqHz, fSampleTime_ms);
                stBodeCrossVelToDrv.fMagnitude = matCrossResponse(idxExciteAxis, idxResponseAxis).stFourierOutCrossRespVelFb_si.fAmplitude ...
                    / stFourierOutExciteDrvCmd_ExpPeakAcc.fAmplitude;
                fPhase_deg = stFourierOutExciteDrvCmd_ExpPeakAcc.fPhaseInSine_deg - matCrossResponse(idxExciteAxis, idxResponseAxis).stFourierOutCrossRespVelFb_si.fPhaseInSine_deg;
                stBodeCrossVelToDrv.fPhase_deg = freq_spectrum_phase_modular(fPhase_deg);
                
                matCrossResponse(idxExciteAxis, idxResponseAxis).stBodeCrossVelToDrv = stBodeCrossVelToDrv;
                
                matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.fStdFbVel_si = std(aResponseNormVelFb_si);
                matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.fPeak2PeakFbVel_si = max(aResponseNormVelFb_si) - min(aResponseNormVelFb_si);
                matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.fRmsFbVel_si = f_get_rms(aResponseNormVelFb_si);
                matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.fRatioExpMaxAccStdVel_si = ...
                    matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.fStdFbVel_si / stFourierOutExciteDrvCmd_ExpPeakAcc.fAmplitude;
                matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.fRatioExpMaxAcc_Peak2PeakVel_si = ...
                    matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.fPeak2PeakFbVel_si / stFourierOutExciteDrvCmd_ExpPeakAcc.fAmplitude;
                matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.fRatioExpMaxAcc_RmsVel_si = ...
                    matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.fRmsFbVel_si / stFourierOutExciteDrvCmd_ExpPeakAcc.fAmplitude;
                
                matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomainToExcitePosn.fRatioExFbPosn_Peak2PeakVel_si = ...
                    matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.fPeak2PeakFbVel_si / fPeakToPeakExAxisFbPosn_mm;
                matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomainToExcitePosn.fRatioExFbPosn_RmsVel_si = ...
                    matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.fRmsFbVel_si / fPeakToPeakExAxisFbPosn_mm;
                
            end
        end
    end
end
astGroupSineSweepRespCase.matCrossResponse = matCrossResponse;

if iPlotFlag >= DEF_PLOT_LEVEL_DEBUG_ALL && ((iCase <=30 &&mod(iCase, 8) == 0) || (iCase > 30 &&mod(iCase, 8) == 0) )
    for idxExciteAxis = 1:1:3
        for idxResponseAxis = 1:1:3
            if idxExciteAxis ~= idxResponseAxis
                if isempty(matCrossResponse(idxExciteAxis, idxResponseAxis).aExciteDrvCmd)
                else
                    iFigId = idxExciteAxis * 1000 + idxResponseAxis *100 + iCase;
                    figure(iFigId);
                    %% astGroupSineSweepRespCase.stSineSweepExciteResponse.aExciteDrvCmd
                    subplot(2,1,1); plot(aIdxTimeOri, matCrossResponse(idxExciteAxis, idxResponseAxis).aExciteDrvCmd_at_ExpPeakAcc, ...
                        aIdxTimeRestruct, stFourierOutExciteDrvCmd_ExpPeakAcc.afReconstructArray);    ylabel('m/s/s in (ExpPeakAcc)');
                    strTextTitle = sprintf('DrvCmd at %5.1f Hz', stGroupSineSweepCfg.astSineSweepCase(iCase).fFreqHz); title(strTextTitle);
                    subplot(2,1,2); plot(aIdxTimeOri, matCrossResponse(idxExciteAxis, idxResponseAxis).aResponseNormVelFb_si, ...
                        aIdxTimeRestruct, matCrossResponse(idxExciteAxis, idxResponseAxis).stFourierOutCrossRespVelFb_si.afReconstructArray);    
                    ylabel('FbVel (mm/sec)');
                    strTextAxisX = sprintf('Sample at %5.1f Hz', 1000/stGroupSineSweepCfg.fSampleTime_ms);   xlabel(strTextAxisX);
                    strTextTitle = sprintf('Mag: %f, Ph: %6.1f deg; T-Rto/MEA: P2P %f, Rms %f; T-Rto/MEA: P2P:%6.4f, RMS:%6.4f', matCrossResponse(idxExciteAxis, idxResponseAxis).stBodeCrossVelToDrv.fMagnitude, ...
                         matCrossResponse(idxExciteAxis, idxResponseAxis).stBodeCrossVelToDrv.fPhase_deg, ...
                         matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.fRatioExpMaxAcc_Peak2PeakVel_si, ...
                         matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomain.fRatioExpMaxAcc_RmsVel_si, ...
                         matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomainToExcitePosn.fRatioExFbPosn_Peak2PeakVel_si, ...
                         matCrossResponse(idxExciteAxis, idxResponseAxis).stTimeDomainToExcitePosn.fRatioExFbPosn_RmsVel_si);
                    title(strTextTitle);
%afRatioExpMaxAcc_Peak2PeakVel_si
                end
            end
        end      
    end
end