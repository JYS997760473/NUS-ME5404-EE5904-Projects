clear;
close all;

x_train = [-1:0.05:1];
x_test = [-1:0.01:1];
y_train = 1.2*sin(pi*x_train)-cos(2.4*pi*x_train);
y_test = 1.2*sin(pi*x_test)-cos(2.4*pi*x_test);
n = [1:10, 20, 50];
train_num = size(x_train, 2);
epoch = 1000;


net = fitnet(n(6), 'trainlm');
net.inputWeights{1,1}.learnParam.lr = 0.001;

for i = 1: epoch
    index = randperm(train_num);
    net = adapt(net, x_train(:, index), y_train(:, index));
end

test_out = net(x_test);
plot(x_test, test_out, 'LineWidth', 2);
hold on;
plot(x_test, y_test, 'LineWidth', 2);  
legend('Estimated Function','Groundtruth Function')
xlabel('x', 'FontSize', 20)
ylabel('y', 'FontSize', 20)