% the data has to be 3D
% p is the percentage of training data to the whole dataset
function [xtrain,xtest] = train_test_split(x,p)
    [~,~,m3] = size(x);
    rng('default');
    index = randperm(m3);
    xtrain = x(:,:,index(1:round(p*m3)));
    xtest = x(:,:,index(round(p*m3)+1:end));
end