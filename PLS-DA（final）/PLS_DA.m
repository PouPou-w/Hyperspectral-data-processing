function [ccr,cvr,ypredict,ycredict,yc,yp,ys]=PLS_DA(x1,y1,x2,y2,lv)
%ƫ��С���������б����
% �������
% x1:��ģ������������Ϊ������ţ���Ϊ������ţ�
% y1:��ģ���������Ϊ������ţ���Ϊ�����ţ������������������������������
% ��ֵΪ1�������е�ֵΪ0�����磬y1�ĵ�2��=[1 0 0]ָ��2���������ڵ�1�࣬������
% ����Ϊ3�����
% x2��Ԥ�⼯����鼯��������y2��Ԥ�⼯��������飻lv:ΪǱ��������
% �������
% yp��ģ�͸����ļ��鼯������yֵ
[n1,m1]=size(x1);%��ѵ��������������n1������������m1
[n2,m2]=size(x2);%�����鼯����������n2������������m2
nj=size(y1,2);%��ѵ�������������nj
ny=size(y2,2);%�����鼯���������ny
if nj ~= ny
    error('ѵ��������鼯���������������')
end
if lv > m1
    error('Ǳ�����������ܴ���������������')
end
ys=[];
ypredict=zeros(n2,nj);%��һ������=���鼯������������=�������Ԫ��ֵ=0������ 
% ypredict �Դ��ģ���б�ļ��鼯���������Ϣ
ycredict=zeros(n1,nj);%��һ������=��ģ��������������=�������Ԫ��ֵ=0������ 
% ypredict �Դ��ģ���б�ļ��鼯���������Ϣ
yp=[];
yc=[];
hindexv=[];
hindexc=[];
for j=1:nj
    [theta,yres]=plsr(x1,y1(:,j),m1,lv);
    yre=mean(abs(yres));
    myre=mean(yre,2);
    ys=[ys myre];%����ģ����ƽ��ƫ���ys
    ayc=x1*theta';%����ģ�͸����Ľ�ģ��������yֵ������ayc
    ayp=x2*theta';%����ģ�͸����ļ��鼯������yֵayp
    yc=[yc ayc];%��ģ�͸����Ľ�ģ��������yֵ����yc
    yp=[yp ayp];%��ģ�͸����ļ��鼯������yֵ����yp
end
for jj=1:nj
    for i=1:n2
        if yp(i,jj) > 0.5 & ys(1,jj) < 0.5
            ypredict(i,jj)=1;
        elseif yp(i,jj) >= 0.5 & ys(1,jj)>0.5
            ypredeict(i,jj)=2;
        else
            ypredict(i,jj)=0;
        end
    end
end
a=find(ypredict(:,:)>1);
hindexv=[hindexv;a];
yactv=y2; %�����鼯�������Ϣ����yactv
yactv(hindexv,:)=[]; %�����鼯�л�ɫ���������ж���Ϊ��
hypr=y2(hindexv,:);%�����鼯�л�ɫ�����������Ϣ���� hypr
ypp=ypredict; %��ģ���б�ļ������ļ��鼯�����Ϣ����ypp
ypp(hindexv,:)=[]; %��ypp�л�ɫ���������ж���Ϊ��
b=size(hypr,1); %ͳ�Ƽ��鼯�л�ɫ�����ĸ���
d=n2-b;%ͳ��ģ�Ϳ���ȷ�б����ļ�����������������d
c=ones(d,1);%��һ����Ϊd��Ԫ��ֵΪ1��������c
ccv=c;
for kk=1:d
    for jjj=1:nj
        if yactv(kk,jjj)~=ypp(kk,jjj)
            ccv(kk,1)=0; %��ģ���б�ļ��鼯���������ʵ�����ͬ�� ccv=0
        end
    end
end
cvr=sum(ccv)/sum(c); %����ģ�ͶԼ��鼯�����б����ȷ������cvr
for jj=1:nj
    for i=1:n1
        if yc(i,jj)>0.5 & ys(1,jj)<0.5
            ycredict(i,jj)=1;
        elseif yc(i,jj) >=0.5 & ys(1,jj)>0.5
            ycredict(i,jj)=0;
        end
    end
end
a=find(ycredict(:,:)>1);
hindexc=[hindexc;a];
yact=y1; %��ѵ�����л�ɫ���������ж���Ϊ��
hypr=y2(hindexc,:);%��ѵ�����л�ɫ�����������Ϣ����hypr
ycp=ycredict;%��ģ���б��ѵ�������Ϣ����ycp
ycp(hindexc,:)=[];%��ycp�л�ɫ���������ж���Ϊ��
b=size(hypr,1);%ͳ��ģ���б�Ϊ��ɫ������ѵ������������
d=n1-b;%ͳ��ģ�Ϳ���ȷ�б�����ѵ������������������d
c=ones(d,1);%��һ����Ϊd,Ԫ��ֵΪ1��������c
cc=c;
for kk=1:d
    for jjj=1:nj
        if yact(kk,jjj)~=ycp(kk,jjj)
            cc(kk,1)=0; %��ģ���б��ѵ�������������ʵ�����ͬ��cc=0
        end
    end
end
ccr=sum(cc)/sum(c);%����ģ�Ͷ�ѵ���������б����ȷ������ccr
% end of the M file