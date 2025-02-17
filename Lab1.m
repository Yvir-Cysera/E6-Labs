%Lab 1 Matlab Code
% Inputting Variables (X,Y,Z) and Weight
% Solving for Z'
% Using Adjusted Z' to solve for Tension
% Using Tension Equations to solve for Smalley-Pulley
clear all
close all
clc

% Function set -- Only usable for 3D
function newVector = vectorMake(start, finish)
   newVector = finish - start;
end

function length = vectorLength(vector)
   length = sqrt((vector(1,1)^2) + (vector(1,2)^2) + (vector(1,3)^2));
end

function unitVector = normalize(vector)
   unitVector = vector ./ vectorLength(vector);
end

function forceComponent = findComponent(vector, mag)
   forceComponent = normalize(vector) .* mag;
end

function moment = findMoment(distanceVector, force)
   moment = cross(distanceVector, force);
end
% Function set -- FINISH

%Variables (meters) -- DO NOT TOUCH
pulley1 = [-2.42824 1.62306 2.965];
pulley2 = [-2.41808 -1.72466 2.964];
pulley3 = [2.40284 -0.18034 2.962];
pulleySheaveRadius = 0.01905; % Corrected to metric (meters)
pulleyAxleRadius = 0.0047625; % also in meters
knotWeight = 1.372*9.8; % Newtons
%Variables end -- DO NOT TOUCH
disp("copy and paste a line [x,y,z] and put into prompted location")
disp("Trial 1 Knot Coord [-1.1049,-0.32512,1.74498]")
disp("Trial 2 Knot Coord [-1.38176,-0.58674,2.06756]")
disp("Trial 3 Knot Coord [-1.39192,-0.74422,2.15138]")

%input
prompt = "Give a point for the knot: ";
prompt2 = "Give the counterweights: ";
knot = input(prompt);
disp(" ")
disp("Trial 1 counterweights in Newtons [9.164502 11.755323 11.738646]")
disp("Trial 2 counterweights in Newtons [9.164502 14.38146 11.738646]")
disp("Trial 3 counterweights in Newtons [7.715565 14.38146 11.738646]")
WeightArry = input(prompt2);
disp(" ")
%pulley coordinates with knot as origin
pulley1 = pulley1 - knot;
pulley2 = pulley2 - knot;
pulley3 = pulley3 - knot;


%ANGLE CALCUALTIONS
%theta  = alpha + beta
%Pulley 1
z1 = pulley1(3);
%Distance from knot to the pully on the x and y axis
a1 = sqrt(((pulley1(1)^2) + (pulley1(2)^2)));
alpha1 = atand(z1/(a1-pulleySheaveRadius));
%beta
pulleyCenter1 = pulley1(3)/sind(alpha1);
beta1 = asind(pulleySheaveRadius/pulleyCenter1);
theta1 = alpha1 +beta1;
%Pulley 2
z2 = pulley2(3);
%Distance from knot to the pully on the x and y axis
a2 = sqrt(((pulley2(1)^2) + (pulley2(2)^2)));
alpha2 = atand(z2/(a2-pulleySheaveRadius));
%beta
pullCenter2 = pulley2(3)/sind(alpha2);
beta2 = asind(pulleySheaveRadius/pullCenter2);
theta2 = alpha2 +beta2;
%Pulley 3
z3 = pulley3(3);
%Distance from knot to the pully on the x and y axis
a3 = sqrt(((pulley3(1)^2) + (pulley3(2)^2)));
alpha3 = atand(z3/(a3-pulleySheaveRadius));
%beta
pullCenter3 = pulley3(3)/sind(alpha3);
beta3 = asind(pulleySheaveRadius/pullCenter3);
theta3 = alpha3 +beta3;
%Recalculated z coord
pulley1(3) = a1 * tand(theta1);
pulley2(3) = a2 * tand(theta2);
pulley3(3) = a3 * tand(theta3);
%Lambda
Lambda1 = pulley1./norm(pulley1);
Lambda2 = pulley2./norm(pulley2);
Lambda3 = pulley3./norm(pulley3);

Matrix = [Lambda1(1) Lambda2(1) Lambda3(1);Lambda1(2) Lambda2(2) Lambda3(2);Lambda1(3) Lambda2(3) Lambda3(3)];
Sum = [0; 0; knotWeight];
Result = Matrix\Sum;
%Result2 = Matrix\Sum; %renames as new variable so as to not overwrite
%Result2 = Result*(3.3291*9.8)

%% FRICTION COEFFICENT CALCULATION %%


TensionArry =  Result.'; %Turns Column into row
%WeightArry = 9.8.*[0.9342, 1.1983, 1.1966; 0.9342, 1.466, 1.1966; 0.7865, 1.466, 1.1966]; %gives collected weights in N
%WeightArry = 9.8.*[0.9342, 1.1983, 1.1966]; %gives collected weights in N



friction = abs(TensionArry-WeightArry)*(pulleySheaveRadius/pulleyAxleRadius);
coeff = friction./sqrt(abs(TensionArry + WeightArry).^2 - friction.^2);


%SMALL PULLEY ESTIMATION USING ORGINAL Z VALUES


%Lambda

pulley2 = [-2.42824 1.62306 2.965];
pulley3 = [-2.41808 -1.72466 2.964];
pulley4 = [2.40284 -0.18034 2.962];

Apulley2 = pulley2 - knot; %overwrites pulley variable with distance from knot
Apulley3 = pulley3 - knot;
Apulley4 = pulley4 - knot;

M2=sqrt(sum(Apulley2.^2));
M3=sqrt(sum(Apulley3.^2));
M4=sqrt(sum(Apulley4.^2));

u2 = Apulley2./M2;
u3 = Apulley3./M3;
u4 = Apulley4./M4;

%% setting up system of equations using given Weight of Knot
syms T_2 T_3 T_4
eqnX = T_2*u2(1) + T_3*u3(1) + T_4*u4(1) == 0; 
eqnY = T_2*u2(2) + T_3*u3(2) + T_4*u4(2) == 0;
eqnZ = T_2*u2(3) + T_3*u3(3) + T_4*u4(3) -knotWeight == 0;

sol = solve([eqnX,eqnY,eqnZ],[T_2, T_3, T_4]);
%% Results for Part a).
Tension_2sol = sol.T_2;
Tension_3sol = sol.T_3;
Tension_4sol = sol.T_4;

fprintf("With the real Pulley and Z', the tension of rope 2 is approximately %f\n",Result(1))
fprintf("The tension of rope 3 is approximately %f\n",Result(2))
fprintf("The tension of rope 4 is approximately %f\n",Result(3))
fprintf('\n')
fprintf('The friction in pulley 2 is %f\n',friction(1))
fprintf('The friction in pulley 3 is %f\n',friction(2))
fprintf('The friction in pulley 4 is %f\n',friction(3))
fprintf('\n')
fprintf("The friction coefficent of rope 2 is %f\n",coeff(1))
fprintf("TThe friction coefficent of rope 3 is %f\n",coeff(2))
fprintf("The friction coefficent of rope 4 is %f\n",coeff(3))
fprintf('\n')
fprintf("With the Small Pulley Approximation (SPA), the tension of rope 2 is approximately %f\n",Tension_2sol)
fprintf("With SPA, the tension of rope 3 is approximately %f\n",Tension_3sol)
fprintf("With SPA, the tension of rope 4 is approximately %f\n",Tension_4sol)