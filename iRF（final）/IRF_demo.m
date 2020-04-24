clear all
clc

%% ѵ����/���Լ�����
load('RAW.mat');
RAW1=RAW(:,:);
RAW=RAW1(:,1:254);
LLL=RAW1(:,255);
[oo, pp]=size(RAW);
temp = randperm(oo);%ѵ������Ԥ�⼯����3:1����
P_train = RAW(temp(1:300),:)';
T_train = LLL(temp(1:300),:)';
P_test = RAW(temp(301:end),:)';
T_test = LLL(temp(301:end),:)';
X=RAW(:,:);
y=LLL(:,:);

%% �����������㷨
F=irf(X,y,1000,5);
A=find(F.probability>0.7);%������ֵ��������ֵ�ľ�����Ҫ����������
figure(1)
bar(F.probability,'b','edgecolor','w');
hold on
plot([0,254],[0.7,0.7],'r-');
xlabel('variable index');
ylabel('selection probability');
xlim([0 255]);
figure(2)
bar(F.RMSECV,'c','edgecolor','w');