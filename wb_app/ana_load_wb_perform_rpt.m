function stOutputWbPerformRpt = ana_load_wb_perform_rpt(strFileFullName)

strCnstLabelWireStart = 'WireNo';
nLenCnstLabelWireStart = length(strCnstLabelWireStart);
strCnstLabelBondHead = '%%BondHead Points @ Time Point';
nLenCnstLabelBondHead = length(strCnstLabelBondHead);

fptr = fopen(strFileFullName);

nTotalWire = 0;
while ~feof(fptr)
    strLine = fgets(fptr);
    if length(strLine) >= nLenCnstLabelWireStart
        if strLine(1:nLenCnstLabelWireStart) == strCnstLabelWireStart
            aReadNum = sscanf(strLine, 'WireNo.%d, IsDryRun:%d');
            nTotalWire = aReadNum(1) + 1;
            stOutputWbPerformRpt(nTotalWire).iFlagIsDryRun = aReadNum(2);
        end
    end
    if length(strLine) >= nLenCnstLabelBondHead
        if strLine(1:nLenCnstLabelBondHead) == strCnstLabelBondHead
            strLine = fgets(fptr);
            strLine = fgets(fptr);
            idxStartCnt = strfind(strLine, 'Time')
            aReadNum = sscanf(strLine(1:(idxStartCnt-4)), 'aPosn_1stSearchHeight = [%8.1f, %8.1f];')
            stOutputWbPerformRpt(nTotalWire).stMoveTo1stSrchHeight.aPosn_1stSearchHeight = [aReadNum(1), aReadNum(2)];
            aReadNum = sscanf(strLine(idxStartCnt:end), 'Time [%d, %d]');
            stOutputWbPerformRpt(nTotalWire).stMoveTo1stSrchHeight.aTimePoints = [aReadNum(1), aReadNum(2)];
        end
    end
end

fclose(fptr);