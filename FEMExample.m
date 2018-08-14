% Backward Euler example to solve y(x_min) = 1, y(x_max) = 1; y'' = -y.
% Here, x_max = 2pi and x_min = 0.

tic

% First, we set up our x domain and boundary values.  The x values we use
% will form our mesh for the finite element method

boundary1 = 1; % BV at x = 0
boundary2 = 1; % BV at x = x_max

numsteps = 10;
x_max = 2*pi;
x_min = 0;
dx = (x_max - x_min)/numsteps;
x = (x_min:dx:x_max)'; % We take the transpose to make sure our dimensions are correct for matrix multiplication
x_size = max(size(x));

% Now we set up our matrix

% Quick note on the math:

% Our ODE is y'' = -y
% We discretize to y''(x_n) = (y(x_n+1) + y(x_n-1) - 2*y(x_n))/(dx^2)
% Therefore y(x_n) = (y(x_n+1) + y(x_n-1))/(2 - dx^2)
A = 1/(2 - dx^2) * (diag(ones(1,x_size - 1),1) + diag(ones(1,x_size - 1),-1));
A(1,:) = zeros(1,x_size);
A(end,:) = zeros(1,x_size);
A(1) = 1;
A(end) = 1; % We change the first and last rows to reflect our lack of knowledge of anything outside our domain.

solBasis = null(eye(x_size) - A); % This is a basis for all solutions to the ODE without boundary conditions
solVector1 = solBasis(:,1);
solVector2 = solBasis(:,2);

% Now we can apply those boundary conditions.  Since we have a second order
% equation, we know there should be two basis vectors for our solution.
% The locations of the boundary values can be changed, but then the exact
% choices of elements from the two solution vectors must be changed as
% well.  Feel free to play around with it.

solMoments = [solVector1(1),solVector2(1);solVector1(end),solVector2(end)]\[boundary1;boundary2];

FEMSol = solMoments(1)*solVector1 + solMoments(2)*solVector2;

toc

% Add in your code for the forward Euler method and the use of one or more
% of MATLab's built in ODE solvers here. Don't forget to modify the plot,
% determine calculation time and error for each method.  Also, remember
% that for explicit methods, we must use initial conditions, so use y(0) =
% 1 and y'(0) = 0.

h = figure();
hold on;
plot(linspace(x_min,x_max,1000),cos(linspace(x_min,x_max,1000)),'LineWidth',2)
plot(x,FEMSol,'*','LineWidth',2)
set(gca,'FontSize',20);
title(['Finite Element Method Approximation of d^{2}y/dx^{2} = -y with ',num2str(x_size), ' points.'],'FontSize',30);
legend('Anayltic Solution','FEM Solution');
axis([x_min,x_max,1.5*min(FEMSol),1.5*max(FEMSol)])