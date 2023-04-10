clc;
clear;
close all;

load qeval.mat;

[numGoal, average_execution_time, qevalstates] = Q_learning(qevalreward);

function [numGoal, average_execution_time, qevalstates] = Q_learning(qevalreward)
    max_trials = 3000;
    runs = 10;
    % initialize a Qtable:
    Qtable = zeros(100, 4);
    % store 10 runs' Qtables
    QtableCell = {};
    % store 10 runs' goal reacher excution time 
    executionTimes = zeros(10, 1);
    reachOpts = zeros(10, 1);
    % store 10 runs' goal reacher total reward
    totalRewards = zeros(10, 1);
    numTrials = zeros(10, 1);
    reachGoals = zeros(10, 1);
    epsilon_type = 5;
    gamma = 0.9;
    numGoal = 0;  % record number of times reaching the goal

    for run = 1: runs
        % run program 10 times Qlearning
        [reach_goal, reachOpt, execution_time, newQtable, numTrial, totalReward] = Qlearning(...
            Qtable, qevalreward, epsilon_type, gamma);
        if reach_goal == 1
            numGoal = numGoal + 1;
            reachGoals(run) = 1;
        end
        executionTimes(run) = execution_time;
        numTrials(run) = numTrial;
        totalRewards(run) = totalReward;
        QtableCell{run} = newQtable;
        reachOpts(run) = reachOpt;
        run
    end

    average_execution_time = sum(executionTimes(find(reachGoals == 1))) / numGoal;

    optimalIndexs = find(reachOpts == 1);
    if length(optimalIndexs) == 0
        disp("no optimal policy, using goal reacher policy");
        indexes = find(reachGoals == 1);
        if length(indexes) == 0
            error("no reaching goal episode");
        end
        optimalPolicy = getPolicyFromQtable(QtableCell{indexes(1)});
        OptimalReward = totalRewards(indexes(1));
    else
        optimalPolicy = getPolicyFromQtable(QtableCell{optimalIndexs(1)});
        OptimalReward = totalRewards(optimalIndexs(1));
    end

    qevalstates = optimalPolicy;

    % draw optimal policy on the 2D grid
    disp("drawing optimal policy");
    drawOptPolicy(optimalPolicy, OptimalReward);

    % draw optimal path
    disp("drawing optimal path");
    drawOptPath(optimalPolicy, OptimalReward);
end