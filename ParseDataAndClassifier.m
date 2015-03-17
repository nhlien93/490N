function [parseddata, classifier] = ParseDataAndClassifier(data)
length = size(data.mrk.pos, 2);
parseddata = zeros(length * 800, 59);
classifier = zeros(length * 800, 1);
for i = 1:length
    start = (i - 1) * 800 + 1;
    mrkstart = data.mrk.pos(i);
    parseddata(start:start+799, :) = 0.1*double(data.cnt(mrkstart:mrkstart + 799, :));
    classifier(start:start+799) = [repmat(data.mrk.y(i), 1, 400), zeros(1, 400)]';
end