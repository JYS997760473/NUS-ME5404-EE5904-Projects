% randomly choose 100 points:
rand_index = randsample(numTr, 100);
rand_train = train_Data(:, rand_index);
rand_train_label = train_ClassLabel(:, rand_index);
distance_max_q2b = -10000;
% convert groundtruth label to 0, 1: 
for i=1: length(train_ClassLabel)
    if train_ClassLabel(1,i) == 1
        % 1 to 0
        TrLabel(i) = 0;
    else 
        % 9 to 1
        TrLabel(i) = 1;
    end
end

for i=1: length(test_ClassLabel)
    if test_ClassLabel(1,i) == 1
        % 1 to 0
        TeLabel(i) = 0;
    else 
        % 9 to 1
        TeLabel(i) = 1;
    end
end

for i=1: 100
    for j=1: 100
        distance = norm(rand_train(:,i)-rand_train(:,j));
        distance_max_q2b = max(distance_max_q2b, distance);
    end
end
sigma_q2b = distance_max_q2b / sqrt(2*100);
% without regularization:
PHI_q2b = zeros(numTr, 100);
for i=1: numTr
    for j=1: 100
        PHI_q2b(i,j) = exp(- (norm(train_Data(:,i)-rand_train(:,j)))^2 / (2*(sigma_q2b^2)));
    end
end
w_q2b = (TrLabel / PHI_q2b')';
output_train_q2b = (PHI_q2b * w_q2b)';

for i=1: numTe
    for j=1: 100
        PHI_test_q2b(i,j) = exp(- (norm(test_Data(:,i)-rand_train(:,j)))^2 / (2*(sigma_q2b^2)));
    end
end
output_test_q2b = (PHI_test_q2b * w_q2b)';

q2evaluate(output_train_q2b, output_test_q2b, TrLabel, TeLabel);
title(['Fixed Centers Selected at Random with fixed size'])
saveas(gcf, 'Fixed Centers Selected at Random with fixed size.jpg')