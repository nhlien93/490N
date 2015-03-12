%  Neuroeng BCI algorthim implementation
% loading data from files, change URL accordingly
% Assume data exists locally
data = load('BCICIV_calib_ds1a.mat');
data = ParseDataAndClassifier(data);
%use if attempting to get data from lindsey's attu
%data = load('\\cseexec.cs.washington.edu\cs\nt\homes\istudents\nhlien93\490n\BCICIV_calib_ds1a.mat');

data.cnt = 0.1 * double(data.cnt);
[cnt, classifier] = ParseDataAndClassifier(data);
% loop through all important frequency bands
% starting from 1 HZ, ending at 23 HZ

%prepare data for discerning ERS/ERD
[] = GetWeightsAndFrequencies(cnt, classifier)

%perpare data for discerning different movements
[] = GetWeightsAndFrequencies(cnt, classifier)

