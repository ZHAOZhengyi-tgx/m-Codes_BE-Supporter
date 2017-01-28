%%%%%% 18V X-Table Limit check
test_group_get_wb_bh_wvfrm_perfrm_index_save_xls('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\18V_check-X-Speed-Limit\18V-0_WbParaWaveform_Y2012.M7.D12');

%%%%%%
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_WB_DATA\VeLoopStepTest\Copley-Linearity\Copley_Pk18A\CopleyLinearity_3'); astOneGroupVelTestOut(1).stOneGroupVelTestOut = stOneGroupVelTestOut;
batch_save_xls_group_vel_step_test(astOneGroupVelTestOut);

%%%%%% 30pcMaxVel
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_WB_DATA\VeLoopStepTest\Copley-Linearity\Copley_Pk18A\MaxVel30pc'); astOneGroupVelTestOut(1).stOneGroupVelTestOut = stOneGroupVelTestOut;
batch_save_xls_group_vel_step_test(astOneGroupVelTestOut);
%%%%%% 20pcMaxVel
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_WB_DATA\VeLoopStepTest\Copley-Linearity\Copley_Pk18A\MaxVel20pc');  astOneGroupVelTestOut(1).stOneGroupVelTestOut = stOneGroupVelTestOut;
batch_save_xls_group_vel_step_test(astOneGroupVelTestOut);

%%%%%%%%%%%%%%% 15% of MaxVel, 12 Amp of Peak Curr in Copley
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_WB_DATA\VeLoopStepTest\Copley-Linearity'); astOneGroupVelTestOut(1).stOneGroupVelTestOut = stOneGroupVelTestOut;
batch_save_xls_group_vel_step_test(astOneGroupVelTestOut);


%%%%%%%%%%%%%%%% 12V-62
test_group_make_spectrum_mstr('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\0');
test_group_make_spectrum_mstr('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\8');
test_group_make_spectrum_mstr('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\16');
test_group_make_spectrum_mstr('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\24');
test_group_make_spectrum_mstr('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\48');

stOneGroupVelTestOut = test_group_make_vel_loop_mstr('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\0');
astOneGroupSpeedUpVelTestOut(1).stOneGroupVelTestOut = stOneGroupVelTestOut; astOneGroupSpeedUpVelTestOut(1).strCaseName = '13V62-0h';
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\8');
astOneGroupSpeedUpVelTestOut(2).stOneGroupVelTestOut = stOneGroupVelTestOut; astOneGroupSpeedUpVelTestOut(2).strCaseName = '13V62-8h';
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\16');
astOneGroupSpeedUpVelTestOut(3).stOneGroupVelTestOut = stOneGroupVelTestOut; astOneGroupSpeedUpVelTestOut(3).strCaseName = '13V62-16h';
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\24');
astOneGroupSpeedUpVelTestOut(4).stOneGroupVelTestOut = stOneGroupVelTestOut; astOneGroupSpeedUpVelTestOut(4).strCaseName = '13V62-24h';
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\48');
astOneGroupSpeedUpVelTestOut(5).stOneGroupVelTestOut = stOneGroupVelTestOut; astOneGroupSpeedUpVelTestOut(5).strCaseName = '13V62-24h';
batch_save_xls_group_vel_step_test(astOneGroupSpeedUpVelTestOut);

test_group_get_wb_bh_wvfrm_perfrm_index_save_xls('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\0');
test_group_get_wb_bh_wvfrm_perfrm_index_save_xls('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\8');
test_group_get_wb_bh_wvfrm_perfrm_index_save_xls('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\16');
test_group_get_wb_bh_wvfrm_perfrm_index_save_xls('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\24');
test_group_get_wb_bh_wvfrm_perfrm_index_save_xls('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\48');

test_group_make_wb_bh_waveform_mstr('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\0');
test_group_make_wb_bh_waveform_mstr('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\8');
test_group_make_wb_bh_waveform_mstr('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\16');
test_group_make_wb_bh_waveform_mstr('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\24');
test_group_make_wb_bh_waveform_mstr('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\48');

%%% New XYZ 2 configs
test_group_make_spectrum_mstr('I:\BE_WB_Data_Spectrum\SpeedUp_2012Q1\WB13V\Bnd_Z_Separate-48VDC');
test_group_make_spectrum_mstr('I:\BE_WB_Data_Spectrum\SpeedUp_2012Q1\WB13V\Bnd-Z_TblY_Share48VDC');

%%% One 48VDC for Y and Z, WB13V
%%% Separate 48VDC for Y and Z, WB13V
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('I:\BE_WB_Data_Spectrum\SpeedUp_2012Q1\WB13V\Bnd_Z_Separate-48VDC'); astOneGroupSpeedUpVelTestOut(1).stOneGroupVelTestOut = stOneGroupVelTestOut; astOneGroupSpeedUpVelTestOut(1).strCaseName = 'Two48VDC';
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('I:\BE_WB_Data_Spectrum\SpeedUp_2012Q1\WB13V\Bnd-Z_TblY_Share48VDC'); astOneGroupSpeedUpVelTestOut(2).stOneGroupVelTestOut = stOneGroupVelTestOut; astOneGroupSpeedUpVelTestOut(2).strCaseName = 'One48VDC';
batch_save_xls_group_vel_step_test(astOneGroupSpeedUpVelTestOut);

test_group_get_wb_bh_wvfrm_perfrm_index_save_xls('I:\BE_WB_Data_Spectrum\SpeedUp_2012Q1\WB13V\Bnd_Z_Separate-48VDC');
test_group_get_wb_bh_wvfrm_perfrm_index_save_xls('I:\BE_WB_Data_Spectrum\SpeedUp_2012Q1\WB13V\Bnd-Z_TblY_Share48VDC');

test_group_make_wb_bh_waveform_mstr('I:\BE_WB_Data_Spectrum\SpeedUp_2012Q1\WB13V\Bnd_Z_Separate-48VDC');
test_group_make_wb_bh_waveform_mstr('I:\BE_WB_Data_Spectrum\SpeedUp_2012Q1\WB13V\Bnd-Z_TblY_Share48VDC');
%% 2012.02.15
test_group_make_wb_bh_waveform_mstr('I:\BE_WB_Data_Spectrum\SpeedUp_2012Q1\WB13V\Bnd_Z_Separate-48VDC\2012.2.15');
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('I:\BE_WB_Data_Spectrum\SpeedUp_2012Q1\WB13V\Bnd_Z_Separate-48VDC\2012.2.15'); 
astOneGroupSpeedUpVelTestOut(1).stOneGroupVelTestOut = stOneGroupVelTestOut; astOneGroupSpeedUpVelTestOut(1).strCaseName = 'Two48VDC-Feb15';
stOneGroupVelTestOut = test_group_make_vel_loop_mstr('I:\BE_WB_Data_Spectrum\SpeedUp_2012Q1\WB13V\Bnd_Z_Separate-48VDC\Y2012.M2.D16'); 
astOneGroupSpeedUpVelTestOut(2).stOneGroupVelTestOut = stOneGroupVelTestOut; astOneGroupSpeedUpVelTestOut(2).strCaseName = 'Two48VDC-Feb16';
batch_save_xls_group_vel_step_test(astOneGroupSpeedUpVelTestOut);

%%% 2012.02.16
test_group_make_wb_bh_waveform_mstr('I:\BE_WB_Data_Spectrum\SpeedUp_2012Q1\WB13V\Bnd_Z_Separate-48VDC\Y2012.M2.D16');
test_group_make_spectrum_mstr('\\Zzy_acer-4736\be_wb_data\SpeedUp\XY_heatup_BH\Y2012.M2.D16');
% I:\BE_WB_Data_Spectrum\SpeedUp_2012Q1\WB13V\Bnd_Z_Separate-48VDC\Y2012.M2
% .D16
%%% 
test_ana_wb_waveform('C:\Documents and Settings\All Users\Documents\BE_WB_DATA\SpeedUp\XY_heatup_BH\WB13V-0_WbParaWaveform_Y2012.M1.D9_H9.m31\WvfmDryRun_2012-1-9_9-31-8.m');
test_ana_wb_waveform('C:\Documents and Settings\All Users\Documents\BE_WB_DATA\SpeedUp\XY_heatup_BH\WB13V-0_WbParaWaveform_Y2012.M1.D9_H12.m47\WvfmBond_2012-1-9_12-47-43.m')
test_ana_wb_waveform('C:\Documents and Settings\All Users\Documents\BE_WB_DATA\SpeedUp\XY_heatup_BH\WB13V-0_WbParaWaveform_Y2012.M1.D9_H17.m6\WvfmBond_2012-1-9_17-6-6.m');
test_ana_wb_waveform('C:\Documents and Settings\All Users\Documents\BE_WB_DATA\SpeedUp\XY_heatup_BH\WB13V-0_WbParaWaveform_Y2012.M1.D10_H10.m2\WvfmBond_2012-1-10_10-2-8.m');

%%% 10Jan2012
test_ana_wb_waveform('C:\Documents and Settings\All Users\Documents\BE_WB_DATA\SpeedUp\XY_heatup_BH\WB13V-0_WbParaWaveform_Y2012.M1.D11_H10.m50_CompareWithD1.10\WvfmBond_2012-1-11_10-50-39.m');
test_ana_wb_waveform('C:\Documents and Settings\All Users\Documents\BE_WB_DATA\SpeedUp\XY_heatup_BH\WB13V-0_WbParaWaveform_Y2012.M1.D10_H17.m57_CurrentSpeed_100min\WvfmBond_2012-1-10_17-57-43.m');
test_ana_wb_waveform('C:\Documents and Settings\All Users\Documents\BE_WB_DATA\SpeedUp\XY_heatup_BH\WB13V-0_WbParaWaveform_Y2012.M1.D11_H9.m15_LastWire_D1.10_H19.M30\WvfmBond_2012-1-11_9-15-9.m');

%%% 20120112
test_ana_wb_waveform('C:\Documents and Settings\All Users\Documents\BE_WB_DATA\SpeedUp\XY_heatup_BH\WB13V-0_WbParaWaveform_Y2012.M1.D12_H10.m4\WvfmDryRun_2012-1-12_10-4-21.m');
test_ana_wb_waveform('C:\Documents and Settings\All Users\Documents\BE_WB_DATA\SpeedUp\XY_heatup_BH\WB13V-0_WbParaWaveform_Y2012.M1.D12_H10.m34 (table 36degc dry run 10 min)\WvfmDryRun_2012-1-12_10-34-31.m');
test_ana_wb_waveform('C:\Documents and Settings\All Users\Documents\BE_WB_DATA\SpeedUp\XY_heatup_BH\WB13V-0_WbParaWaveform_Y2012.M1.D12_H13.m32(table 42degc dry run 90 min)\WvfmDryRun_2012-1-12_13-32-11.m');

