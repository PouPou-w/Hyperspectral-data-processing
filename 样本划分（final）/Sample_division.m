clear all
clc

%% ѵ����/���Լ�����
RAW=xlsread('xia.xlsx');
X=RAW(2:end,1:254);
Y=RAW(2:end,255);
Z=RAW(2:end,:);
[m,dminmax] =spxy(X,Y,315);
%[m,dminmax] = KS(X,300);
a=randperm(420);
b=setdiff(a,m);%��������������
RAW1=Z(m,:);
RAW2=Z(b,:);
xia=[RAW1;RAW2];