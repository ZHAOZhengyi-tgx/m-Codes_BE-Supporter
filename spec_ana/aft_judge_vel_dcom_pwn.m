function stTestCondition = aft_judge_vel_dcom_pwn(stPWNInput, matRespPRBS)
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
%% PWN: Pseudo-White-Noise test input
%% 20110406

iExcitingAxis = stPWNInput.iExcitingAxisCtrlId;

idxNoiseColMapExciteAxis = 0;
if iExcitingAxis == 0
    idxNoiseColMapExciteAxis = 4;
elseif iExcitingAxis == 1
    idxNoiseColMapExciteAxis = 5;
elseif iExcitingAxis == 4 || iExcitingAxis == 2
    idxNoiseColMapExciteAxis = 6;
end

aExcitingNoise = matRespPRBS(:, idxNoiseColMapExciteAxis);

EPSLON = 0.001;
nLenExcitingArray = length(aExcitingNoise);

%% One logic by grouping by sign first
% afNegExcitingNoise = 0;
% afPosExcitingNoise = 0;
% nLenNegNum = 0;
% nLenPosNum = 0;
% for ii = 1:1:nLenExcitingArray
%     if aExcitingNoise(ii) < -EPSLON
%         nLenNegNum = nLenNegNum + 1; afNegExcitingNoise(nLenNegNum) = aExcitingNoise(ii);
%     elseif aExcitingNoise(ii) > EPSLON
%         nLenPosNum = nLenPosNum + 1; afPosExcitingNoise(nLenPosNum) = aExcitingNoise(ii);
%     else
%     end
% end
% fStdNegExcite = std(afNegExcitingNoise);
% fStdPosExcite = std(afPosExcitingNoise);
% if fStdNegExcite + fStdPosExcite < 0.1
% %% OpenLoop Spectrum is +- Binary seqency,
%     stTestCondition.iFlagIsOpenLoop = 1;
% else
% %% Vel-Loop Spectrum is NOT so
%     stTestCondition.iFlagIsOpenLoop = 0;
% end

fMaxAbsExcite = max(aExcitingNoise);
fMinAbsExcite = min(aExcitingNoise);
% fMaxAbsExcite
% afAbsExcitingNoise = abs(aExcitingNoise);
% fMaxAbsExcite = max(afAbsExcitingNoise)
% fMinAbsExcite = min(afAbsExcitingNoise)

%% 20110406
if isfield(stPWNInput, 'iFlagVelLoopExcite')
   stTestCondition.iFlagIsOpenLoop = 1 - stPWNInput.iFlagVelLoopExcite;
else  %% for legacy compatible %% 20110406
    %%%% Data to be Captured is DCOM, 
    if fMaxAbsExcite - fMinAbsExcite > 0.01
    %% OpenLoop Spectrum is +- Binary seqency,
        stTestCondition.iFlagIsOpenLoop = 1;
    else
    %% Vel-Loop Spectrum is NOT so, ALL ZERO 2010/07/12
        stTestCondition.iFlagIsOpenLoop = 0;
    end
end  %% 20110406