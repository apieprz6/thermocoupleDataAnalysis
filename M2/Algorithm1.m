function [minimum, maximum, timeStep, tau, counter] = Algorithm1(y, t, counter)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
%   Calculates min max timestep and tau variables and outputs them
%
% Function Call
% 	Algorithm1
%
% Input Arguments
%   1. Time - vector for time of data
%	2. y -  the y that corresponds to the time vector
%
% Output Arguments
%	1. minimum - returns the mimimum value of the data
%	2. maximum - the maximum value of the data
%   3. timeStep - timeStep of the passed data
%	4. tau - the time constant of the data
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
counter = counter + 1;

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

index = find(timeStep == t);  % index of the time step
indexMax = length(y);		%index of the last data point

%Original Data
figure(counter)
plot(t,y,'b.');
title('Thermocouple Temperature vs Time');
xlabel('Time (s)');
ylabel('Temperature (°C)');
grid on;
newY = y;
yold = y;

%Smoothing the data
avgLast20 = mean(y((indexMax - 20):indexMax));
j = 1;
while(j < 5)
    i = 6;
	while(i < indexMax)
		if(i >= indexMax-21)
			newY(i) = mean([yold(i-1), avgLast20]);
			%fprintf('end\n');
        else
            meanLast5 = mean(yold(i-5:i-1));
            meanFront5 = mean(yold(i+1:i+10));
			newY(i) = mean([meanLast5, meanFront5]);
        end
		i = i + 1;
	end
	if(y == newY)
		fprintf('true\n');
	end
	yold = newY;
	j = j+1;
end



%Plotting smooth data
counter = counter + 1;
figure(counter)
plot(t,newY,'b.');
title('Thermocouple Temperature vs Time (Smooth)');
xlabel('Time (s)');
ylabel('Temperature (°C)');
grid on;
hold on;

%Calculations
maximum = mean(newY((length(newY) - 3):length(newY)));


% tauIndex = find(newY == (.632 * (abs(maximum - (minimum)))) );
% tauIndex = tauIndex(1);
% tau = t(tauIndex) - timeStep;

%Checks if its heating or cooling then appropriatly calculates tau using smooth data
if(maximum - minimum > 0)
	tauY = .632 * (abs(maximum - newY(index)));
	i = index;
	while(i < indexMax)
		if(newY(i) >= tauY)
			tau = t(i) - timeStep;
			i = indexMax;
		end
		i = i+1;
	end
else
	i = index;
	tauY = (1 - .632) * (abs(maximum - newY(index)));
	while(i < indexMax)
		if(newY(i) <= tauY)
			tau = t(i) - timeStep;
			i = indexMax;
		end
		i = i+1;
	end
end

if(minimum > maximum)
	temp = maximum;
	maximum = minimum;
	minimum = temp;
end