function Algorithm1Copy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
%   Calculates important variables using algorithm one and outputs them
%
% Function Call
% 	Algorithm1
%
% Input Arguments
%   None
%
% Output Arguments
%   none
%
% Assigment Information
%   Assignment:  	    Project M2
%   Authors:             Alexander Pieprzycki, apieprzy@purdue.edu
%						 Micah Huffman, huffma11@purdue.edu
%   Team ID:            014-05
%  	Contributor:        Name, login@purdue [repeat for each]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = csvread('M2_Data_HEATING_NoisyCalibration.csv',0,0);
tHeat = data(:,1);
yHeat = data(:,2);
data = csvread('M2_Data_COOLING_NoisyCalibration.csv',0,0);
tCool = data(:,1);
yCool = data(:,2);
data = csvread('M2_Data_HEATING_CleanCalibration.csv',0,0);
tHeatClean = data(:,1);
yHeatClean = data(:,2);
data = csvread('M2_Data_COOLING_CleanCalibration.csv',0,0);
tCoolClean = data(:,1);
yCoolClean = data(:,2);
counter = 0;

%GETTING VALUES
[minimum, maximum, timeStep, tau, counter] = Algorithm1(yHeatClean,tHeatClean,counter);

fprintf('CLEAN HEATING\nyMin: %.4f\nyMax: %.4f\nTimeStep: %.4f\nTau: %.4f\n\n',minimum, maximum, timeStep, tau);

[minimum, maximum, timeStep, tau, counter] = Algorithm1(yHeat,tHeat, counter);

fprintf('NOISY HEATING\nyMin: %.4f\nyMax: %.4f\nTimeStep: %.4f\nTau: %.4f\n\n',minimum, maximum, timeStep, tau);

[minimum, maximum, timeStep, tau, counter] = Algorithm1(yCoolClean,tCoolClean, counter);

fprintf('CLEAN COOLING\nyMin: %.4f\nyMax: %.4f\nTimeStep: %.4f\nTau: %.4f\n\n',minimum, maximum, timeStep, tau);

[minimum, maximum, timeStep, tau, counter] = Algorithm1(yCool,tCool, counter);

fprintf('NOISY COOLING\nyMin: %.4f\nyMax: %.4f\nTimeStep: %.4f\nTau: %.4f\n\n',minimum, maximum, timeStep, tau);

%PLOTTING RESULTS
