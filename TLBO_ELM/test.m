clear all
clc

%% ѵ����/���Լ�����
load('CARS.mat');
CARS1=CARS(:,:);
CARS=CARS1(:,1:29);
LLL=CARS1(:,30);

P_train = CARS(:,:)';
T_train = LLL(:,:)';
P_test = CARS(316:end,:)';
T_test = LLL(316:end,:)';
P_test1 = CARS(1:315,:)';
T_test1 = LLL(1:315,:)';

%% ELM����/ѵ��
[IW,B,LW,TF,TYPE] = elmtrain(P_train,T_train,160,'sig',1);

%% ELM�������
T_sim_1 = elmpredict(P_train,IW,B,LW,TF,TYPE);
T_sim_2 = elmpredict(P_test,IW,B,LW,TF,TYPE);
T_sim_3 = elmpredict(P_test1,IW,B,LW,TF,TYPE);
%% ����Ա�
result_1 = [T_train' T_sim_1'];
result_2 = [T_test' T_sim_2'];
result_3 = [T_test1' T_sim_3'];
result_1_1=sortrows(result_1,1);
result_2_1=sortrows(result_2,1);
result_3_1=sortrows(result_3,1);
a1=result_1_1(:,1)';
a2=result_1_1(:,2)';
a3=result_2_1(:,1)';
a4=result_2_1(:,2)';
a5=result_3_1(:,1)';
a6=result_3_1(:,2)';
% ѵ������ȷ��
k1 = length(find(T_train == T_sim_1));
n1 = length(T_train);
Accuracy_1 = k1 / n1 * 100;
disp(['ѵ������ȷ��Accuracy = ' num2str(Accuracy_1) '%(' num2str(k1) '/' num2str(n1) ')'])

k3 = length(find(T_test1 == T_sim_3));
n3 = length(T_test1);
Accuracy_3 = k3 / n3 * 100;
disp(['ѵ������ȷ��Accuracy = ' num2str(Accuracy_3) '%(' num2str(k3) '/' num2str(n3) ')'])



% ���Լ���ȷ��
k2 = length(find(T_test == T_sim_2));
n2 = length(T_test);
Accuracy_2 = k2 / n2 * 100;
disp(['���Լ���ȷ��Accuracy = ' num2str(Accuracy_2) '%(' num2str(k2) '/' num2str(n2) ')'])

%% ��ͼһ
% figure(1)
% plot(1:315,T_train,'bo',1:315,T_sim_1,'r-*')
% axis([1,315,0.5,7.5]);
% grid on
% xlabel('ѵ�����������')
% ylabel('ѵ�������������')
% string = {'ѵ����Ԥ�����Ա�(ELM)';['(��ȷ��Accuracy = ' num2str(Accuracy_1) '%)' ]};
% title(string)
% legend('��ʵֵ','ELMԤ��ֵ')
% 
% figure(2)
% plot(1:105,T_test,'bo',1:105,T_sim_2,'r-*')
% axis([1,105,0.5,7.5]);
% grid on
% xlabel('���Լ��������')
% ylabel('���Լ��������')
% string = {'���Լ�Ԥ�����Ա�(ELM)';['(��ȷ��Accuracy = ' num2str(Accuracy_2) '%)' ]};
% title(string)
% legend('��ʵֵ','ELMԤ��ֵ')

%% ��ͼ��
figure(1)
plot(1:315,a5,'r-*',1:315,a6,'b-.o')
axis([0,316,0.5,7.5]);
grid on
xlabel('Prediction set')
ylabel('Calibration set')
string = {'ѵ����Ԥ�����Ա�(ELM)';['(��ȷ��Accuracy = ' num2str(Accuracy_3) '%)' ]};
title(string)
legend('Reference category','Prediction category')

figure(2)
plot(1:105,a3,'r-*',1:105,a4,'b-.o')
axis([0,106,0.5,7.5]);
grid on
xlabel('Prediction set')
ylabel('Calibration set')
string = {'���Լ�Ԥ�����Ա�(ELM)';['(��ȷ��Accuracy = ' num2str(Accuracy_2) '%)' ]};
title(string)
legend('Reference category','Prediction category')




















