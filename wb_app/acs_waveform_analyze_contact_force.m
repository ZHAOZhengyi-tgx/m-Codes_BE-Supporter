function acs_waveform_analyze_contact_force(stForceWaveformAcsOutput)

% CH1: REF Velocity
% CH2: PE
% CH3: AIN - Force Sensor
% CH4: DOUT



afRefVel = stForceWaveformAcsOutput.astChannelAcsScope(1).afDataInScope;
afPositionError = stForceWaveformAcsOutput.astChannelAcsScope(2).afDataInScope;
afAnalogInput = stForceWaveformAcsOutput.astChannelAcsScope(3).afDataInScope;
afDrvOutput = stForceWaveformAcsOutput.astChannelAcsScope(4).afDataInScope;

nLen = length(afRefVel);

for ii = 1:1:nLen - 100
    if afRefVel(ii) == 0 afRefVel(ii+1) <0 afPositionError(ii)
end

