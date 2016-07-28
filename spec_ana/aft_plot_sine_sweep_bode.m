function aft_plot_sine_sweep_bode(stGroupSineSweepCfg, stBodeOutput)
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

fMinFreqPlot_Hz = stGroupSineSweepCfg.fMinFreqPlot_Hz;
stAppName = stGroupSineSweepCfg.stAppName;

stBodeVelToDrv = stBodeOutput.stBodeVelToDrv;
stBodePosnToDrv = stBodeOutput.stBodePosnToDrv;
nTotalCaseGroupSineSweep = length(stBodeVelToDrv.afFreqHz);

iExciteAxisCtrlCard = stGroupSineSweepCfg.iExciteAxisCtrlCard;
iExciteAppAxis = wb_map_axis_acs_2_app(iExciteAxisCtrlCard, stGroupSineSweepCfg.iMachineType); 

for ii = 1:1:nTotalCaseGroupSineSweep
    if stBodeVelToDrv.afFreqHz(ii) >= fMinFreqPlot_Hz
        nStartFreq = ii;
        break;
    end
end

figure(101);
subplot(2,1,1);
loglog(stBodeVelToDrv.afFreqHz(nStartFreq:end), stBodeVelToDrv.afMagnitude(nStartFreq:end));
ylabel('Vel over DrvCmd', 'FontSize', 16);
title('Bode graph, Vel v.s. DrvCmd', 'FontSize', 18);
grid on;
subplot(2,1,2);
semilogx(stBodeVelToDrv.afFreqHz(nStartFreq:end), stBodeVelToDrv.afPhase_deg(nStartFreq:end));
hold on;
plot([stBodePosnToDrv.afFreqHz(nStartFreq), stBodePosnToDrv.afFreqHz(end)], [-180, -180],  'LineWidth', 5);
plot([stBodePosnToDrv.afFreqHz(nStartFreq), stBodePosnToDrv.afFreqHz(end)], [180, 180],  'LineWidth', 5);
ylabel('Phase (deg)', 'FontSize', 16);
xlabel('Hz', 'FontSize', 16);
grid on;
%%% 
strSaveFilename_jpg = sprintf('%sSelfSpectrumBodeVel2DrvCmd_%s.jpg', stGroupSineSweepCfg.stFilePath.strPathname,  char(stAppName.astAppNameByCtrlBdAxis(iExciteAppAxis)));
strSaveFilename_fig = sprintf('%sSelfSpectrumBodeVel2DrvCmd_%s.fig', stGroupSineSweepCfg.stFilePath.strPathname,  char(stAppName.astAppNameByCtrlBdAxis(iExciteAppAxis)));

if stGroupSineSweepCfg.iPlotFlag >= 2
    saveas(gcf, strSaveFilename_fig, 'fig');
end
saveas(gcf, strSaveFilename_jpg, 'jpg');


figure(102);
subplot(2,1,1);
loglog(stBodePosnToDrv.afFreqHz(nStartFreq:end), stBodePosnToDrv.afMagnitude(nStartFreq:end));
ylabel('Posn over DrvCmd', 'FontSize', 16);
title('Bode graph, Plant Position v.s. DrvCmd', 'FontSize', 18);
grid on;
subplot(2,1,2);
semilogx(stBodePosnToDrv.afFreqHz(nStartFreq:end), stBodePosnToDrv.afPhase_deg(nStartFreq:end));
hold on;
plot([stBodePosnToDrv.afFreqHz(nStartFreq), stBodePosnToDrv.afFreqHz(end)], [-180, -180],  'LineWidth', 5);
plot([stBodePosnToDrv.afFreqHz(nStartFreq), stBodePosnToDrv.afFreqHz(end)], [180, 180],  'LineWidth', 5);
ylabel('Phase (deg)', 'FontSize', 16);
xlabel('Hz', 'FontSize', 16);
grid on;

%%% 
strSaveFilename_jpg = sprintf('%sSelfSpectrumBodePosn2DrvCmd_%s.jpg', stGroupSineSweepCfg.stFilePath.strPathname,  char(stAppName.astAppNameByCtrlBdAxis(iExciteAppAxis)));
strSaveFilename_fig = sprintf('%sSelfSpectrumBodePosn2DrvCmd_%s.fig', stGroupSineSweepCfg.stFilePath.strPathname,  char(stAppName.astAppNameByCtrlBdAxis(iExciteAppAxis)));

if stGroupSineSweepCfg.iPlotFlag >= 2
    saveas(gcf, strSaveFilename_fig, 'fig');
end
saveas(gcf, strSaveFilename_jpg, 'jpg');
