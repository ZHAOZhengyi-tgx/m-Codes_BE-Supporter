
%%%%%%

test_ana_SineSweep_response('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\18V_check-X-Speed-Limit\18V_17July\Spec_XY_2012.7.17.H17.M37_SineSwp_18V-0__AxTable.X\MasterSineSwp_2012.7.17.H17.M37.txt');
test_ana_SineSweep_response('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\18V_check-X-Speed-Limit\18V_17July\Spec_XY_2012.7.17.H17.M40_SineSwp_18V-0__AxTable.Y\MasterSineSwp_2012.7.17.H17.M40.txt');

test_ana_SineSweep_response('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\18V_check-X-Speed-Limit\18V_17July\Spec_XYZ_2012.7.17.H20.M37_SineSwp_18V-0__AxTable.X\MasterSineSwp_2012.7.17.H20.M37.txt');
test_ana_SineSweep_response('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\18V_check-X-Speed-Limit\18V_17July\Spec_XYZ_2012.7.17.H20.M40_SineSwp_18V-0__AxTable.Y\MasterSineSwp_2012.7.17.H20.M40.txt');
test_ana_SineSweep_response('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\18V_check-X-Speed-Limit\18V_17July\Spec_XYZ_2012.7.17.H20.M43_SineSwp_18V-0__AxBond.Z\MasterSineSwp_2012.7.17.H20.M43.txt');

test_group_get_wb_bh_wvfrm_perfrm_index_save_xls('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\18V_check-X-Speed-Limit\18V_16July')

stOneGroupVelTestOut = test_group_make_vel_loop_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\18V_check-X-Speed-Limit\18V_16July'); astOneGroupVelTestOut(1).stOneGroupVelTestOut = stOneGroupVelTestOut;
batch_save_xls_group_vel_step_test(astOneGroupVelTestOut);

test_group_make_spectrum_mstr('E:\Users\JohnZHAO\BE_Mach@Customer\2012_Q3\18V_check-X-Speed-Limit\18V_16July');

%%%%%% 18V X-Table Limit check
test_group_get_wb_bh_wvfrm_perfrm_index_save_xls('I:\BE_WB_Data_Spectrum\DryRunDrifting\WB13V_062\0');

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
