function Algorithm1
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

%GETTING VALUES
[timeStep,minimum] = time_step_Alg1(tHeatClean,yHeatClean);
[maximum,tau] = tau_Alg1(yHeatClean,tHeatClean,timeStep,minimum);

fprintf('CLEAN HEATING\nyMin: %.4f\nyMax: %.4f\nTimeStep: %.4f\nTau: %.4f\n\n',minimum, maximum, timeStep, tau);

[timeStep,minimum] = time_step_Alg1(tHeat,yHeat);
[maximum,tau] = tau_Alg1(yHeat,tHeat,timeStep,minimum);

fprintf('NOISY HEATING\nyMin: %.4f\nyMax: %.4f\nTimeStep: %.4f\nTau: %.4f\n\n',minimum, maximum, timeStep, tau);

[timeStep,minimum] = time_step_Alg1(tCoolClean,yCoolClean);
[maximum,tau] = tau_Alg1(yCoolClean,tCoolClean,timeStep,minimum);

fprintf('CLEAN COOLING\nyMin: %.4f\nyMax: %.4f\nTimeStep: %.4f\nTau: %.4f\n\n',minimum, maximum, timeStep, tau);

[timeStep,minimum] = time_step_Alg1(tCool,yCool);
[maximum,tau] = tau_Alg1(yCool,tCool,timeStep,minimum);

fprintf('NOISY COOLING\nyMin: %.4f\nyMax: %.4f\nTimeStep: %.4f\nTau: %.4f\n\n',minimum, maximum, timeStep, tau);

%PLOTTING RESULTS
