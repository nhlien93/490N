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
kSize = size(parsedData, 1) / 3;
runningScore = 0;
for i = 0:2
    leftIndex = (i * kSize) + 1;
    rightIndex = (i + 1) * kSize; 
    testData = parsedData(leftIndex: rightIndex, :);
    testClasses = classes(leftIndex: rightIndex, :);
    trainData = [parsedData(1: leftIndex - 1, :) ; parsedData(leftIndex + 1: end, :)]; 
    trainClasses = [classes(1: leftIndex - 1, :) ; classes(leftIndex + 1: end, :)]; 
    disp(trainClasses);
    runningScore = runningScore + ClassSplit(trainData, trainClasses, testData, testClasses);
end
S = runningScore / 3;
end