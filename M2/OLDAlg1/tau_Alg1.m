function [maximum,tau] = tau_Alg1(y,t,timeStep,minimum);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
%   Calculates important 
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

index = find(timeStep == t);  % index of the time step
indexMax = length(y);

%Original Data
% figure(counter)
% plot(t,y,'b.');
% title('Thermocouple Temperature vs Time');
% xlabel('Time (s)');
% ylabel('Temperature (°C)');
% grid on;
newY = y;
yold = y;

%Smoothing the data
avgLast20 = mean(y((indexMax - 20):indexMax));
j = 1;
while(j < 10)
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
% counter = counter + 1;
% figure(counter)
% plot(t,newY,'b.');
% title('Thermocouple Temperature vs Time (Smooth)');
% xlabel('Time (s)');
% ylabel('Temperature (°C)');
% grid on;
% hold on;

%Calculations
maximum = mean(newY((length(newY) - 3):length(newY)));


% tauIndex = find(newY == (.632 * (abs(maximum - (minimum)))) );
% tauIndex = tauIndex(1);
% tau = t(tauIndex) - timeStep;
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

% plot(t,ones(1,length(y))*tauY);
% hold off;