clc


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
%% ��������
type = 'c';
kernel_type = 'RBF_kernel';
gam =418.3101;
sig2 =  24.41722;

preprocess = 'preprocess';
codefct = 'code_MOC';   

%% ����

[Yc,codebook,old_codebook] = code(T_train,codefct);


%% ������֤�Ż�����
%L_fold = 10; % L-fold crossvalidation
%[gam,sig2] = tunelssvm({P_train,T_train,type,[],[],'RBF_kernel'},'simplex','crossvalidatelssvm',{L_fold,'misclass'});
%[gam,sig2] = tunelssvm({P_train,T_train,type,[],[],'RBF_kernel'},'gridsearch','crossvalidatelssvm',{L_fold,'misclass'});
%[gam,sig2] = tunelssvm({P_train,Yc,type,gam,sig2,kernel_type,preprocess});

%% ѵ�������

[alpha,b] = trainlssvm({P_train,Yc,type,gam,sig2,kernel_type,preprocess});           % ѵ��
Yd0 = simlssvm({P_train,Yc,type,gam,sig2,kernel_type,preprocess},{alpha,b},P_test);      % Ԥ�⼯����
Yd1 = simlssvm({P_train,Yc,type,gam,sig2,kernel_type,preprocess},{alpha,b},P_train);      % ѵ��������

%% ����

Yd2= code(Yd0,old_codebook,[],codebook);
Yd3 = code(Yd1,old_codebook,[],codebook);


%% ���ͳ��

%% ����Ա�
result_1 = [T_train Yd3];
result_2 = [T_test Yd2];
% ѵ������ȷ��
k1 = length(find(T_train == Yd3));
n1 = length(T_train);
Accuracy_1 = k1 / n1 * 100;
disp(['ѵ������ȷ��Accuracy = ' num2str(Accuracy_1) '%(' num2str(k1) '/' num2str(n1) ')'])
% ���Լ���ȷ��
k2 = length(find(T_test == Yd2));
n2 = length(T_test);
Accuracy_2 = k2 / n2 * 100;
disp(['���Լ���ȷ��Accuracy = ' num2str(Accuracy_2) '%(' num2str(k2) '/' num2str(n2) ')'])

%% ��ͼ
figure(1)
plot(1:300,T_train,'m--+',1:300,Yd3,'b-*')
axis([1,300,0.5,4.5]);
grid on
xlabel('ѵ�����������')
ylabel('ѵ�������������')
string = {'ѵ�����������Ա�(LS-SVM)';['(��ȷ��Accuracy = ' num2str(Accuracy_1) '%)' ]};
title(string)
legend('��ʵֵ','LS-SVMԤ��ֵ')
figure(2)
plot(1:100,T_test,'m--+',1:100,Yd2,'b-*')
axis([1,100,0.5,4.5]);
grid on
xlabel('���Լ��������')
ylabel('���Լ��������')
string = {'���Լ��������Ա�(LS-SVM)';['(��ȷ��Accuracy = ' num2str(Accuracy_2) '%)' ]};
title(string)
legend('��ʵֵ','LS-SVMԤ��ֵ')


