function [SSE,SST,r2,m,b] = M3Regr_014_05(tau)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 Program Description 
%	This function graps all 100 time histories of different thermocouple models
%	by their price vs tau value. Then creates a regression line modling the price
%	versus tau value.
%
% Function Call
% 	[SSE,SST,r2] = M3Regr_014_05(tau)
%
% Input Arguments
%	1. tau -  this is a 5x20 matrix of all time history tau values 
%
% Output Arguments
%	1. SSE: sum of squares of error for regression line
%	2. SST: SST for the regression line
%	3. r2: r^2 value for the regression line
%   4. m: slop of best fit line
%   5. b: b of best fit line
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

%Written by Micah Huffman
price1 = ones(1,20) * 15.77;	%Creates a 1,20 matrixs of all the respective prices
price2 = ones(1,20) * 10.61;
price3 = ones(1,20) * 2.69;
price4 = ones(1,20) * 1.23;
price5 = ones(1,20) * 0.11;

%% ____________________
%% CALCULATIONS ---

%Written by Micah Huffman
price = [price1 price2 price3 price4 price5];		%Concatenates price vectors
tauNew = [tau(1,:) tau(2,:) tau(3,:) tau(4,:) tau(5,:)];	%Concatenates matrix of taus

%Creates a regression of linearized data
pricelog = log10(price);
tauCoeffs = polyfit(tauNew,pricelog,1);
m = 10^tauCoeffs(1);
b = 10^tauCoeffs(2);
tauPlot = [0:.01:2];
polytau = b * m .^ tauPlot;


%Written by Colin Jamison
%Computes the r^2 of the line
coeffs = polyfit(pricelog, tauNew, 1);
regressTau = polyval(coeffs,pricelog);
SSE = sum((tauNew - regressTau).^2);
SST = sum((tauNew - mean(regressTau)).^2);
r2 = 1 - SSE / SST;

%% ____________________
%% FORMATTED TEXT & FIGURE DISPLAYS ---
%Written by Colin Jamison
figure(1)
plot(tau(1,:),price1,'b*',tau(2,:),price2,'r^',tau(3,:),price3,'kd',tau(4,:),price4,'y*',tau(5,:),price5,'m*');;
ylabel('price (dollars)');
xlabel('tau (sec)');
title('Price vs Tau for 5 Thermocouple Designs');
grid on;
hold on;
plot(tauPlot,polytau,'g-');
text(1,11,'Price = 32.46 * 0.0524^t^a^u');
legend('FSO1','FSO2','FS03','FS04','FS05','Best Fit Curve','Location','northeast');%CHANGE LINE EQUATION TO BE IN RIGHT FORMAT

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT ---
% I/We have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I/we provided
% access to my/our code to another. The project I/we am/are submitting
% is my/our own original work.
%% ____________________
