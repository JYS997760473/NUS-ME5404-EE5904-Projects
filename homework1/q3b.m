close all;
clear;

d = [0,1,1,0];
x = [1, 0, 0; 1, 0, 1; 1, 1, 0; 1, 1, 1];
% d = [1, 0];
% x = [1, 0; 1, 1];
w = [0.5;0;0.5];
% w = [0.2;0];
eta = 1;
s = 1;
length = length(d);
step = 1;
weight(1, :) = w;
while s
    if step > 100
        break;
    end
    s = 0;
    for i=1: length
        y = x(i, :)*w;
        if y <= 0
            y = 0;
        else
            y = 1;
        end
        e = d(i) - y;
        if e ~= 0
            w = w + eta*e*x(i, :)';
            s = 1;
        end
        step = step + 1;
        weights(step, :) = w;
    end
end

plot(1:step, weights(1:step, 1), 'LineWidth', 2);
hold on;
ylim([-1.5 2]);
xlim([1 step]);
plot(1:step, weights(1:step, 2), 'LineWidth', 2);
hold on;
plot(1:step, weights(1:step, 3), 'LineWidth', 2);
xlabel('learning step', 'FontSize', 20);
legend('weight: b', 'weight: w1', 'weight: w2');