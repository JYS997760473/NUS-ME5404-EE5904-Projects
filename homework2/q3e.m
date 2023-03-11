close all;
clear;

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
test_images = dir(test_dir);
% convert images to vectors and create label matrix
for i = 3: length(test_images)
    image = fullfile(test_dir, test_images(i).name);
    I = double(imread(image));
    V = I(:);
    V = [1; V];
    test_vectors(:, i-2) = V;
    tmp = strsplit(test_images(i).name, {'_', '.'});
    test_labels(i-2) = double(str2num(tmp{2}));
end


net = patternnet(5, 'traingdx');
net.trainParam.lr = 0.01;
net.trainparam.goal=1e-8;
net.divideFcn = 'dividetrain';
net.performParam.regularization = 0.5;
for i = 1: 100
    net=adapt(net, train_vectors, labels);
end
test = net(test_vectors);
accu_test = 1 - mean(abs(test-test_labels));