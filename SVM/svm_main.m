clc;
close all;
clear all;

load('train.mat')
load('test.mat')
% load('eval.mat')

% pre process data
run preprocess

num_train = size(train_data, 2);
num_test = size(test_data, 2);
% num_eval = size(eval_data, 2);


%% SVM with the RBF kernel
disp("RBF Kernel for the training and test set---------")
gamma = 0.05;
C = 2.0;
[RBF_train_accuracy, RBF_test_accuracy, test_predicted] = RBF(gamma, num_train, train_label, ...
                train_data, test_data, num_test, test_label, C);
disp("RBF train accuracy: "+RBF_train_accuracy);
disp("RBF test accuracy: "+RBF_test_accuracy);
disp("RBF Kernel for the evaluation set---------")
% [RBF_train_accuracy, RBF_eval_accuracy, eval_predicted] = RBF(gamma, num_train, train_label, ...
%                 train_data, eval_data, num_eval, eval_label, C);
% disp("RBF evaluation accuracy: "+RBF_eval_accuracy);
disp('-------------------------------------------------------------------------------------------')

% SVM with Hard Margin Linear Kernel
disp("Hard Margin Kernel for the training and test set---------")
[linear_train_accuracy, linear_test_accuracy, linear_predicted] = linear_hard(num_train, train_label, ...
                train_data, test_data, num_test, test_label);
disp("Linear Hard train accuracy: "+linear_train_accuracy);
disp("Linear Hard test accuracy: "+linear_test_accuracy);
disp("Linear Hard Kernel for the evaluation set---------")
% [linear_train_accuracy, linear_eval_accuracy, linear_eval_predicted] = linear_hard(num_train, train_label, ...
%                 train_data, eval_data, num_eval, eval_label);
% disp("Linear Hard evaluation accuracy: "+linear_eval_accuracy);
disp('-------------------------------------------------------------------------------------------')

% SVM with Hard Margin Polynomial Kernel
disp("Hard Margin Polynomial Kernel for the training and test set---------")
p = 2;
[poly_train_accuracy, poly_test_accuracy, poly_predicted] = poly_hard(num_train, train_label, ...
                train_data, test_data, num_test, test_label, p);
disp("Polynomial Hard train accuracy: "+poly_train_accuracy);
disp("Polynomial Hard test accuracy: "+poly_test_accuracy);
disp("polynomial Hard Kernel for the evaluation set---------")
% [poly_train_accuracy, poly_eval_accuracy, poly_eval_predicted] = poly_hard(num_train, train_label, ...
%                 train_data, eval_data, num_eval, eval_label, p);
% disp("Polynomial Hard evaluation accuracy: "+poly_eval_accuracy);
disp('-------------------------------------------------------------------------------------------')

% SVM with Soft Margin Polynomial Kernel
disp("Soft Margin Polynomial Kernel for the training and test set---------")
p = 2;
C = 2.1;
[poly_train_accuracy_soft, poly_test_accuracy_soft, poly_predicted_soft] = poly_soft(num_train, train_label, ...
                train_data, test_data, num_test, test_label, p, C);
disp("Polynomial Soft train accuracy: "+poly_train_accuracy_soft);
disp("Polynomial Soft test accuracy: "+poly_test_accuracy_soft);
disp("polynomial Soft Kernel for the evaluation set---------")
% [poly_train_accuracy_soft, poly_eval_accuracy_soft, polysoft_eval_predicted] = poly_soft(num_train, train_label, ...
%                 train_data, eval_data, num_eval, eval_label, p, C);
% disp("Polynomial Soft evaluation accuracy: "+poly_eval_accuracy_soft);
disp('-------------------------------------------------------------------------------------------')