% clear all
% clc
% 
% %% ѵ����/���Լ�����
% load('RAW.mat');
% RAW1=RAW(:,:);
% RAW=RAW1(:,1:254);
% LLL=RAW1(:,255);
% [oo, pp]=size(RAW);
% temp = randperm(oo);%ѵ������Ԥ�⼯����3:1����
% X=RAW(temp(1:300),:);
% Y=LLL(temp(1:300),:);
% Xt=RAW(temp(301:end),:);
% Yt=LLL(temp(301:end),:);
% 
% %% LS-SVM����
% % gam =      2;
% % sig2 = 0.125;
% % type = 'classification';
% %  
% % [alpha,b] = trainlssvm({X,Y,type,gam,sig2,'RBF_kernel'});
% % %[alpha,b] = trainlssvm({X,Y,type,gam,sig2,'RBF_kernel','original'});
% % %[alpha,b] = trainlssvm({X,Y,type,gam,sig2,'RBF_kernel','preprocess'});
% % 
% % disp(' >> Ytest = simlssvm({X,Y,type,gam,sig2,''RBF_kernel'',''preprocess''},{alpha,b},Xt);');
% % Ytest = simlssvm({X,Y,type,gam,sig2,'RBF_kernel','preprocess'},{alpha,b},Xt);
% %  
% % figure; plotlssvm({X,Y,type,gam,sig2,'RBF_kernel','preprocess'},{alpha,b});
% % 
% 
% %% LS-SVM�ع�
% 
% gam = 50;
% sig2 = 0.2;
% type = 'function estimation';
%  
% %[alpha,b] = trainlssvm({X,Y,type,gam,sig2,'RBF_kernel'});
% [alpha,b] = trainlssvm({X,Y,type,gam,sig2,'RBF_kernel','original'});
% %[alpha,b] = trainlssvm({X,Y,type,gam,sig2,'RBF_kernel','preprocess'});
%  
% Ytest = simlssvm({X,Y,type,gam,sig2,'RBF_kernel','preprocess'},{alpha,b},Xt);
%  
% figure; plotlssvm({X,Y,type,gam,sig2,'RBF_kernel','preprocess'},{alpha,b});
% % hold off
% % Xt = (min(X):.1:max(X))'; 
% % eval('Yt = sinc(Xt);',...
% %      'Yt = sin(pi.*Xt+12345*eps)./(pi*Xt+12345*eps)+0.1.*randn(length(Xt),1);');
% % hold on;  plot(Xt,Ytest,'r-.'); hold off




% %% ����
% clc
% 
% %% ��������
% 
% S_Data=load('RAW.mat');
% S_Data=RAW(:,:);
% 
% n = 254;   % n ���Ա����ĸ���
% m = 1;     % m ��������ĸ���
% %% ��ȡѵ������
% train_num = 300;  %ѵ��������
% train_Data = S_Data(1:train_num,:);
% 
% % ����ֵ��һ��
% [train_Input,minI,maxI] = premnmx(train_Data(:,1:n)');%train_Data(:,1:n)'//////premnmx
% 
% % �����������
% [train_Output,minO,maxO] = premnmx(train_Data(:,n+1:end)');%premnmx
% 
% %% ��ȡ��������
% test_Data = S_Data(train_num+1:end,:);
% % ����ֵ��һ��
% test_Input = tramnmx(test_Data(:,1:n)',minI,maxI);
% % ��������������
% test_Output = tramnmx(test_Data(:,n+1:end)',minO,maxO);
% 
% % ѡȡ���ʵĲ���gam
% RMSE = []; 
% Gam = 1:10:200;
% sig = 2540; 
% 
% for q = 1:20     
%     gam = Gam(1,q); %��10Ϊ������ѵ��20��
%     tic;   %��ʱ��ʼ
%     % ��trainlssvm()������ѵ�����ݽ���ѵ��
%     [alpha, b] = trainlssvm({train_Input',train_Output','f',gam,sig});
%     %[alpha,b] = trainlssvm(train_Input',train_Output',gam,sig);
%     %alpha��LS-SVM��support values
%     %b��ƫ�����1 x m����
%     % sig�Ǻ˿�ȣ�gam�����򻯲���
%     %gam�����򻯲���:����gam�ͣ�ǿ��ģ�͸��Ӷȵ���С��;����gam�ߣ�ǿ��ѵ�����ݵ��������ϡ�
%     %kernel_par���ں˵Ĳ���;��RBF�˵�һ������£��ϴ��sig2��ʾ��ǿ��ƽ����
%     %ѵ��LS-SVM��֧��ֵ��ƫ������ڷ�������ƽ�
%    % SVMtest_Output = simlssvm(test_Input',train_Input',alpha,b,sig);
%    [SVMtest_Output, Zt] = simlssvm({train_Input',train_Output','f',gam,sig}, test_Input');
%     %simlssvm�ڸ����ĵ��LS-SVM��������
%     toc;   %��ʱ����
% 
%     test_Output = postmnmx(test_Output,minO,maxO);
%     SVMtest_Output = postmnmx(SVMtest_Output,minO,maxO);
%     
%     % �����������
%     test_err = test_Output' - SVMtest_Output;
%     n1 = length(SVMtest_Output);
%     test_RMSE = sqrt(sum((test_err).^2)/n1);
%     RMSE(1,q) = test_RMSE;
% end
% 
% x = Gam;  y = RMSE;
% plot(x,y,'-o')
% xlabel('����gam')
% ylabel('S����Ԥ����RMSE��')

clc

%% ��������
load('RAW.mat');
%  load('zz.mat', 'var_sel1')
% ZZ=var_sel1(:,:);
S_Data=RAW(:,:);

%n1=11
n = 254;   % n ���Ա����ĸ���
m = 1;     % m ��������ĸ���
%% ��ȡѵ������


train_num = randperm(400);  %ѵ��������
% train_Data1 = S_Data(train_num(1:300),ZZ);
% train_Data2=S_Data(train_num(1:300),255);
% train_Data=[train_Data1 train_Data2];
train_Data=S_Data(train_num(1:300),:);
% ����ֵ��һ��
[train_Input,minI,maxI] = premnmx(train_Data(:,1:n)');
% �����������
[train_Output,minO,maxO] = premnmx(train_Data(:,n+1:end)');
 gam = 30;
 sig = 0.5;
type = 'function estimation';
tic; %��ʱ��ʼ
% ��trainlssvm()������ѵ�����ݽ���ѵ��
[alpha,b] = trainlssvm({train_Input',train_Output',type,gam,sig,'RBF_kernel'});
SVMtrain_Output = simlssvm({train_Input',train_Output',type,gam,sig,'RBF_kernel','preprocess'},{alpha,b},train_Input');
toc; %��ʱ����
train_Output = postmnmx(train_Output',minO,maxO);
SVMtrain_Output = postmnmx(SVMtrain_Output',minO,maxO);
% ѵ���������
train_err = train_Output - SVMtrain_Output';
n1 = length(SVMtrain_Output);
train_RMSE = sqrt(sum((train_err).^2)/n1);

%% ��ȡ��������
test_Data = S_Data(train_num(301:400),:);
% ����ֵ��һ��
test_Input = tramnmx(test_Data(:,1:n)',minI,maxI)';
%[test_Input,minI1,maxI1] = premnmx(test_Data(:,1:n)');
% ��������������
test_Output = tramnmx(test_Data(:,n+1:end)',minO,maxO)';
%[test_Output,minO1,maxO1] = premnmx(test_Data(:,n+1:end)');

SVMtest_Output = simlssvm({train_Input',train_Output,type,gam,sig,'RBF_kernel','preprocess'},{alpha,b},test_Input);
test_Output = postmnmx(test_Output,minO,maxO);
SVMtest_Output = postmnmx(SVMtest_Output',minO,maxO);

%% �����������
result_1 = [test_Output SVMtest_Output'];

% ���Լ��������
E = mse(SVMtest_Output-test_Output');%E=sqrt(mse(SVMtest_Output-test_Output'));����Լ����������

% ���Լ�����ϵ��
N = length(test_Output');
R2=(N*sum(SVMtest_Output.*test_Output')-sum(SVMtest_Output)*sum(test_Output'))^2/((N*sum((SVMtest_Output).^2)-(sum(SVMtest_Output))^2)*(N*sum((test_Output').^2)-(sum(test_Output'))^2));

% ���Լ�ƽ���������
M=mean(abs(SVMtest_Output'-test_Output));

%% ѵ���������
result_2 = [train_Output SVMtrain_Output'];

% ѵ�����������
E1 =mse(SVMtrain_Output-train_Output');%E1=sqrt(mse(SVMtrain_Output-train_Output'));��ѵ�������������

% ѵ��������ϵ��
N1=length(train_Output');
R21=(N1*sum(SVMtrain_Output.*train_Output')-sum(SVMtrain_Output)*sum(train_Output'))^2/((N1*sum((SVMtrain_Output).^2)-(sum(SVMtrain_Output))^2)*(N1*sum((train_Output').^2)-(sum(train_Output'))^2)); 

% ѵ����ƽ���������
M1=mean(abs(SVMtrain_Output'-train_Output));

%% ������ӻ�
figure(1);  
plot(1:N,SVMtest_Output,'m--+',1:N,test_Output','b-*'); 
axis([1,100,0.5,4.50]);
grid on
legend('Ԥ��ֵ','��ʵֵ');  
ylabel('��������','fontsize',12);  
xlabel('�������','fontsize',12);  
string = {'Ԥ�⼯��������Ԥ�����Ա�(LS-SVM)';['(MSE = ' num2str(E) ' R^2 = ' num2str(R2) ' MAE =' num2str(M) ')']};
title(string)

figure(2)
plot(1:N1,SVMtrain_Output,'m--+',1:N1,train_Output,'b-*');
axis([1,300,0.5,4.50]);
grid on
legend('Ԥ��ֵ','��ʵֵ')
xlabel('�������')
ylabel('��������')
string = {'ѵ������������Ԥ�����Ա�(LS-SVM)';['(MSE = ' num2str(E1) ' R^2 = ' num2str(R21) ' MAE =' num2str(M1) ' )']};
title(string)



%% ����

Yl=[l*ones(l,4),2*ones(l,4),3*ones(l,4),4*ones(l,4),5*ones(l,4)]';%ѵ��Ŀ��ֵ
X2=[];%������������,X2Ϊ5��20�еľ���
Y2 =[l*ones(l,l),2*ones(l,l),3*ones(l,l),4*ones(l,l),5*ones(l,l)]����% ����Ŀ��ֵ
type=��c��;%����Ϊ����
kernel_type=��RBF_kerner;%�˺���Ϊ������˺���
gam=2 ;%�ͷ�������ʼֵ
sig2=2;%�˲�����ʼֵ
preprocess=��preprocess';% ������ҳ����
codefct=��code_OneVsAir;%���Զ��㷨ѡ��
[Yc,codebook,old_codebook]=code(Yl,codefct) %���б��봦��[gam,sig2]=tunelssvrn({Xl,Yc,type,gam,sig2,kemel_type,preprocess})% �Ż�����[alpha,b]=trainlssvm({Xl,Yc,type,gam,sig2,kernel_type,preprocess})% ����ѵ��ϵZ=simlssvm({Xl,Yc,type,gam,sig2,kernel��type,preprocess},{alpha,b},X2)% �������ݵķ���
Z0 =code(Z,old-codebook,[],codebook); %��Ч�ȼ���ʾ
Result=~abs(Z0-Y2)%��ʾ���,1����ȷ
Percent=sum(Result)/length(Result)% �����������ݷ�����ȷ��
[Yc,codebook,old-codebook]=code(Yl,codefct)% ���б��봦��
X0=[];%ʵ�ʷ�������,X0Ϊ3��20�еľ���
N = simlssvm({Xl,Yc,type,gam,sig2,kernel-type,preprocess}, {alpha,b},X0)% ʵ�����ݵķ���
N0 = code(N,old_codebook,[],codebook)% ��Ч�ȼ���ʾ




  

