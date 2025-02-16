%Lab 1 Matlab Code
% Inputting Variables (X,Y,Z) and Weight
% Solving for Z'
% Using Adjusted Z' to solve for Tension
% Using Tension Equations to solve for Smalley-Pulley
clear
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
pulley2 = [-2.42824 1.62306 2.965];
pulley3 = [-2.41808 -1.72466 2.964];
pulley4 = [2.40284 -0.18034 2.962];
pulleySheaveRadius = 0.01905; % Corrected to metric (meters)
pulleyAxleRadius = 0.0047625; % also in meters
knotWeight = 1.372*9.8; % Newtons
%Variables end -- DO NOT TOUCH
%input
prompt = "Give a point for the knot: ";
knot = input(prompt);
%pulley coordinates with knot as origin
pulley2 = pulley2 - knot;
pulley3 = pulley3 - knot;
pulley4 = pulley4 - knot;
%ANGLE CALCULATIONS
%theta  = alpha + beta
%Pulley 2
z2 = pulley2(3);
%Distance from knot to the pully on the x and y axis
a2 = ((pulley2(1)^2) + (pulley2(2)^2))^(1/2);
alpha2 = atand(z2/(a2-pulleySheaveRadius));
%beta
pulleyCenter2 = pulley2(3)/sind(alpha2);
beta2 = asind(pulleySheaveRadius/pulleyCenter2);
theta2 = alpha2 +beta2;
%Pulley 3
z3 = pulley3(3);
%Distance from knot to the pully on the x and y axis
a3 = ((pulley3(1)^2) + (pulley3(2)^2))^(1/2);
alpha3 = atand(z3/(a3-pulleySheaveRadius));
%beta
pullCenter3 = pulley3(3)/sind(alpha3);
beta3 = asind(pulleySheaveRadius/pullCenter3);
theta3 = alpha3 +beta3;
%Pulley 4
z4 = pulley4(3);
%Distance from knot to the pully on the x and y axis
a4 = ((pulley4(1)^2) + (pulley4(2)^2))^(1/2);
alpha4 = atand(z4/(a4-pulleySheaveRadius));
%beta
pullCenter4 = pulley4(3)/sind(alpha4);
beta4 = asind(pulleySheaveRadius/pullCenter4);
theta4 = alpha4 +beta4;
%Recalculated z coord
pulley2(3) = a2 * tand(theta2);
pulley3(3) = a3 * tand(theta3);
pulley4(3) = a4 * tand(theta4);
%Lambda
Lambda2 = pulley2./norm(pulley2);
Lambda3 = pulley3./norm(pulley3);
Lambda4 = pulley4./norm(pulley4);
Matrix = [Lambda2(1) Lambda3(1) Lambda4(1);Lambda2(2) Lambda3(2) Lambda4(2);Lambda2(3) Lambda3(3) Lambda4(3)];
Sum = [0; 0; knotWeight];
Result2 = Matrix\Sum
%Result2 = Result*(3.3291*9.8)
