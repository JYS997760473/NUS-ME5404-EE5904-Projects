train_error_list = [0.0092, 0.0130, 0.0208, 0.0264, 0.0291, 0.0323, 0.0344, 0.0399, 0.0962];
test_error_list = [0.0494, 0.0450, 0.0375, 0.0347, 0.0336, 0.0329, 0.0330, 0.0346, 0.0769];
lambda_list = [0.001, 0.01, 0.1, 0.3, 0.5, 0.8, 1, 1.5, 5];
plot(lambda_list, train_error_list, 'LineWidth', 1.5);
hold on;
plot(lambda_list, test_error_list, 'LineWidth', 1.5);
xlabel('Regularization factor, lambda')
ylabel('MSE Error')
legend('Train Error', 'Test Error')