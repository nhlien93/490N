function P = ClassSplit(traindata, classifier, testdata, testclass)
trow = size(traindata, 1);
[row, col] = size(classifier);
if (trow ~= row)
    disp('length of classifier must match number of rows in trainging data.');
    return;
elseif (col ~= 1)
    disp('there should only be 1 class in the classifer per row');
end
trainsplit = arrayfun(@(x) traindata(classifier == x, :), unique(classifier), 'uniformoutput', false);
PTranspose = CSP(trainsplit{1},trainsplit{2});
train = spatFilt(traindata,PTranspose,59);

W = LDA(train,classifier);

% Calulcate linear scores for training data
length = size(testdata, 1);
L = [ones(length,1) testdata] * W';

% Calculate class probabilities
P = exp(L) ./ repmat(sum(exp(L),2),[1 2]);