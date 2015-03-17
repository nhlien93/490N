function index = EvaluationAlg(cnt, cspW, ldaW, lo, hi)
%EVALUATIONALG Summary of this function goes here
%   Detailed explanation goes here
    [a, b] = butterTwoBp(1/100, lo, hi);
    Y = zeros(size(cnt, 1), 59);
    for n = 1:59
        Y(:, n) = filter(a, b, cnt(:,n));
    end
    YHilb = abs(hilbert(Y)) .^ 2;
    
    eval = spatFilt(YHilb',cspW, 59)';
    % Calulcate linear scores for training data
    length = size(eval, 1);
    L = [ones(length,1) eval] * ldaW';

    % Calculate class probabilities
    P = (exp(L) ./ repmat(sum(exp(L),2),[1 2]))';

    [~, index] = max(P);
    index = (index - 1)';
end

