% function S = CrossValidation( parsedData, classes )
% % Neuroeng BCI Cross Validation
% kSize = 200;
% % not  200? [size(parsedData, 1) / 10;]
% runningScore = 0;
% for i = 0:9
%     kData = parsedData(((i*kSize)+1:((i+1)*kSize)),:);
%     kClasses = classes(((i*kSize)+1:((i+1)*kSize)),:);
%     trainData = kData(1:18,:);
%     trainClass = kClasses(1:18,:);
%     testData = kData(19:end,:);
%     testClass = kClasses(19:end,:);
%     runningScore = runningScore + ClassSplit(trainData, trainClass, testData, testClass);
% end
% S = runningScore / 10;
% end

function S = CrossValidation(parsedData, classes)
kSize = size(parsedData, 1) / 2;
runningScore = 0;
for i = 0:1
    leftIndex = (i * kSize) + 1;
    rightIndex = (i + 1) * kSize; 
    testData = parsedData(leftIndex: rightIndex, :);
    testClasses = classes(leftIndex: rightIndex, :);
    trainData = [parsedData(1: leftIndex - 1, :) ; parsedData(rightIndex + 1: end, :)]; 
    trainClasses = [classes(1: leftIndex - 1, :) ; classes(rightIndex + 1: end, :)]; 
    disp(size(trainData));
    disp(size(testData));
    [Percent, PTranspose, W] = ClassSplit(trainData, trainClasses, testData, testClasses);
    runningScore = runningScore + Percent;
end
S = runningScore / 2;
end