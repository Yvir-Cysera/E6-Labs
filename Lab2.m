% 2/21/25
% ENGR006
% Lab 2 Matlab Code
% Steps:
% Inputting Variables (X,Y,Z) and Weight

% clean workspace, figures and command window
clear all
close all
clc

% Variables (meters) 
pulley2 = [-2.47015 2.962];
pulley4 = [2.39776 2.965];
knotWeight = 1.372 * 9.8; % Newtons

% We display these coordinates from our experiment for simplicity's sake
% Feel free to use your own dataset! :D
%disp("Copy and paste a line [x,y,z] and put into prompted location")
%disp("Trial 1 Knot Coord [-0.64008,1.25476]")
%disp("Trial 2 Knot Coord [-0.58928,1.07696]")
%disp("Trial 3 Knot Coord [-0.38354,0.92456]")

% input
%prompt = "Give a point for the knot: ";
%prompt2 = "Give the counterweights: ";
%knot = input(prompt);
knot = [-0.64008,1.25476];
disp(" ")
%disp("Trial 1 counterweights in Newtons [10.784133 8.488593]")
%disp("Trial 2 counterweights in Newtons [10.502586 8.488593]")
%disp("Trial 3 counterweights in Newtons [9.568674 8.488593]")
%WeightArry = input(prompt2);
WeightArry = [10.784133 8.488593];
disp(" ")

% pulley coordinates with knot as origin
vector2 = pulley2 - knot;
vector4 = pulley4 - knot;

% Distance from knot to the pulley on the x and z axis
distance2 = sqrt(((vector2(1)^2))+(vector2(2)^2));
distance4 = sqrt(((vector4(1)^2))+(vector4(2)^2));
% y axis ignored since we only have 2 dimensions

% find unit vector
lambda2 = vector2 ./ distance2;
lambda4 = vector4 ./ distance4;

% fsolve
%function F = myfun(x)

%F(1) = (x(1).*lambda2(1)) + (x(2).*lambda4(1));
%F(2) = (x(1).*lambda2(3)) + (x(2).*lambda4(3));
%F(3) = (x(3).*x(1)) - (cross(vector4,x(3)));

fun = @;
x0 = [0,0,0];
x = fsolve(fun,x0);
