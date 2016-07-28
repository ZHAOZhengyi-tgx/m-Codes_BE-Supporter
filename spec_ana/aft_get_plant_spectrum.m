function stSpectrumPrbs = aft_get_plant_spectrum(stGroupPrbs, stPrbsInput, matRespPRBS, iPlotFlag)
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
%% 20090704   Zhengyi Add aiArrayMappingCtrlId = [0, 1, 4, 5];
%% 20110121             Add cross spectrum

if ~exist('iPlotFlag')
    iPlotFlag = 0;
end
fFreqBasic = stGroupPrbs.fFreqBasic ;
nMovAveHalfLen = stGroupPrbs.nMovAveHalfLen ;
aiArrayMappingCtrlId = stGroupPrbs.aiArrayMappingCtrlId;
usBinaryAmplitude = stPrbsInput.usBinaryAmplitude;  %% 20120103

iExcitingAxisCtrlId = stPrbsInput.iExcitingAxisCtrlId;
usFrequencyFactor = stPrbsInput.usFrequencyFactor;
%nMovAveHalfLen = 11;
%fFreqBasic = 2000;
%fFreqTestSpectrum = fFreqBasic/usFrequencyFactor;
f_CTimeMPU_ms = stPrbsInput.f_CTimeMPU_ms; % 0.5;  %% 1.0
fFreqTestSpectrum = 1000/f_CTimeMPU_ms;  %% stPrbsInput.fActualSamplePeriod_ms;

idxExciteAxis = 8; %% by default, invalid axis
aiArrayMappingCtrlId = aiArrayMappingCtrlId;
for ii = 1:1:length(aiArrayMappingCtrlId)
    if aiArrayMappingCtrlId(ii) == iExcitingAxisCtrlId
        idxExciteAxis = ii;
    end
end

for ii = 1:1:3
    astRespPrbs(ii).aFdVel = matRespPRBS(:, ii);
    astRespPrbs(ii).aFdVelMean0 = astRespPrbs(ii).aFdVel; % - mean(astRespPrbs(ii).aFdVel);
    astRespPrbs(ii).aFdPosn = cumsum(astRespPrbs(ii).aFdVel);
    astRespPrbs(ii).aFdPosnMean0 = astRespPrbs(ii).aFdPosn; % - mean(astRespPrbs(ii).aFdPosn);
end

%% Study the excite axis' response
astRespPrbs(idxExciteAxis).aFreqFdVel = abs(fft(astRespPrbs(idxExciteAxis).aFdVelMean0));
astRespPrbs(idxExciteAxis).aFreqFdPosn = abs(fft(astRespPrbs(idxExciteAxis).aFdPosnMean0));

%% Study cross-Y response
for ii = 1:1:3
    if ii ~= idxExciteAxis
        astRespPrbs(ii).aFreqFdVel = abs(fft(astRespPrbs(ii).aFdVelMean0));
        astRespPrbs(ii).aFreqFdPosn = abs(fft(astRespPrbs(ii).aFdPosnMean0));
    end
end

%stExciteAxis.aFbPosn = matRespPRBS(:, 7);
stExciteAxis.aDrvCmd = matRespPRBS(:, idxExciteAxis + 3);
stExciteAxis.aFdVelMean0 = astRespPrbs(idxExciteAxis).aFdVelMean0;

astRespPrbs(idxExciteAxis).aFreqFdVel = astRespPrbs(idxExciteAxis).aFreqFdVel;
%% idxExciteAxis: 0-X, 1-Y, 2-A 
nLenData = length(astRespPrbs(idxExciteAxis).aFreqFdVel);
nDispLen = floor(nLenData/2);
fFreqNyquist = fFreqTestSpectrum/2;
fMinFreqDisp = fFreqTestSpectrum/nLenData;

idxSpectrumStart = 5; %% skip first several data, too low frequency
idxSpectrumEnd   = nDispLen;
% figure(1);
% semilogy(aFreqAxis, astRespPrbs(idxExciteAxis).aFreqFdVel(idxSpectrumStart:idxSpectrumEnd));
% xlabel('Freq, Hz');

aFullFreqAxis = linspace(fMinFreqDisp * nMovAveHalfLen, fFreqNyquist, nDispLen);
aFreqAxis = aFullFreqAxis(idxSpectrumStart:idxSpectrumEnd);

%% 20120107
%% nLenData *
fScaledAmplitudeExciteCmd = spectrum_calc_scaled_factor(usBinaryAmplitude, fFreqTestSpectrum);  %% usBinaryAmplitude/32767 * 100 *  fFreqTestSpectrum * 50; %% ? why 50? needs to study
%% Feedback velocity: Enc/sec
%% Command velocity: Enc/sample, at fFreqTestSpectrum
%%   is the peak value of binary noise, usBinaryAmplitude/32767 * 100
for ii = 1:1:3
    afFdVelSmoothSpectrum = smooth_move_ave(astRespPrbs(ii).aFreqFdVel, nMovAveHalfLen); 
    if ii == idxExciteAxis
        fLowFreqVelAmpRef = mean(afFdVelSmoothSpectrum(1:nMovAveHalfLen));
    end
    
    astRespPrbs(ii).aFreqFdVelSmoothSpec = afFdVelSmoothSpectrum(idxSpectrumStart:idxSpectrumEnd)/ mean(afFdVelSmoothSpectrum(1:nMovAveHalfLen)); 
    
    astRespPrbs(ii).aFreqSpectrumScaledFdVelSmooth = ...
        afFdVelSmoothSpectrum(idxSpectrumStart:idxSpectrumEnd)/ fScaledAmplitudeExciteCmd; %% 20120108
    %% /usBinaryAmplitude;  %% 20120103
    afFdPosnSmoothSpectrum = smooth_move_ave(astRespPrbs(ii).aFreqFdPosn, nMovAveHalfLen);  
    astRespPrbs(ii).aFreqFdPosnSmoothSpec = afFdPosnSmoothSpectrum(idxSpectrumStart:idxSpectrumEnd)/mean(afFdPosnSmoothSpectrum(1:nMovAveHalfLen));  
end
stSpectrumPrbs.fScaledAmplitudeExciteCmd = fScaledAmplitudeExciteCmd;  %% 20120212

if iPlotFlag >= 2
    
%    fScaledAmplitudeExciteCmd
    strDebug = sprintf('fScaledAmplitudeExciteCmd = %f, fLowFreqVelAmpRef = %f', fScaledAmplitudeExciteCmd, fLowFreqVelAmpRef);
    disp(strDebug);
end

%%% Velocity Spectrum
if iPlotFlag >= 5
    figure(102);
    semilogy(aFreqAxis, astRespPrbs(idxExciteAxis).aFreqFdVelSmoothSpec); %(idxSpectrumStart:idxSpectrumEnd));
    xlabel('Freq, Hz');
    title('Freq Response for PRBS test, Plant Velocity Spectrum');
    grid on;

    figure(103);
    loglog(aFreqAxis, astRespPrbs(idxExciteAxis).aFreqFdVelSmoothSpec); %(idxSpectrumStart:idxSpectrumEnd));
    xlabel('Freq, Hz');
    title('Freq Response for PRBS test, Plant Velocity Spectrum');
    grid on;
end

if iPlotFlag >= 5
    for ii = 1:1:3
        if ii ~= idxExciteAxis
            figure(1000 + idxExciteAxis * 100 + ii *10);
            semilogy(aFreqAxis, astRespPrbs(idxExciteAxis).aFreqFdVelSmoothSpec) ; %(idxSpectrumStart:idxSpectrumEnd));
            xlabel('Freq, Hz');
            strTitle = sprintf('Cross Freq Response for PRBS test, Plant Velocity Spectrum, Excit: %d, Resp: %d', idxExciteAxis, ii);
            title(strTitle);%%idxExciteAxis
            grid on;
            hold on;
        end
    end
end

stSpectrumPrbs.astRespPrbs = astRespPrbs;
stSpectrumPrbs.aFreqAxis = aFreqAxis;
stSpectrumPrbs.stExciteAxis = stExciteAxis;

% %%% Position Spectrum
% figure(4);
% semilogy(aFreqAxis, astRespPrbs(idxExciteAxis).aFreqFdPosnSmoothSpec(idxSpectrumStart:idxSpectrumEnd));
% xlabel('Freq, Hz');
% title('Freq Response for PRBS test, Plant Position Spectrum');
% grid on;
% 
% figure(5);
% loglog(aFreqAxis, astRespPrbs(idxExciteAxis).aFreqFdPosnSmoothSpec(idxSpectrumStart:idxSpectrumEnd));
% xlabel('Freq, Hz');
% title('Freq Response for PRBS test, Plant Position Spectrum');
% grid on;
