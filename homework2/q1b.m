clear;
close all;
iteration = 1;
target = 0.00001;
x(1) = 0;
y(1) = 0.5;
f(1) = (1-x(1))^2 + 100*(y(1)-x(1)^2)^2;
w(:, 1) = [x(1); y(1)];
while f(iteration) > target
    H(:, :, iteration) = [1200*x(iteration)^2-400*y(iteration)+2, -400*x(iteration); 
                    -400*x(iteration), 200];
    g(:, iteration) = [400*x(iteration)^3-400*y(iteration)*x(iteration)+2*x(iteration)-2;
                    200*y(iteration)-200*x(iteration)^2];
    w(:, iteration+1)=w(:, iteration)-H(:, :, iteration)^(-1)*g(:, iteration);
    x(iteration+1)=w(1, iteration+1);
    y(iteration+1)=w(2, iteration+1);
    iteration = iteration + 1;
    f(iteration) = (1-x(iteration))^2 + 100*(y(iteration)-x(iteration)^2)^2;
end