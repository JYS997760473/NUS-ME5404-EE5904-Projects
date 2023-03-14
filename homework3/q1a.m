clear;
close all;
train_x = [-1:0.05:1];
test_x = [-1:0.01:1];
num_neuron = length(train_x);
train_y = 1.2*sin(pi*train_x)-cos(2.4*pi*train_x)+0.3*randn(1, num_neuron);
test_y = 1.2*sin(pi*test_x)-cos(2.4*pi*test_x);
sigma = 0.1;
d = train_y';
% 41 samples in train, 41 hidden units in the network.
PHI = zeros(length(train_x), length(train_x));
for i=1: length(train_x)
    for j=1: length(train_x)
        phi = exp(-(train_x(i)-train_x(j))^2 / (2*(sigma^2)));
        PHI(i, j) = phi;
    end
end
w = inv(PHI) * d;

% test for one test sample
% phi matrix for the test size is 201*41
PHI_TEST = zeros(length(test_x), num_neuron);
for i=1: length(test_x)
    for j=1: num_neuron
        PHI_TEST(i, j) = exp(-(test_x(i)-train_x(j))^2 / (2*(sigma^2)));
    end
end
output = (PHI_TEST * w)';

% evaluation: mean squared error MSE:
error_matrix = (output-test_y).^2;
error = (1/length(test_x))*ones(1, length(test_x))*error_matrix';
error_train_matrix = ((PHI*w)'-train_y).^2;
error_train = (1/length(train_x))*ones(1, length(train_x))*error_train_matrix';
% plot
plot(test_x, test_y, 'LineWidth', 1.5);
hold on;
% plot(train_x, train_y);
hold on;
plot(test_x, output, 'LineWidth', 1.5);
scatter(train_x, train_y,'filled');
xlabel('x');
ylabel('y');
legend('Test Groundtruth','Test Output','Train Samples');