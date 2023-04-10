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
QtableCell = {};
epsilon_type = 1;
gamma = 0.5;
numGoal = 0;  % record number of times reaching the goal

for run = 1: runs
    % run program 10 times Qlearning
    [reach_goal, execution_time, newQtable, numTrials] = Qlearning(Qtable, ... 
            reward, epsilon_type, gamma);
    if reach_goal == 1
        numGoal = numGoal + 1;
    end
    QtableCell{run} = newQtable;
end