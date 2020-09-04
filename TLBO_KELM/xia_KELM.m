 clear all
clc

%% ѵ����/���Լ�����
load('SNV.mat');
load('SNV1.mat');
a1=SNV1(1:60,:);
a2=SNV1(61:120,:);
a3=SNV1(121:180,:);
a4=SNV1(181:240,:);  
a5=SNV1(241:300,:);
a6=SNV1(301:360,:);
a7=SNV1(361:end,:);

data=SNV(:,1:254);
label=SNV(:,255);

P_train = data(1:315,:);
T_train = label(1:315,:);

a1_P_test = a1(:,1:254);
a1_T_test = a1(:,end);

a2_P_test = a2(:,1:254);
a2_T_test = a2(:,end);

a3_P_test = a3(:,1:254);
a3_T_test = a3(:,end);

a4_P_test = a4(:,1:254);
a4_T_test = a4(:,end);

a5_P_test = a5(:,1:254);
a5_T_test = a5(:,end);

a6_P_test = a6(:,1:254);
a6_T_test = a6(:,end);

a7_P_test = a7(:,1:254);
a7_T_test = a7(:,end);

%% ѵ����ѵ��
[TrainingTime, TrainingAccuracy, ELM_Kernel_Model]=elm_kernel_train(P_train,T_train,7,1,100, 'RBF_kernel',1);%AddLabel�Ƿ�������

%% Ԥ����
[~, T_sim_1] = elm_kernel_predict(a1_P_test, P_train, ELM_Kernel_Model);
[~, T_sim_2] = elm_kernel_predict(a2_P_test, P_train, ELM_Kernel_Model);
[~, T_sim_3] = elm_kernel_predict(a3_P_test, P_train, ELM_Kernel_Model);
[~, T_sim_4] = elm_kernel_predict(a4_P_test, P_train, ELM_Kernel_Model);
[~, T_sim_5] = elm_kernel_predict(a5_P_test, P_train, ELM_Kernel_Model);
[~, T_sim_6] = elm_kernel_predict(a6_P_test, P_train, ELM_Kernel_Model);
[TestingTime, T_sim_7] = elm_kernel_predict(a7_P_test, P_train, ELM_Kernel_Model);

%% ����Ա�
a1_T_test=a1_T_test';


a2_T_test=a2_T_test';


a3_T_test=a3_T_test';


a4_T_test=a4_T_test';

a5_T_test=a5_T_test';

a6_T_test=a6_T_test';


a7_T_test=a7_T_test';


%% ��ȷ��
k1 = length(find(a1_T_test== T_sim_1));
n1 = length(a1_T_test);
Accuracy_1 = k1 / n1 * 100;
disp(['����label��1����ȷ��Accuracy = ' num2str(Accuracy_1) '%(' num2str(k1) '/' num2str(n1) ')'])

k2 = length(find(a2_T_test== T_sim_2));
n2 = length(a2_T_test);
Accuracy_2 = k2 / n2 * 100;
disp(['����label��2����ȷ��Accuracy = ' num2str(Accuracy_2) '%(' num2str(k2) '/' num2str(n2) ')'])

k3 = length(find(a3_T_test== T_sim_3));
n3 = length(a3_T_test);
Accuracy_3 = k3 / n3 * 100;
disp(['����label��3����ȷ��Accuracy = ' num2str(Accuracy_3) '%(' num2str(k3) '/' num2str(n3) ')'])

k4 = length(find(a4_T_test== T_sim_4));
n4 = length(a4_T_test);
Accuracy_4 = k4 / n4 * 100;
disp(['����label��4����ȷ��Accuracy = ' num2str(Accuracy_4) '%(' num2str(k4) '/' num2str(n4) ')'])

k5 = length(find(a5_T_test== T_sim_5));
n5 = length(a5_T_test);
Accuracy_5 = k5 / n5 * 100;
disp(['����label��5����ȷ��Accuracy = ' num2str(Accuracy_5) '%(' num2str(k5) '/' num2str(n5) ')'])

k6 = length(find(a6_T_test== T_sim_6));
n6 = length(a6_T_test);
Accuracy_6 = k6 / n6 * 100;
disp(['����label��6����ȷ��Accuracy = ' num2str(Accuracy_6) '%(' num2str(k6) '/' num2str(n6) ')'])

k7 = length(find(a7_T_test== T_sim_7));
n7 = length(a7_T_test);
Accuracy_7 = k7 / n7 * 100;
disp(['����label��7����ȷ��Accuracy = ' num2str(Accuracy_7) '%(' num2str(k7) '/' num2str(n7) ')'])

k8=k1+k2+k3+k4+k5+k6+k7;
n8=n1+n2+n3+n4+n5+n6+n7;
Accuracy_8 = k8/ n8 * 100;
disp(['��������ȷ��Accuracy = ' num2str(Accuracy_8) '%(' num2str(k8) '/' num2str(n8) ')'])

%% ��ͼ
a_T_test=[a1_T_test a2_T_test a3_T_test a4_T_test a5_T_test a6_T_test a7_T_test]';
T_sim=[T_sim_1 T_sim_2 T_sim_3 T_sim_4 T_sim_5 T_sim_6 T_sim_7]';

figure(2)
plot(1:420,a_T_test,'r-*',1:420,T_sim,'b-.o')
axis([0,421,0.5,7.5]);
grid on
xlabel('Sample set')
ylabel('Category labels')
string = {'��ʵֵԤ��ֵ����Ա�(KELM)';['(��ȷ��Accuracy = ' num2str(Accuracy_8) '%)' ]};
title(string)
legend('Reference category','Prediction category')




