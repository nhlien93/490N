% actually creates files that have spaces between each number.
% parameters:
%   actualFile = results.mat
%   expectedFile = eval true y.mat
%   saveFile = file.txt we are trying to save to
% also prints out the final score again
function CreateCSVFiles(actualFile, expectedFile, saveFile)

actual = load(actualFile);
actual_classifiers = actual.index;
expected = load(expectedFile);
expected_classifiers = expected.true_y(1:10:end);


noNaNLength = size(expected_classifiers(~isnan(expected_classifiers)), 1);
length = size(expected_classifiers, 1);
final = zeros(noNaNLength, 2);

i = 1;
for j = 1:length
    if ~isnan(expected_classifiers(j))
        final(i, :) = [actual_classifiers(j) expected_classifiers(j)];
        i = i + 1;
    end
end

% match = size(final(final(:,1) == final(:,2)), 1);
% diff = zeros(noNaNLength-match, 2);
% 
% i = 1;
% for j = 1:noNaNLength
%     if final(j, 1) ~= final(j, 2)
%         diff(i, :) = [final(j, 1) final(j, 2)];
%         i = i + 1;
%     end
% end
changes = zeros(7, 1);
changes(1) = size(final(final(:,1) == -1 & final(:,2) == 0), 1);
changes(2) = size(final(final(:,1) == -1 & final(:,2) == 1), 1);
changes(3) = size(final(final(:,1) == 0 & final(:,2) == -1), 1);
changes(4) = size(final(final(:,1) == 0 & final(:,2) == 1), 1);
changes(5) = size(final(final(:,1) == 1 & final(:,2) == -1), 1);
changes(6) = size(final(final(:,1) == 1 & final(:,2) == 0), 1);
changes(7) = size(final(final(:,1) == final(:,2)), 1);
changes = changes / noNaNLength;
file = fopen(saveFile,'w');
fprintf(file, '%.5f\n', changes);
fclose(file);

percent = changes(7);
disp(percent);