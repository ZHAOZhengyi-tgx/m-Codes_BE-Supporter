

nLenTime = 4096;
aTimeAxis = 1:1:nLenTime;
Fs = 2000;
F1= 100;
F2 = 300;

for ii = 1:1:nLenTime
    afTimeSig(ii) = 1 * sin(2 * pi * F1 * aTimeAxis(ii)/ Fs ) + 3 * 1 * sin(2 * pi * F2 * aTimeAxis(ii)/ Fs );
end

aSpectrumFreq = abs(fft(afTimeSig));

nDispLen = nLenTime/2;
fFreqNyquist = Fs/2;
fMinFreqDisp = Fs/nLenTime;
aFullFreqAxis = linspace(fMinFreqDisp, fFreqNyquist, nDispLen);

figure(1);
subplot(2,1,1);
plot(afTimeSig);
xlabel('2000 Hz');
subplot(2,1,2);
plot(aFullFreqAxis, aSpectrumFreq(1:nDispLen))

aScaleSpectrumFreq = aSpectrumFreq/Fs;
figure(2);
plot(aFullFreqAxis, aScaleSpectrumFreq(1:nDispLen))
