function S = CrossValidation( filteredData )
% Neuroeng BCI Cross Validation
kSize = size(filteredData, 1) / 10;
runningScore = 0;
testData = filteredData(((9*kSize):end),:(1:58));
for i = 1:9
    kData = filteredData(((i*kSize):(i+1*kSize)),:);
    trainData = kData(:,1:58);
    classifier = kData(:,59);
    runningScore = runningScore + ClassSplit(trainData, classifier, testData);
end
S = runningScore / 9;
end
