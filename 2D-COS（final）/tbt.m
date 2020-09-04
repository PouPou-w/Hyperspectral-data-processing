fig_num=0;%����ͺ����Ǿ�figure(fig_num*2+1);һ��ʱ������ͼ�����ġ�

pre_data=zmczzl811;%dadou���Լ����ļ���

select_star_n=800;     %  ѡ�����(����)
select_end_n =406;     %  ѡ���յ�(����)

[~,c]=size(pre_data);
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


data_x=pre_data(:,select_star:select_end);
data_y=pre_data(:,select_star:select_end);

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
z_label='���ǿ��';


%%��ط���
[x,y]=meshgrid(data_x(1,1):(data_x(1,c_x)-data_x(1,1))/(c_x-1):data_x(1,c_x),...
    data_y(1,1):(data_y(1,c_y)-data_y(1,1))/(c_y-1):data_y(1,c_y));
synch=tran_data_y(:,1:c_y)'  *tran_data_x(:,1:c_x) /(n-1);
asynch=tran_data_y(:,1:c_y)' * N * tran_data_x(:,1:c_x)/(n-1);
asynch=-1.*asynch;
globel=asynch./synch;
%��ͼ

contour_n=32;

figure(fig_num*2+1);
mesh(x,y,synch);
xlabel(x_label);
ylabel(x_label);
zlabel(z_label);
title('ͬ��ͼ');
colormap('gray');
figure('color','white');
set(gca, 'XDir','normal');                
set(gca, 'YDir','normal');


figure(fig_num*2+2);
contour (x,y,synch,contour_n);
xlabel(x_label);
ylabel(x_label);
title('ͬ��ͼ');
colormap('gray');
figure('color','white');
set(gca, 'XDir','normal');                
set(gca, 'YDir','normal');


clear N asynch tran_data_x tran_data_y c_end c_star data_x data_y i ...
    mean_data_x mean_data_y clear n_x n_y synch x y   c_x x_select ...
    y_select c_y globel x_label y_label z_label jiange n c contour_n fig_num  ...
     figure_FontSize pre_data r select_end select_end_n select_star ...
     select_star_n ;