load('train.mat');
load('test.mat');
disp("preprocessing...");
train_mean = mean(train_data, 2);
% standard deviation
train_std = std(train_data, 0, 2);
x_train = (train_data - train_mean) ./ train_std;
x_test = (test_data - train_mean) ./ train_std;
train_data = x_train;
test_data = x_test;