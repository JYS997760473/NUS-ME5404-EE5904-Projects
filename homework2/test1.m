% image_dir = "/Users/jiayansong/Desktop/nus/ME5404/group_4/group_4";
% test_dir = fullfile(image_dir, 'test');
% test_images = dir(test_dir);
% % convert images to vectors and create label matrix
% for i = 3: length(test_images)
%     image = fullfile(test_dir, test_images(i).name);
%     I = double(imread(image));
%     V = I(:);
%     V = [1; V];
%     test_vectors(:, i-2) = V;
%     tmp = strsplit(test_images(i).name, {'_', '.'});
%     test_labels(i-2) = double(str2num(tmp{2}));
% end
% results = abs((W'*test_vectors > 0)-test_labels);
% sum = 0;
% for j = results
%     if j == 0
%         sum = sum + 1;
%     end
% end

test_sum = 0;
for i=1: 171
    if test(i) < 0.5
        cur = 0;
    else
        cur = 1;
    end
    if cur == test_labels(i)
        test_sum = test_sum + 1;
    end
end
test_sum