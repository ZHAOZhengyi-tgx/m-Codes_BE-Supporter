function iAppAxis = wb_map_axis_acs_2_app(idxAcsAxis, iMachineType)

if ~exist('iMachineType')
    iMachineType = 2;
end

if iMachineType == 2 || iMachineType == 5 || iMachineType == 3 ...
        || iMachineType == 10  || iMachineType == 11 %% 20120807
    switch (idxAcsAxis)
        case 0
            iAppAxis = 2;
        case 1
            iAppAxis = 1;
        case {4, 2}
            iAppAxis = 3;
        case 5
            iAppAxis = 4;
        otherwise
    end
    
else  %% default
    switch (idxAcsAxis)
        case 0
            iAppAxis = 1;
        case 1
            iAppAxis = 2;
        case {4, 2}
            iAppAxis = 3;
        case 5
            iAppAxis = 4;
        otherwise
    end
end