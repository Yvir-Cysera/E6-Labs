clear 
close all
clc

%% DATA
% Pul2 = [-2.42824, 2.962]; %pulley location 2, [X Z] meters
% Pul4 = [2.41681, 2.965]; 
% 
% HW = 9.8 * [1.372]; %Laser weight, N   
% 
% CWL1 = 0.0254 * [-25.2, 36.7]; %Laser location 1, [X Z] meters
% CWL2 = 0.0254 * [-23.2, 29.7];
% CWL3 = 0.0254 * [-15.1, 23.7];
% 
% CW1 = 9.8 * [1.0993, .8653]; %Counterweight by trial [pulley 2, pulley 4], newtons
% CW2 = 9.8 * [1.0706, .8653];
% CW3 = 9.8 * [.9754, .8653];



%% TRIAL 1 
% 0. Variable coordinates & weights [x, z] 

fun = @root2d;
x0 = [.01905, 10.77, 8.4699] %estimate based on counterweights and given value for radius
x = fsolve(fun,x0)

function F = root2d(x)

Pul2 = [-2.42824, 2.962]; %pulley location 2, [X Z] meters
Pul4 = [2.41681, 2.965]; 

HW = 9.8 * [1.372]; %Laser weight, N   

CWL1 = 0.0254 * [-25.2, 36.7]; %Laser location 1, [X Z] meters

CW1 = 9.8 * [1.0993, .8653]; %Counterweight by trial [pulley 2, pulley 4],newtons 


%% 1. Calculation Shortcuts

x2 = Pul2(1) - CWL1(1); %distance from centerweight to pulley in x and z
x4 = Pul4(1) - CWL1(1);

z2 = Pul2(2) - CWL1(2);
z4 = Pul4(2) - CWL1(2);

%% 2. Z' calulations
a2 = atand( x2 / (x2-x(1)) ); %solves for pulley 2 alpha/beta/z' based z' equation
b2 = asind(x(1)/sqrt(z4 - x(1)^2 + (z4)^2));
zprime2 = Pul2(1)*atand(a2 + b2);
m2 = sqrt(x2^2+z2^2);

a4 = atand(z4)/(x4-x(1)); %solves for pulley 4
b4 = asind(x(1) / sqrt((z4 - x(1))^2 + z4^2));
zprime4 = Pul4(1)*atand(a4 + b4);
m4 = sqrt(x4^2+z4^2);

%% 3 Equations in terms of radius

%Fx=0 equation
F(1) = (x(2) * x2)/m2 - (x(3) * z4)/m4;

%Fz=0 equation
F(2) = (x(2)*zprime2)/m2 + (x(3)*zprime4)/m4 - HW;

%moment equation
F(3) = abs(((x2 - x(1)) * zprime2)/m2 - (x2*z2)/m2) - x(1);

end 
x

%% TRIAL 2 
% 0. Variable coordinates & weights [x, z] 

fun = @root2d;
y0 = [.01905, 10.49188, 8.47994] %estimate based on counterweights and given value for radius
y = fsolve(fun,y0)

function A = root2d(y)

Pul2 = [-2.42824, 2.962]; %pulley location 2, [X Z] meters
Pul4 = [2.41681, 2.965]; 

HW = 9.8 * [1.372]; %Laser weight, N   

CWL2 = 0.0254 * [-23.2, 29.7];

%CW2 = 9.8 * [1.0706, .8653]; %gives basis for estimates

%% 1. Calculation Shortcuts

x2 = Pul2(1) - CWL2(1); %distance from centerweight to pulley in x and z
x4 = Pul4(1) - CWL2(1);

z2 = Pul2(2) - CWL2(2);
z4 = Pul4(2) - CWL2(2);

%% 2. Z' calulations
a2 = atand( x2 / (x2-x(1)) ); %solves for pulley 2 alpha/beta/z' based z' equation
b2 = asind(x(1)/sqrt(z4 - x(1)^2 + (z4)^2));
zprime2 = Pul2(1)*atand(a2 + b2);
m2 = sqrt(x2^2+z2^2);

a4 = atand(z4)/(x4-x(1)); %solves for pulley 4
b4 = asind(x(1) / sqrt((z4 - x(1))^2 + z4^2));
zprime4 = Pul4(1)*atand(a4 + b4);
m4 = sqrt(x4^2+z4^2);

%% 3 Equations in terms of radius

%Fx=0 equation
A(1) = (x(2) * x2)/m2 - (x(3) * z4)/m4;

%Fz=0 equation
A(2) = (x(2)*zprime2)/m2 + (x(3)*zprime4)/m4 - HW;

%moment equation
A(3) = abs(((x2 - x(1)) * zprime2)/m2 - (x2*z2)/m2) - x(1);

end 

%% TRIAL 3 
% 0. Variable coordinates & weights [x, z] 

fun = @root2d;
z0 = [.01905, 9.55892, 8.47994]; %estimate based on counterweights and given value for radius
z = fsolve(fun,x0);

function B = root2d(z);

Pul2 = [-2.42824, 2.962]; %pulley location 2, [X Z] meters
Pul4 = [2.41681, 2.965]; 

HW = 9.8 * [1.372]; %Laser weight, N   

CWL3 = 0.0254 * [-15.1, 23.7];

% CW3 = 9.8 * [.9754, .8653];


%% 1. Calculation Shortcuts

x2 = Pul2(1) - CWL3(1); %distance from centerweight to pulley in x and z
x4 = Pul4(1) - CWL3(1);

z2 = Pul2(2) - CWL3(2);
z4 = Pul4(2) - CWL3(2);

%% 2. Z' calulations
a2 = atand( x2 / (x2-x(1)) ); %solves for pulley 2 alpha/beta/z' based z' equation
b2 = asind(x(1)/sqrt(z4 - x(1)^2 + (z4)^2));
zprime2 = Pul2(1)*atand(a2 + b2);
m2 = sqrt(x2^2+z2^2);

a4 = atand(z4)/(x4-x(1)); %solves for pulley 4
b4 = asind(x(1) / sqrt((z4 - x(1))^2 + z4^2));
zprime4 = Pul4(1)*atand(a4 + b4);
m4 = sqrt(x4^2+z4^2);

%% 3 Equations in terms of radius

%Fx=0 equation
B(1) = (x(2) * x2)/m2 - (x(3) * z4)/m4;

%Fz=0 equation
B(2) = (x(2)*zprime2)/m2 + (x(3)*zprime4)/m4 - HW;

%moment equation
B(3) = abs(((x2 - x(1)) * zprime2)/m2 - (x2*z2)/m2) - x(1);

end 


%% 5. STANDARD DEVIATION CALCULATION

Radii = [x(1), y(1), z(1)]; 

Average = mean(Radii);
StanDev = ((sum((Radii-Average).^2))./(3))^.5;
StanDevRange = [Average - 3*StanDev, Average + 3*StanDev];

formatSpec = 'The Standard Deviation is %f2 meters. Its range is %f4 meters to %f5 meters.'
fprintf(formatSpec,StanDev,StanDevRange(1),StanDevRange(2))

