clc
load('var.mat');
load('var_ch.mat');
var_x=var(:,:);
var_y=var_ch(:,:);
var=[var_x(1:19,:),var_y(1:19,:)];
mu=mean(var);sig=std(var); %���ֵ�ͱ�׼��
rr=corrcoef(var);   %�����ϵ������
ab=zscore(var); %���ݱ�׼��
a=ab(:,[1:1781]);b=ab(:,[1782:end]);  %�����׼������Ա��������������
[XL,YL,XS,YS,BETA,PCTVAR,MSE,stats] =plsregress(a,b);
xw=a\XS;  %���Ա�������ɷ�ϵ��
yw=b\YS;  %�����������ɷֵ�ϵ��
a_0=PCTVAR(1,:);b_0=PCTVAR(2,:);%PCTVAR��һ�����еľ��󣬵�һ��Ϊ�Ա�����ȡ�ɷֵĹ����ʣ��ڶ���Ϊ�������ȡ�ɷֵĹ�����
a_1=cumsum(a_0);b_1=cumsum(b_0);
i=1;
%�ж�����ɷֶԵĸ���
while ((a_1(i)<0.95)&&(a_0(i)>0.05)&&(b_1(i)<0.95)&&(b_0(i)>0.05))
    i=i+1;
end
ncomp=i;
fprintf('���ɷָ���Ϊ��%d\n',ncomp);
fprintf('%d�Գɷֱַ�Ϊ��\n',ncomp);
for i=1:ncomp
    fprintf('��%d�Գɷ֣�\n',i);
    fprintf('u%d=',i);
    for k=1:1781%�˴�Ϊ����x�ĸ���
        fprintf('+(%f*x_%d)',xw(k,i),k);
    end
    fprintf('\n');
        fprintf('v%d=',i);
    for k=1:3%�˴�Ϊ����y�ĸ���
        fprintf('+(%f*y_%d)',yw(k,i),k);
    end
    fprintf('\n');
end
[XL2,YL2,XS2,YS2,BETA2,PCTVAR2,MSE2,stats2] =plsregress(a,b,ncomp);
n=size(a,2); m=size(b,2); %n���Ա����ĸ���,m��������ĸ���
beta3(1,:)=mu(n+1:end)-mu(1:n)./sig(1:n)*BETA2([2:end],:).*sig(n+1:end); %ԭʼ���ݻع鷽�̵ĳ�����
beta3([2:n+1],:)=(1./sig(1:n))'*sig(n+1:end).*BETA2([2:end],:); %����ԭʼ������ϵ����ÿһ����һ���ع鷽��
fprintf('���ó����»ع鷽�̣�\n')
for i=1:3%�˴�Ϊ����y�ĸ���
    fprintf('y%d=%f',i,beta3(1,i));
    for j=1:1781%�˴�Ϊ����x�ĸ���
        fprintf('+(%f*x%d)',beta3(j+1,i),j);
    end
    fprintf('\n');
end
c=var_x(20:24,:);d=var_y(20:24,:);
for i=1:5
    predict(i,:)=(sum(beta3(2:end,:)'.*c(i,:),2)+beta3(1,:)')';
end
fprintf('Ԥ��2020-2025��Ľ����\n');
disp(predict)
