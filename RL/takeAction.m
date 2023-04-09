function [action, epsilon] = takeAction(Qtable, reward, currentState, epsilon_type, k)
    % Q learning take action by current Q-table
    epsilon = getEpsilon(epsilon_type, k);
    QCurrentState = Qtable(currentState, :);
    rewardCurrentState = reward(currentState, :);
    valid_index = find(rewardCurrentState ~= -1);
    valid_Qvalue = QCurrentState(valid_index);

    if sum(QCurrentState) == 0
        % current state's Q value is at the initialization state
        action = valid_index(randperm(length(valid_index), 1));
    else
        % current state's Q value has been updated
        if rand > epsilon
            % epsilon soft policy
            [maxNum, max_index] = max(valid_Qvalue);
            action = valid_index(max_index);
        else
            valid_rest_index = find(rewardCurrentState ~= -1 & QCurrentState...
                         ~= max(QCurrentState));
            action = valid_rest_index(randperm(length(valid_rest_index), 1));
        end
    end
end

function epsilon = getEpsilon(epsilon_type, k)
    % get epsilon value
    if epsilon_type == 1
        epsilon = 1 / k;
    elseif epsilon_type == 2
        epsilon = 100 / (100 + k);
    elseif epsilon_type == 3
        epsilon = (1 + log(k)) / k;
    else
        epsilon = (1 + 5 * log(k)) / k;
    end
end