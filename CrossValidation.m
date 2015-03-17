function S = CrossValidation(parsedData, classes)
kSize = size(parsedData, 1) / 5;
runningScore = 0;
for i = 0:4 %TODO: change back
    leftIndex = (i * kSize) + 1;
    rightIndex = (i + 1) * kSize; 
    testData = parsedData(leftIndex: rightIndex, :);
    testClasses = classes(leftIndex: rightIndex, :);
    trainData = [parsedData(1: leftIndex - 1, :) ; parsedData(rightIndex + 1: end, :)]; 
    trainClasses = [classes(1: leftIndex - 1, :) ; classes(rightIndex + 1: end, :)]; 
    %disp(size(trainData));
    %disp(size(testData));
    [Percent, ~, ~] = ClassSplit(trainData, trainClasses, testData, testClasses);
    
    runningScore = runningScore + Percent;
end
S = runningScore / 5;
end