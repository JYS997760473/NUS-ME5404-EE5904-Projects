function next_state = calState(current_state, current_action)
    % calcualte next state upon current state and current action
    % action: 1: up, 2: right, 3: down, 4: left
    % change current state to grid coordinate:
    mod_number = mod(current_state, 10);
    if mod_number == 0
        row = 10;
    else
        row = mod_number;
    end
    column = floor((current_state - 1) / 10) + 1;

    if current_action == 1
        % up
        next_row = row - 1;
        next_column = column;
    elseif current_action == 2
        % right
        next_row = row;
        next_column = column + 1;
    elseif current_action == 3
        % down
        next_row = row + 1;
        next_column = column;
    else
        % left
        next_row = row;
        next_column = column - 1;
    end

    % convert 2D grid coordinate to state

    % first check whether the state is valid:
    if next_row < 1 | next_column < 1 | next_row > 10 | next_column > 10
        next_row
        next_column
        current_state
        current_action
        error("out of the valid region!");
    end
    next_state = next_row + (next_column - 1) * 10;
end