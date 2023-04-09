clc;
clear;
close all;

load task1.mat;

% state: (colomn-1) * 10 + row
% action: 1: up, 2: right, 3: down, 4: left

max_trials = 3000;
runs = 10;
% initialize a Qtable:
Qtable = zeros(100, 4);
epsilon_type = 4;
gamma = 0.9;

in = 1;
for run = 1: runs
    % run program 10 times Qlearning
    [reach_goal, execution_time, Qtable] = Qlearning(Qtable, reward, ...
        epsilon_type, gamma);
    reach_goal
end