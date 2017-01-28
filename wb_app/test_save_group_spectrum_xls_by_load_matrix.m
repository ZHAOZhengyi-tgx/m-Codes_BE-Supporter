function test_save_group_spectrum_xls_by_load_matrix(astGroupSpectrumMcEvent, strPathTargetFolder)

%% bakup current path
strCurrentPath = chdir(); 

strSpectrumFolderHeader = 'Spec_*';
chdir(strPathTargetFolder);
strFindFolderString = dir(strSpectrumFolderHeader);
nNumFolder = length(strFindFolderString);

aLocBackSlash = strfind(strPathTargetFolder, '\');
if length(aLocBackSlash) >= 2
    strFileGenerateMaster = sprintf('Spectrum_WhN_master_%s_%s.m',  ...
        strPathTargetFolder(aLocBackSlash(end - 1)+1: aLocBackSlash(end)-1), ...
        strPathTargetFolder(aLocBackSlash(end)+1: end));
else
    strFileGenerateMaster = sprintf('Spectrum_WhN_master_%s.m',  ...
        strPathTargetFolder(aLocBackSlash(end)+1: end));
end

aLocMinus = strfind(strFileGenerateMaster, '-');
for jj = 1:1:length(aLocMinus)
    strFileGenerateMaster(aLocMinus(jj)) = '.';
end

strFullPathnameGenerateMaster = sprintf('%s\\%s', strPathTargetFolder, strFileGenerateMaster);
    
fptr = fopen(strFullPathnameGenerateMaster, 'w');
for ii = 1:1:nNumFolder
    strPathname = sprintf('%s\\%s\\', strPathTargetFolder, strFindFolderString(ii).name);
    strFullFilename = sprintf('%sPrbsGroupTestCases.txt', strPathname);
    stStringFullFilename = dir(strFullFilename);
    if length(stStringFullFilename) < 1
        continue;
    end        
    fprintf(fptr, 'test_ana_prbs_response(''%s'') \r\n', strFullFilename);
end
fclose(fptr);

strFileGenerateMaster = sprintf('Spectrum_WhN_master_%s_%s.xls',  ...
    strPathTargetFolder(aLocBackSlash(end - 1)+1: aLocBackSlash(end)-1), ...
    strPathTargetFolder(aLocBackSlash(end)+1: end));
strFullPathnameXlsMaster = sprintf('%s\\%s', strCurrentPath, strFileGenerateMaster);  %% strPathTargetFolder
nTotalSheets = length(astGroupSpectrumMcEvent(end).stGroupPrbsResp.astCaseAxisXlsOutput);

for kk = 1:1:nTotalSheets
    idxRow = 1;
    idxCol = 1;
    
    for ii = 1:1:nNumFolder
        stCaseAxisXlsOutput = astGroupSpectrumMcEvent(ii).stGroupPrbsResp.astCaseAxisXlsOutput(kk);
        [nLenRow, nLenCol] = size(stCaseAxisXlsOutput.cellSpectrumMatrix);
        matXlsCellSpectrum(idxRow:(idxRow + nLenRow -1), :) =  stCaseAxisXlsOutput.cellSpectrumMatrix;
        aCellPathname(idxRow, 1) = {strFindFolderString(ii).name};
%%stGroupPrbsResp.astCase(:).stSpectrumPrbs.astRespPrbs(idxExciteAxis).aFreqSpectrumScaledFdVelSmooth
%% stGroupPrbsResp.astCase(ii).stSpectrumPrbs.astRespPrbs(idxExciteAxis).aFreqSpectrumScaledFdVelSmooth
        %afSelfSpectrumMatrix = astGroupSpectrumMcEvent(ii).stGroupPrbsResp.stCaseAxisXlsOutput(kk).afSelfSpectrumMatrix;
        matXlsCellSpectrum((idxRow + nLenRow), 1) = {'max'};
        matXlsCellSpectrum((idxRow + nLenRow + 1), 1) = {'min'};
        matXlsCellSpectrum((idxRow + nLenRow + 2), 1) = {'ave'};
        matXlsCellSpectrum((idxRow + nLenRow + 3), 1) = {'std'};
        for jj = 2:1:nLenCol
            matXlsCellSpectrum((idxRow + nLenRow), jj) =  {max(stCaseAxisXlsOutput.afSelfSpectrumMatrix(2:end, jj))};
            matXlsCellSpectrum((idxRow + nLenRow + 1), jj) =  {min(stCaseAxisXlsOutput.afSelfSpectrumMatrix(2:end, jj))};
            matXlsCellSpectrum((idxRow + nLenRow + 2), jj) =  {mean(stCaseAxisXlsOutput.afSelfSpectrumMatrix(2:end, jj))};
            matXlsCellSpectrum((idxRow + nLenRow + 3), jj) =  {std(stCaseAxisXlsOutput.afSelfSpectrumMatrix(2:end, jj))};
        end
        
        idxRow = idxRow + nLenRow + 4 + 1; %% add 4 rows: max, min, ave, std
    end
    xlswrite(strFullPathnameXlsMaster, matXlsCellSpectrum,  stCaseAxisXlsOutput.strXlsSheetName, 'D5');
    xlswrite(strFullPathnameXlsMaster, aCellPathname,  stCaseAxisXlsOutput.strXlsSheetName, 'C5')
end


