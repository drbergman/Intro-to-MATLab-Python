% Play the "Chaos Game" by picking a random point inside an equilateral
% triangle then choosing one of the vertices at random, making a new point
% halfway between the previous one and the chosen vertex, and repeating.
%
% Note: If the first point is outside the triangle, this will still work
% fine.

tic
n = 10000;

% Select an initial point
y(1) = rand()*sqrt(3);
x(1) = (1 - 2*rand())*(sqrt(3) - y(1))/sqrt(3);

% Run the Gillespie Algorithm to determin each following point
for i = 2:n
    switch(randi([1,3]))
        case 1
            x(i) = 0.5 * (-1 - x(i - 1));
            y(i) = 0.5 * y(i - 1);
        case 2
            x(i) = 0.5 * x(i - 1);
            y(i) = y(i - 1) + 0.5 * (sqrt(3) - y(i - 1));
        case 3
            x(i) = 0.5 * (1 - x(i - 1));
            y(i) = 0.5 * y(i - 1);
    end
end

%Plot your output
f = figure();
hold on;
plot(x,y,'.','LineWidth',0.1);
plot([-1,0,1],[0,sqrt(3),0],'k*','LineWidth',3);
plot(x(1),y(1),'r*','LineWidth',3);
axis([-1.1,1.1,-0.1,1.8]);
set(gca,'FontSize',20);
title('Look Familiar?');
toc