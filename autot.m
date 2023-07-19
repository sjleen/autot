% Results = [ normality_of_a  normality_of_b  hypothesis  p-value  test_type]
% test_type
%   1: Unpaired T-test (Two-sample t-test)
%   2: Two-sample t-test with Welch's correction
%   3: Mann-Whitney U-test (Wilcoxon rank sum test)

function Results = autot(a,b)

if size(a,1)>1
    a = a';
end
if size(b,1)>1
    b = b';
end
disp('Data 1')
if size(a,2) < 7 
    aTest(3) = 0;
else
    aTest = swtest_lsj(a);
end
disp('Data 2')
if size(b,2) < 7 
    bTest(3) = 0;
else
    bTest = swtest_lsj(b);
end
disp(' ')

Results(1) = aTest(3);
Results(2) = bTest(3);

if aTest(3) + bTest(3) == 2
    if vartest2(a,b) == 0
        [hypothesis,p] = ttest2(a,b)
        disp('Unpaired T-test (Two-sample t-test)')
        Results(5) = 1;
    else
        [hypothesis,p] = ttest2(a,b,'Vartype', 'unequal')
        disp('Two-sample t-test with Welch''''s correction')
        Results(5) = 2;
    end
else
    [p,hypothesis] = ranksum(a,b,'method','exact')
    disp('Mann-Whitney U-test (Wilcoxon rank sum test)')
    Results(5) = 3;
end

Results(4) = p;
if p<0.01
    hypothesis = hypothesis+1;
end
if p<0.001
    hypothesis = hypothesis+1;
end

Results(3) = hypothesis;
