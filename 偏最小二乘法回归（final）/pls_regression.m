clc;
clear;
%% ���ݵ���

load('RAW.mat');
RAW1=RAW(:,:);
RAW=RAW1(:,1:254);
LLL=RAW1(:,255);
[oo, pp]=size(RAW);
temp = randperm(oo);
data_train = RAW(temp(1:300),:);
target_out = LLL(temp(1:300),:);
data_predict = RAW(temp(301:end),:);
predict_out = LLL(temp(301:end),:);


%% ���ݴ���
var=[data_train,target_out];
mu=mean(var);  %���ֵ
sig=std(var);  %���׼��
rr=corrcoef(var);   %�����ϵ������
ab=zscore(var); %���ݱ�׼��
a=ab(:,[1:254]);b=ab(:,end);  %�����׼������Ա��������������
[XL,YL,XS,YS,BETA,PCTVAR,MSE,stats] =plsregress(a,b);
xw=a\XS;  %���Ա�������ɷ�ϵ��
yw=b\YS;  %�����������ɷֵ�ϵ��
a_0=PCTVAR(1,:);b_0=PCTVAR(2,:);%PCTVAR��һ�����еľ��󣬵�һ��Ϊ�Ա�����ȡ�ɷֵĹ����ʣ��ڶ���Ϊ�������ȡ�ɷֵĹ�����
a_1=cumsum(a_0);b_1=cumsum(b_0);

%% �ж�����ɷֶԵĸ���
i=1;
while ((a_1(i)<0.95)&&(a_0(i)>0.05)&&(b_1(i)<0.95)&&(b_0(i)>0.05))
    i=i+1;
end
ncomp=i;
fprintf('���ɷָ���Ϊ��%d\n',ncomp);
fprintf('%d�Գɷֱַ�Ϊ��\n',ncomp);
for i=1:ncomp
    fprintf('��%d�Գɷ֣�\n',i);
    fprintf('u%d=',i);
    for k=1:254  %�˴�Ϊ����x�ĸ���
        fprintf('+(%f*x_%d)',xw(k,i),k);
    end
    fprintf('\n');
        fprintf('v%d=',i);
    for k=1  %�˴�Ϊ����y�ĸ����������������3���Ļ���Ҫд��1:3
        fprintf('+(%f*y_%d)',yw(k,i),k);
    end
    fprintf('\n');
end


%% ѵ����Ԥ��ֵ���ع鷽��
[XL2,YL2,XS2,YS2,BETA2,PCTVAR2,MSE2,stats2] =plsregress(a,b,ncomp);
n=size(a,2); m=size(b,2); %n���Ա����ĸ���,m��������ĸ���
beta3(1,:)=mu(n+1:end)-mu(1:n)./sig(1:n)*BETA2([2:end],:).*sig(n+1:end); %ԭʼ���ݻع鷽�̵ĳ�����
beta3([2:n+1],:)=(1./sig(1:n))'*sig(n+1:end).*BETA2([2:end],:); %����ԭʼ������ϵ����ÿһ����һ���ع鷽��
%ֱ��ͼ
bar(BETA2','b');%BETA2Ϊ�ع�ģ�͵�ϵ��
%y��Ԥ��ֵ
yhat = repmat(beta3(1),[size(a,1),1]) + var(:,1:n)*beta3(2:end,:);
fprintf('���ó����»ع鷽�̣�\n')

%rcoplot(XS2,YS2);���в�ͼ����û����������׼��ʽΪ[b,bint,r,rint,stats]=regress(y,x)��rcoplot(r,rint)��rcoplot(r,rint)����ʹ������ regress()��Ϻ�����ݲв�ͼ�ģ�����������������Ⱥ�㡣
%���� r�� rint��regress()����������ֵ��r����вrint����������ݵ���Ӧ��95%�������䡣
%��rcoplot()��ͼ��������ں���ɫ�������������õ�Ϊ��Ⱥ�㡣

%% Ԥ�⼯Ԥ��ֵ
for i=1 %�˴�Ϊ����y�ĸ����������������3���Ļ���Ҫд��1:3
    fprintf('y%d=%f',i,beta3(1,i));
    for j=1:254 %�˴�Ϊ�Ա���x�ĸ���
        fprintf('+(%f*x%d)',beta3(j+1,i),j);
    end
    fprintf('\n');
end
c=data_predict;
d=predict_out;
for i=1:100  %Ԥ�⼯������
    predict(i,:)=(sum(beta3(2:end,:)'.*c(i,:),2)+beta3(1,:)')';
end
%fprintf('Ԥ������\n');
%disp(predict)

%% ѵ���������
result_2 = [target_out yhat];

% ѵ�����������
E1 =mse(yhat'-target_out');%E1=sqrt(mse(yhat-data_train'));��ѵ�������������

% ѵ��������ϵ��
N1=length(target_out');
R21=(N1*sum(yhat'.*target_out')-sum(yhat')*sum(target_out'))^2/((N1*sum((yhat').^2)-(sum(yhat'))^2)*(N1*sum((target_out').^2)-(sum(target_out'))^2)); 

% ѵ����ƽ���������
M1=mean(abs(yhat'-target_out'));

%% �����������
result_1 = [predict_out predict];

% ���Լ��������
E = mse(predict'-predict_out');%E=sqrt(mse(predict-predict_out'));����Լ����������

% ���Լ�����ϵ��
N = length(predict_out');
R2=(N*sum(predict'.*predict_out')-sum(predict')*sum(predict_out'))^2/((N*sum((predict').^2)-(sum(predict'))^2)*(N*sum((predict_out').^2)-(sum(predict_out'))^2));

% ���Լ�ƽ���������
M=mean(abs(predict'-predict_out'));


%% ������ӻ�(����ͼ��
figure(2);  
plot(1:N,predict,'m--+',1:N,predict_out','b-*'); 
axis([1,100,0.5,5]);
grid on
legend('Ԥ��ֵ','��ʵֵ');  
ylabel('��������','fontsize',12);  
xlabel('�������','fontsize',12);  
string = {'Ԥ�⼯��������Ԥ�����Ա�(pls)';['(MSE = ' num2str(E) ' R^2 = ' num2str(R2) ' MAE =' num2str(M) ')']};
title(string)

figure(3)
plot(1:N1,yhat,'m--+',1:N1,target_out,'b-*');
axis([1,300,0.5,5]);
grid on
legend('Ԥ��ֵ','��ʵֵ')
xlabel('�������')
ylabel('��������')
string = {'ѵ������������Ԥ�����Ա�(pls)';['(MSE = ' num2str(E1) ' R^2 = ' num2str(R21) ' MAE =' num2str(M1) ' )']};
title(string)


%% ������ӻ������ͼ��
%yhat=sort(yhat);
y1max=max(yhat);%��Ԥ��ֵ�����ֵ
y2max=max(target_out);%��۲�ֵ�����ֵ
ymax=max([y1max;y2max]);%��Ԥ��ֵ�͹۲�ֵ�����ֵ
cancha=yhat-target_out;%����в�
figure(4)
plot(0:ymax(1),0:ymax(1),yhat(:,1),target_out(:,1),'c*');
title('ѵ�������')


y11max=max(predict);%��Ԥ��ֵ�����ֵ
y22max=max(predict_out);%��۲�ֵ�����ֵ
y1max=max([y11max;y22max]);%��Ԥ��ֵ�͹۲�ֵ�����ֵ
cancha1=predict-predict_out;%����в�
figure(5)
plot(0:y1max(1),0:y1max(1),predict(:,1),predict_out(:,1),'mx');
title('Ԥ�⼯���')

%% ���в�ͼ�����ع�������
[b4,bint4,r4,rint4,stats4]=regress(yhat,target_out);
figure(6)
rcoplot(r4,rint4);
[b3,bint3,r3,rint3,stats3]=regress(predict,predict_out);
figure(7)
rcoplot(r3,rint3);








