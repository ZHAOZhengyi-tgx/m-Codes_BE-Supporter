function aft_plot_group_spectrm_loglog(stGroupPrbs, stGroupPrbsResp, iExcitingAxisCtrlId, strTitle)
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

global stAppName;

iPlotFlag = stGroupPrbs.iPlotFlag;

aiArrayMappingCtrlId = stGroupPrbs.aiArrayMappingCtrlId;
nTotalCaseGroupPrbs = stGroupPrbs.nTotalCaseGroupPrbs;
nActualCaseSpectrum = stGroupPrbs.nActualCaseSpectrum;  %% 20120722

% for ii = 1:1:4
%     if aiArrayMappingCtrlId(ii) == iExcitingAxisCtrlId
%         idxAppAxisExcite = ii;
%     end
% end
%figure(iExcitingAxisCtrlId + 1);
idxAppAxisExcite = wb_map_axis_acs_2_app(iExcitingAxisCtrlId, stGroupPrbs.iMachineType);

figure(idxAppAxisExcite * 100 + idxAppAxisExcite * 10); clf;
stPlotStyle = aft_init_plot_style();
nLenPlotStyle = length(stPlotStyle);
iCountLegend = 0;
iHoldFlag = 1;

%strLegend = [];

    %%%% only plot 7 Hz and above, 20111129
    aFreqAxisData = stGroupPrbsResp.astCase(1).stSpectrumPrbs.aFreqAxis;
    nDataLen = length(aFreqAxisData);
    for jj = 1:1:length(aFreqAxisData)
        if aFreqAxisData(jj) >= 7
            iStartDrawingFreq = jj;
            break;
        end
    end
    nDrawingFreqRange = [iStartDrawingFreq, nDataLen]
    %%%%
    fMaxAmpDrawing = 1;
    fMinAmpDrawing = 1;

for ii = 1:1:nActualCaseSpectrum;  %% 20120722
    if stGroupPrbsResp.astCase(ii).stPrbsInput.iExcitingAxisCtrlId == iExcitingAxisCtrlId
        
        for jj = 1:1:length(aiArrayMappingCtrlId)
            if aiArrayMappingCtrlId(jj) == iExcitingAxisCtrlId
                idxExciteAxis = jj;
            end
        end
        fCheckSum = sum(abs(stGroupPrbsResp.astCase(ii).stSpectrumPrbs.astRespPrbs(idxExciteAxis).aFdVelMean0(1:end)));
        if fCheckSum < 100
            strTextError = sprintf('Invalid number: Case-%d, Axis-%d', ii, iExcitingAxisCtrlId);
            disp(strTextError);
            continue;
        end
        
        iCountLegend = iCountLegend + 1;
        strText =  mat2str(stGroupPrbs.astPrbsTestOnceInput(ii).aAxisPositions');
        strLegend(iCountLegend) = {strText};
        aFreqAxisData = stGroupPrbsResp.astCase(ii).stSpectrumPrbs.aFreqAxis;
        nDataLen = length(stGroupPrbsResp.astCase(ii).stSpectrumPrbs.aFreqAxis);
        maxFreq = aFreqAxisData(nDataLen);
        idxPlotStyle = mod(iCountLegend, nLenPlotStyle) + 1;
        %%%% only plot  above, 20111129
        loglog(aFreqAxisData(iStartDrawingFreq:nDataLen), ...
            stGroupPrbsResp.astCase(ii).stSpectrumPrbs.astRespPrbs(idxExciteAxis).aFreqFdVelSmoothSpec(iStartDrawingFreq:nDataLen), ...
            stPlotStyle(idxPlotStyle).FigureColor);

        fPeakAmpCurrFreq = max(stGroupPrbsResp.astCase(ii).stSpectrumPrbs.astRespPrbs(idxExciteAxis).aFreqFdVelSmoothSpec(iStartDrawingFreq:nDataLen));
        fBottAmpCurrFreq = min(stGroupPrbsResp.astCase(ii).stSpectrumPrbs.astRespPrbs(idxExciteAxis).aFreqFdVelSmoothSpec(iStartDrawingFreq:nDataLen));
        if fMaxAmpDrawing < fPeakAmpCurrFreq
            fMaxAmpDrawing = fPeakAmpCurrFreq;
        end
        if fMinAmpDrawing > fBottAmpCurrFreq
            fMinAmpDrawing = fBottAmpCurrFreq;
        end
        
        if iHoldFlag == 1
            hold on; iHoldFlag = 0; grid on;
            xlabel('Freq, Hz', 'FontSize', 16);
            title(strTitle, 'FontSize', 18);
        end
        
    end
end

if iHoldFlag == 0
    legend(strLegend,  'FontSize', 6, 'Location', 'SouthWest');
end
axis([7, maxFreq, fMinAmpDrawing / 5, fMaxAmpDrawing * 5])

