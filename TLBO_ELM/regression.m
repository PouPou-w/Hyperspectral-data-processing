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
[IW,B,LW,TF,TYPE] = elmtrain(P_train,T_train,150,'sig',1);

%% ELM�������
T_sim_1 = elmpredict(P_train,IW,B,LW,TF,TYPE);
T_sim_2 = elmpredict(P_test,IW,B,LW,TF,TYPE);


%% ����Ա�
result_1 = [T_train' T_sim_1'];
result_2 = [T_test' T_sim_2'];
% �������
E = mse(T_sim_1 - T_train);
% ����ϵ��
N = length(T_train);
R2=(N*sum(T_sim_1.*T_train)-sum(T_sim_1)*sum(T_train))^2/((N*sum((T_sim_1).^2)-(sum(T_sim_1))^2)*(N*sum((T_train).^2)-(sum(T_train))^2)); 


%% ��ͼ
figure(1)
plot(1:N-,T_test,'r-*',1:N,T_sim,'b:o')
grid on
legend('��ʵֵ','Ԥ��ֵ')
xlabel('�������')
ylabel('��������')
string = {'���Լ���������Ԥ�����Ա�(KELM)';['(mse = ' num2str(E) ' R^2 = ' num2str(R2) ')']};
title(string)