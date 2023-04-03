function [poly_train_accuracy, poly_test_accuracy, poly_predicted] = poly_hard(num_train, train_label, ...
                                            train_data, test_data, num_test, test_label, p)

    % H matrix of polynomial kernel for quadratic programming:
    disp("calculating polynomial H matrix")
    H_polynomial = zeros(num_train, num_train);
    for i = 1: num_train
        for j = 1: num_train
            H_polynomial(i,j) = train_label(i) * train_label(j) * ...
                                (train_data(:,i)' * train_data(:,j) + 1)^p;
        end
    end

    % (2) hard margin SVM with polynomial kernel
    % Gram matrix construction
    disp("calculating polynomial kernel Gram matrix...");
    Gram_polynomial = zeros(num_train, num_train);
    disp("calculating "+p+" Gram matrix...");
    for i = 1: num_train
        for j = 1: num_train
            Gram_polynomial(i,j) = (train_data(:,i)' * train_data(:,j) + 1)^p;
        end
    end

    % test the Mercer’s condition
    % create a cell array to store polynomial kernel with different p.
    alpha_poly = {};
    support_vector_idx_poly = {};
    kernel_support_vector_poly = {};
    eig_value_polynomial(:) = eig(reshape(Gram_polynomial(:,:), [num_train, num_train]));
    if min(eig_value_polynomial(:)) < -1e-4
        fprintf("\n");
        disp("polynomial "+p+" doesn't satify Mercer's condition");
    else
        fprintf("\n");
        disp("polynomial "+p+" satify Mercer's condition");
        [alpha_poly, support_vector_idx_poly] = cal_quadprog(num_train, ...
                                    H_polynomial(:,:), 1e7, train_data, train_label);
        [kernel_support_vector_poly, bias_mean_poly] = cal_disfun_poly(...
                        support_vector_idx_poly, train_label, num_train, train_data, alpha_poly, p);
    end

    % polynomial kernel:
    % hard margin:
    prediction_poly_train = predict_poly(train_data, train_data, num_train, num_train, train_label,...
                    alpha_poly, bias_mean_poly, p);
    poly_train_accuracy = cal_accuracy(prediction_poly_train, train_label);
    % disp("poly train p: "+p+" accuracy: "+poly_train_accuracy);

    prediction_poly_test = predict_poly(test_data, train_data, num_test, num_train, train_label,...
                    alpha_poly, bias_mean_poly, p);
    poly_test_accuracy = cal_accuracy(prediction_poly_test, test_label);
    % disp("poly test p: "+p+" accuracy: "+poly_test_accuracy);

    poly_predicted = prediction_poly_test;
end