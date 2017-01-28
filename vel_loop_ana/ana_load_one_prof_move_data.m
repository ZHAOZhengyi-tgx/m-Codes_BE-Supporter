function TrajData = ana_load_one_prof_move_data(strFileFullName)

strLabelStartTrajData = 'TrajData';
nlenLabelTrajData = length(strLabelStartTrajData);

fptr = fopen(strFileFullName);

while ~feof(fptr)
    strLine = fgets(fptr);
    if length(strLine) >= 8
        if strLine(1:nlenLabelTrajData) == strLabelStartTrajData
            break;
        else
            eval(strLine);
        end
    end
end

TrajData(1,:) = sscanf(strLine, 'TrajData = [%f, %f, %f, %f, %f');
ii = 0;
while ~feof(fptr)
    strLine = fgetl(fptr);
    ii = ii + 1;
    if strLine(end) == ';'
        TrajData(ii + 1,:) = sscanf(strLine, '%f, %f, %f, %f, %f];');
    else
        TrajData(ii + 1,:) = sscanf(strLine, '%f, %f, %f, %f, %f');
    end
end
fclose(fptr);
