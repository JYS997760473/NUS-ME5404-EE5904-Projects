function [linear_train_accuracy, linear_test_accuracy, linear_predicted] = linear_hard(num_train, train_label, ...
                            train_data, test_data, num_test, test_label)
    % H matrix of linear kernel for quadratic programming:
    disp("calculating linear H matrix")
    didj = train_label * train_label';
    xixj = train_data' * train_data;
    H_linear = didj .* xixj;

    % (1) hard margin SVM with the linear kernel
    % Gram matrix construction
    disp("calculating linear kernel Gram matrix...");
    Gram_linear = zeros(num_train, num_train);
    for i = 1: num_train
        for j = 1: num_train
            Gram_linear(i,j) = train_data(:,i)' * train_data(:,j);
        end
    end

    % test the Mercer’s condition
    eig_value_linear = eig(Gram_linear);
    if min(eig_value_linear) < -1e-4
        % error("Don't satisfy Mercer's condition");
        disp("linear kernel doesn't satify Mercer's condition");
    else
        disp("linear kernel satify Mercer's condition");
        [alpha_linear, support_vector_idx_linear] = cal_quadprog(num_train, H_linear, 1e7, train_data, ...
                                                            train_label);
        [kernel_support_vector_linear, bias_mean_linear] = cal_disfun_linear(support_vector_idx_linear, ...
                                train_label, num_train, train_data, alpha_linear);
    end

    % linear kernel:
    prediction_linear_train = predict_linear(train_data, train_data, num_train, num_train, train_label,...
                        alpha_linear, bias_mean_linear);
    linear_train_accuracy = cal_accuracy(prediction_linear_train, train_label);
    % disp("linear train accuracy: "+linear_train_accuracy);

    prediction_linear_test = predict_linear(test_data, train_data, num_test, num_train, train_label,...
                                        alpha_linear, bias_mean_linear);
    linear_test_accuracy = cal_accuracy(prediction_linear_test, test_label);
    % disp("linear test accuracy: "+linear_test_accuracy);

    linear_predicted = prediction_linear_test;

end