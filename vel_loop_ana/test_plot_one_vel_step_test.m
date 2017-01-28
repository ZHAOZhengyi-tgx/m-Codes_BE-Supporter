function [stOutputAccDrvCmd, stOutputVelStepTimePerform] = test_plot_one_vel_step_test(strFileFullName)

close all;
%clear all;

if ~exist('strFileFullName')
    [strFilename, strPathname] = uigetfile('*.m', 'Pick an m file as output from Velocity Step Response');
    strFileFullName = strcat(strPathname , strFilename);
else
    aList = strfind(strFileFullName, '\');
    strPathname = strFileFullName(1: aList(end));
    strFilename = strFileFullName(aList(end) + 1: end);    
end

%VelStepGroupTestCases
%[Filename, Pathname] = uigetfile('*.m', 'Pick an m file as output from one VelocityStep Test');
%strFileFullName = strcat(Pathname , Filename);
stOutputLoadFile = ana_load_one_vel_step_test_m_file(strFileFullName);

stOutputCalcByLibC = stOutputLoadFile.stOutputCalcByLibC;
TrajData = stOutputLoadFile.TrajData;

[stOutputAccDrvCmd, stOutputVelStepTimePerform] = ana_vel_step_data(TrajData);

figure(20); xlim([100,400]);
saveas(gcf, strcat(strFileFullName, '_Vel.jpg'), 'jpg');

figure(21); xlim([100,400]);
saveas(gcf, strcat(strFileFullName, '_DrvCmd.jpg'), 'jpg');

figure(23); xlim([100,400]);
saveas(gcf, strcat(strFileFullName, '_FbAcc.jpg'), 'jpg');
