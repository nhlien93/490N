function [maxlo, maxhi, cspW, ldaW] = GetWeightsAndFrequencies(cnt, classifier)
    lo = 1;
    hi = 3;
    maxlo = 1;
    maxhi = 3;
    maxscore = 0;
    maxY = zeros(190594, 59);
    while hi <= 23
        [a, b] = butterTwoBp(1/100, lo, hi);
        Y = zeros(190594, 59);
        for n = 1:59
            Y(:, n) = filter(a, b, cnt(:,n));
        end

        YHilb = abs(hilber(Y)) .^ 2;

        score = CrossValidation(YHilb, classifier);
        if score > maxscore
            maxscore = score;
            maxlo = lo;
            maxhi = hi;
            maxY = YHilb;
        end
        hi = hi + 2;
        lo = lo + 2;
    end
    %pass in dummy testdata parameter cause we don't care
    [~, cspW, ldaW] = ClassSplit(maxY, classifier, zeros(100, 59));
end