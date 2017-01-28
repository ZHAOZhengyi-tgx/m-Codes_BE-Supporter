% aGram = [8, 34, 58, 83]';
% aForceFb = [-2850, -2100, -1500, -1020]';


%aGram = [0, 30, 45, 55]';
%aForceFb = [-6050, -6019, -5613, -5651]';

% aGram = [0, 45, 70]';
% aForceFb = [-4719, -3653, -3477]';

aGram = [0, 85, 95, 120, 120]';
aForceFb = [-4352, -3939, -3831, -3731, -3731]';

plot(aGram, aForceFb, '-*');
xlabel('gram')
ylabel('ForceFbAdc');
title('Force ratio calibration'); %% 11-12-2012

matRHS = [aForceFb, ones(size(aForceFb))];
aLinFit = inv(matRHS' * matRHS ) * matRHS' * aGram;
ForceRatio = aLinFit(1)

