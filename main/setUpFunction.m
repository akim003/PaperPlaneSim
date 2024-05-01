% Set up Function for the Test Cases

function setUpFunction()
    %% Paperplane.m Setup	
    global CL CD S m g rho
	S		=	0.017;			% Reference Area, m^2
	AR		=	0.86;			% Wing Aspect Ratio
	e		=	0.9;			% Oswald Efficiency Factor;
	m		=	0.003;			% Mass, kg
	g		=	9.8;			% Gravitational acceleration, m/s^2
	rho		=	1.225;			% Air density at Sea Level, kg/m^3	
	CLa		=	3.141592 * AR/(1 + sqrt(1 + (AR / 2)^2));
							% Lift-Coefficient Slope, per rad
	CDo		=	0.02;			% Zero-Lift Drag Coefficient
	epsilon	=	1 / (3.141592 * e * AR);% Induced Drag Factor	
	CL		=	sqrt(CDo / epsilon);	% CL for Maximum Lift/Drag Ratio
	CD		=	CDo + epsilon * CL^2;	% Corresponding CD
	LDmax	=	CL / CD;			% Maximum Lift/Drag Ratio
	Gam		=	-atan(1 / LDmax);	% Corresponding Flight Path Angle, rad
	V		=	sqrt(2 * m * g /(rho * S * (CL * cos(Gam) - CD * sin(Gam))));
							% Corresponding Velocity, m/s
	Alpha	=	CL / CLa;			% Corresponding Angle of Attack, rad
	
    % General Inital Condtions
	H		=	2;			% Initial Height, m
	R		=	0;			% Initial Range, m
	to		=	0;			% Initial Time, sec
	tf		=	6;			% Final Time, sec
	tspan	=	[to tf];
    xo		=	[V;Gam;H;R];

    %% Creates Random Curves
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

    %% Finds Curve Fit Equations
    time_array = zeros(numel(tspan), 1);   
    height_array = zeros(numel(tspan), 1);
    range_array = zeros(numel(tspan), 1);

    % populates parameter arrays
    for i = 1:numel(tspan)
        time_array(i)   = tspan(i);
        height_array(i) = results.height(i);
        range_array(i)  = results.range(i);
    end

    degree = 10;
    range_fit_coeffs = polyfit(time_array, range_array, degree);
    height_fit_coeffs = polyfit(time_array, height_array, degree);

    range_fit = polyval(range_fit_coeffs, time_array);
    height_fit = polyval(height_fit_coeffs, time_array);

    %% Save Values to Workspace
    assignin('base', 'S', S);
    assignin('base', 'm', m);
    assignin('base', 'g', g);
    assignin('base', 'rho', rho);
    assignin('base', 'Gam', Gam);
    assignin('base', 'CL', CL);
    assignin('base', 'CD', CD);
    assignin('base', 'V', V);
    assignin('base', 'time_array', time_array)
    assignin('base', 'height_array', height_array)
    assignin('base', 'height_fit', height_fit)
    assignin('base', 'range_fit', range_fit)
end