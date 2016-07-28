function plot_freq_spectrum_amp_phase(afFreqHz, afAmplitudeDB, afPhase, iFigId, strTitle, strCurveFont)
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

figure(iFigId);
subplot(2,1,1);
loglog(afFreqHz, afAmplitudeDB, strCurveFont);
grid on;
ylabel('Relative Amplitude', 'FontSize', 15);
title(strTitle, 'FontSize', 25);
axis([min(afFreqHz), max(afFreqHz), min(afAmplitudeDB), max(afAmplitudeDB)]);
hold on;
plot([min(afFreqHz), max(afFreqHz)], [1, 1],  'LineWidth', 5);

subplot(2,1,2); 
semilogx(afFreqHz, afPhase, strCurveFont);
ylabel('deg', 'FontSize', 15);
xlabel('Hz', 'FontSize', 15);
axis([min(afFreqHz), max(afFreqHz), min(afPhase), max([max(afPhase), 190])]);
hold on;
plot([min(afFreqHz), max(afFreqHz)], [-180, -180],  'LineWidth', 5);
plot([min(afFreqHz), max(afFreqHz)], [180, 180],  'LineWidth', 5);
grid on;


