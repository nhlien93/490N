function [maxlo, maxhi, cspW, ldaW] = GetWeightsAndFrequencies(cnt, classifier)
% loop through all important frequency bands
% starting from 1 HZ, ending at 23 HZ
    lo = 7;
    hi = 10;
    maxlo = 7;
    maxhi = 10;
    maxscore = 0;
    maxY = zeros(size(cnt, 1), 59);
    while hi <= 19
        [a, b] = butterTwoBp(1/100, lo, hi);
        Y = zeros(size(cnt, 1), 59);
        for n = 1:59
            Y(:, n) = filter(a, b, cnt(:,n));
        end

        YHilb = abs(hilbert(Y)) .^ 2;
        disp('Frequencies are');
        disp(lo);
        disp(hi);
        score = CrossValidation(YHilb, classifier);
        if score > maxscore
            maxscore = score;
            maxlo = lo;
            maxhi = hi;
            maxY = YHilb;
        end
        hi = hi + 3;
        lo = lo + 3;
    end
    %pass in dummy testdata parameter cause we don't care
    [~, cspW, ldaW] = ClassSplit(maxY, classifier, zeros(100, 59), zeros(100, 1));
end