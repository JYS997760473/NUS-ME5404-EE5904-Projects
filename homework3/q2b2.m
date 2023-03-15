% randomly choose 100 points:
rand_index = randsample(numTr, 100);
rand_train = train_Data(:, rand_index);
rand_train_label = train_ClassLabel(:, rand_index);
sigma_list = [0.1, 1, 10, 100, 1000, 10000];
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

for sigma_q2b2 = sigma_list
    % without regularization:
    PHI_q2b2 = zeros(numTr, 100);
    for i=1: numTr
        for j=1: 100
            PHI_q2b2(i,j) = exp(- (norm(train_Data(:,i)-rand_train(:,j)))^2 / (2*(sigma_q2b2^2)));
        end
    end
    w_q2b2 = (TrLabel / PHI_q2b2')';
    output_train_q2b2 = (PHI_q2b2 * w_q2b2)';

    for i=1: numTe
        for j=1: 100
            PHI_test_q2b2(i,j) = exp(- (norm(test_Data(:,i)-rand_train(:,j)))^2 / (2*(sigma_q2b2^2)));
        end
    end
    output_test_q2b2 = (PHI_test_q2b2 * w_q2b2)'

    q2evaluate(output_train_q2b2, output_test_q2b2, TrLabel, TeLabel);
    title(['Width(sigma = ', num2str(sigma_q2b2), ')'])
    saveas(gcf, ['./figures/Width(sigma = ', num2str(sigma_q2b2), ').jpg'])
end
