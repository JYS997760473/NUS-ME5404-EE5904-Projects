[idx, center] = kmeans(train_Data', 2);
center = center';
% first center is 9, second center is 1
% tmp=reshape(center(1,:),28,28);
% imshow(double(tmp)); 
% tmp=reshape(center(2,:),28,28);
% imshow(double(tmp)); 

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

distance_max_q2c = norm(center(:,1)-center(:,2));
sigma_q2c = distance_max_q2c / sqrt(2*2);
PHI_q2c = zeros(numTr, 2);
for i=1: numTr
    for j=1: 2
        PHI_q2c(i,j) = exp(- (norm(train_Data(:,i)-center(:, j)))^2 / (2*(sigma_q2c^2)));
    end
end
w_q2c = (TrLabel / PHI_q2c')';
output_train_q2c = (PHI_q2c * w_q2c)';

PHI_test_q2c = zeros(numTe, 2);
for i=1: numTe
    for j=1: 2
        PHI_test_q2c(i,j) = exp(- (norm(test_Data(:,i)-center(j, :)))^2 / (2*(sigma_q2c^2)));
    end
end
output_test_q2c = (PHI_test_q2c * w_q2c)';

class1_idx = find(output_train_q2c <= 0.2);
class2_idx = find(output_train_q2c > 0.2);
class1 = train_Data(:, class1_idx);
class2 = train_Data(:, class2_idx);
class1_mean = mean(class1');
class2_mean = mean(class2');
% tmp=reshape(center(2,:),28,28);
% imshow(double(tmp));

q2evaluate(output_train_q2c, output_test_q2c, TrLabel, TeLabel);
title(['Clustering by K-means with fixed size'])
saveas(gcf, './figures/Clustering by K-means with fixed size.jpg')