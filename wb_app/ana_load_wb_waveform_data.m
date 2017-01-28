function WB_Waveform = ana_load_wb_waveform_data(strFileFullName)

strLabelStartTrajData = '[RPX, FPX, RPY, FPY, RPZ, FPZ, MFZ, DW] = [';
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
        WB_Waveform(ii,:) = sscanf(strLine, '%f, %f, %f, %f, %f, %f, %f, %f;');
    end
end
fclose(fptr);
