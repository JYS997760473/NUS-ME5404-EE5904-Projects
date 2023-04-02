load('train.mat');
load('test.mat');

num_train = size(train_data, 2);
num_test = size(test_data, 2);

% H matrix of linear kernel for quadratic programming:
didj = train_label * train_label';
xixj = train_data' * train_data;
H_linear = didj .* xixj;

% H matrix of polynomial kernel for quadratic programming:
for p = 1: 5
    didj = train_label * train_label';
    xixj = (train_data' * train_data + 1)^p;
    H_polynomial(p, :, :) = didj .* xixj;
end

% hard margin SVM with the linear kernel
[alpha, support_vector_idx] = cal_disfun(num_train, H_linear, 1e7, train_data, train_label, 1);

num_support_vector = size(support_vector_idx, 1);
label_support_vector = train_label(support_vector_idx);
bias0 = zeros(num_support_vector, 1);

% calculate kernel support vector
kernel_support_vector = zeros(num_train, num_support_vector);
for i = 1: num_support_vector
    for j = 1: num_train
        kernel_support_vector(j,i) = train_data(:,j)' * train_data(:,support_vector_idx(i));
    end   
end

% calculate the sum of weights*kernel values and the bias values
weights_support_vector = zeros(num_support_vector,1);
for i = 1: num_support_vector
    weights_support_vector(i) = sum((alpha .* train_label) .* kernel_support_vector(:,i));
    bias0(i) = label_support_vector(i) - weights_support_vector(i);
end
bias_mean = mean(bias0);

 