clear 
close all
clc

%% Variable coordinates & weights [x, z] 
function F = root2d(x)

%WLx2 = -2.47015; %weight location 2, meters, x 
%WLx4 = 2.41681; %weight location 4, meters, x

Pul2 = [-2.42824, 2.962]; %pulley location 2, [X Z] meters
Pul4 = [2.41681, 2.965]; 

%T1x2 = Pul2(1) - CWL1(1);
%T1x4 = Pul4(1) - CWL1(1);

%T1z2 = Pul2(2) - CWL1(2);
%T1z4 = Pul4(2) - CWL1(2);

HW = 9.8 * [1.372]; %Laser weight, N   

CWL1 = 0.0254 * [-25.2, 36.7]; %Laser location 1, [X Z] meters

%CW1 = 9.8 * [1.0993, .8653]; %Counterweight by trial [pulley 2, pulley 4],newtons 

%% 1. Calculations for angle




%% 2. Z' calulations
a2 = atand((Pul2(2)-CWL1(2))/((Pul2(1)-CWL1(1)-x(1)))); %solves for pulley 2 alpha/beta/z' based on handout
b2 = asind(x(1)/sqrt((Pul4(2)-CWL1(2)) - x(1)^2+(Pul4(2)-CWL1(2))^2));
zprime2 = Pul2(1)*atand(a2 + b2);
m2 = sqrt((Pul2(1)-CWL1(1))^2+(Pul2(2)-CWL1(2))^2);

a4 = atand((Pul4(2)-CWL1(2))/((Pul4(1)-CWL1(1)-x(1)))); %solves for relevant components on pulley 4
b4 = asind(x(1)/sqrt((Pul4(2)-CWL1(2)) - x(1)^2+(Pul4(2)-CWL1(2))^2));
zprime4 = Pul4(1)*atand(a4 + b4);
m4 = sqrt((Pul4(1)-CWL1(1))^2+(Pul4(2)-CWL1(2))^2);

%Fx=0 equation
F(1) = (x(2) * (Pul2(1)-CWL1(1)))/m2 - (x(3) * (Pul4(1)-CWL1(1)))/m4;

%Fz=0 equation
F(2) = (x(2)*zprime2)/m2 + (x(3)*zprime4)/m4 + HW;

%moment equation
F(3) = abs(((Pul2(1)-CWL1(1))- x(1)) * zprime2)/m2 - ((Pul2(1)-CWL1(1))*(Pul2(2)-CWL1(2))/m2) - x(1);

end 

fun = @root2d;
x0 = [0.01905, 10.77, 8.48]
x = fsolve(fun,x0)


%% 5. STANDARD DEVIATION CALCULATION

Radii = [.001905,0.006205,0.004305]; %FILL IN WITH VALUES FROM TRIALS 1-3

Average = (sum(Radii, "all"))/3;
StanDev = ((sum((Radii-Average).^2))./(3))^.5;
StanDevRange = [Average - 3*StanDev, Average + 3*StanDev];

formatSpec = 'The Standard Deviation is %f2 meters. Its range is %f4 meters to %f5 meters.';
fprintf(formatSpec,StanDev,StanDevRange(1),StanDevRange(2));

