clear;
close all;

X = [1, 0; 1, 0.8; 1, 1.6; 1, 3; 1, 4; 1, 5];
d = [0.5; 1; 4; 5; 6; 9];
[rowX, colX] = size(X);

% the weight by standard linear least-squares(LLS) method:
w_a = inv(X'*X)*X'*d;
error_a = 0;
for i = 1: rowX
    error_a = error_a + 0.5 * (d(i, 1) - X(i, :) * w_a)^2;
end


w_b = [0; 0];
eta = 0.2;
epoch = 100;
weights = zeros(epoch*rowX, 2);
error_b = zeros(epoch, 1);
for j = 1: epoch
    error_epoch = 0;
    for i = 1: rowX
        e_n = d(i, 1) - X(i, :) * w_b;
        error_epoch = error_epoch + 0.5 * e_n^2;
        w_b = w_b + eta * X(i, :)' * e_n;
        weights((j-1)*rowX+i, :) = w_b';
    end
    error_b(j, :) = error_epoch;
end

plot(1:epoch*rowX, weights(1:epoch*rowX, 1), 'LineWidth', 2);
hold on;
plot(1:epoch*rowX, weights(1:epoch*rowX, 2), 'LineWidth', 2);
legend('weight: b', 'weight: w');
xlabel('learning step', 'FontSize', 15);

% scatter(X(:, 2), d(:, 1), 'filled');
% hold on;
% x = -1:6;
% y = w_a(2,1)*x+w_b(1,1);
% xlim([-1 6]);
% ylim([-1 10]);
% xlabel('x');
% ylabel('y');
% plot(x,y);

% plot(1:epoch, error_b(1:epoch, 1), 'LineWidth', 2);
% legend('error');
% xlabel('epoch');