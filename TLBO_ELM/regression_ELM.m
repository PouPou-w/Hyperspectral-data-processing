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
[IW,B,LW,TF,TYPE] = elmtrain(P_train,T_train,80,'sig',0);%ѵ������������1/3����ʱЧ�����

%% ELM�������
T_sim_1 = elmpredict(P_train,IW,B,LW,TF,TYPE);
T_sim_2 = elmpredict(P_test,IW,B,LW,TF,TYPE);


%% ����Ա�
result_1 = [T_train' T_sim_1'];
result_2 = [T_test' T_sim_2'];


% ѵ�����������
E =mse(T_sim_1-T_train);
% ѵ��������ϵ��
N = length(T_train);
R2=(N*sum(T_sim_1.*T_train)-sum(T_sim_1)*sum(T_train))^2/((N*sum((T_sim_1).^2)-(sum(T_sim_1))^2)*(N*sum((T_train).^2)-(sum(T_train))^2)); 


% Ԥ�⼯�������
E1 =mse(T_sim_2-T_test);
% Ԥ�⼯����ϵ��
N1=length(T_test);
R21=(N*sum(T_sim_2.*T_test)-sum(T_sim_2)*sum(T_test))^2/((N*sum((T_sim_2).^2)-(sum(T_sim_2))^2)*(N*sum((T_test).^2)-(sum(T_test))^2)); 


%% ��ͼ
figure(1)
plot(1:N,T_train,'r-*',1:N,T_sim_1,'b:o');
axis([1,300,0.5,4.50]);
grid on
legend('��ʵֵ','Ԥ��ֵ')
xlabel('�������')
ylabel('��������')
string = {'ѵ������������Ԥ�����Ա�(ELM)';['(mse = ' num2str(E) ' R^2 = ' num2str(R2) ')']};
title(string)

figure(2)
plot(1:N1,T_test,'r-*',1:N1,T_sim_2,'b:o');
axis([1,100,0.5,4.50]);
grid on
legend('��ʵֵ','Ԥ��ֵ')
xlabel('�������')
ylabel('��������')
string = {'���Լ���������Ԥ�����Ա�(ELM)';['(mse= ' num2str(E1) ' R^2 = ' num2str(R21) ')']};
title(string)