%  Neuroeng BCI algorthim implementation
% loading data from files, change URL accordingly
% 
data = load('BCICIV_calib_ds1a.mat');
data = load('\\cseexec.cs.washington.edu\cs\nt\homes\istudents\nhlien93\490n\BCICIV_calib_ds1a.mat');
cnt = 0.1 * double(data.cnt);

% loop through all important frequency bands
% starting from 1 HZ, ending at 23 HZ
lo = 1;
hi = 3;
maxlo = 1;
maxhi = 3;
maxscore = 0;
while hi <= 23
    [a, b] = butterTwoBp(1/100, lo, hi);
    Y = zeros(190594, 59);
    for n = 1:59
        Y(:, n) = filter(a, b, cnt(:,n));
    end
    
    
    hi = hi + 2;
    lo = lo + 2;
end
% Y is a filtered matrix
