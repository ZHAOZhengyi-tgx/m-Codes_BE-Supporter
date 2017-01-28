function iFigId = wb_spec_get_fig_id_by_machine_type_app_axis(idxAppExcite, idxAppResp, iMachineType)

% if iMachineType 

if iMachineType == 2
    switch (idxAppExcite)
        case 1
            idxFigExcite = 2;
        case 2
            idxFigExcite = 1;
        case 3
            idxFigExcite = 3;
        case 4
            idxFigExcite = 4;
        otherwise
    end
    switch (idxAppResp)
        case 1
            idxFigResp = 2;
        case 2
            idxFigResp = 1;
        case 3
            idxFigResp = 3;
        case 4
            idxFigResp = 4;
        otherwise
    end
    
else  %% default
    idxFigExcite = idxAppExcite;
    idxFigResp = idxAppResp;
end

iFigId = idxFigExcite * 100 + idxFigResp * 10;
