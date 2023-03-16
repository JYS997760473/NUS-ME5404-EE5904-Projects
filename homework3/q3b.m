clear;
close all;
trainX = rands(2,500); % 2x500 matrix, column-wise points
% plot(trainX(1,:),trainX(2,:),'+r');
N_train = size(trainX, 2);
% SOM parameter
iter = 0;
N = 600;
record = [0, 10, 20, 50, 100:100:N];
r = 1;
N_weights = 5 * 5;
weights = rand(2, N_weights);
sigma0 = N_weights / 2;
tau = N / log(sigma0);
while iter <= N
    chosen = randi(N_train);
    now = trainX(:, chosen);
    % find the index of minimum
    [~, idx] = min(sum((now - weights) .^ 2));
    sigma = 2 * (sigma0 * exp(-iter / tau)) ^ 2 ;
    learning_rate = 0.1 * exp(iter / N);
    for i = 1 : N_weights
        d = (fix((i - 1) / 5) - fix((idx - 1) / 5)) ^ 2 + (mod(i - 1, 5) - mod(idx - 1, 5)) ^ 2;
        h = exp(-d / sigma);
        weights(:, i) = weights(:, i) + learning_rate * h * (now - weights(:, i));
    end
    % draw and save figure of certain iterations
    if iter == record(r)
        figure
        hold on
        plot(trainX(1,:),trainX(2,:),'+r');
        for i = 1 : 5
            plot(weights(1, i*5-4:i*5), weights(2, i*5-4:i*5), '+b-');
            plot(weights(1, i:5:end), weights(2, i:5:end), '+b-');
        end
        hold off
        title(['n=', num2str(iter), ')'])
        axis equal
        saveas(gcf, ['2-dim SOM result(iteration=', num2str(iter), ').png'])
        r = r + 1;
    end
    iter = iter + 1;
end