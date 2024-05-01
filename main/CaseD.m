% Simulates Case D (Time Derivatives)

% set up pre-reqs
setUpFunction();

%% Calculates Derivatives
midpoints = (time_array(1:end-1) + time_array(2:end)) / 2;

% derivatives
dydx_Height = diff(height_fit)./diff(time_array);
dydx_Range = diff(range_fit)./diff(time_array);

%% Plots Data
figure;
grid on;

% Plot Height Derivative
subplot(1,2,1);
plot(midpoints, dydx_Height, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Rate of Change of Height (m/s)');
title('Time Derivative of Height');
hold on;

% Plot Range Derivative
subplot(1,2,2);
plot(midpoints, dydx_Range, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Rate of Change of Range (m/s)');
title('Time Derivative of Range');
hold on;