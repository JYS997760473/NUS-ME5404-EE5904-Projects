function [poly_train_accuracy_soft, poly_test_accuracy_soft, poly_predicted_soft] = poly_soft(num_train, train_label, ...
                                train_data, test_data, num_test, test_label, p, C)
    
    % H matrix of polynomial kernel for quadratic programming:
    disp("calculating polynomial H matrix")
    H_polynomial = zeros(num_train, num_train);
    for i = 1: num_train
        for j = 1: num_train
            H_polynomial(i,j) = train_label(i) * train_label(j) * ...
                                (train_data(:,i)' * train_data(:,j) + 1)^p;
        end
    end

    % fprintf("\n");
    disp("calculating polynomial kernel Gram matrix...");
    Gram_polynomial = zeros(num_train, num_train);
    disp("calculating "+p+" Gram matrix...");
    for i = 1: num_train
        for j = 1: num_train
            Gram_polynomial(i,j) = (train_data(:,i)' * train_data(:,j) + 1)^p;
        end
    end

    % (3) soft-margin SVM with polynomial kernel
    alpha_poly_soft = {};
    support_vector_idx_poly_soft = {};
    kernel_support_vector_poly_soft = {};
    eig_value_polynomial(:) = eig(reshape(Gram_polynomial(:,:), [num_train, num_train]));
    if min(eig_value_polynomial(:)) < -1e-4
        fprintf("\n");
        disp("polynomial "+p+" doesn't satify Mercer's condition");
    else
        fprintf("\n");
        disp("polynomial "+p+" satify Mercer's condition");
        alpha_poly_soft_tmp = {};
        support_vector_idx_poly_soft_tmp = {};
        kernel_support_vector_poly_soft_tmp = {};
        disp("optimizing soft margin polynomial "+p+" "+"C: "+C);
        [alpha_poly_soft_tmp, support_vector_idx_poly_soft_tmp] = cal_quadprog(num_train, ...
                                    H_polynomial(:,:), C, train_data, train_label);
        [kernel_support_vector_poly_soft_tmp, bias_mean_poly_soft] = cal_disfun_poly(...
    support_vector_idx_poly_soft_tmp, train_label, num_train, train_data, alpha_poly_soft_tmp, p);
        alpha_poly_soft = alpha_poly_soft_tmp;
        support_vector_idx_poly_soft = support_vector_idx_poly_soft_tmp;
        kernel_support_vector_poly_soft = kernel_support_vector_poly_soft_tmp;
    end

    % soft margin:
    % fprintf("\n");
    % disp("polynomial kernel soft margin");
    prediction_poly_train_soft = predict_poly(train_data, train_data, num_train, num_train,... 
            train_label, alpha_poly_soft, bias_mean_poly_soft, p);
    poly_train_accuracy_soft = cal_accuracy(prediction_poly_train_soft, train_label);
    % disp("poly train p: "+p+" C: "+C+" accuracy: "+poly_train_accuracy_soft);

    prediction_poly_test_soft = predict_poly(test_data, train_data, num_test, num_train,... 
            train_label, alpha_poly_soft, bias_mean_poly_soft, p);
    poly_test_accuracy_soft = cal_accuracy(prediction_poly_test_soft, test_label);
    % disp("poly test p: "+p+" C: "+C+" accuracy: "+poly_test_accuracy_soft);

    poly_predicted_soft = prediction_poly_test_soft;
end