function test_plot_acs_frf_output(strFileFullName, strCurveFont)
% The MIT License (MIT)
% 
% Copyright (c) 2016 ZHAOZhengyi-tgx
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%
% Zhengyi John ZHAO <zzytgx@gmail.com>
%

%close all;
%clear all;

if ~exist('strFileFullName')
    [strFilename, strPathname] = uigetfile('*.frf', 'Pick an m file as output from ACS FRF analysis');
    strFileFullName = strcat(strPathname , strFilename);
else
    aList = strfind(strFileFullName, '\');
    strPathname = strFileFullName(1: aList(end));
    strFilename = strFileFullName(aList(end) + 1: end);    
end

delete('temp.m')
 
stOutputLoadFile = ana_load_acs_frf(strFileFullName);

frf_plot_acs_output(stOutputLoadFile, strCurveFont);

figure(2); subplot(2,1,1); xlim([100,5000]); subplot(2,1,2); xlim([100,5000]); ylim([-190, 190]); title(strFilename);
saveas(gcf, strcat(strFileFullName, '_Plant.jpg'), 'jpg');

figure(3); subplot(2,1,1); xlim([100,5000]);  subplot(2,1,2); xlim([100,5000]); ylim([-190, 190]); title(strFilename);
saveas(gcf, strcat(strFileFullName, '_Open.jpg'), 'jpg');

figure(1); subplot(2,1,1); xlim([100,5000]);  subplot(2,1,2); xlim([100,5000]); ylim([-190, 190]); title(strFilename);
saveas(gcf, strcat(strFileFullName, '_CloseLoop.jpg'), 'jpg');
