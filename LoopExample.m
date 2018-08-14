% Loop Examples.  This are just simple loops which run through a vector of
% random integers, doubling a number if it is not divisible by 2, and
% halving that number if it is.  We have a for loop, a while loop, and a
% vectorized loop replacement.

close all;
clear all;

num = 2000;

% Make our vector

vect = randi(100,num,1);
loop1Out = zeros(num,1);
loop2Out = zeros(num,1);
loop3Out = zeros(num,1);

% First, the for loop

tic

for j = 1:num
    if mod(vect(j),2) == 0
        loop1Out(j) = vect(j)*0.5;
    else
        loop1Out(j) = vect(j)*2;
    end
end

toc

% Next, the while loop, which should be avoided if at all possible since
% it can hang the computer.

tic

counter = 1;

while counter <= num
    if mod(vect(counter),2) == 0
        loop2Out(counter) = vect(counter)*0.5;
    else
        loop2Out(counter) = vect(counter)*2;
    end
    counter = counter + 1;
end

toc

% Lastly, we just deal with the vectors directly and all at once (as far as
% the code is concerned

tic

tic

loop3Out = 2 * mod(vect,2) .* vect + 0.5 * (1 - mod(vect,2)) .* vect;

toc

plot([vect,loop1Out,loop2Out,loop3Out],'.','LineWidth',0.5);
set(gca,'FontSize',20);
title('Loop Output Comparison');
legend('Original Random Vector','For Loop','While Loop','Vectorized Operations');

% We should see only blue and purple one this plot