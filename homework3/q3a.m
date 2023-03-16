close all;
clear;
t = linspace(-pi,pi,200);
trainX = [t.*sin(pi*sin(t)./t); 1-abs(t).*cos(pi*sin(t)./t)]; % 2x200 matrix, column-wise points
num_train = size(trainX, 2);
num_neurons = 25;
neurons = rand(2, num_neurons);
N = 600;
% initial width:
sigma0 = sqrt(2*(num_neurons^2)) / 2;
% time constant:
tau = N / log(sigma0);
record = [0, 10, 20, 50, 100:100:N];
r=1;
% begin training
for n=1 : N
    % choose an input vector x from the training set:
    x = trainX(:, randi(num_train));
    % time-varying width:
    sigma = sigma0 * exp(- n / tau);
    % find the cloeset nerons to the vector x chosen:
    [min_num, min_index]=min(sum((x-neurons).^2));
    % learning rate
    lr = 0.1 * exp(- n / N);
    % update neurons:
    for i=1: num_neurons
        % distance
        distanceSquare = (i-min_index)^2;
        % time-varying neighborhood function:
        h = exp(- distanceSquare / (2 * (sigma^2)));
        % update neurons:
        neurons(:, i) = neurons(:, i) + lr * h * (x - neurons(:, i));
    end
    if n == record(r)
        n
        figure
        hold on
        scatter(neurons(1,:), neurons(2,:), 'b');
        plot(neurons(1,:), neurons(2,:),'b'); 
        plot(trainX(1,:),trainX(2,:),'+r');
        title(['n=', num2str(n), ')']);
        hold off;
        axis equal;
        saveas(gcf, ['./figures/n=', num2str(n), ').jpg']);
        r = r + 1;
    end
end
