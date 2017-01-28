function astOutput =test_plot_save_E60_m_4K(strFolderName)

astOutput = [];
if(~exist('strFolderName'))
    [strFilename, strFolderName, filterindex] = uigetfile('*.M', 'Pick an M-file for E60 servo-data');
    strFileFullName = strcat(strFolderName, strFilename);
else
    aList = strfind(strFolderName, '\');
    strFolderName = strFolderName(1: aList(end));
    strFilename = strFolderName(aList(end) + 1: end);    
end

iPlotFlag = 0;
% strFolderName = 'C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2013-Q1\Peneng_FairChild\21Feb\MtnZ_CV-AV_PE';
strFolderNameWithM = sprintf('%s\\*.m', strFolderName);

strHomePath = pwd;
chdir(strFolderName);

stFileFind = dir(strFolderNameWithM)
nLen = length(stFileFind);
warning('off','MATLAB:dispatcher:InexactMatch');

for ii = 1:1:nLen

    clear z;
    stFileFind(ii).name(end) = 'm';
    eval(stFileFind(ii).name(1:(end-2)));
    if iPlotFlag > 1
        figure(4000);
        clf;
        subplot(2,2,1); plot(z(:,1)); grid on; zoom on;
        subplot(2,2,2);  plot(z(:,2)); grid on; zoom on; 
        subplot(2,2,3); plot(z(:,3)), grid on; zoom on;
        subplot(2,2,4); plot(z(:,4)); grid on; zoom on;
        strSaveFileNameJpg = sprintf('%s.jpg', stFileFind(ii).name(1:(end-2)));
    
        saveas(gcf, strSaveFileNameJpg, 'jpg');
    end
    astOutput(ii).aWvfrm4K = z;
end

chdir(strHomePath);
warning('on','MATLAB:dispatcher:InexactMatch')
