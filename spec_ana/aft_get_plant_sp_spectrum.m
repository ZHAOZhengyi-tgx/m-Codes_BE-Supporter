function astRespPrbsSpData = aft_get_plant_sp_spectrum(stGroupPrbs, stGroupPrbsResp)
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

fSampleFreqSp_Hz = 1000/stGroupPrbs.fActualSamplePeriod_ms;  %%5000; % by default all in 20KHz
nMovAveHalfLen = stGroupPrbs.nMovAveHalfLen ;
if ~exist('iPlotFlag')
    iPlotFlag = 0;
end

aiArrayMappingCtrlId = stGroupPrbs.aiArrayMappingCtrlId;

nTotalCases = length(stGroupPrbsResp.astCase);
for ii = 1:1:nTotalCases
    %%%
    nMaxLenData = length(stGroupPrbsResp.astCase(ii).aRespRawDataSP);
    jj = nMaxLenData;
    while(jj >= 1 && abs(stGroupPrbsResp.astCase(ii).aRespRawDataSP(jj))<0.5)
        jj = jj - 1;
    end
    nLenData = jj;
    
    nDispLen = floor(nLenData/2);
    fFreqNyquist = fSampleFreqSp_Hz/2;
    fMinFreqDisp = fSampleFreqSp_Hz/nLenData - 40; %% adjust by an offset, compared with 2K spectrum
    if fMinFreqDisp < 10
        fMinFreqDisp = 10;
    end

    aFreqAxis = linspace(fMinFreqDisp, fFreqNyquist, nDispLen);

    idxSpectrumStart = 1;
    idxSpectrumEnd = nDispLen;

    %%%
    aRespRawDataPosn = stGroupPrbsResp.astCase(ii).aRespRawDataSP(1:nLenData);
    
    astRespPrbsSpData(ii).aRespRawDataPosnValid = aRespRawDataPosn;
    astRespPrbsSpData(ii).aRespRawDataPosnMean0 = aRespRawDataPosn - mean(aRespRawDataPosn);
    astRespPrbsSpData(ii).aRespRawDataVel = [0, diff(aRespRawDataPosn)];
    
    astRespPrbsSpData(ii).aRespRawDataVelMean0 = astRespPrbsSpData(ii).aRespRawDataVel; %  - mean(astRespPrbsSpData(ii).aRespRawDataVel);
    astRespPrbsSpData(ii).aFreqFdVel = abs(fft(astRespPrbsSpData(ii).aRespRawDataVelMean0));
    astRespPrbsSpData(ii).aFreqFdPosn = abs(fft(astRespPrbsSpData(ii).aRespRawDataPosnMean0));
    
    afFdVelSmoothSpectrum = smooth_move_ave(astRespPrbsSpData(ii).aFreqFdVel, nMovAveHalfLen); % idxExciteAxis
    afFdPosnSmoothSpectrum = smooth_move_ave(astRespPrbsSpData(ii).aFreqFdPosn, nMovAveHalfLen); % idxExciteAxis
    
    astRespPrbsSpData(ii).afFdVelSmoothSpectrum = afFdVelSmoothSpectrum / mean(afFdVelSmoothSpectrum(1:nMovAveHalfLen));
    astRespPrbsSpData(ii).afFdPosnSmoothSpectrum = afFdPosnSmoothSpectrum / mean(afFdPosnSmoothSpectrum(1:nMovAveHalfLen));
end

aiHoldAxisFlagVelSpec = zeros(1,3);
aiHoldAxisFlagPosnSpec = zeros(1,3);

for iAppAxis = 1:1:3

    for ii = 1:1:nTotalCases
    
        if stGroupPrbsResp.astCase(ii).stPrbsInput.iExcitingAxisCtrlId == aiArrayMappingCtrlId(iAppAxis)
            if iPlotFlag >= 0
                figure(iAppAxis);
                loglog(aFreqAxis, astRespPrbsSpData(ii).afFdVelSmoothSpectrum(idxSpectrumStart:idxSpectrumEnd));
                if aiHoldAxisFlagVelSpec(iAppAxis) == 0
                    hold on;
                    xlabel('Freq, Hz');
                    title('Freq Response for PRBS test, Plant Velocity Spectrum');
                    grid on;
                    aiHoldAxisFlagVelSpec(iAppAxis) = 1;
                end
                figure(iAppAxis * 1000 + iAppAxis * 100)
                semilogy(aFreqAxis, astRespPrbsSpData(ii).afFdPosnSmoothSpectrum(idxSpectrumStart:idxSpectrumEnd));
                if aiHoldAxisFlagPosnSpec(iAppAxis) == 0
                    hold on;
                    xlabel('Freq, Hz');
                    title('Freq Response for PRBS test, Plant Velocity Spectrum');
                    grid on;
                    aiHoldAxisFlagPosnSpec(iAppAxis) = 1;
                end

                figure(1002);
                subplot(2,1,1);
                plot(astRespPrbsSpData(ii).aRespRawDataVelMean0);
                title('Response Velocity in Time domain')
                subplot(2,1,2);
                plot(astRespPrbsSpData(ii).aRespRawDataPosnMean0);
                title('Response Position in Time domain')
            end
        end
    end
end

% figure(1);
% semilogy(aFreqAxis, astRespPrbs(idxExciteAxis).aFreqFdVel(idxSpectrumStart:idxSpectrumEnd));
% xlabel('Freq, Hz');

% for ii = 1:1:nTotalCases
% end

