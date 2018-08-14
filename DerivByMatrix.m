% Example script to show numerical differentiation by matrix.

% This takes the function y = sin(x) and produces the first and second
% derivatives, as well as the first antiderivative, using a matrix
% implementation of the right difference derivative scheme.

numsteps = 1000;
x_max = 2*pi;
x_min = 0;
dx = (x_max - x_min)/numsteps;
x = (x_min:dx:x_max)'; % We take the transpose to make sure our dimensions are correct for matrix multiplication
x_size = max(size(x));
y = sin(x);

% First, we create a matrix to implement the right difference scheme;
rightDeriv = (1/dx) * (-eye(x_size) + diag(ones(1,x_size - 1),1));

% Now we take derivatives
y_prime = rightDeriv*y;
y_prime_prime = (rightDeriv^2)*y; 

% And finally we plot the results
plot(x,[y,y_prime,y_prime_prime],'LineWidth',2)
axis([0,2*pi,-2,2]);
title('Numerical Differentiation Example','FontSize',50);
xlabel('X Label Goes Here','FontSize',40);
ylabel('Y Label Goes Here','FontSize',40);
legend('y = sin(x)','dy/dx','d^{2}y/dx^{2}'); % Note that we can use a lot of LaTeX here

% Try some different functions here, and see what happens when using the
% inverse of the right deriv operator.  Also, note that since y(x_max + dx)
% isn't defined, we have some real numerical error for the last entry.
% The opposite problem would occur for the first in the left difference
% scheme.
