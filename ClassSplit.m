function [Percent, PTranspose, W] = ClassSplit(traindata, trainclass, testdata, testclass)

trow = size(traindata, 1);
[trainrow, traincol] = size(trainclass);
if (trow ~= trainrow)
    disp('length of classifier must match number of rows in trainging data.');
    return;
elseif (traincol ~= 1)
    disp('there should only be 1 class in the classifer per row');
end
trainsplit = arrayfun(@(x) traindata(trainclass == x,:), unique(trainclass), 'uniformoutput', false);
disp('Starting CSP');
PTranspose = CSP(trainsplit{1}',trainsplit{2}');
train = spatFilt(traindata',PTranspose,59)';
disp('Starting LDA');
W = LDA(train,trainclass);

% Calulcate linear scores for training data
length = size(testdata, 1);
L = [ones(length,1) testdata] * W';

% Calculate class probabilities
P = (exp(L) ./ repmat(sum(exp(L),2),[1 2]))';

[~, index] = max(P);
index = (index - 1)';

match = 0;
for i = 1:length
    if index(i) == testclass(i)
        match = match + 1;
    end
end

Percent = match / length;
