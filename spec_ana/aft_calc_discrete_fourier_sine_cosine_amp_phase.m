function [stFourierOut] = aft_calc_discrete_fourier_sine_cosine_amp_phase(afTimeArray, fFreqHz, fSampleTime_ms)
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

usExciteLength = length(afTimeArray);
nNumCycle = ceil(usExciteLength * fSampleTime_ms / 1000 * fFreqHz);

fMeanValue = mean(afTimeArray);
aMeanArray = afTimeArray - fMeanValue;

[afSineOut, aTimePoint_at_Ts] = gen_sin_sweep_one_freq(1, fSampleTime_ms, fFreqHz, nNumCycle);
[afCosineOut, aTimePoint_at_Ts] = gen_cos_sweep_one_freq(1, fSampleTime_ms, fFreqHz, nNumCycle);

nLenSinCos = length(afSineOut);
if usExciteLength > nLenSinCos
    nLenAdding = nLenSinCos;
else
    nLenAdding = usExciteLength;
end
fSumProdSineSeriesAtHz = 0;
for ii=1:1:nLenAdding
    fSumProdSineSeriesAtHz = fSumProdSineSeriesAtHz + afSineOut(ii) * aMeanArray(ii);
end
fAmpSineSeriesAtHz = fSumProdSineSeriesAtHz/nLenAdding * 2;

fSumProdCosSeriesAtHz = 0;
for ii=1:1:nLenAdding
    fSumProdCosSeriesAtHz = fSumProdCosSeriesAtHz + afCosineOut(ii) * aMeanArray(ii);
end
fAmpCosSeriesAtHz = fSumProdCosSeriesAtHz/nLenAdding * 2;

afReconstructArray =  fMeanValue + fAmpSineSeriesAtHz *afSineOut + fAmpCosSeriesAtHz * afCosineOut;

stFourierOut.fMeanValue = fMeanValue;
stFourierOut.fAmpSineSeriesAtHz = fAmpSineSeriesAtHz;
stFourierOut.fAmpCosSeriesAtHz = fAmpCosSeriesAtHz;
stFourierOut.fAmplitude = sqrt(fAmpSineSeriesAtHz * fAmpSineSeriesAtHz + fAmpCosSeriesAtHz * fAmpCosSeriesAtHz);
stFourierOut.fPhaseInSine_rad = atan2(fAmpCosSeriesAtHz, fAmpSineSeriesAtHz);
stFourierOut.fPhaseInSine_deg = stFourierOut.fPhaseInSine_rad / pi * 180;
stFourierOut.afReconstructArray = afReconstructArray;
