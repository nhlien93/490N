%  Neuroeng BCI algorthim implementation

data = load('\\cseexec.cs.washington.edu\cs\nt\homes\istudents\nhlien93\490n\BCICIV_calib_ds1a.mat');
cnt = 0.1 * double(data.cnt);
[a, b] = butterTwoBp(1/100, 10, 15);
Y = zeros(190594, 59);
for n = 1:59
    Y(:, n) = filter(a, b, cnt(:,n));
end