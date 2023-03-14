num_train = length(train_x);
num_test = length(test_x);
% randomly choose 15 points:
rand_index = randsample(num_train, 15);
rand_train_x = train_x(1, rand_index(:));
rand_train_y = train_y(1, rand_index(:));
distance_max = max(rand_train_x) - min(rand_train_x);
sigma_b = distance_max / sqrt(2*15);
PHI_b = zeros(num_train, 15);
for i=1: num_train
    for j=1: 15
        PHI_b(i,j) = exp(- (train_x(i) - rand_train_x(j))^2 / (2*(sigma_b^2)) );
    end
end
% w_b = inv(PHI_b'*PHI_b)*PHI_b'*train_y';
w_b = (train_y / PHI_b')';
PHI_TEST_b = zeros(length(test_x), 15);
for i=1: length(test_x)
    for j=1: 15
        PHI_TEST_b(i, j) = exp(-(test_x(i)-rand_train_x(j))^2 / (2*(sigma_b^2)));
    end
end
output_b = (PHI_TEST_b * w_b)';
% evaluation: mean squared error MSE:
error_matrix_b = (output_b-test_y).^2;
error_b = (1/length(test_x))*ones(1, length(test_x))*error_matrix_b';
error_train_matrix_b = ((PHI_b*w_b)'-train_y).^2;
error_train_b = (1/length(train_x))*ones(1, length(train_x))*error_train_matrix_b';

% plot
plot(test_x, test_y, 'LineWidth', 1.5);
hold on;
% plot(train_x, train_y);
hold on;
plot(test_x, output_b, 'LineWidth', 1.5);
scatter(train_x, train_y,'filled');
xlabel('x');
ylabel('y');
legend('Test Groundtruth','Test Output','Train Samples');