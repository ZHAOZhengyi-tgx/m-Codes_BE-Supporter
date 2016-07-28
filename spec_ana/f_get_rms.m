function fRMS = f_get_rms(aInput)

nLen = length(aInput);
fSumSq = 0;
for ii=1:1:nLen
    fSumSq = fSumSq + aInput(ii) * aInput(ii);
end
fRMS = sqrt(fSumSq / nLen);