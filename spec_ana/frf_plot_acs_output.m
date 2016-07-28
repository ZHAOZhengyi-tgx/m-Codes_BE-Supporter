function frf_plot_acs_output(stOutputLoadFile, strCurveFont)
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
%close all;
%clear all;

%Table_X_FullLoad_20101105
%Table_Y_SOF_800_FullLoad_20101105

%C17_562_R15_64K_R12_46K_20110228
%OneCup_Z_20110315_frf
%OneCup_X_5000Hz_20110325_frf
%OneCup_Y_5000Hz_20110325_frf
%OneCup_Z_5000Hz_20110325_frf

Measure_Plant_Data = stOutputLoadFile.Measure_Plant_Data;
Measure_Open_Loop_Data = stOutputLoadFile.Measure_Open_Loop_Data;
Measure_Closed_Loop_Data = stOutputLoadFile.Measure_Closed_Loop_Data;

afFreqHz = Measure_Plant_Data(:, 1);
afAmplitudeDB = Measure_Plant_Data(:, 2);
afPhase = freq_spectrum_phase_modular(Measure_Plant_Data(:, 3));
iFigId = 2; 
strTitle = 'SineSweep Plant With Driver';
figure(iFigId); hold on; %clf;
plot_freq_spectrum_amp_phase(afFreqHz, afAmplitudeDB, afPhase, iFigId, strTitle, strCurveFont)

afFreqHz = Measure_Open_Loop_Data(:, 1);
afAmplitudeDB = Measure_Open_Loop_Data(:, 2);
afPhase = freq_spectrum_phase_modular(Measure_Open_Loop_Data(:, 3));
iFigId = 3; 
strTitle = 'OpenLoop';
figure(iFigId); hold on; %clf;
plot_freq_spectrum_amp_phase(afFreqHz, afAmplitudeDB, afPhase, iFigId, strTitle, strCurveFont)

afFreqHz = Measure_Closed_Loop_Data(:, 1);
afAmplitudeDB = Measure_Closed_Loop_Data(:, 2);
afPhase = freq_spectrum_phase_modular(Measure_Closed_Loop_Data(:, 3));
iFigId = 1; 
strTitle = 'SineSweep CloseLoop';
figure(iFigId); hold on; %clf;
plot_freq_spectrum_amp_phase(afFreqHz, afAmplitudeDB, afPhase, iFigId, strTitle, strCurveFont)

% C17_562_R15_64K_20110228_
% afFreqHz = Measure_Closed_Loop_Data(:, 1);
% afAmplitudeDB = Measure_Closed_Loop_Data(:, 2);
% afPhase = Measure_Closed_Loop_Data(:, 3);
% iFigId = 2; 
% strTitle = 'SineSweep Spectrum R12 = 180K';
% figure(iFigId);
% plot_freq_spectrum_amp_phase(afFreqHz, afAmplitudeDB, afPhase, iFigId, strTitle)
