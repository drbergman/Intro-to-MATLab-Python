% Exmaple of fitting lines to noisy data.  We will use both lsqcurvefit and
% fminsearch

clear all;
close all;

% First, set up the true parameters for our line, m and b, as well as a
% range of x values

m = -2;
b = 17;
x = (-10:0.1:10)';
y = m*x+b;

% Now add some noise.
stdDev = 1;
noise = stdDev*randn(size(y));
yNoisy = y + noise;

% First, we'll use lsqcurvefit
lsqFun = @(params,x) params(1)*x + params(2); % We need to set the function up in this way, with only these arguments, for lsqcurvefit

tic

initialGuess = [0,0]; % We need an initial fitting attempt for these functions
lsqParams = lsqcurvefit(lsqFun,initialGuess,x,yNoisy);
lsqLine = lsqParams(1)*x + lsqParams(2);

toc

tic

fminFun = @(params) mean(abs(yNoisy - (params(1)*x + params(2)))); % We need to set this one up so that the correct values get us as close to 0 as possible.
fminParams = fminsearch(fminFun,initialGuess);
fminLine = fminParams(1)*x + fminParams(2);

toc

% Plot the data and both fit attempts, as well as the noiseless line

figure();
hold on;
plot(x,yNoisy,'k.');
plot(x,[y,lsqLine,fminLine],'LineWidth',2);
set(gca,'FontSize',20);
legend('Noisy Data','Noiseless Line','LSQCurveFit Results','FMinSearchResults');