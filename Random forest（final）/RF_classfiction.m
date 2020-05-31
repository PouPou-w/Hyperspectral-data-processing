clear all
clc

%% ѵ����/���Լ�����
load('snv_uve.mat');

CARS=snv_uve(:,1:87);
LLL=snv_uve(:,88);

P_train = CARS(1:315,:);
T_train = LLL(1:315,:);
P_test = CARS(316:end,:);
T_test = LLL(316:end,:);
%% �������ɭ�ַ�����
% P=CARS(:,:);
% T=LLL(:,:);
model = classRF_train(P_train,T_train);
%% �������
[T_sim_1,votes1] = classRF_predict(P_train,model);
[T_sim_2,votes2] = classRF_predict(P_test,model);
%% ������ɭ��
ctree=ClassificationTree.fit(P_train,T_train);
%% ���ɭ����ͼ
 view(ctree);
view(ctree,'mode','graph');

%% ʮ�ֽ�����֤
leafs=logspace(1,2,10);%��ʾ10��1�η���10��2�η��ȷֳ�10��
N=numel(leafs);
err=zeros(N,1);
for n=1:N
t=ClassificationTree.fit(P_train,T_train,'crossval','on','minleaf',leafs(n));
err(n)=kfoldLoss(t);
end
figure(1)
plot(leafs,err);

%% ����Ա�
T_train=T_train';
T_sim_1=T_sim_1';
T_test=T_test';
T_sim_2=T_sim_2';
result_1 = [T_train' T_sim_1'];
result_2 = [T_test' T_sim_2'];

result_1_1=sortrows(result_1,1);
result_2_1=sortrows(result_2,1);

a1=result_1_1(:,1)';
a2=result_1_1(:,2)';
a3=result_2_1(:,1)';
a4=result_2_1(:,2)';

%% ѵ������ȷ��
k1 = length(find(T_train== T_sim_1));
n1 = length(T_train);
Accuracy_1 = k1 / n1 * 100;
disp(['ѵ������ȷ��Accuracy = ' num2str(Accuracy_1) '%(' num2str(k1) '/' num2str(n1) ')'])

%% ���Լ���ȷ��
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
figure(2)
plot(1:315,a1,'r-*',1:315,a2,'b-.o')
axis([0,316,0.5,7.5]);
grid on
xlabel('Prediction set')
ylabel('Calibration set')
string = {'ѵ����Ԥ�����Ա�(ELM)';['(��ȷ��Accuracy = ' num2str(Accuracy_1) '%)' ]};
title(string)
legend('Reference category','Prediction category')

figure(3)
plot(1:105,a3,'r-*',1:105,a4,'b-.o')
axis([0,106,0.5,7.5]);
grid on
xlabel('Prediction set')
ylabel('Calibration set')
string = {'���Լ�Ԥ�����Ա�(ELM)';['(��ȷ��Accuracy = ' num2str(Accuracy_2) '%)' ]};
title(string)
legend('Reference category','Prediction category')
