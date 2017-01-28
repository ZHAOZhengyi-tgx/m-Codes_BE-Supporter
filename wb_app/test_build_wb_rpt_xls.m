function [stOutputWbPerformRpt] =test_build_wb_rpt_xls()


[Filename, Pathname] = uigetfile('*.txt', 'Pick an txt file as output from wb-perform-report');
strFileFullName = strcat(Pathname , Filename);

stOutputWbPerformRpt = ana_load_wb_perform_rpt(strFileFullName);
