function M3Alg_014_05
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 Program Description 
%	This executive function calculates mean and std Tau for 5 different
%	
%
% Function Call
% 	[SSE] = M3Calibration_014_05(yL1,yH1,ts1,tau1,yData,time,heating)
%
% Input Arguments
%	none
%
% Output Arguments
%	none
%
% Assignment Information
%	Assignment:         Final Project
%  	Team ID:            014-05     
%  	Team Members:       Alex Pieprzycki, apieprzy@purdue.edu
%                       Colin Jamison, cjamison@purdue.edu
%                       Peter Swales, pswales@purdue.edu 
%						Micah Huffman, mhuffma11@purdue.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% INITIALIZATION ---
tic
data = csvread('fos_time_histories.csv');

time = data(:,1);	%Time data

rangeData = 21;		%Specifies which current model of thermocouple program is analyzing
oldRangeData = 1;	%Specifies which past range was anaylzed
aggregateTau = 0;	%5x20 matrix of tau values
aggregateSSE = 0;	%5x20 matrix of sse values
%% ____________________
%% CALCULATIONS ---
%Written by Alex Pieprzycki
i = 2;
j = 1;
while(j <= 5)	%Loops 5 times for the prototypes
	while(i <= rangeData)	%i keeps incrementing by one, rangeData incements by 20 after inner loop to increase to correct range
		%[minimum, maximum, timeStep, tau, isHeating] = M2Alg1_014_05(data(:,i), time);
		[minimum, maximum, timeStep, tau, isHeating] = M3Alg2_014_05([time, data(:,i)]);
		aggregateSSE(j,i-oldRangeData) = M3Calibration_014_05(minimum, maximum, timeStep, tau, data(:,i), time, isHeating);
		aggregateTau(j,i-oldRangeData) = tau;
		i = i+1;
	end
	oldRangeData = rangeData;
	rangeData = rangeData + 20;
	j = j + 1;
end

%Calculates means,std, and see stats for all models of thermocouple
meanFS1 = mean(aggregateTau(1,:));
stdFS1 = std(aggregateTau(1,:));
sseFS1 = mean(aggregateSSE(1,:));
meanFS2 = mean(aggregateTau(2,:));
stdFS2 = std(aggregateTau(2,:));
sseFS2 = mean(aggregateSSE(2,:));
meanFS3 = mean(aggregateTau(3,:));
stdFS3 = std(aggregateTau(3,:));
sseFS3 = mean(aggregateSSE(3,:));
meanFS4 = mean(aggregateTau(4,:));
stdFS4 = std(aggregateTau(4,:));
sseFS4 = mean(aggregateSSE(4,:));
meanFS5 = mean(aggregateTau(5,:));
stdFS5 = std(aggregateTau(5,:));
sseFS5 = mean(aggregateSSE(5,:));

%% ____________________
%% COMMAND WINDOW OUTPUTS ---
fprintf('\tMean\tStd\t\tMean SSE\n');
fprintf('FS1 %.4f\t%.4f\t%.4f\nFS2 %.4f\t%.4f\t%.4f\nFS3 %.4f\t%.4f\t%.4f\nFS4 %.4f\t%.4f\t%.4f\nFS5 %.4f\t%.4f\t%.4f\n',meanFS1,stdFS1,sseFS1,meanFS2,stdFS2,sseFS2,meanFS3,stdFS3,sseFS3,meanFS4,stdFS4,sseFS4,meanFS5,stdFS5,sseFS5);

[SSE,SST,r2,m,b] = M3Regr_014_05(aggregateTau);	%Calls the Regression function to plot a regression curve
fprintf('\nRegression line stats: \n');
fprintf('SSE: %.6f\nSST: %.6f\nr2: %.6f\nm: %.6f\nb: %.6f\n',SSE,SST,r2,m,b);
%% ____________________
%% ACADEMIC INTEGRITY STATEMENT ---
% I/We have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I/we provided
% access to my/our code to another. The project I/we am/are submitting
% is my/our own original work.
%% ____________________
toc

