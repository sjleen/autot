% modified from "Ahmed BenSaïda (2023). Shapiro-Wilk and Shapiro-Francia normality tests."

function Results=swtest_lsj(x)
alpha=0.05;
n=length(x);
y=sort(x);

% SHAPIRO-WILK TEST

a=[];
i=1:n;
mi=norminv((i-0.375)/(n+0.25));
u=1/sqrt(n);
m=mi.^2;

a(n)=-2.706056*(u^5)+4.434685*(u^4)-2.07119*(u^3)-0.147981*(u^2)+0.221157*u+mi(n)/sqrt(sum(m));
a(n-1)=-3.58263*(u^5)+5.682633*(u^4)-1.752461*(u^3)-0.293762*(u^2)+0.042981*u+mi(n-1)/sqrt(sum(m));
a(1)=-a(n);
a(2)=-a(n-1);
eps=(sum(m)-2*(mi(n)^2)-2*(mi(n-1)^2))/(1-2*(a(n)^2)-2*(a(n-1)^2));
a(3:n-2)=mi(3:n-2)./sqrt(eps);
ax=a.*y;
KT=sum((x-mean(x)).^2);
b=sum(ax)^2;
SWtest=b/KT;
mu=0.0038915*(log(n)^3)-0.083751*(log(n)^2)-0.31082*log(n)-1.5861;
sigma=exp(0.0030302*(log(n)^2)-0.082676*log(n)-0.4803);
z=(log(1-SWtest)-mu)/sigma;
pvalue=1-normcdf(z,0,1);
Results(1)=SWtest;
Results(2)=pvalue;

% Compare p-value to alpha
if Results(2)>alpha
    Results(3)=1;
else
    Results(3)=0;
end

% Output display

disp(' ')
disp('Test Name                  Test Statistic   p-value   Normality (1:Normal,0:Not Normal)')
disp('-----------------------    --------------  ---------  --------------------------------')
fprintf('Shapiro-Wilk Test              %6.4f \t     %6.4f                 %1.0f \r',SWtest,Results(2),Results(3));
