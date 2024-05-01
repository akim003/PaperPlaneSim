% Simulates Case C (Average Trajectory)

%% Generates Random V0 & Gama0 Values
% V0 Values
lower_limit = 2;
upper_limit = 7.5;

% Generate 100 Random Numbers Within the Specified Range
V0 = lower_limit + (upper_limit - lower_limit) * rand(100, 1);

% Gama0 Values
lower_limit = -0.5;
upper_limit = 0.4;

% Generate 100 Random Numbers Within the Specified Range
Gama0 = lower_limit + (upper_limit - lower_limit) * rand(100, 1);

%% Find Height & Range for various cases
H		=	2;			% Initial Height, m
R		=	0;			% Initial Range, m
to		=	0;			% Initial Time, sec
tf		=	6;			% Final Time, sec

% specify constant t-span
tspan = linspace(to, tf, 200);

% creates variables to store results
results.height = zeros(numel(tspan), 100);
results.range = zeros(numel(tspan), 100);

% loops through inital conditons
for i = 1:100
    % update initial conditons
    xo = [V0(i); Gama0(i); H; R];

    % Simulate the flight trajectory for the current initial conditions
    [t, x] = ode23('EqMotion', tspan, xo);
    
    % Store the time and state vectors in the results array
    results.height(:,i) = x(:,3); 
    results.range(:,i) = x(:,4); 
end

%% Creates Parameter Arrays  
time_array = zeros(numel(tspan), 1);   
height_array = zeros(numel(tspan), 1);
range_array = zeros(numel(tspan), 1);

% populates parameter arrays
for i = 1:numel(tspan)
    time_array(i)   = tspan(i);
    height_array(i) = results.height(i);
    range_array(i)  = results.range(i);
end

%% Create Curve Fits
degree = 10;
range_fit_coeffs = polyfit(time_array, range_array, degree);
height_fit_coeffs = polyfit(time_array, height_array, degree);

range_fit = polyval(range_fit_coeffs, time_array);
height_fit = polyval(height_fit_coeffs, time_array);

%% Plot Data
figure;
grid on;

% Plot Height Data
subplot(1,2,1);
scatter(time_array, height_array, 10);
hold on;
plot(time_array, height_fit, 'LineWidth', 2);
hold on;
xlabel('Time');
ylabel('Height');
title('Fitted Curve for Height');
legend('Original Points', 'Fitted Curve');

% Plot Range Data
subplot(1,2,2);
scatter(time_array, range_array, 10);
hold on;
plot(time_array, range_fit, 'LineWidth', 2);
hold on;
xlabel('Time');
ylabel('Range');
title('Fitted Curve for Range');
legend('Original Points', 'Fitted Curve');