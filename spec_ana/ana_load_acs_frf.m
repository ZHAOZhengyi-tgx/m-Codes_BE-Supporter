function stOutputLoadFile = ana_load_acs_frf(strFileFullName)
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

stOutputLoadFile = [];

%anLocFrfInFilename = strfind(strFileFullName, 'frf');
%rename(
%eval(
eval('delete temp.m');
strNewFileName = 'temp.m'; %strcat(strFileFullName(1: anLocFrfInFilename(end) - 1), 'm');
anLocMinusInFilename = strfind(strNewFileName, '-');
if length(anLocMinusInFilename) >= 1
    strNewFileName(anLocMinusInFilename(end)) = '_';
end

fptrNew = fopen(strNewFileName, 'w');
fptrFrf = fopen(strFileFullName, 'r');

while(~ feof(fptrFrf))
    strReadLine = fgetl(fptrFrf);
    fprintf(fptrNew, '%s\n', strReadLine);

end

fclose(fptrNew);
fclose(fptrFrf);

eval('temp');

stOutputLoadFile.Measure_Plant_Data = Measure_Plant_Data;
stOutputLoadFile.Measure_Open_Loop_Data = Measure_Open_Loop_Data;
stOutputLoadFile.Measure_Closed_Loop_Data = Measure_Closed_Loop_Data;
