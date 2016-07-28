function astCaseAxisXlsOutput = aft_save_spectrum_xls(stGroupPrbs, stGroupPrbsResp)
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

aiArrayMappingCtrlId = stGroupPrbs.aiArrayMappingCtrlId;
nTotalCaseGroupPrbs = stGroupPrbs.nTotalCaseGroupPrbs;
stAppName = stGroupPrbs.stAppName;
astCaseAxisXlsOutput = [];

aFreqAxisData = stGroupPrbsResp.astCase(1).stSpectrumPrbs.aFreqAxis;
nDataLen = length(aFreqAxisData);
for jj = 1:1:nDataLen
    if aFreqAxisData(jj) >= 7
        iStartDrawingFreq = jj;
        break;
    end
end
strXlsOutFullFilename = sprintf('%s\\_SpectrumXlsOut.xls', stGroupPrbs.stFilePath.strPathname);

aExciteAxisCtrlList = [0, 1, 4];

for kk = 1:1:length(aExciteAxisCtrlList)
    
    iExcitingAxisCtrlId = aExciteAxisCtrlList(kk);
    idxAppAxisExcite = wb_map_axis_acs_2_app(iExcitingAxisCtrlId, stGroupPrbs.iMachineType);
    strXlsSheetName = char(stAppName.astAppNameByCtrlBdAxis(idxAppAxisExcite));

    idxRow = 1;
    cellSpectrumMatrix(idxRow, 1) = {'Freq (Hz)'};
    for ff = iStartDrawingFreq:1:nDataLen
        cellSpectrumMatrix(idxRow, ff - iStartDrawingFreq + 2) = {aFreqAxisData(ff)};
    end
    idxRow = idxRow + 1;
    cellSpectrumMatrix(idxRow, 1) = {'Scaled RelAmp'};
    fCheckSum(kk) = 0;
    for ii = 1:1:nTotalCaseGroupPrbs
        if stGroupPrbsResp.astCase(ii).stPrbsInput.iExcitingAxisCtrlId == iExcitingAxisCtrlId

            for jj = 1:1:length(aiArrayMappingCtrlId)
                if aiArrayMappingCtrlId(jj) == iExcitingAxisCtrlId
                    idxExciteAxis = jj;
                end
            end
            
            aFreqAxisData = stGroupPrbsResp.astCase(ii).stSpectrumPrbs.aFreqAxis;
            nDataLen = length(stGroupPrbsResp.astCase(ii).stSpectrumPrbs.aFreqAxis);

            fCheckSum(kk) = sum(abs(stGroupPrbsResp.astCase(ii).stSpectrumPrbs.astRespPrbs(idxExciteAxis).aFdVelMean0(1:end)));
            if fCheckSum(kk) < 100
                strTextError = sprintf('Invalid number: Case-%d, Axis-%d', ii, iExcitingAxisCtrlId);
                disp(strTextError);
                continue;
            end
            
            %aFreqAxisData(iStartDrawingFreq:nDataLen), 
            for ff = iStartDrawingFreq:1:nDataLen
                cellSpectrumMatrix(idxRow, ff - iStartDrawingFreq + 2) = ...
                    {stGroupPrbsResp.astCase(ii).stSpectrumPrbs.astRespPrbs(idxExciteAxis).aFreqSpectrumScaledFdVelSmooth(ff)};
                afSelfSpectrumMatrix(idxRow, ff - iStartDrawingFreq + 2) = ...
                    stGroupPrbsResp.astCase(ii).stSpectrumPrbs.astRespPrbs(idxExciteAxis).aFreqSpectrumScaledFdVelSmooth(ff);
            end
            idxRow = idxRow + 1;

        end
    end

    astCaseAxisXlsOutput(kk).cellSpectrumMatrix = cellSpectrumMatrix;
    astCaseAxisXlsOutput(kk).strXlsSheetName = strXlsSheetName;
    astCaseAxisXlsOutput(kk).afSelfSpectrumMatrix = afSelfSpectrumMatrix;  %% 
    astCaseAxisXlsOutput(kk).aFreqAxisDataLowFreqCutOff = aFreqAxisData(iStartDrawingFreq:nDataLen);
    if fCheckSum(kk) >= 100
        xlswrite(strXlsOutFullFilename, cellSpectrumMatrix,  strXlsSheetName, 'D5');
    end
end
