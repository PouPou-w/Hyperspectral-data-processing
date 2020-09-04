%%���ݽṹ(pre_data)
%  ���׷���---����
%  ��һ��Ϊ��������(�����򲨳�)
%  
fig_num=0;%����ͺ����Ǿ�figure(fig_num*2+1);һ��ʱ������ͼ�����ġ�

load DOSC.mat
xia=xlsread('xia.xlsx'); 
x=xia(1,6:249);
data=DOSC(:,6:249);

pre_data=[x;data];%dadou���Լ����ļ���

select_star_n=883.6;     %  ѡ�����(����)
select_end_n =1685.3;     %  ѡ���յ�(����)

[r,c]=size(pre_data);
i=1;
while i<c+1
    if pre_data(1,i)<select_star_n
        select_star=i-1;
        i=c;
    end
    i=i+1;
end

j=select_star+1;
while j<c+1
    if pre_data(1,j)<select_end_n
        select_end=j;
        j=c;
    end
    j=j+1;
end


data_x=pre_data(:,:);
data_y=pre_data(:,:);

%ƽ���任
[n_x,c_x]=size(data_x);
n_x=n_x-1;
mean_data_x=mean(data_x(2:n_x+1,:));
for i=1:n_x
    tran_data_x(i,:)=data_x(i+1,:)-mean_data_x;
end

[n_y,c_y]=size(data_y);
n_y=n_y-1;
mean_data_y=mean(data_y(2:n_y+1,:));
for i=1:n_y
    tran_data_y(i,:)=data_y(i+1,:)-mean_data_y;
end

n=n_x;

%  Hilbert_Noda
N = zeros(n);
for i=2:(n)
    N(1,i) = 1/(pi * (i-1));
end
for i=2:(n-1)
    for j=i:(n)
        N(i,j) = N(i-1,j-1);
    end;
end
for i=2:(n)
    for j=1:i
        N(i,j) = -N(j,i);
    end;
end
clear i j

x_label='����/nm';
y_label='����/nm';


%%��ط���
[x,y]=meshgrid(data_x(1,1):(data_x(1,c_x)-data_x(1,1))/(c_x-1):data_x(1,c_x),...
    data_y(1,1):(data_y(1,c_y)-data_y(1,1))/(c_y-1):data_y(1,c_y));
synch=tran_data_y(:,1:c_y)'  *tran_data_x(:,1:c_x) /(n-1);
asynch=tran_data_y(:,1:c_y)' * N * tran_data_x(:,1:c_x)/(n-1);
asynch=-1.*asynch;
globel=asynch./synch;
%��ͼ

contour_n=16;
figure(fig_num*2+1);
contourf (x, y,synch,contour_n, 'DisplayName', 'x, y,synch');
xlabel(x_label);
ylabel(x_label);
title('ͬ��ͼ');
% set(gca, 'XDir','reverse');                
% set(gca, 'YDir','reverse');
% Draw_for_2d;
 
 
figure(fig_num*2+2);
contourf (x, y,asynch,contour_n, 'DisplayName', 'x, y,asynch');
xlabel(x_label);
ylabel(x_label);
title('�첽ͼ');
set(gca, 'XDir','reverse');                
set(gca, 'YDir','reverse');
Draw_for_2d;

figure(fig_num*2+3);
for m=1:c_x
    xx(m)=x(m,m);
    zz(m)=synch(m,m);
end
plot(xx,zz);
xlabel(x_label);
title('�Զ���ǿ������ͼ');
set(gca, 'XDir','reverse');

clear N asynch tran_data_x tran_data_y c_end c_star data_x data_y i ...
    mean_data_x mean_data_y clear n_x n_y synch x y   c_x x_select ...
    y_select c_y globel x_label y_label jiange n c contour_n fig_num  ...
     figure_FontSize pre_data r select_end select_end_n select_star ...
     select_star_n   m ;