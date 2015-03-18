function [index, final_score] = EvaluateData(e_lo, e_hi, e_cspW, e_ldaW, m_lo, m_hi, m_cspW, m_ldaW)
    data = load('BCICIV_eval_ds1g.mat');

    cnt = 0.1 * double(data.cnt);
    disp('Evaluating for movement/non-movement');
    index = EvaluationAlg(cnt, e_cspW, e_ldaW, e_lo, e_hi);
    
    % filter out non-movement data
    zeroLength = size(index(index == 0), 1);
    m_cnt = zeros(size(cnt, 1) - zeroLength, 59);
    i = 1;
    for j = 1:size(cnt, 1)
        if index(j) == 1
            index(j) = 2; %need way marking index, chose 2 cause whatever
            m_cnt(i, :) = cnt(j, :);
            i = i + 1;
        end
    end
    
    disp('Evaulating for types of movement');
    %should be index of 0 and 1's based on left/right movement
    m_index = EvaluationAlg(m_cnt, m_cspW, m_ldaW, m_lo, m_hi);
    
    %add indeces back into original index, converting 0/1 to -1 1
    i = 1;
    for j = 1:size(cnt, 1)
        if index(j) == 2
            if m_index(i) == 0
                index(j) = -1;
            else
                index(j) = 1;
            end
            i = i + 1;
        end
    end
    
    disp('Checking results against actual labels');
    true_data = load('BCICIV_eval_ds1g_1000Hz_true_y.mat');
    true_y = true_data.true_y;
    true_y_trunc = true_y(1:10:end);
    match = 0;
    nans = 0;
    length = size(true_y_trunc, 1);
    
    for i = 1:length
        if isnan(true_y_trunc(i))
            nans = nans + 1;
        elseif index(i) == true_y_trunc(i)
            match = match + 1;
        end
    end
    
    final_score = match / (length - nans);
    disp(strcat('final score for algorithm is ', num2str(final_score)));
    
end
