%% STANDARD DEVIATION CALCULATION
clc 
Radii = [.001905,0.006205,0.004305]; %FILL IN WITH VALUES FROM TRIALS 1-3

Average = (sum(Radii, "all"))/3;
StanDev = ((sum((Radii-Average).^2))./(3))^.5;
StanDevRange = [Average - 3*StanDev, Average + 3*StanDev];

formatSpec = 'The Standard Deviation is %f2 meters. Its range is %f4 meters to %f5 meters.';
fprintf(formatSpec,StanDev,StanDevRange(1),StanDevRange(2))
