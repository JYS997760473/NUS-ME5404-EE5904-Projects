function [] = drawOptPath(optimalPolicy, total_reward)
    % draw optimal policy on 2D grid
    % action: 1: up, 2: right, 3: down, 4: left
    direction = ['^';'>';'v';'<'];
    figure
    hold on
    plot(9.5, 9.5, '*')
    axis([0 10 0 10])
    title(['Optimal policy with associated reward = ', num2str(total_reward)])
    grid on
    set(gca,'YDir','reverse')
    current_state = 1;
    current_row = 1;
    current_col = 1;
    while current_state ~= 100
        current_action = optimalPolicy(current_state);
        plot(current_col - 0.5, current_row - 0.5, direction(current_action));
        if current_action == 1
            current_row = current_row - 1;
            current_col = current_col;
        elseif current_action == 2
            current_row = current_row;
            current_col = current_col + 1;
        elseif current_action == 3
            current_row = current_row + 1;
            current_col = current_col;
        else
            current_row = current_row;
            current_col = current_col - 1;
        end
        current_state = current_row + (current_col - 1) * 10;
    end
    hold off
end