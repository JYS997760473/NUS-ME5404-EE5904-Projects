clear;
close all;

image_dir = "/Users/jiayansong/Desktop/nus/ME5404/group_4/group_4";
train_dir = fullfile(image_dir, 'train');
test_dir = fullfile(image_dir, 'test');
train_images = dir(train_dir);
% convert images to vectors and create label matrix
for i = 3: length(train_images)
    image = fullfile(train_dir, train_images(i).name);
    I = double(imread(image));
    V = I(:);
    V = [1; V];
    train_vectors(:, i-2) = V;
    tmp = strsplit(train_images(i).name, {'_', '.'});
    labels(i-2) = double(str2num(tmp{2}));
end
% weights
W = zeros(256*256 + 1, 1);
epoches = 50;
epoch = 1;
lr = 0.1;
while epoch < epoches
    samples = randperm(513);
    for i=samples
        y = W'*train_vectors(:, i);
        % activate function hard limiter
        y = y > 0;
        e = labels(i) - y;
        W = W + lr*e*train_vectors(:, i);
    end
    results = abs((W'*train_vectors > 0)-labels);
    sum = 0;
    for j = results
        if j == 0
            sum = sum + 1;
        end
    end
    ac_train(epoch) = sum;
    if sum == 513
        break
    end
    epoch = epoch + 1;
end























function [net, accu_train, accu_val] = train_seq(n, images, labels, train_num, val_num, epochs)
    % Construct a 1-n-1 MLP and conduct sequential training.
    %
    % Args:
    % 
    % n: int, number of neurons in the hidden layer of MLP. 
    % images: matrix of (image_dim, image_num), containing possibly
    %         preprocessed image data as input.
    % labels: vector of (1, image_num), containing corresponding label of
    %         each image.
    % train_num: int, number of training images. 
    % val_num: int, number of validation images. 
    % epochs: int, number of training epochs.
    % 
    % Returns:
    % net: object, containing trained network.
    % accu_train: vector of (epochs, 1), containing the accuracy on training
    %             set of each eopch during trainig.
    % accu_val: vector of (epochs, 1), containing the accuracy on validation
    %           set of each eopch during trainig.

    % 1. Change the input to cell array form for sequential training
    images_c = num2cell(images, 1);
    labels_c = num2cell(labels, 1);
    % 2. Construct and configure the MLP
    net = patternnet(n);

    net.divideFcn = 'dividetrain'; % input for training only 
    net.performParam.regularization = 0.25; % regularization strength 
    net.trainFcn = 'traingdx'; % 'trainrp' 'traingdx' 
    net.trainParam.epochs = epochs;

    accu_train = zeros(epochs,1); % record accuracy on training set of each epoch
    accu_val = zeros(epochs,1); % record accuracy on validation set of each epoch

    % 3. Train the network in sequential mode
    for i = 1 : epochs
        display(['Epoch: ', num2str(i)])
        idx = randperm(train_num); % shuffle the input
        net = adapt(net, images_c(:,idx), labels_c(:,idx));
        pred_train=round(net(images(:,1:train_num))); %predictions on training set
        accu_train(i) = 1 - mean(abs(pred_train-labels(1:train_num)));
        pred_val=round(net(images(:,train_num+1:end))); %predictions on validation set
        accu_val(i) = 1 - mean(abs(pred_val-labels(train_num+1:end)));
    end
 end