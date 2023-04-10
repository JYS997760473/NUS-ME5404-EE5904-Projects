function policy = getPolicyFromQtable(Qtable)
    % get policy from Q table
    policy = zeros(100, 1);
    for i = 1: 100
        [~, index] = max(Qtable(i, :));
        % choose the max to the action
        policy(i, 1) = index;
    end
end