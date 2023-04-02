function accuracy = cal_accuracy(prediciton, groundtruth)
    success = 0;
    num = size(prediciton, 1);
    for i = 1: num
        if prediciton(i) == groundtruth(i)
            success = success + 1;
        end
    end
    accuracy = success / num;
end