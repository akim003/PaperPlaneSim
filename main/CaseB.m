% Simulates Case B (Monte Carlo)

% set up pre-reqs
setUpFunction();

%% Generates Random V0 & Gamma0 Values
% V0 Values
lower_limit = 2;
upper_limit = 7.5;

% Generate 100 Random Numbers Within the Specified Range
V0 = lower_limit + (upper_limit - lower_limit) * rand(100, 1);

% Gamma0 Values
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
tspan = linspace(to, tf, 1000);

% creates variables to store results
results.height = cell(100, 1);
results.range = cell(100, 1);

% loops through inital conditons
for i = 1:100
    % update initial conditons
    xo = [V0(i); Gama0(i); H; R];

    % Simulate the flight trajectory for the current initial conditions
    [t, x] = ode23('EqMotion', tspan, xo);
    
    % Store the time and state vectors in the results array
    results.height{i} = x(:,3); 
    results.range{i} = x(:,4); 
end

%% Plot Data
figure;
grid on;

for i = 1:100
    plot(results.range{i}, results.height{i});
    hold on;
end

xlabel('Range (m)');
ylabel('Height (m)');
title('Effect of Initial Flight Angle (\Gamma_0) & Inital Velocity (V_0) on Flight Trajectory');