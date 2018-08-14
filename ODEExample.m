% Example of ODE solved by Forward Euler and by ODE23, compared to
% the exact solution.

clear all;
close all;

tic

% First, we define the function of our ODE y' = f(y,t) using an anonymous
% function.  In this case, we're dealing with y' = y.

myODE = @(t,y) y; % We need to include t as an argument for ode23 to work, and they must be in this order

% Set up the minimum and maximum times, and the time step we use with
% Forward Euler.  Also, chose a value for y(tmin).

tmin = 0;
tmax = 5;
t_step = 0.01;
y_init = 1;

time = tmin:t_step:tmax; % A time vector used for the true solution and Forward Euler
yTrue = exp(time); % The true solution for reference
yFE = zeros(size(time));
yFE(1) = y_init; % Set up a vector to store the Forward Euler Solution

% Implement the Forward Euler Solution
for j = 2:max(size(time))
    yFE(j) = yFE(j - 1) + t_step * myODE(time(j),yFE(j - 1));
end

toc

tic

% Implement the ODE23 solution (Note that this will create its own time
% vector.

tRange = [tmin,tmax]; % MATLab's ODE solvers require a start and end time in a vector, but make their own range of times
[tODE,yODE] = ode23(myODE,tRange,y_init);

toc

% Plot the results

h = figure();
hold on;
plot(time,yTrue,'k','LineWidth',2);
plot(time,yFE,'b','LineWidth',2);
plot(tODE,yODE,'r','LineWidth',2);
set(gca,'FontSize',20);
title(['Different solutions to dy/dt = y, y(',num2str(tmin),') = ',num2str(y_init)]);
xlabel('t');
ylabel('y');
legend('True Solution, y = e^{x}','Forward Euler','ode23');

% See what happens as we use different time steps for Forward Euler.  Also,
% try ode113 or ode45 for different solution methods, and if you're very
% ambitious, try a more complex function (and erase the "true" solution,
% since it will no longer be accurate.)