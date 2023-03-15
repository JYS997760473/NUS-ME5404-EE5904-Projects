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

for sigma_q2c2 = sigma_list
    PHI_q2c2 = zeros(numTr, 2);
    for i=1: numTr
        for j=1: 2
            PHI_q2c2(i,j) = exp(- (norm(train_Data(:,i)-center(:, j)))^2 / (2*(sigma_q2c2^2)));
        end
    end
    w_q2c2 = (TrLabel / PHI_q2c2')';
    output_train_q2c2 = (PHI_q2c2 * w_q2c2)';
    
    PHI_test_q2c2 = zeros(numTe, 2);
    for i=1: numTe
        for j=1: 2
            PHI_test_q2c2(i,j) = exp(- (norm(test_Data(:,i)-center(j, :)))^2 / (2*(sigma_q2c2^2)));
        end
    end
    output_test_q2c2 = (PHI_test_q2c2 * w_q2c2)';
    
    q2evaluate(output_train_q2c2, output_test_q2c2, TrLabel, TeLabel);
    title(['Clustering by K-means with width (sigma = ', num2str(sigma_q2c2), ')'])
    saveas(gcf, ['./figures/Clustering by K-means with width (sigma = ', num2str(sigma_q2c2), ').jpg'])
end