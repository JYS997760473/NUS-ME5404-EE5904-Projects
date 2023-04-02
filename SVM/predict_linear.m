function prediction = predict_linear(test_data, train_data, num_test, num_train, train_label,...
                         alpha, bias_mean)
    kernel_data=zeros(num_train, num_test);
    for i = 1: num_test
        for j = 1: num_train
            kernel_data(j,i) = train_data(:,j)' * test_data(:,i);
        end
    end

    weights_whole = zeros(num_test,1);
    prediction = zeros(num_test,1);

    for i = 1: num_test
        weights_whole(i) = sum((alpha .* train_label) .* kernel_data(:,i));
        gx = weights_whole(i) + bias_mean;
        prediction(i) = sign(gx);
    end
end
