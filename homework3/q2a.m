% classify for classes 1 and 9.
clear;
close;
load MNIST_database.mat;
% train_data  training data, 784x1000 matrix
% train_classlabel  the labels of the training data, 1x1000 vector % test_data  test data, 784x250 matrix
% train_classlabel  the labels of the test data, 1x250 vector
% tmp=reshape(train_data(:,1),28,28); 
trainIdx = find(train_classlabel==1 | train_classlabel == 9);
testIdx = find(test_classlabel == 1 | test_classlabel == 9);
train_ClassLabel = train_classlabel(trainIdx); 
train_Data = train_data(:,trainIdx);
test_Data = test_data(:, testIdx);
test_ClassLabel = test_classlabel(testIdx);
sigma = 100;
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

TrData = train_Data;
TeData = test_Data;
numTr = size(TrData, 2);
numTe = size(TeData, 2);
% without regularization:
PHI = zeros(numTr, numTr);
for i=1: numTr
    for j=1: numTr
        PHI(i,j) = exp(- (norm(TrData(:,i)-TrData(:,j)))^2 / (2*(sigma^2)));
    end
end
w = inv(PHI) * TrLabel';
output_train = (PHI*w)';

PHI_test = zeros(numTe, numTr);
for i=1: numTe
    for j=1: numTr
        PHI_test(i,j) = exp(- (norm(TeData(:,i)-TrData(:,j)))^2 / (2*(sigma^2)));
    end
end
output = (PHI_test * w)';

q2evaluate(output_train, output, TrLabel, TeLabel);
title('Exact Interpolation Method')
saveas(gcf, 'Exact Interpolation Method.png')