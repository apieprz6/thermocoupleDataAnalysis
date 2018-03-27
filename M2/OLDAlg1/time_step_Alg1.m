function [timeStep,minimum] = time_step_Alg1(t,y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
%   Calculates timestep and minimum
%
% Function Call
% 	Algorithm1
%
% Input Arguments
%   1. Time - vector for time of data
%	2. y -  the y that corresponds to the time vector
%
% Output Arguments
%   1. timeStep - timeStep of the passed data
%	2. minimum - returns the mimimum value of the data
%
% Assigment Information
%   Assignment:  	    Project M2
%   Authors:             Alexander Pieprzycki, apieprzy@purdue.edu
%						 Micah Huffman, huffma11@purdue.edu
%   Team ID:            014-05
%  	Contributor:        Name, login@purdue [repeat for each]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%TAKING AVERAGE OF FIRST 50 POINTS TO ESTABLISH "CRUDE MINIMUM"
minimum = mean(y(1:50));	%Crude minimum for the data
sizeOfArray = length(y);	%How many data points we're dealing with
lastPointData = y(sizeOfArray);	%This is the last data point
i = 50;
inLoop = 1;
timeStep = 0;
baseCase = abs(lastPointData - minimum);

%Runs through all data points until the the while loop finds when the 
% moving average of 50 points increases past a 1.75 value buffer
while(i < sizeOfArray && inLoop == 1)		
    step = mean(y(i: i + 50));
    if(abs(lastPointData - step) < abs(baseCase - 1.75))
        timeStep = i;
        inLoop = 0;
    end
    i = i + 1;
end

minimum = mean(y(1:timeStep));
timeStep = t(timeStep);
