function WB_B1W_waveform = ana_load_wb_b1w_tune_data(strFileFullName)

strLabelStartTrajData = 'aTuneB1W_StopSrch = [';
nlenLabelTrajData = length(strLabelStartTrajData);

fptr = fopen(strFileFullName);

while ~feof(fptr)
    strLine = fgets(fptr);
    if length(strLine) >= 11
        if strLine(1:nlenLabelTrajData) == strLabelStartTrajData
            break;
        else
            %eval(strLine);
        end
    end
end

%WB_Waveform(1,:) = sscanf(strLine, 'WB_Waveform = [%f, %f, %f, %f, %f, %f, %f, %f;');
ii = 0;
while ~feof(fptr)
    strLine = fgetl(fptr);
    ii = ii + 1;
    if strLine(1:2) == '];'
        break;
    else
        WB_B1W_waveform(ii,:) = sscanf(strLine, '%f, %f, %f, %f, %f, %f, %f, %f;');
    end
end
fclose(fptr);