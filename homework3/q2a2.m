% with regularization:

lambda = 0.1;
lambda_list = [0.001, 0.01, 0.1, 1, 10];

for lambda = 0.5
    w_2 = inv(PHI'*PHI+lambda*eye(numTr))*PHI'*TrLabel';
    output_2 = (PHI_test * w_2)';
    output_train_2 = (PHI * w_2)';
    figure;
    q2evaluate(output_train_2, output_2, TrLabel, TeLabel);
    title(['Regularization(lambda = ', num2str(lambda), ')'])
    saveas(gcf, ['Regularization(lambda = ', num2str(lambda), ').jpg'])
end

