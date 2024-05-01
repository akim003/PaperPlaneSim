% Simulates Case A	

% set up pre-reqs
setUpFunction();

%% ODE to find h & range
H		=	2;			% Initial Height, m
R		=	0;			% Initial Range, m
to		=	0;			% Initial Time, sec
tf		=	6;			% Final Time, sec
tspan	=	[to tf];

% Varying V0
xo		=	[2;Gam;H;R];
[ta,xa]	=	ode23('EqMotion',tspan,xo);
xo		=	[3.55;Gam;H;R];
[tb,xb]	=	ode23('EqMotion',tspan,xo);
xo		=	[7.5;Gam;H;R];
[tc,xc]	=	ode23('EqMotion',tspan,xo);

% Varying Gamma0
xo		=	[V;-0.5;H;R];
[td,xd]	=	ode23('EqMotion',tspan,xo);
xo		=	[V;-0.18;H;R];
[te,xe]	=	ode23('EqMotion',tspan,xo);
xo		=	[V;0.4;H;R];
[tf,xf]	=	ode23('EqMotion',tspan,xo);

%% Display Data
figure;
hold on;

% Plot Varying V0
subplot(1,2,1)
plot(xa(:,4), xa(:,3), 'r', 'LineWidth', 1.5); % Lower V0
hold on;
plot(xb(:,4), xb(:,3), 'k', 'LineWidth', 1.5); % Nominal V0
hold on;
plot(xc(:,4), xc(:,3), 'g', 'LineWidth', 1.5); % Higher V0
hold on;

% Label Subplot
xlabel('Range (m)');
ylabel('Height (m)');
legend('Lower V_0', 'Nominal V_0', 'Higher V_0');
title('Effect of Initial Velocity (V_0) on Flight Trajectory');
grid on;

% Plot Varying Gamma0
subplot(1,2,2)
plot(xd(:,4), xd(:,3), 'r', 'LineWidth', 1.5); % Lower Gama0
hold on;
plot(xe(:,4), xe(:,3), 'k', 'LineWidth', 1.5); % Nominal Gama0
hold on;
plot(xf(:,4), xf(:,3), 'g', 'LineWidth', 1.5); % Higher Gama0
hold on;

% Label Subplot
xlabel('Range (m)');
ylabel('Height (m)');
legend('Lower \Gamma_0', 'Nominal \Gamma_0', 'Higher \Gamma_0');
title('Effect of Initial Flight Angle (\Gamma_0) on Flight Trajectory');
grid on;