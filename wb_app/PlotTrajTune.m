close all;
clear all;

%DataTraj_00;
%DataTraj_01;
%DataTraj_02
DataTraj_03

afPosnErr = TrajData(:,1);
afRefPosn = TrajData(:,2);
afFeedVel = TrajData(:,3);
afRefVel = TrajData(:,4);
afDac = TrajData(:,5);
afFeedPosn = afRefPosn - afPosnErr;

traj_calc_plot;