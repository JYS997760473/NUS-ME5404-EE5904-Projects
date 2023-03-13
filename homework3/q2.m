load MNIST_database.mat;
% train_data  training data, 784x1000 matrix
% train_classlabel  the labels of the training data, 1x1000 vector % test_data  test data, 784x250 matrix
% train_classlabel  the labels of the test data, 1x250 vector
tmp=reshape(train_data(:,column_no),28,28); 
imshow(double(tmp));