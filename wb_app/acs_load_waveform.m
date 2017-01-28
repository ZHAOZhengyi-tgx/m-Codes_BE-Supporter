%% ACS load waveform
function stOutput = acs_load_waveform(strFileFullName)

stOutput = [];
global iPlotFlag;

if ~exist('strFileFullName')
    [Filename, Pathname] = uigetfile('*.sgn', 'Pick an sgn file as output from ACS-MMI Scope');
    strFileFullName = strcat(Pathname , Filename);
else
    aPosnBackSlash = strfind(strFileFullName, '\');
    Pathname = strFileFullName(1: aPosnBackSlash(end));
    Filename = strFileFullName(aPosnBackSlash(end)+1 : end);
end

stOutput.strPathname = Pathname;
stOutput.strFilename = Filename;
%%%%%%%%%%%%%%%
strChannelHead = '===== CH';
nLenLabelData = 8;

strAxisLabelHead = 'Axis=';
strSampleTimeLabelHead = 'Sampling Time=';
strVariableNameLabelHead = 'Variable=';
strAxisNameLabelHead = 'Name';
%%%%%%%%%%%%%%%
fptr = fopen(strFileFullName);

strLine = fgets(fptr);
while ~feof(fptr)
    if length(strLine) >= nLenLabelData
        if strLine(1:length(strChannelHead)) == strChannelHead
            nChannel = sscanf(strLine, '===== CH%d');
            %%%% load data for one channel
            
            
            while strLine(1) ~= '}'
                strLine = fgets(fptr);
                if(length(strLine) >= 15)
                    if strLine(1:length(strSampleTimeLabelHead)) == strSampleTimeLabelHead
                        tSampleTime = sscanf(strLine, 'Sampling Time=%f');
                    elseif strLine(1:length(strVariableNameLabelHead)) == strVariableNameLabelHead
                        strVariableName = strLine(((length(strVariableNameLabelHead) + 2) : end));
                    end
                elseif(length(strLine) >= 6)
                    if strLine(1:length(strAxisLabelHead)) == strAxisLabelHead
                        idxAxisACS = sscanf(strLine, 'Axis=%d');
                    end
                    if strLine(1:length(strAxisNameLabelHead)) == strAxisNameLabelHead
                        strAxisName = strLine(((length(strAxisNameLabelHead)+2) : end)); %sscanf(strLine, 'Name=%d');
                    end
                else
                end
            end
            
            %%
            aFindUnderLine = strfind(strVariableName, '_');
            for ii=1:1:length(aFindUnderLine)
                strVariableName(aFindUnderLine(ii)) = '-';
            end
            %%
            astChannelAcsScope(nChannel).fSampleTime_ms = tSampleTime;
            astChannelAcsScope(nChannel).strVariableName = strVariableName;
            astChannelAcsScope(nChannel).idxAxisACS = idxAxisACS;
            astChannelAcsScope(nChannel).strAxisName = strAxisName;
            
            strLine = fgets(fptr);
            ii = 1;
            while ~feof(fptr) && strLine(1) ~= '='                
                fDataRead = sscanf(strLine, '%f');
                if prod(size(fDataRead)) == 0
                    strLine
                    fDataRead = -sscanf(strLine, ' -%f')
                end
                astChannelAcsScope(nChannel).afDataInScope(ii) = fDataRead;
                
                strLine = fgets(fptr);
                ii = ii + 1;
            end
        else
            strLine = fgets(fptr);
        end
    else
        strLine = fgets(fptr);
    end
end

fclose(fptr);
%%
    if iPlotFlag >= 2
        figure(1)
        for jj = 1:1:4
            subplot(2,2,jj);
            plot(astChannelAcsScope(jj).afDataInScope);
            legend(astChannelAcsScope(jj).strVariableName); % strAxisName 
            grid on;
        end    
    end


stOutput.astChannelAcsScope = astChannelAcsScope;

