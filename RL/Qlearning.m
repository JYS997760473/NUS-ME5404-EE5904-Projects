function [reach_goal, reachOpt, execution_time, newQtable, numTrials, totalReward] = ...
                Qlearning(oldQtable, reward, epsilon_type, gamma)
    % one time running Q-learning

    % stop watch
    tic;
    % old Qtable is the initialization Q table
    Qtable = oldQtable;
    max_trials = 3000;
    max_steps = 1000;
    reachOpt = 0;
    reach_goal = 0;

    for i = 1: max_trials
        % different episodes
        % every episode's initial state is 1
        current_state = 1;
        totalReward = 0;
        beforeQtable = Qtable;
        % traverse every step:
        for k = 1: max_steps
            % judge whether reach the goal
            if current_state == 100
                % reach the goal, break this trial
                reach_goal = 1;
                break;
            end
            % choose an action
            [current_action, epsilon] = takeAction(Qtable, reward, current_state, ...
                    epsilon_type, k);
            % calculate next state
            next_state = calState(current_state, current_action);
            % choose next action
            next_actions = find(Qtable(next_state, :) == max(Qtable(next_state, :)));
            next_action = next_actions(1);
            % alpha is the same as epsilon
            alpha = epsilon;
            if alpha < 0.005
                break;
            end
            % update Q value of current state with current action
            Qtable(current_state, current_action) = Qtable(current_state, current_action)...
                + alpha * (reward(current_state, current_action) + gamma * ...
                max(Qtable(next_state, :)) - Qtable(current_state, current_action));
            % take reward
            totalReward = totalReward + reward(current_state, current_action);
            % update current state and current action
            current_state = next_state;
            current_action = next_action;
        end
        % if reach the optimal policy, Qtable converges, finish this run.
        afterQtable = Qtable;
        if reach_goal == 1 & max(abs(afterQtable - beforeQtable)) < 0.05
            reachOpt = 1;
            break;
        end
    end
    numTrials = i;
    newQtable = Qtable;
    execution_time = toc;
end