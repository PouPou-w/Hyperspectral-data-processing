fig_num=0;%这个和后面那句figure(fig_num*2+1);一起时用来给图命名的。

load DOSC.mat
xia=xlsread('xia.xlsx'); 
x=xia(1,6:249);
data=DOSC(:,6:249);

pre_data=[x;data];%dadou是自己的文件名

select_star_n=883.6;     %  选择起点(波数)
select_end_n =1685.3;     %  选择终点(波数)
[tem,c]=size(pre_data);
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

%平均变换
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

x_label='Wavelength/nm';
y_label='Wavelength/nm';
z_label='Intensity';


%%相关分析
[x,y]=meshgrid(data_x(1,1):(data_x(1,c_x)-data_x(1,1))/(c_x-1):data_x(1,c_x),...
    data_y(1,1):(data_y(1,c_y)-data_y(1,1))/(c_y-1):data_y(1,c_y));
synch=tran_data_y(:,1:c_y)'  *tran_data_x(:,1:c_x) /(n-1);
asynch=tran_data_y(:,1:c_y)' * N * tran_data_x(:,1:c_x)/(n-1);
asynch=-1.*asynch;
globel=asynch./synch;
%绘图


contour_n=32;
figure(fig_num*2+1);
mesh(x,y,synch);  %同步三维图
xlabel(x_label);
ylabel(x_label);
zlabel(z_label);
title('同步三维图');
% colormap('gray'); %colormap 是用于控制曲面图的颜色。 colormap(gray) 输出一个灰色系的曲面图
% figure('color','white');%设置图的颜色为白色
set(gca, 'XDir','normal'); 
%  就是让 x 轴的刻度顺序设置为 “正常”，也就是刻度从下往上是依次增大的。如果你希望反过来， 就是 >> set(gca,'YDir','reverse')                                               
set(gca, 'YDir','normal');  %设置y轴的刻度顺序，从下向上一次增大


figure(fig_num*2+2);
contour (x,y,synch,contour_n);  %   同步等高线图
xlabel(x_label);
ylabel(x_label);
title('同步等高线图');
% colormap('gray');
% figure('color','white');
set(gca, 'XDir','normal');                
set(gca, 'YDir','normal');



figure(fig_num*2+3);
mesh(x,y,asynch);  %     异步三维图   x  y是自变量矩阵，z（asynch)是建立在x和y之上的函数矩阵
xlabel(x_label);
ylabel(x_label);
zlabel(z_label);
title('异步三维图');
% colormap('gray');
% figure('color','white');
set(gca, 'XDir','normal');                
set(gca, 'YDir','normal');

figure(fig_num*2+4);
contour (x,y,asynch,contour_n);%  异步等高线图
xlabel(x_label);
ylabel(x_label);
% title('异步等高线图');
% colormap('gray');
figure('color','white');
set(gca, 'XDir','normal');                
set(gca, 'YDir','normal');

clear N asynch tran_data_x tran_data_y c_end c_star data_x data_y i ...
    mean_data_x mean_data_y clear n_x n_y synch x y   c_x x_select ...
    y_select c_y globel x_label y_label z_label jiange n c contour_n fig_num  ...
     figure_FontSize pre_data r select_end select_end_n select_star ...
     select_star_n ;