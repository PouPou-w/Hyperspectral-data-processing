clear all
clc

%% ѵ����/���Լ�����
load('RAW.mat');
RAW1=RAW(:,:);
RAW=RAW1(:,1:254);
LLL=RAW1(:,255);
[oo, pp]=size(RAW);
temp = randperm(oo);%ѵ������Ԥ�⼯����3:1����
P_train = RAW(temp(1:300),:);
T_train = LLL(temp(1:300),:);
P_test = RAW(temp(301:end),:);
T_test = LLL(temp(301:end),:);
X=RAW(:,:);
y=LLL(:,:);

%% ����Ϣ����������ʵ��
[mean_b,std_b,t_values,var_retain,RMSECVnew,Yhat,E]=plsuve(X,y,10,400,254);%10�������������400����һ���Ĵ�����һ��ȡ��������254�Ǽ������������Ĳ�����������ȡ��ֵҲ���������������������Ĳ�����������