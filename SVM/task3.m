% use Radial Bias Function as kernel
gamma = 0.05;

% H matrix of RBF kernel for quadratic programming:
disp("calculating RBF H matrix")
for i = 1: num_train
    for j = 1: num_train
        H_RBF(i,j) = train_label(i) * train_label(j) * ...
            exp(-gamma*((train_data(:,i)'-train_data(:,j)') * (train_data(:,i)-train_data(:,j))));
    end
end


% Gram matrix construction
fprintf("\n");
disp("calculating RBF kernel Gram matrix...");
Gram_RBF = zeros(num_train, num_train);
for i = 1: num_train
    for j = 1: num_train
        Gram_RBF(i,j) = exp(-gamma*((train_data(:,i)'-train_data(:,j)') * ...
                    (train_data(:,i)-train_data(:,j))));
    end
end
% test the Mercer’s condition
eig_value_RBF = eig(Gram_RBF);
if min(eig_value_RBF) < -1e-4
    disp("RBF kernel doesn't satify Mercer's condition");
else
    disp("RBF kernel satify Mercer's condition");
    [alpha_RBF, support_vector_idx_RBF] = cal_quadprog(num_train, H_RBF, 2.0, train_data, ...
                                                        train_label);
    [kernel_support_vector_RBF, bias_mean_RBF] = cal_disfun_RBF(support_vector_idx_RBF, ...
                            train_label, num_train, train_data, alpha_RBF, gamma);
end

% RBF kernel results:
fprintf("\n");
disp("RBF kernel");
prediction_RBF_train = predict_RBF(train_data, train_data, num_train, num_train, train_label,...
                    alpha_RBF, bias_mean_RBF, gamma);
RBF_train_accuracy = cal_accuracy(prediction_RBF_train, train_label);
disp("RBF train accuracy: "+RBF_train_accuracy);

prediction_RBF_test = predict_RBF(test_data, train_data, num_test, num_train, train_label,...
                                    alpha_RBF, bias_mean_RBF, gamma);
RBF_test_accuracy = cal_accuracy(prediction_RBF_test, test_label);
disp("RBF test accuracy: "+RBF_test_accuracy);