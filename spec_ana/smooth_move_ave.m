function aDataOut = smooth_move_ave(aDataIn, nMovAveHalfLen)
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
% zzytgx@gmail.com
%

nLenData = length(aDataIn);
nLenSkipFirstSeveralFreq = 2;
for ii =1:1:nLenData
    if ii < nLenSkipFirstSeveralFreq  %% 
        aDataOut(ii) = mean(aDataIn(1: 2*nLenSkipFirstSeveralFreq));  %% nMovAveHalfLen)); % 
    elseif ii <= nMovAveHalfLen
        aDataOut(ii) = mean(aDataIn(1:ii * 2 -1));  %% nMovAveHalfLen)); % 
    elseif ii >= nLenData - nMovAveHalfLen
        aDataOut(ii) = mean(aDataIn((2 * ii - nLenData) : nLenData));
    else
        aDataOut(ii) = mean(aDataIn((ii - nMovAveHalfLen):(ii + nMovAveHalfLen)));
    end
end
