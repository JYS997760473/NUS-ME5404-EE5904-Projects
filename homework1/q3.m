close all;
clear;

% and:
x = [0, 0, 1, 1];
y = [0, 1, 0, 1];
% x = [0, 1];
% y = [1, 0];
scatter(x, y, 50, 'filled');
grid;
xlim([-0.5 1.5]);
ylim([-0.5 1.5]);
x = [-1:2];
y = -2.5*x+3;
hold on;
plot(x, y, 'LineWidth', 2);
% line([0.2 0.2],[-1 100],'LineWidth',2)