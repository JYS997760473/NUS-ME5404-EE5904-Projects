function [] = drawOptPolicy(optimalPolicy, total_reward)
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
    for i = 1 : 10 
        for j = 1: 10 
            state = i + (j - 1) * 10;
            plot(j - 0.5, i - 0.5, direction(optimalPolicy(state)));
        end
    end
    hold off
end