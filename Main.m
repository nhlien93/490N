%  Neuroeng BCI algorthim implementation
% loading data from files, change URL accordingly
% Assume data exists locally
data = load('BCICIV_calib_ds1a.mat');

data.cnt = 0.1 * double(data.cnt);
[cnt, classifier] = ParseDataAndClassifier(data);

%prepare data for discerning ERS/ERD
e_class = abs(classifier);
% [e_lo, e_hi, e_cspW, e_ldaW] = GetWeightsAndFrequencies(cnt, e_class);

%perpare data for discerning different movements\
split = arrayfun(@(x) cnt(classifier == x, :), unique(classifier), 'uniformoutput', false);
zeroLength = size(split{2}, 1);
m_cnt = zeros(size(cnt, 1) - zeroLength, 59);
m_class = zeros(size(cnt, 1) - zeroLength, 1);
i = 1;
for j = 1:size(cnt, 1)
    if classifier(j) == -1
        m_class(j) = 0;
        m_cnt(i, :) = cnt(j, :);
        i = i + 1;
    elseif classifier(j) == 1
        m_cnt(i, :) = cnt(j, :);
        m_class(j) = 1;
        i = i + 1;
    end
end


m_class = sort(classifier(classifier ~= 0));
disp(m_class);
[m_lo, m_hi, m_cspW, m_ldaW] = GetWeightsAndFrequencies(cnt, classifier);

%evaluateData(e_lo, e_hi, e_cspW, e_ldaW, m_lo, m_hi, m_cspW, m_ldaW);



