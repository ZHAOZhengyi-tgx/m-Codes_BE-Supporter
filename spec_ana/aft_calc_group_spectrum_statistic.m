function matAxis2AxisPrbsGuideLine = aft_calc_group_spectrum_statistic(stGroupPrbsRespGuidLine, iPlotFlag)
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

matAxis2AxisPrbsGuideLine = [];

disp('---------------------------------------------------------------------------------------');
disp('3-Stage mechatronics(motor-table, XYZ)  ');
disp('Spectrum Guidline ');
disp('All right reserved');
disp('zzytgx@gmail.com');
if(isfield(stGroupPrbsRespGuidLine, 'strReleaseTime'))
    strReleaseTime = sprintf('Guideline Release time: %s', stGroupPrbsRespGuidLine.strReleaseTime);
    disp(strReleaseTime);
end
if(isfield(stGroupPrbsRespGuidLine, 'strReleaseNotes'))
    strReleaseNote = sprintf('Release notes: %s', stGroupPrbsRespGuidLine.strReleaseNotes);
    disp(strReleaseNote);
end
disp('---------------------------------------------------------------------------------------');
aiArrayMappingCtrlId = stGroupPrbsRespGuidLine.aiArrayMappingCtrlId;
nTotalCase = length(stGroupPrbsRespGuidLine.astCase);
nTotalAxis = 3;  %%% initialization, 20120722
for ii = 1:1:nTotalAxis
    for jj = 1:1:nTotalAxis
        matAxis2AxisPrbsGuideLine(ii, jj).nTotalCase = 0;
    end
end

if nTotalCase >= 1
    nTotalAxis = length(stGroupPrbsRespGuidLine.astCase(1).stSpectrumPrbs.astRespPrbs);
else
    error(astErrorMsgId(1).strMsgId, astrErrorMessage(1).strErrMsgText) ;
end

%stTestCondition = stGroupPrbsRespGuidLine.astCase(1).stTestCondition; % 20110924

for ii = 1:1:nTotalCase
    for jj = 1:1:nTotalAxis
        if(stGroupPrbsRespGuidLine.astCase(ii).stPrbsInput.iExcitingAxisCtrlId == aiArrayMappingCtrlId(jj))
            iWbAppExciteAxis = jj;
        end
    end
    usBinaryAmplitude = stGroupPrbsRespGuidLine.astCase(ii).stPrbsInput.usBinaryAmplitude;
    if(isfield(stGroupPrbsRespGuidLine.astCase(ii).stPrbsInput, 'f_CTimeMPU_ms'))
        fFreqTestSpectrum = 1000/stGroupPrbsRespGuidLine.astCase(ii).stPrbsInput.f_CTimeMPU_ms;
    else
        stGroupPrbsRespGuidLine.astCase(ii).stPrbsInput.f_CTimeMPU_ms = 1.0;
        fFreqTestSpectrum = 1000/1.0;
    end
    fScaledAmplitudeExciteCmd = spectrum_calc_scaled_factor(usBinaryAmplitude, fFreqTestSpectrum);
    
    for jj = 1:1:nTotalAxis
        iWbAppRespAxis = jj;
        
        nTotalCaseFromExciteToResp = matAxis2AxisPrbsGuideLine(iWbAppExciteAxis, iWbAppRespAxis).nTotalCase + 1;
        matAxis2AxisPrbsGuideLine(iWbAppExciteAxis, iWbAppRespAxis).nTotalCase = nTotalCaseFromExciteToResp;
        matAxis2AxisPrbsGuideLine(iWbAppExciteAxis, iWbAppRespAxis).astResp(nTotalCaseFromExciteToResp).aFreqFdVelSmoothSpec = ...
            stGroupPrbsRespGuidLine.astCase(ii).stSpectrumPrbs.astRespPrbs(iWbAppRespAxis).aFreqFdVelSmoothSpec;
        matAxis2AxisPrbsGuideLine(iWbAppExciteAxis, iWbAppRespAxis).astResp(nTotalCaseFromExciteToResp).aFreqFdVelScaledSmoothSpec = ...
            fScaledAmplitudeExciteCmd * stGroupPrbsRespGuidLine.astCase(ii).stSpectrumPrbs.astRespPrbs(iWbAppRespAxis).aFreqFdVelSmoothSpec; %% 20120212
        matAxis2AxisPrbsGuideLine(iWbAppExciteAxis, iWbAppRespAxis).astResp(nTotalCaseFromExciteToResp).aFreqAxis = ...
            stGroupPrbsRespGuidLine.astCase(ii).stSpectrumPrbs.aFreqAxis;        
    end
end



if isfield(stGroupPrbsRespGuidLine, 'iMachineType')
    iMachineType = stGroupPrbsRespGuidLine.iMachineType;
else
    iMachineType = 1;
end

fFreqStdRampUp = 400;

iFlagHasStatisticGuideLine = 0;
if isfield(stGroupPrbsRespGuidLine, 'matAxis2AxisPrbsGuideLine') == 1
    iFlagHasStatisticGuideLine = 1;
    %%matAxis2AxisPrbsGuideLine = stGroupPrbsRespGuidLine.matAxis2AxisPrbsGuideLine;
    for ii = 1:1:nTotalAxis
        for jj = 1:1:nTotalAxis
            matAxis2AxisPrbsGuideLine(ii,jj).aFreqFdVelErrorUppBound = stGroupPrbsRespGuidLine.matAxis2AxisPrbsGuideLine(ii,jj).aFreqFdVelErrorUppBound;
            matAxis2AxisPrbsGuideLine(ii,jj).aFreqFdVelExpectIdeal = stGroupPrbsRespGuidLine.matAxis2AxisPrbsGuideLine(ii,jj).aFreqFdVelExpectIdeal;
            matAxis2AxisPrbsGuideLine(ii,jj).aFreqFdVelWarningUppBound = stGroupPrbsRespGuidLine.matAxis2AxisPrbsGuideLine(ii,jj).aFreqFdVelWarningUppBound;
            matAxis2AxisPrbsGuideLine(ii,jj).aFreqFdVelWarningLowBound = stGroupPrbsRespGuidLine.matAxis2AxisPrbsGuideLine(ii,jj).aFreqFdVelWarningLowBound;
        end
    end
    
    %% matAxis2AxisPrbsGuideLine(1,1).aFreqFdVelWarningLowBound);
    aFreqAxis = stGroupPrbsRespGuidLine.astCase(1).stSpectrumPrbs.aFreqAxis; 
    % matAxis2AxisPrbsGuideLine(iWbAppExciteAxis, iWbAppRespAxis).astResp(1).aFreqAxis((end - nLenFreq + 1):end);
else
    aFreqAxis = matAxis2AxisPrbsGuideLine(iWbAppExciteAxis, iWbAppRespAxis).astResp(1).aFreqAxis;
end
nLenFreq = length(aFreqAxis); 

if iFlagHasStatisticGuideLine == 0
    
for idxExcite = 1:1:nTotalAxis
    for idxResp = 1:1:nTotalAxis
        if idxExcite == 1 && idxResp == 1
            matPassFail(idxExcite,idxResp).fWarningUpper = stGroupPrbsRespGuidLine.stThresholdVelWarningFail.stTableXSelf.fWarningUpper;
            matPassFail(idxExcite,idxResp).fErrorUpper = stGroupPrbsRespGuidLine.stThresholdVelWarningFail.stTableXSelf.fErrorUpper;
            matPassFail(idxExcite,idxResp).fErrorLower = stGroupPrbsRespGuidLine.stThresholdVelWarningFail.stTableXSelf.fErrorLower;
        elseif idxExcite == idxResp
            matPassFail(idxExcite,idxResp).fWarningUpper = stGroupPrbsRespGuidLine.stThresholdVelWarningFail.stOtherSelf.fWarningUpper;
            matPassFail(idxExcite,idxResp).fErrorUpper = stGroupPrbsRespGuidLine.stThresholdVelWarningFail.stOtherSelf.fErrorUpper;
            matPassFail(idxExcite,idxResp).fErrorLower = stGroupPrbsRespGuidLine.stThresholdVelWarningFail.stOtherSelf.fErrorLower;
        else                
            matPassFail(idxExcite,idxResp).fWarningUpper = stGroupPrbsRespGuidLine.stThresholdVelWarningFail.stCross.fWarningUpper;
            matPassFail(idxExcite,idxResp).fErrorUpper = stGroupPrbsRespGuidLine.stThresholdVelWarningFail.stCross.fErrorUpper;
            matPassFail(idxExcite,idxResp).fErrorLower = stGroupPrbsRespGuidLine.stThresholdVelWarningFail.stCross.fErrorLower;
        end
    end
end

for idxExcite = 1:1:nTotalAxis
    for idxResp = 1:1:nTotalAxis
        nTotalCasePerExciteResp = matAxis2AxisPrbsGuideLine(idxExcite,idxResp).nTotalCase;
        if nTotalCasePerExciteResp == 0   %%%% 20111226
            continue;
        end   %%%% 20111226
            
        aFreqFdVelMinRelAmp = matAxis2AxisPrbsGuideLine(idxExcite,idxResp).astResp(1).aFreqFdVelSmoothSpec;
        aFreqFdVelMaxRelAmp = matAxis2AxisPrbsGuideLine(idxExcite,idxResp).astResp(1).aFreqFdVelSmoothSpec;
        aFreqFdVelSumRelAmp = matAxis2AxisPrbsGuideLine(idxExcite,idxResp).astResp(1).aFreqFdVelSmoothSpec;
        aFreqFdVelSumSqRelAmp = matAxis2AxisPrbsGuideLine(idxExcite,idxResp).astResp(1).aFreqFdVelSmoothSpec .* ...
            matAxis2AxisPrbsGuideLine(idxExcite,idxResp).astResp(1).aFreqFdVelSmoothSpec;
        
        nLenFreq = length( matAxis2AxisPrbsGuideLine(idxExcite,idxResp).astResp(1).aFreqFdVelSmoothSpec);
        
        for cc = 2:1:nTotalCasePerExciteResp
            
            for ii = 1:1:nLenFreq
                if aFreqFdVelMinRelAmp(ii) > matAxis2AxisPrbsGuideLine(idxExcite,idxResp).astResp(cc).aFreqFdVelSmoothSpec(ii)
                    aFreqFdVelMinRelAmp(ii) = matAxis2AxisPrbsGuideLine(idxExcite,idxResp).astResp(cc).aFreqFdVelSmoothSpec(ii);
                end
                if aFreqFdVelMaxRelAmp(ii) < matAxis2AxisPrbsGuideLine(idxExcite,idxResp).astResp(cc).aFreqFdVelSmoothSpec(ii)
                    aFreqFdVelMaxRelAmp(ii) = matAxis2AxisPrbsGuideLine(idxExcite,idxResp).astResp(cc).aFreqFdVelSmoothSpec(ii);
                end
            end
            aFreqFdVelSumRelAmp = aFreqFdVelSumRelAmp + matAxis2AxisPrbsGuideLine(idxExcite,idxResp).astResp(cc).aFreqFdVelSmoothSpec;
            aFreqFdVelSumSqRelAmp = aFreqFdVelSumSqRelAmp + ...
                    matAxis2AxisPrbsGuideLine(idxExcite,idxResp).astResp(cc).aFreqFdVelSmoothSpec .* matAxis2AxisPrbsGuideLine(idxExcite,idxResp).astResp(cc).aFreqFdVelSmoothSpec;
        end
        
        matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelMinRelAmp = smooth_move_ave(aFreqFdVelMinRelAmp, 49);
        matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelMaxRelAmp = aFreqFdVelMaxRelAmp;
        matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelSumRelAmp = aFreqFdVelSumRelAmp;
        matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelMeanRelAmpRaw = aFreqFdVelSumRelAmp/nTotalCasePerExciteResp;
        matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelMeanRelAmp = smooth_move_ave(aFreqFdVelSumRelAmp/nTotalCasePerExciteResp, 49);
        matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelSumSqRelAmp = aFreqFdVelSumSqRelAmp;
        matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelStdRelAmp = sqrt(aFreqFdVelSumSqRelAmp / nTotalCasePerExciteResp);
        
        fMaxGapFromMaxToMean = min( matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelMaxRelAmp - matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelMeanRelAmpRaw);

        aGuideLineMax_1 = smooth_move_ave(matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelMaxRelAmp, 49);
        aGuideLineStd_2 = smooth_move_ave(matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelStdRelAmp, 49);
        aGuideLineStd_3 = smooth_move_ave(matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelStdRelAmp, 9);

        
        for ii = 1:1:nLenFreq  %% 20111007
            if(aFreqAxis(ii) < fFreqStdRampUp ) %% 400 Hz  = 400;
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningUppBound(ii) = ...
                    aGuideLineMax_1(ii) + ...
                     aGuideLineStd_2(ii) * matPassFail(idxExcite,idxResp).fWarningUpper;
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound(ii) = matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningUppBound(ii) + ...
                    aGuideLineStd_2(ii) * matPassFail(idxExcite,idxResp).fErrorUpper;
            else
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningUppBound(ii) = ...
                    aGuideLineMax_1(ii) + ...
                     aGuideLineStd_2(ii) * matPassFail(idxExcite,idxResp).fWarningUpper * sqrt(aFreqAxis(ii)/fFreqStdRampUp);
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound(ii) = matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningUppBound(ii) + ...
                    aGuideLineStd_3(ii) * matPassFail(idxExcite,idxResp).fErrorUpper * (aFreqAxis(ii)/fFreqStdRampUp)^3;
            end
        end
        
        
        %%%% Warning upper
        for ii = 1:1:nLenFreq  %% 20110924
            if matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningUppBound(ii) > matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound(ii)
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningUppBound(ii) = matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound(ii);
            elseif (matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningUppBound(ii) < matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelMeanRelAmp(ii))
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningUppBound(ii) = matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelMeanRelAmp(ii);
            end
        end
        
    %%            mean(matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelStdRelAmp);
        
        fMaxGapFromMeanToMin = max( matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelMeanRelAmp - matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelMinRelAmp);
        matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningLowBound =  ...
            matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelMeanRelAmp - ...
            fMaxGapFromMeanToMin * matPassFail(idxExcite,idxResp).fErrorLower;
        for ii = 1:1:nLenFreq
            if (matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningLowBound(ii) < ...
                    matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelMinRelAmp(ii)/2)
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningLowBound(ii) = ...
                    matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelMinRelAmp(ii)/2;
            end
            
            if matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningLowBound(ii) > 0.8
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningLowBound(ii) = 0.8;
            end
        end
        
    %%%%%% Ideal Expection
        matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelExpectIdeal = matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelMeanRelAmp;
        for ii = 1:1:nLenFreq
            if matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelExpectIdeal(ii) > 2
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelExpectIdeal(ii) = 2;
            end
            if matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelExpectIdeal(ii) < 0.9
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelExpectIdeal(ii) = 0.9;
            end
            
            if matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelExpectIdeal(ii) < matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningLowBound(ii)
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelExpectIdeal(ii) = matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningLowBound(ii);
            end
            
            if matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelExpectIdeal(ii) > matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningUppBound(ii)
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelExpectIdeal(ii) = matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningUppBound(ii);
            end
        end
        
        % matAxis2AxisPrbsGuideLine(iWbAppExciteAxis, iWbAppRespAxis).astResp(nTotalCaseFromExciteToResp).aFreqFdVelScaledSmoothSpec
    end
end

for idxExcite = 1:1:nTotalAxis
    for idxResp = 1:1:nTotalAxis

        for ii = 1:1:nLenFreq  %% 20110924
            if (matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound(ii) < 2.5)
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound(ii) = 2.5;
            end
            
            if (matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningUppBound(ii) < 1.5)
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningUppBound(ii) = 1.5;
             elseif (matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningUppBound(ii) > 3.0)
                 matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningUppBound(ii) = 3.0;
            end
        end
            
         for ii = 1:1:nLenFreq  %% 20110924
           if(aFreqAxis(ii) < fFreqStdRampUp ) %% 400 Hz  = 400;
                 if (matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound(ii) > 5.0)
                     matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound(ii) = 5.0;
                 end
               if(aFreqAxis(ii) >= 100 ) %% 400 Hz  = 400;
                    if matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound(ii) < ...
                            matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound(ii - 1) 
                        matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound(ii) = ...
                            matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound(ii - 1); 
                    end
               end
           else
           if iFlagHasStatisticGuideLine == 0    
                if idxExcite ~= nTotalAxis || idxResp ~= nTotalAxis  ...
                        || matAxis2AxisPrbsGuideLine(1,1).nTotalCase >= 1%%% %%%% 20111226, DONOT include bondhead station and 
                    fErrorUpperBound = 6.0;
                else
                    fErrorUpperBound = 10.0;
                end
                if (matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound(ii) > fErrorUpperBound)
                    matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound(ii) = fErrorUpperBound;
                end
           end
 
                if matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound(ii) < ...
                        matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound(ii - 1) 
                    matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound(ii) = ...
                        matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound(ii - 1); 
                end
            end
        end %% 20110924
    end
end


end

global DEF_PLOT_LEVEL_CROSS_EFFECT;
global DEF_PLOT_LEVEL_DEBUG_ALL;
for idxExcite = 1:1:nTotalAxis
    for idxResp = 1:1:nTotalAxis
%        idxExciteResp = [idxExcite,idxResp]
        nTotalCasePerExciteResp = matAxis2AxisPrbsGuideLine(idxExcite,idxResp).nTotalCase;
            if nTotalCasePerExciteResp == 0   
                continue;
            end   %%%% 20111226
%         if iFlagHasStatisticGuideLine == 0
%             if matAxis2AxisPrbsGuideLine(idxExcite,idxResp).nTotalCase == 0
%                 continue;
%             end
%             nTotalCasePerExciteResp = matAxis2AxisPrbsGuideLine(idxExcite,idxResp).nTotalCase;
%         else
%             nTotalCasePerExciteResp = matAxis2AxisPrbsGuideLine(idxExcite,idxResp).nTotalCase;
%         end
        if  (iPlotFlag >= DEF_PLOT_LEVEL_CROSS_EFFECT) || (idxExcite == idxResp)    %%%% 20111226
            if length(matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningLowBound) == 0
                continue
            end
            
            %%% Machine Type, 20110924
            iFigId = wb_spec_get_fig_id_by_machine_type_app_axis(idxExcite, idxResp, iMachineType);
            %%% Machine Type, 20110924
%             idxExcite
%             idxResp
%             matAxis2AxisPrbsGuideLine(idxExcite,idxResp).nTotalCase
%             idx_Excite_Resp_nLenFreq_WarningLowB = [idxExcite, idxResp, nLenFreq, ...
%                 length(matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningLowBound)]
            
            figure(iFigId);
            loglog(aFreqAxis, ...
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningLowBound((end - nLenFreq +1):end), 'k-', 'LineWidth',3);  %%% aFreqFdVelMinRelAmp
            grid on;
            xlabel('Hz');
            ylabel('Relative amplitude');
            hold on;
%             loglog(aFreqAxis, ...
%                 matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningUppBound((end - nLenFreq +1):end), 'k-', 'LineWidth',3); %% aFreqFdVelMaxRelAmp
            loglog(aFreqAxis, ...
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound((end - nLenFreq +1):end), 'r-', 'LineWidth',3);  %%% aFreqFdVelMaxRelAmp
            loglog(aFreqAxis, ...
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelExpectIdeal((end - nLenFreq +1):end), 'g-', 'LineWidth',3);
        end
        
        %%%%% plot scaled spectrum in semilogy, NOT the same as ScaledWithLowFreq, 20120207 DEF_PLOT_LEVEL_CROSS_EFFECT
        if  (iPlotFlag >= DEF_PLOT_LEVEL_DEBUG_ALL) || (idxExcite == idxResp)    %%%% 20111226  
            
            iFigId = wb_spec_get_fig_id_scaled_semilogy_by_mc_type_app_axis(idxExcite, idxResp, iMachineType);
            
            figure(iFigId);
            %nTotalCasePerExciteResp = matAxis2AxisPrbsGuideLine(idxExcite,idxResp).nTotalCase;
            semilogy(aFreqAxis, ...
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningLowBound((end - nLenFreq +1):end), 'k-', 'LineWidth',3);  %%% aFreqFdVelMinRelAmp
            grid on;
            xlabel('Hz');
            ylabel('Relative amplitude');
            hold on;
            semilogy(aFreqAxis, ...
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelWarningUppBound((end - nLenFreq +1):end), 'k-', 'LineWidth',3); %% aFreqFdVelMaxRelAmp
            semilogy(aFreqAxis, ...
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelErrorUppBound((end - nLenFreq +1):end), 'r-', 'LineWidth',3);  %%% aFreqFdVelMaxRelAmp
            semilogy(aFreqAxis, ...
                matAxis2AxisPrbsGuideLine(idxExcite,idxResp).aFreqFdVelExpectIdeal((end - nLenFreq +1):end), 'g-', 'LineWidth',3);
        end
        
        if iFlagHasStatisticGuideLine == 0 && iPlotFlag >= DEF_PLOT_LEVEL_DEBUG_ALL %% || (idxExcite == idxResp) 
            for cc = 1:1:nTotalCasePerExciteResp
                loglog(matAxis2AxisPrbsGuideLine(iWbAppExciteAxis, iWbAppRespAxis).astResp(cc).aFreqAxis, ...
                    matAxis2AxisPrbsGuideLine(idxExcite,idxResp).astResp(cc).aFreqFdVelSmoothSpec, 'b.');
            end
        end
    end
end
