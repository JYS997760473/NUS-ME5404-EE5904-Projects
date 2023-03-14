lambda = 0.7;
w_c = inv(PHI'*PHI+lambda*eye(length(train_x)))*PHI'*train_y';
% test for one test sample
% phi matrix for the test size is 201*41
PHI_TEST_c = zeros(length(test_x), num_neuron);
for i=1: length(test_x)
    for j=1: num_neuron
        PHI_TEST_c(i, j) = exp(-(test_x(i)-train_x(j))^2 / (2*(sigma^2)));
    end
end
output_c = (PHI_TEST_c * w_c)';
% evaluation: mean squared error MSE:
error_matrix_c = (output_c-test_y).^2;
error_c = (1/length(test_x))*ones(1, length(test_x))*error_matrix_c'
error_train_matrix_c = ((PHI*w_c)'-train_y).^2;
error_train_c = (1/length(train_x))*ones(1, length(train_x))*error_train_matrix_c'
% plot
plot(test_x, test_y, 'LineWidth', 1.5);
hold on;
% plot(train_x, train_y);
hold on;
plot(test_x, output_c, 'LineWidth', 1.5);
scatter(train_x, train_y,'filled');
xlabel('x');
ylabel('y');
legend('Test Groundtruth','Test Output','Train Samples');