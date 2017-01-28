function [stOutputWbPerformIndex, stDesireVoltage] = test_ana_wb_waveform(strFileFullName)

global iPlotFlag;

if ~exist('strFileFullName')
%    close all;
%    clear all;
    [Filename, Pathname] = uigetfile('*.m;*.dat', 'Pick an m file as output from wb waveform');
    strFileFullName = strcat(Pathname , Filename);
else
    aPosnBackSlash = strfind(strFileFullName, '\');
    Pathname = strFileFullName(1: aPosnBackSlash(end));
    Filename = strFileFullName(aPosnBackSlash(end)+1 : end);
end


WB_Waveform = ana_load_wb_waveform_data(strFileFullName);
%bsd_ok_trig_001

stDesireVoltage = plot_wb_waveform(WB_Waveform);
aLocDot = strfind(Filename, '.');

fRefPosnZ = WB_Waveform(:, 5);
fMinPosnZ = min(fRefPosnZ);
fMaxPosnZ = max(fRefPosnZ);
fFeedPosnZ = WB_Waveform(:, 6);

if iPlotFlag >= 2

%%%% Save Zoom-in waveform for velocity
    figure(2);
    axis([20, 500, -90, 40]);  %%% 200, 360,
    strSaveFilename_jpg = sprintf('%s\\_%s_BondVelCmdFb_.jpg', Pathname, Filename(aLocDot(1)-4: aLocDot(1) -1));
    saveas(gcf, strSaveFilename_jpg, 'jpg');

    figure(3);
    axis([20, 500,  fMinPosnZ, fMinPosnZ + 850]); %% 200, 360,
    strSaveFilename_jpg = sprintf('%s\\_%s_BondPosnCmdFb_.jpg', Pathname, Filename(aLocDot(1)-4: aLocDot(1) -1));
    saveas(gcf, strSaveFilename_jpg, 'jpg');

    figure(4);
    fFeedPosnX = WB_Waveform(:, 2);
    fRefPosnX = WB_Waveform(:, 1);
    fRefVelX = [diff(fRefPosnX); 0];
    fFeedVelX = [diff(fFeedPosnX); 0];
    axis([20, 500,  -20, 20]); %% 200, 360,
    strSaveFilename_jpg = sprintf('%s\\_%s_TableX_.jpg', Pathname, Filename(aLocDot(1)-4: aLocDot(1) -1));
    saveas(gcf, strSaveFilename_jpg, 'jpg');

    figure(5);
    fFeedPosnY = WB_Waveform(:, 4);
    fRefPosnY = WB_Waveform(:, 3);
    fRefVelY = [diff(fRefPosnY); 0];
    fFeedVelY = [diff(fFeedPosnY); 0];
    axis([20, 500,  -20, 20]); %% 200, 360,
    strSaveFilename_jpg = sprintf('%s\\_%s_TableY_.jpg', Pathname, Filename(aLocDot(1)-4: aLocDot(1) -1));
    saveas(gcf, strSaveFilename_jpg, 'jpg');

    figure(2);
    axis([20, 500, -500, 500]);  %%% 200, 360,

    figure(3);
    axis([20, 500,  fMinPosnZ, fMaxPosnZ+300]); %% 200, 360,
end
%input('Press any key to analyze and save file.')

astDirectory = dir(Pathname);
nLenDirFilename = length(astDirectory);
strFilenamePerformIdx = [];
for ii = 1:1:nLenDirFilename
    if length(astDirectory(ii).name) >= 4
        if astDirectory(ii).name(end-2:end) == 'txt'
            strFilenamePerformIdx = astDirectory(ii).name;
            break;
        end
    end
end

stOutputWbPerformIndex = [];
try
    stOutputWbPerformIndex = ana_wb_waveform(WB_Waveform);
catch
    strErrMessage = sprintf('Error analyzing some wires');
    disp(strErrMessage);
    %return;
end

if iPlotFlag >= 2
    figure(31);
    view(-37.5, 30);
    title('Looping Study');
    xlabel('X'); ylabel('Y'); zlabel('Z');
    strSaveFilename_jpg = sprintf('%s\\_%s_Looping_XYZ.jpg', Pathname, Filename(aLocDot(1)-4: aLocDot(1) -1));
    saveas(gcf, strSaveFilename_jpg, 'jpg');

    view(0, 90);
    strSaveFilename_jpg = sprintf('%s\\_%s_Looping_XY_.jpg', Pathname, Filename(aLocDot(1)-4: aLocDot(1) -1));
    saveas(gcf, strSaveFilename_jpg, 'jpg');

    figure(32);
    title('Maximum Sway Error');
    xlabel('X'); ylabel('Y');
    strSaveFilename_jpg = sprintf('%s\\_%s_LoopingMaxSwayError_XY.jpg', Pathname, Filename(aLocDot(1)-4: aLocDot(1) -1));
    saveas(gcf, strSaveFilename_jpg, 'jpg');

    figure(21);
    strSaveFilename_jpg = sprintf('%s\\_%s_DesireVoltageX.jpg', Pathname, Filename(aLocDot(1)-4: aLocDot(1) -1));
    saveas(gcf, strSaveFilename_jpg, 'jpg');

    figure(22);
    strSaveFilename_jpg = sprintf('%s\\_%s_DesireVoltageY.jpg', Pathname, Filename(aLocDot(1)-4: aLocDot(1) -1));
    saveas(gcf, strSaveFilename_jpg, 'jpg');
end    
    

