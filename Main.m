%  Neuroeng BCI algorthim implementation
% loading data from files, change URL accordingly
% Assume data exists locally

% starttime = tic;

data = load('BCICIV_calib_ds1g.mat');
[cnt, classifier] = ParseDataAndClassifier(data);

%prepare data for discerning ERS/ERD
e_class = abs(classifier);
[e_lo, e_hi, e_cspW, e_ldaW] = GetWeightsAndFrequencies(cnt, e_class);

%perpare data for discerning different movements\
split = arrayfun(@(x) cnt(classifier == x, :), unique(classifier), 'uniformoutput', false);
zeroLength = size(split{2}, 1);
m_cnt = zeros(size(cnt, 1) - zeroLength, 59);
m_class = zeros(size(cnt, 1) - zeroLength, 1);
i = 1;
for j = 1:size(cnt, 1)
    if classifier(j) == -1
        m_class(i) = 0;
        m_cnt(i, :) = cnt(j, :);
        i = i + 1;
    elseif classifier(j) == 1
        m_cnt(i, :) = cnt(j, :);
        m_class(i) = 1;
        i = i + 1;
    end
end
disp(size(m_cnt, 1));
disp(size(m_class, 1));
[m_lo, m_hi, m_cspW, m_ldaW] = GetWeightsAndFrequencies(m_cnt, m_class);
% disp('Frequency band for movement/non-movement is');
% disp(e_lo);
% disp(e_hi);
% disp('Frequency band for different movements is');
% disp(m_lo);
% disp(m_hi);

[index, final_score] = EvaluateData(e_lo, e_hi, e_cspW, e_ldaW, m_lo, m_hi, m_cspW, m_ldaW);
% endtime = tic;
% totaltime = endtime - starttime;
% disp('Time algorithm took:');
% disp(totaltime);

results.index = index;
results.final_score = final_score;
results.e = [e_lo, e_hi];
results.m = [m_lo, m_hi];
% results.total_time = totaltime;
save('results_b.mat','-struct','results'); 

