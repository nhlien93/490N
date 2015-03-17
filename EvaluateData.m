function EvaluateData(e_lo, e_hi, e_cspW, e_ldaW, m_lo, m_hi, m_cspW, m_ldaW)
    data = load('BCICIV_eval_ds1a.mat');
    data.cnt = 0.1 * double(data.cnt);
    
    [a, b] = butterTwoBp(1/100, e_lo, e_hi);
    Y = zeros(size(cnt, 1), 59);
    for n = 1:59
        Y(:, n) = filter(a, b, cnt(:,n));
    end
    YHilb = abs(hilbert(Y)) .^ 2;
    
    e_eval = spatFilt(YHilb',e_cspW, 59)';
    
end
