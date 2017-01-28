%%% make dir for WB13V
for ii = 1:100
    if ii <= 9
        strPathName = sprintf('13V-00%d', ii);
    elseif ii <=99
        strPathName = sprintf('13V-0%d', ii);
    end
    
    stFindPath = dir(strPathName);
    if length(stFindPath) == 0
        mkdir(strPathName);
    end
end

%%% make dir for WB13T
for ii = 1:100
    if ii <= 9
        strPathName = sprintf('13T-00%d', ii);
    elseif ii <=99
        strPathName = sprintf('13T-0%d', ii);
    else
        strPathName = sprintf('13T-%d', ii);
    end
    
    stFindPath = dir(strPathName);
    if length(stFindPath) == 0
        mkdir(strPathName);
    end
end