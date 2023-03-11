clear;
close all;

image_dir = "/Users/jiayansong/Desktop/nus/ME5404/group_4/group_4";
train_dir = fullfile(image_dir, 'train');
test_dir = fullfile(image_dir, 'test');
train_images = dir(train_dir);
% convert images to vectors and create label matrix
for i = 3: length(train_images)
    image = fullfile(train_dir, train_images(i).name);
    I = double(imresize(imread(image), [32 32]));
    V = I(:);
    V = [1; V];
    train_vectors(:, i-2) = V;
    tmp = strsplit(train_images(i).name, {'_', '.'});
    labels(i-2) = double(str2num(tmp{2}));
end
% weights
W = zeros(32*32 + 1, 1);
epoches = 10000;
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

test_dir = fullfile(image_dir, 'test');
test_images = dir(test_dir);
% convert images to vectors and create label matrix
for i = 3: length(test_images)
    image = fullfile(test_dir, test_images(i).name);
    I = double(imresize(imread(image), [32 32]));
    V = I(:);
    V = [1; V];
    test_vectors(:, i-2) = V;
    tmp = strsplit(test_images(i).name, {'_', '.'});
    test_labels(i-2) = double(str2num(tmp{2}));
end
test_results = abs((W'*test_vectors > 0)-test_labels);
test_sum = 0;
for j = test_results
    if j == 0
        test_sum = test_sum + 1;
    end
end