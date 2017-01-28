function astOneGroupVelTestOut = test_group_make_vel_loop_mstr(strPathTargetFolder)

%strPathTargetFolder = 'I:\BE_WB_Data_Spectrum\BH_study\071_BH\71-1\'
strVelStepResponseFolderHeader = '*VeloopStepTest_*';
strVelStepResponseGroupFileHeader = 'VelStepGroupTestCases*.m';

strVelStepResponseTableAxisWaveformFileHeader = 'Table*.m';
strVelStepResponseBndHdAxisWaveformFileHeader = 'Bond*.m';

astOneGroupVelTestOut = [];

try
    chdir(strPathTargetFolder);
catch
    strErrMessage = sprintf('Folder NOT exist: %s', strPathname);
    disp(strErrMessage);
    return;
end

strFindFolderString = dir(strVelStepResponseFolderHeader);
nNumFolder = length(strFindFolderString);


parfor ii = 1:1:nNumFolder
    
    strPathname = sprintf('%s\\%s\\', strPathTargetFolder, strFindFolderString(ii).name);
    try
        chdir(strPathname);
    catch
        strErrMessage = sprintf('Folder NOT exist: %s', strPathname);
        disp(strErrMessage);
        continue;
    end

    ii
    strFindFileString = dir(strVelStepResponseGroupFileHeader);
    nNumFile = length(strFindFileString);
    for jj = 1:1:nNumFile
        strFullFilename = sprintf('%s', strPathname, strFindFileString(jj).name);
        disp(strFullFilename)
        stOneGroupVelTestOut = test_plot_group_vel_step_test(strFullFilename);
        astOneGroupVelTestOut(ii).astVelStepGroupTestAnalyze = stOneGroupVelTestOut.astVelStepGroupTestAnalyze;
        astOneGroupVelTestOut(ii).stTestInfo = stOneGroupVelTestOut.stTestInfo;

        close all; 
    end

    strFindFileString = dir(strVelStepResponseTableAxisWaveformFileHeader);
    nNumFile = length(strFindFileString);
    for jj = 1:1:nNumFile
        strFullFilename = sprintf('%s', strPathname, strFindFileString(jj).name);
        disp(strFullFilename)
        [stOutputAccDrvCmd, stOutputVelStepTimePerform] = test_plot_one_vel_step_test(strFullFilename);
        close all;
    end
    
    strFindFileString = dir(strVelStepResponseBndHdAxisWaveformFileHeader);
    nNumFile = length(strFindFileString);
    for jj = 1:1:nNumFile
        strFullFilename = sprintf('%s', strPathname, strFindFileString(jj).name);
        disp(strFullFilename)
        [stOutputAccDrvCmd, stOutputVelStepTimePerform] = test_plot_one_vel_step_test(strFullFilename);
        close all;
    end
    
    chdir(strPathTargetFolder)
end

% aLocBackSlash = strfind(strPathTargetFolder, '\');
% strFileGenerateMaster = sprintf('VelStepResponse_WhN_master_%s_%s.m',  ...
%     strPathTargetFolder(aLocBackSlash(end - 1)+1: aLocBackSlash(end)-1), ...
%     strPathTargetFolder(aLocBackSlash(end)+1: end));
% 
% aLocMinus = strfind(strFileGenerateMaster, '-');
% for jj = 1:1:length(aLocMinus)
%     strFileGenerateMaster(aLocMinus(jj)) = '.';
% end
% 
% strFullPathnameGenerateMaster = sprintf('%s\\%s', strPathTargetFolder, strFileGenerateMaster);
%     
% fptr = fopen(strFullPathnameGenerateMaster, 'w');
% for ii = 1:1:nNumFolder
%     strPathname = sprintf('%s\\%s\\', strPathTargetFolder, strFindFolderString(ii).name);
%     strFullFilename = sprintf('%sPrbsGroupTestCases.txt', strPathname);
%     fprintf(fptr, 'test_ana_prbs_response(''%s'') \r\n', strFullFilename);
% end
% fclose(fptr);

