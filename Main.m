%  Neuroeng BCI algorthim implementation
% loading data from files, change URL accordingly
% Assume data exists locally
data = load('BCICIV_calib_ds1a.mat');
%use if attempting to get data from lindsey's attu
%data = load('\\cseexec.cs.washington.edu\cs\nt\homes\istudents\nhlien93\490n\BCICIV_calib_ds1a.mat');

data.cnt = 0.1 * double(data.cnt);
[cnt, classifier] = ParseDataAndClassifier(data);

%prepare data for discerning ERS/ERD
e_class = abs(classifier);
%[e_lo, e_hi, e_cspW, e_ldaW] = GetWeightsAndFrequencies(cnt, e_class);

%perpare data for discerning different movements\
split = arrayfun(@(x) cnt(classifier == x, :), unique(classifier), 'uniformoutput', false);
m_cnt = [split{1};split{3}]; 
m_class = sort(classifier(classifier ~= 0));
disp(m_class);
%[m_lo, m_hi, m_cspW, m_ldaW] = GetWeightsAndFrequencies(cnt, classifier);

%evaluateData(e_lo, e_hi, e_cspW, e_ldaW, m_lo, m_hi, m_cspW, m_ldaW);



