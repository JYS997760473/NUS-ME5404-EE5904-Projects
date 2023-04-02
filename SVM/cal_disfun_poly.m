function [kernel_support_vector, bias_mean] = cal_disfun_poly(support_vector_idx, ...
                                                train_label, num_train, train_data, alpha, p)
    alpha = reshape(alpha, [num_train, 1]);
    num_support_vector = size(support_vector_idx, 1);
    label_support_vector = train_label(support_vector_idx);
    bias0 = zeros(num_support_vector, 1);

    % calculate kernel support vector
    kernel_support_vector = zeros(num_train, num_support_vector);
    for i = 1: num_support_vector
        for j = 1: num_train
            kernel_support_vector(j,i) = (train_data(:,j)' * train_data(:,support_vector_idx(i)) + 1)^p;
        end   
    end

    % calculate the sum of weights*kernel values and the bias values
    weights_support_vector = zeros(num_support_vector,1);
    for i = 1: num_support_vector
        weights_support_vector(i) = sum((alpha .* train_label) .* kernel_support_vector(:,i));
        bias0(i) = label_support_vector(i) - weights_support_vector(i);
    end
    bias_mean = mean(bias0);
end