% An Example of Plots for MATLab

% When running scripts, unless you know you want to have a variable or
% figure from a previous script or command, it is generally best to clear
% everything.

close all;
clear all; 

tic % Reset the internal time counter

x1 = (-4*pi:0.1*pi:4*pi)'; % If we don't transpose this line, we will run into issues on the plot
y1 = sin(x1);
y2 = cos(x1);

x2 = linspace(0,10,1001)';
y3 = 2.^x2;
y4 = 3.^x2;
y5 = exp(x2);
y6 = log(x2);

A = toeplitz(linspace(0,1,11));

h1 = figure(); % Create a figure with the label h1
subplot(1,3,1); % Partition h1 into a 1x3 subplot structure and select the first subplot
plot(x1,[y1,y2],'LineWidth',2); % Plot both y1 and y2 vs x1
set(gca,'FontSize',20); % Set all default font sizes to 20 in this plot. (Put this AFTER the plot command!)
title('Trig Functions'); % Add a title (Put this AFTER the plot command!)
axis([-4*pi,4*pi,-1,1]);
xlabel('Linear Scale X');
ylabel('Linear Scale Y');
legend('y = Sin(x)','y = Cos(x)');
subplot(1,3,2);
semilogy(x2,[y3,y4],'LineWidth',2);
set(gca,'FontSize',20);
title('Different Base Exponential Functions');
legend('y = 2^{x}','y = 3^{x}');
xlabel('Linear Scale X');
ylabel('Log Scale Y');
subplot(1,3,3);
loglog(x2,[y5,y6,x2],'LineWidth',2);
set(gca,'FontSize',20);
title('Different Base Exponential Functions');
legend('y = e^{x}','y = ln(x)','y = x');
xlabel('Log Scale X');
ylabel('Log Scale Y');

h2 = figure();
subplot(1,2,1);
imagesc(A);
set(gca,'FontSize',20);
title('Heatmap of Toeplitz Matrix');
subplot(1,2,2);
surf(1:11,1:11,A);
set(gca,'FontSize',20);
title('3d surface of Toeplitz Matrix');

toc % Output the amount of time since the last tic