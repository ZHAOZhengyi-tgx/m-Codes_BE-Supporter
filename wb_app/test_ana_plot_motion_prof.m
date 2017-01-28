function stCalcOutput = test_ana_plot_motion_prof()
%close all;
%clear all;
stCalcOutput = [];

%DataTraj_00;
%DataTraj_01;
%DataTraj_02
%DataTraj_03

[Filename, Pathname] = uigetfile('*.m', 'Pick an m file as output from one profile motion Test');
strFileFullName = strcat(Pathname , Filename);
stTrajDataLoad = ana_load_one_prof_move_data(strFileFullName);


stInputAnaSpec.fThresholdSettleTime = 10;
stInputAnaSpec.stTrajSetting = stTrajDataLoad.stTrajSetting;

stCalcOutput = traj_calc_plot(stTrajDataLoad.TrajData, stInputAnaSpec);