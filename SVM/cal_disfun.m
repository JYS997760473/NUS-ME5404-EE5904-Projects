function [alpha, support_vector_idx] = cal_disfun(num_data, H_matrix, C, data, label, p)
    f = -ones(num_data, 1);
    A = [];
    b = [];
    Aeq = label'; % Aeq should be 1 * n
    beq = 0;
    lb = zeros(num_data, 1);
    ub = ones(num_data, 1) * C;
    x0 = [];
    % opt = optimset('LargeScale', 'off', 'MaxIter', 1000);
    alpha = quadprog(H_matrix, f, A, b, Aeq, beq, lb, ub, x0);

    rounded_alpha = find(alpha < 1e-4);
    alpha(rounded_alpha) = 0; 
    
    support_vector_idx = find(alpha>0 & alpha<C);
end