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

%% ELM����/ѵ��
[IW,B,LW,TF,TYPE] = elmtrain(P_train,T_train,80 ,'sig',1);

%% ELM�������
T_sim_1 = elmpredict(P_train,IW,B,LW,TF,TYPE);
T_sim_2 = elmpredict(P_test,IW,B,LW,TF,TYPE);

%% ����Ա�
result_1 = [T_train' T_sim_1'];
result_2 = [T_test' T_sim_2'];
% ѵ������ȷ��
k1 = length(find(T_train == T_sim_1));
n1 = length(T_train);
Accuracy_1 = k1 / n1 * 100;
disp(['ѵ������ȷ��Accuracy = ' num2str(Accuracy_1) '%(' num2str(k1) '/' num2str(n1) ')'])
% ���Լ���ȷ��
k2 = length(find(T_test == T_sim_2));
n2 = length(T_test);
Accuracy_2 = k2 / n2 * 100;
disp(['���Լ���ȷ��Accuracy = ' num2str(Accuracy_2) '%(' num2str(k2) '/' num2str(n2) ')'])

%% ��ͼ
figure(1)
plot(1:300,T_train,'bo',1:300,T_sim_1,'r-*')
grid on
xlabel('ѵ�����������')
ylabel('ѵ�������������')
string = {'ѵ����Ԥ�����Ա�(ELM)';['(��ȷ��Accuracy = ' num2str(Accuracy_1) '%)' ]};
title(string)
legend('��ʵֵ','ELMԤ��ֵ')

figure(2)
plot(1:100,T_test,'bo',1:100,T_sim_2,'r-*')
grid on
xlabel('���Լ��������')
ylabel('���Լ��������')
string = {'���Լ�Ԥ�����Ա�(ELM)';['(��ȷ��Accuracy = ' num2str(Accuracy_2) '%)' ]};
title(string)
legend('��ʵֵ','ELMԤ��ֵ')










