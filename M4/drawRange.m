function drawRange

data = csvread('fos_time_histories.csv');

time = data(:,1);	%Time data
fos1 = data(:,12);
fos5 = data(:,97);

k=1;

[minimum, maximum, timeStep, tau, isHeating] = M4Alg2_014_05([time, fos1],k);
sse = M4Calibration_014_05(minimum, maximum, timeStep, tau, fos1, time, isHeating);

k = k + 1;

[minimum, maximum, timeStep, tau, isHeating] = M4Alg2_014_05([time, fos5],k);
sse = M4Calibration_014_05(minimum, maximum, timeStep, tau, fos5, time, isHeating);

k = k + 1;

[minimum, maximum, timeStep, tau, isHeating] = M3Alg2_014_05([time, fos1],k);
sse = M3Calibration_014_05(minimum, maximum, timeStep, tau, fos5, time, isHeating);

k = k + 1;

[minimum, maximum, timeStep, tau, isHeating] = M3Alg2_014_05([time, fos5],k);
sse = M3Calibration_014_05(minimum, maximum, timeStep, tau, fos5, time, isHeating);