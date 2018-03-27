function [maximum,tau] = tau_Alg1OLD(y,t,timeStep,minimum)


index = find(timeStep == t);  % index of the time step
maximum = mean(y((length(y) - 10):length(y))); % Crude maximum of the data
indexMax = length(t);
%indexMax = find(y >= maximum); 
%indexMax = indexMax(1); % index where the temp data first reaches or exceeds maximum
newY = (y(index:indexMax));
tNew = log10(t(index:indexMax));

% Linearizing data
coeffs = polyfit(tNew,newY,1);
yRegressed = polyval(coeffs,tNew);
 

% Calculating error
 SSE = sum((newY - yRegressed).^2);
 SST = sum((newY - mean(newY)).^2);
 r2 = 1 - SSE / SST;
 fprintf('R^2: %.2f\n',r2);
 
 % Calculating tau
 tauIndex = find(y >= .632 * (y(indexMax) - minimum));
 tauIndex = tauIndex(1);
 tau = t(tauIndex) - timeStep;
 

 
figure(1)
plot(t,y,'b.');
title('Thermocouple Temperature vs Time');
xlabel('Time (s)');
ylabel('Temperature (°C)');
grid on;

%  % Plotting linear regression of data
% figure(2)
% semilogx(tNew,newY,'g.');
% title('y vs log10(t) on Semilogx Scale from Time Step to Time of Max Temp.');
% xlabel('log10(t) (seconds)');
% ylabel('y (°C)');
% grid on;
% hold on;

%Overlaying trendline on truncated data
figure(2)
plot(t(index:indexMax),newY,'g.');
title('Truncated Thermocouple Temperature vs Time w/ Trendline');
xlabel('Time (s)');
ylabel('Temperature (°C)');
grid on;
hold on;

xValues = t(index:indexMax);
yValues = coeffs(1) * log10(xValues) + coeffs(2);
plot(xValues,yValues,'r-');
legend('Data',['Trendline: Y = ' num2str(coeffs(1)) 'X + ' num2str(coeffs(2))],'Location','northwest');

