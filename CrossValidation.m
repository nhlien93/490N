function S = CrossValidation( parsedData, classes )
% Neuroeng BCI Cross Validation
kSize = 200;
% not  200? [size(parsedData, 1) / 10;]
runningScore = 0;
for i = 0:9
    kData = parsedData(((i*kSize)+1:((i+1)*kSize)),:);
    kClasses = classes(((i*kSize)+1:((i+1)*kSize)),:);
    trainData = kData(1:18,:);
    trainClass = kClasses(1:18,:);
    testData = kData(19:end,:);
    testClass = kClasses(19:end,:);
    runningScore = runningScore + ClassSplit(trainData, trainClass, testData, testClass);
end
S = runningScore / 10;
end
