B=[];%����һ���վ���
for i=1:12 %
data=zeros(8,1);%����һ����*��Ϊ396*1�������     
for j=1:3
    s=strcat(num2str(i),'-',num2str(j),'.txt');%'-'��ȡ��i��j֮������ӷ��������1.2�Ǿ���'.'��
    k=importdata(s);
    alldata=k.data;
    C = alldata(:,5)./alldata(:,4);
    %t=k(:,2);%���ԭ���ݵĵ�һ���ǹ�Ĳ������ڶ��в�������ȣ���ô����д2
    data=data+C;
end
    data=data/3;
    B=[B,data];
end