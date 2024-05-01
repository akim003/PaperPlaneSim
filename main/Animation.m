% Animation

%% Load in variables from paperplane.m
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

%% Graph desired trajectories
H		=	2;			% Initial Height, m
R		=	0;			% Initial Range, m
to		=	0;			% Initial Time, sec
tf		=	6;			% Final Time, sec
tspan	=	[to tf];

xo		=	[3.55;Gam;H;R];
[tb,xb]	=	ode23('EqMotion',tspan,xo);
xo		=	[7.5;0.4;H;R];
[tc,xc]	=	ode23('EqMotion',tspan,xo);

% Initialize animation and Create plot
animation_fig = figure;
trajectory_lines = plot(NaN, NaN, 'k-', NaN, NaN, 'g-'); % Placeholder for the trajectory lines
hold on;
point_plot = plot(NaN, NaN, 'ro', 'MarkerSize', 7, 'MarkerFaceColor', 'r'); % Plot point
xlim([0,25]);
ylim([-2,4]);
title('Animation for Nominal and Scenario (V=7.5 m/s, \Gamma=+0.4 rad)');
xlabel('Range (m)');
ylabel('Height (m)');
legend('Nominal','V=7.5 m/s, \Gamma=+0.4 rad')

% Create File
gifFile = "animation.gif";
exportgraphics(animation_fig, gifFile);

% Animate
for i = 1:length(tb)
    set(point_plot, 'XData', xb(i,4), 'YData', xb(i,3));
    set(trajectory_lines(1), 'XData', xb(1:i,4), 'YData', xb(1:i,3));
    drawnow;
    pause(0.1);
    exportgraphics(animation_fig, gifFile, Append=true);
end

for i = 1:length(tc)
    set(point_plot, 'XData', xc(i,4), 'YData', xc(i,3));
    set(trajectory_lines(2), 'XData', xc(1:i,4), 'YData', xc(1:i,3));
    drawnow;
    pause(0.1);
    exportgraphics(animation_fig, gifFile, Append=true);
end



