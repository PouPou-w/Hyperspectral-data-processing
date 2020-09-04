%������
%****���������������£�********
clc;
clear;
seeddim=8;%��ʼ��ά��
initseednum=10;%��ʼ�����Ӹ���
Pmax=20;%��Ⱥ�������ֵ
maxseed=4;%�������������
xmax=1;%��ʼ�����Xֵ
xmin=0;%��ʼ����СXֵ
iter_max=100;%����������
iter=1;%��ʼ����������
%****���������������ϣ�********
x=xmin+(xmax-xmin)*rand(seeddim,initseednum);
Sum=initseednum;
directva=[];
while iter<=iter_max
    for i=1:Sum
        seed_num=fix(maxseed-maxseed*direct(x(:,i))/4);
        if seed_num<0
            break;
        end
        sd=normrnd(0,acur(iter,iter_max),[seeddim seed_num]);
        for j=1:seed_num
            temx=x(:,i)+sd(:,j);
            temx(temx<xmin)=xmin;
            x=[x temx];
        end
    end
    Sum=length(x(1,:));
    if Sum>Pmax
        Fit_tem1=[];
        for i=1:Sum
            Fit_tem1=[Fit_tem1 direct(x(:,i))];
        end
        Fit_tem2=sort(Fit_tem1);
         directva=[directva Fit_tem2(1)];
        x_tem=x;
        for i=1:Sum
            for j=1:Sum
                if Fit_tem2(i)==Fit_tem1(j)
                   x_tem(:,i)=x(:,j);
                end
            end
        end
        x=x_tem;
        x(:,[Pmax+1:Sum])=[];
        Sum=Pmax;
    end
    iter=iter+1;
    iter
end