clear;
close all;


run preprocess

num_train = size(train_data, 2);
num_test = size(test_data, 2);

% H matrix of linear kernel for quadratic programming:
disp("calculating linear H matrix")
didj = train_label * train_label';
xixj = train_data' * train_data;
H_linear = didj .* xixj;

% H matrix of polynomial kernel for quadratic programming:
fprintf("\n");
disp("calculating polynomial H matrix")
H_polynomial = zeros(5, num_train, num_train);
for p = 1: 5
    for i = 1: num_train
        for j = 1: num_train
            H_polynomial(p,i,j) = train_label(i) * train_label(j) * ...
                                (train_data(:,i)' * train_data(:,j) + 1)^p;
        end
    end
end

% (1) hard margin SVM with the linear kernel
% Gram matrix construction
fprintf("\n");
disp("calculating linear kernel Gram matrix...");
Gram_linear = zeros(num_train, num_train);
for i = 1: num_train
    for j = 1: num_train
        Gram_linear(i,j) = train_data(:,i)' * train_data(:,j);
    end
end
% test the Mercer’s condition
eig_value_linear = eig(Gram_linear);
if min(eig_value_linear) < -1e-4
    % error("Don't satisfy Mercer's condition");
    disp("linear kernel doesn't satify Mercer's condition");
else
    disp("linear kernel satify Mercer's condition");
    [alpha_linear, support_vector_idx_linear] = cal_quadprog(num_train, H_linear, 1e7, train_data, ...
                                                        train_label);
    [kernel_support_vector_linear, bias_mean_linear] = cal_disfun_linear(support_vector_idx_linear, ...
                            train_label, num_train, train_data, alpha_linear);
end



% (2) hard margin SVM with polynomial kernel
% Gram matrix construction
fprintf("\n");
disp("calculating polynomial kernel Gram matrix...");
Gram_polynomial = zeros(5, num_train, num_train);
for p = 1: 5
    disp("calculating "+p+" Gram matrix...");
    for i = 1: num_train
        for j = 1: num_train
            Gram_polynomial(p, i,j) = (train_data(:,i)' * train_data(:,j) + 1)^p;
        end
    end
end
% test the Mercer’s condition
% create a cell array to store polynomial kernel with different p.
alpha_poly = {};
support_vector_idx_poly = {};
kernel_support_vector_poly = {};
for p = 1: 5
    eig_value_polynomial(p,:) = eig(reshape(Gram_polynomial(p,:,:), [num_train, num_train]));
    if min(eig_value_polynomial(p,:)) < -1e-4
        fprintf("\n");
        disp("polynomial "+p+" doesn't satify Mercer's condition");
    else
        fprintf("\n");
        disp("polynomial "+p+" satify Mercer's condition");
        [alpha_poly{p}, support_vector_idx_poly{p}] = cal_quadprog(num_train, ...
                                    H_polynomial(p,:,:), 1e7, train_data, train_label);
        [kernel_support_vector_poly{p}, bias_mean_poly(p)] = cal_disfun_linear(...
                        support_vector_idx_poly{p}, train_label, num_train, train_data, alpha_poly{p});
    end
end


% (3) soft-margin SVM with polynomial kernel
fprintf("\n");
disp("Soft-margin--------");
C = [0.1, 0.6, 1.1, 2.1];
alpha_poly_soft = {};
support_vector_idx_poly_soft = {};
kernel_support_vector_poly_soft = {};
bias_mean_poly_soft = zeros(5,4);
for p = 1: 5
    eig_value_polynomial(p,:) = eig(reshape(Gram_polynomial(p,:,:), [num_train, num_train]));
    if min(eig_value_polynomial(p,:)) < -1e-4
        fprintf("\n");
        disp("polynomial "+p+" doesn't satify Mercer's condition");
    else
        fprintf("\n");
        disp("polynomial "+p+" satify Mercer's condition");
        alpha_poly_soft_tmp = {};
        support_vector_idx_poly_soft_tmp = {};
        kernel_support_vector_poly_soft_tmp = {};
        for idx = 1: 4
            disp("optimizing soft margin polynomial "+p+" "+"C: "+C(idx));
            [alpha_poly_soft_tmp{idx}, support_vector_idx_poly_soft_tmp{idx}] = cal_quadprog(num_train, ...
                                        H_polynomial(p,:,:), C(idx), train_data, train_label);
            [kernel_support_vector_poly_soft_tmp{idx}, bias_mean_poly_soft(p,idx)] = cal_disfun_linear(...
    support_vector_idx_poly_soft_tmp{idx}, train_label, num_train, train_data, alpha_poly_soft_tmp{idx});
        end
        alpha_poly_soft{p} = alpha_poly_soft_tmp;
        support_vector_idx_poly_soft{p} = support_vector_idx_poly_soft_tmp;
        kernel_support_vector_poly_soft{p} = kernel_support_vector_poly_soft_tmp;
    end
end