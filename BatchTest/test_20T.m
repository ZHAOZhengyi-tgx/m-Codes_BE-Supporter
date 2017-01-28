%% Korea-PCB Machine
test_group_make_wb_bh_waveform_mstr('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q3\Korea-PCB\20T-2__Y2012.M9.D26');
test_group_make_wb_bh_waveform_mstr('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q4\20T-0_Compare_CopleyServotronix\20T-2_WbParaWaveform_Y2012.M10.D17\20T-2_Y2012.M10.D17_H13_9G');
test_group_make_wb_bh_waveform_mstr('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q4\20T-0_Compare_CopleyServotronix\20T-2_WbParaWaveform_Y2012.M10.D17\20T-2_Y2012.M10.D17_h12_10G');
test_group_make_wb_bh_waveform_mstr('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q4\20T-0_Compare_CopleyServotronix\20T-2_WbParaWaveform_Y2012.M10.D17\20T-2_Y2012.M10.D17_H14_10G8G');
test_group_make_wb_bh_waveform_mstr('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q4\20T-0_Compare_CopleyServotronix\20T-2_WbParaWaveform_Y2012.M10.D17\20T-2_Wvfrm_H17_10g15K');

test_group_make_wb_bh_waveform_mstr('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q4\20T-0_Compare_CopleyServotronix\20T-2_WbParaWaveform_Y2012.M10.D18\_25K10g');
test_group_make_wb_bh_waveform_mstr('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q4\20T-0_Compare_CopleyServotronix\20T-2_WbParaWaveform_Y2012.M10.D18\_20K10g');

%%%
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\CDHD-Tuning\20T-2_VeloopStepTest_2012.9.24'); astOneGroupVelTestOut(1).stOneGroupVelTestOut = stOneGroupVelTestOut;
batch_save_xls_group_vel_step_test(astOneGroupVelTestOut);

test_group_make_spectrum_mstr('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q4\20T-0_Compare_CopleyServotronix\20T-2_Spectrum_xy-VL__2012.10.D16-D17')
test_group_make_BE_SineSwp_mstr('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q4\20T-0_Compare_CopleyServotronix\20T-2_Spectrum_xy-VL__2012.10.D16-D17');

%%% 22 Aug 2012
test_group_make_BE_SineSwp_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\CrossAxis_Ref\');
test_group_make_wb_bh_waveform_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\CrossAxis_Ref\'); close all;
test_group_make_spectrum_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\CrossAxis_Ref\');
%%% 22 Aug 2012
test_group_make_BE_SineSwp_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\20T-1_BL\22Aug\');
test_group_make_wb_bh_waveform_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\20T-1_BL\22Aug'); 
test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\20T-1_BL\22Aug\'); close all;
test_group_make_spectrum_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\20T-1_BL\22Aug'); close all;

%%%%%%%% 20T-0 (Sg-EFSIKA)
test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\20T-0-SgEFSIKA\20T-0_Y2012.M7.D29');
%% Comparison of Copley and ServoTronix
test_group_make_vel_loop_mstr('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q4\20T-0_Compare_CopleyServotronix\20T-0_Y2012.M10.D3');
test_group_make_spectrum_mstr('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q4\20T-0_Compare_CopleyServotronix\20T-0_Y2012.M10.D3');

test_group_make_vel_loop_mstr('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q4\20T-0_Compare_CopleyServotronix\20T-0_2012.10.5_SrvTronix');
test_group_make_spectrum_mstr('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q4\20T-0_Compare_CopleyServotronix\20T-0_2012.10.5_SrvTronix');
test_group_make_wb_bh_waveform_mstr('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q4\20T-0_Compare_CopleyServotronix\20T-0_2012.10.5_SrvTronix');

test_group_make_wb_bh_waveform_mstr('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q4\20T-0_Compare_CopleyServotronix\20T-0_Y2012.M10.D3');
test_group_make_wb_bh_waveform_mstr('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q4\20T-0_Compare_CopleyServotronix\20T-0_2012-10-04');
test_group_make_wb_bh_waveform_mstr('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q4\20T-0_Compare_CopleyServotronix\20T-0_2012.10.5');
%%%% Looping Reference from 13T
test_group_make_wb_bh_waveform_mstr('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q4\20T-0_Compare_CopleyServotronix\LoopingRef_13T\WB13T_JuLiang_Sept2012');

%% 13Aug2012
test_group_make_BE_SineSwp_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\20T-0-SgEFSIKA\20T-0_Y2012.M8.D13');
test_group_make_wb_bh_waveform_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\20T-0-SgEFSIKA\20T-0_Y2012.M8.D13');
test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\20T-0-SgEFSIKA\20T-0_Y2012.M8.D13');
test_group_make_spectrum_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\20T-0-SgEFSIKA\20T-0_Y2012.M8.D13');
%%15 Aug 2012
test_group_make_BE_SineSwp_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\YZ-DC\2012.8.15.H17.M56_SineSwp_WB13T-10\_AxTable.X'); close all;
test_group_make_BE_SineSwp_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\YZ-DC\2012.8.15.H17.M56_SineSwp_WB13T-10\_AxTable.Y'); close all;
test_group_make_BE_SineSwp_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\YZ-DC\2012.8.15.H17.M56_SineSwp_WB13T-10\_AxBond.Z'); close all;

%% Compare with 13V-0
test_group_make_BE_SineSwp_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\YZ-DC\2012.8.15.H15.M33_SineSwp_WB13V-0\_AxTable.X'); close all;
test_group_make_BE_SineSwp_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\YZ-DC\2012.8.15.H15.M33_SineSwp_WB13V-0\_AxTable.Y'); close all;
test_group_make_BE_SineSwp_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\YZ-DC\2012.8.15.H15.M33_SineSwp_WB13V-0\_AxBond.Z'); close all;

%% 14Aug2012
test_group_make_BE_SineSwp_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\YZ-DC\_SineSwp_WB20T-10_2012.8.14.H16.M31\__AxTable.X'); close all;
test_group_make_BE_SineSwp_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\YZ-DC\_SineSwp_WB20T-10_2012.8.14.H16.M31\__AxTable.Y'); close all;
test_group_make_BE_SineSwp_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\YZ-DC\_SineSwp_WB20T-10_2012.8.14.H16.M31\__AxBond.Z');

%29 July 2012
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\WB20T-1_Y2012.M7.D29'); astOneGroupVelTestOut(1).stOneGroupVelTestOut = stOneGroupVelTestOut;
batch_save_xls_group_vel_step_test(astOneGroupVelTestOut);

%% Bantam
test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\Servicing_2012Q2\13V-Z_bantam');

stOneGroupVelTestOut = test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\Tune_Bond.Z\Tuning_26July_13V\WB13V-0_VeloopStepTest_2012July26_NoCap'); astOneGroupVelTestOut(1).stOneGroupVelTestOut = stOneGroupVelTestOut;
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\Tune_Bond.Z\Tuning_26July_13V\WB13V-0_VeloopStepTest_20120726_with22mF'); astOneGroupVelTestOut(2).stOneGroupVelTestOut = stOneGroupVelTestOut;
batch_save_xls_group_vel_step_test(astOneGroupVelTestOut);
%%%%% 26July
test_group_plot_b1w_stop_srch('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\Tune_Bond.Z\Tuning_27July_13V_ResetDist=7.2mm');
test_ana_SineSweep_response('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q3\Korea-PCB\20T-2__Y2012.M9.D26\Spec_XYZ_2012.9.21.H16.M48_SineSwp_20T-2__AxTable.Y\MasterSineSwp_2012.9.21.H16.M48.txt');
test_ana_SineSweep_response('C:\Documents and Settings\All Users\Documents\BE_Mach@Customer\2012_Q3\Korea-PCB\20T-2__Y2012.M9.D26\Spec_XYZ_2012.9.21.H16.M46_SineSwp_20T-2__AxTable.X\MasterSineSwp_2012.9.21.H16.M46.txt');
%%%%% 25July
test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\Tune_Bond.Z')
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\Tune_Bond.Z\HighEnc'); astOneGroupVelTestOut(1).stOneGroupVelTestOut = stOneGroupVelTestOut;
batch_save_xls_group_vel_step_test(astOneGroupVelTestOut);


stOneGroupVelTestOut = test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\Tune_Bond.Z\HighEnc\encf=1.0'); astOneGroupVelTestOut(1).stOneGroupVelTestOut = stOneGroupVelTestOut;
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\Tune_Bond.Z\HighEnc\encf=0.5'); astOneGroupVelTestOut(2).stOneGroupVelTestOut = stOneGroupVelTestOut;
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\Tune_Bond.Z\HighEnc\encf=0.2'); astOneGroupVelTestOut(3).stOneGroupVelTestOut = stOneGroupVelTestOut;
batch_save_xls_group_vel_step_test(astOneGroupVelTestOut);
test_group_make_spectrum_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\Tune_Bond.Z\HighEnc')

stOneGroupVelTestOut = test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\Tune_Bond.Z\Tuning_25July_13V'); astOneGroupVelTestOut(1).stOneGroupVelTestOut = stOneGroupVelTestOut;
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\Auto-Tuning\Tune_Bond.Z\Tuning_10July_18V'); astOneGroupVelTestOut(2).stOneGroupVelTestOut = stOneGroupVelTestOut;
batch_save_xls_group_vel_step_test(astOneGroupVelTestOut);

%% Why use 15, 20, 25, 30 % of VelStep
test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\VeloopStepTest_20T')
test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\BL-ProblemMachine\WB13T-79');

%20T
test_group_make_spectrum_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T')

%% ACS-FRF
test_plot_acs_frf_output('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\X\FRF_ACS\20T_X_9A_15mm_g.frf'); clear all;
test_plot_acs_frf_output('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\X\FRF_ACS\20T_X_10A_15mm_g.frf'); clear all;
test_plot_acs_frf_output('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\X\FRF_ACS\20T_X_11A_15mm_g.frf'); clear all;
test_plot_acs_frf_output('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\X\FRF_ACS\20T_X_12A_15mm_g.frf'); clear all;
test_plot_acs_frf_output('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\X\FRF_ACS\20T_X_13A_15mm_g.frf'); clear all;
test_plot_acs_frf_output('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\X\FRF_ACS\20T_X_14A_15mm_g.frf'); clear all;

test_plot_acs_frf_output('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\X\FRF_ACS\20T_X_9A_30mm_g.frf'); clear all;
test_plot_acs_frf_output('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\X\FRF_ACS\20T_X_10A_30mm_g.frf'); clear all;
test_plot_acs_frf_output('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\X\FRF_ACS\20T_X_11A_30mm_g.frf'); clear all;
test_plot_acs_frf_output('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\X\FRF_ACS\20T_X_12A_30mm_g.frf'); clear all;
test_plot_acs_frf_output('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\X\FRF_ACS\20T_X_13A_30mm_g.frf'); clear all;
test_plot_acs_frf_output('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\X\FRF_ACS\20T_X_14A_30mm_g.frf'); clear all;

stOneGroupVelTestOut = test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\20T\X'); astOneGroupVelTestOut(1).stOneGroupVelTestOut = stOneGroupVelTestOut;
batch_save_xls_group_vel_step_test(astOneGroupVelTestOut);

%%% BE-Problem-Machines
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\BL-ProblemMachine\13T-45'); astOneGroupVelTestOut(1).stOneGroupVelTestOut = stOneGroupVelTestOut;
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\BL-ProblemMachine\WB13T-79'); astOneGroupVelTestOut(2).stOneGroupVelTestOut = stOneGroupVelTestOut;
batch_save_xls_group_vel_step_test(astOneGroupVelTestOut);
