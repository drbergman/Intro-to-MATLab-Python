% Example model of cashiers checking people out while they join lines at
% different rates.  Customers show up according to a Poisson distribution
% with lambda = 10, and have a number of items with another Poisson
% distribution, this time lambda = 20.  A cashier takes one time unit for
% each item a customer has.

maxTime = 1000;
numCashiers = 3;
lanes = zeros(maxTime,numCashiers); %This size was chosen so that no overflow is possible
lanePos = ones(1,numCashiers); % Which position in the lane is next
customerLambda = 10; %
itemLambda = 30;
rates = [10,10,10];
timeToNext = ceil(exprnd(customerLambda)); % See when the next customer arrives
peopleOverTime = zeros(maxTime,numCashiers);

% Simulate each time step

for i = 1:maxTime
    % First, each cashier processes one item
    for j = 1:numCashiers
        if lanes(1,j) > 1
            lanes(1,j) = lanes(1,j) - 1;
        else
            lanes(1:end-1,j) = lanes(2:end,j); %If the front person is done, go on to the next!
            lanes(end,j) = 0;
            if lanePos(j) > 1
                lanePos(j) = lanePos(j) - 1;
            end
        end
    end
    
    % Decrement the time to the next customer, and if they show up, figure
    % out where they go.  If any lanes are open, customers choose one of
    % those with uniform random probability.  Otherwise, they move to a
    % lane with probability inversely proportional to the number of items
    % in that lane (prefering the quickest checkout.)
    
    totalItems = sum(sum(lanes));
    itemsPerLane = sum(lanes);
    openLanes = find(itemsPerLane == 0);
    timeToNext = timeToNext - 1;
    if timeToNext <= 0
        timeToNext = ceil(exprnd(customerLambda));
        if min(size(openLanes)) > 0
            nextLane = openLanes(randi(max(size(openLanes))));
        else
            laneProbs = 1 - (sum(lanes)/totalItems);
            laneProbs = laneProbs/sum(laneProbs);
            dice = rand;
            nextLane = numCashiers - sum( cumsum(laneProbs) >= dice ) + 1;
        end
        lanes(lanePos(nextLane),nextLane) = poissrnd(itemLambda);
        lanePos(nextLane) = lanePos(nextLane) + 1;
    end
    
    % Finally, record the number of people at each time
    
    peopleOverTime(i,:) = lanePos - ones(1,numCashiers);
end

hist(peopleOverTime,max(max(peopleOverTime)) + 1);
title('Histogram of people over time in each lane','FontSize',30);
set(gca,'FontSize',20)
xlabel('Number of people in line');
ylabel('Number of times with line length');
