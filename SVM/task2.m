fprintf("\n");
disp("Predict--------------------------");

% linear kernel:
fprintf("\n");
disp("linear kernel");
prediction_linear_train = predict_linear(train_data, train_data, num_train, num_train, train_label,...
                    alpha_linear, bias_mean_linear);
linear_train_accuracy = cal_accuracy(prediction_linear_train, train_label);
disp("linear train accuracy: "+linear_train_accuracy);

prediction_linear_test = predict_linear(test_data, train_data, num_test, num_train, train_label,...
                                    alpha_linear, bias_mean_linear);
linear_test_accuracy = cal_accuracy(prediction_linear_test, test_label);
disp("linear test accuracy: "+linear_test_accuracy);

% polynomial kernel:
% hard margin:
fprintf("\n");
disp("polynomial kernel hard margin");
for idx = 1: 3
    prediction_poly_train = predict_poly(train_data, train_data, num_train, num_train, train_label,...
                    alpha_poly{idx}, bias_mean_poly(idx), idx);
    poly_train_accuracy = cal_accuracy(prediction_poly_train, train_label);
    disp("poly train p: "+idx+" accuracy: "+poly_train_accuracy);

    prediction_poly_test = predict_poly(test_data, train_data, num_test, num_train, train_label,...
                    alpha_poly{idx}, bias_mean_poly(idx), idx);
    poly_test_accuracy = cal_accuracy(prediction_poly_test, test_label);
    disp("poly test p: "+idx+" accuracy: "+poly_test_accuracy);
end

% soft margin:
fprintf("\n");
disp("polynomial kernel soft margin");
for idx = 1: 3
    for i = 1: 4
        prediction_poly_train_soft = predict_poly(train_data, train_data, num_train, num_train,... 
                train_label, alpha_poly_soft{idx}{i}, bias_mean_poly_soft(idx,i), idx);
        poly_train_accuracy_soft = cal_accuracy(prediction_poly_train_soft, train_label);
        disp("poly train p: "+idx+" C: "+C(i)+" accuracy: "+poly_train_accuracy_soft);

        prediction_poly_test_soft = predict_poly(test_data, train_data, num_test, num_train,... 
                train_label, alpha_poly_soft{idx}{i}, bias_mean_poly_soft(idx,i), idx);
        poly_test_accuracy_soft = cal_accuracy(prediction_poly_test_soft, test_label);
        disp("poly test p: "+idx+" C: "+C(i)+" accuracy: "+poly_test_accuracy_soft);
    end
end