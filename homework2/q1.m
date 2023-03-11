clear;
close all;
rate = 0.2;
target = 1e-5;
x(1) = 0;
y(1) = 0.5;
f(1) = (1-x(1))^2 + 100*(y(1)-x(1)^2)^2;
iteration = 1;
while f(iteration) > target
    x(iteration + 1) = x(iteration) - rate*(2*x(iteration)-2+400*x(iteration)^3-400*y(iteration)*x(iteration));
    y(iteration + 1) = y(iteration) - rate*(200*y(iteration)-200*x(iteration)^2);
    iteration = iteration + 1;
    f(iteration) = (1-x(iteration))^2 + 100*(y(iteration)-x(iteration)^2)^2;
end

% plot(x, y, 'linewidth',2)
% xlabel('x', 'FontSize', 20)
% ylabel('y', 'FontSize', 20) 

% plot(1:iteration, f, 'linewidth',2)
% xlabel('iteration', 'FontSize', 20)
% ylabel('f(x,y)', 'FontSize', 20)   