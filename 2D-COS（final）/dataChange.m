B=[];%����һ���վ���
for i=0:14
data=zeros(396,1);%����һ����*��Ϊ396*1�������     
for j=1:3
    s=strcat(num2str(i),'-',num2str(j),'.txt');%'-'��ȡ��i��j֮������ӷ��������1.2�Ǿ���'.'��
    k=importdata(s);
    t=k(:,2);%���ԭ���ݵĵ�һ���ǹ�Ĳ������ڶ��в�������ȣ���ô����д2
    data=data+t;
end
    data=data/3;
    B=[B,data];
end
xlswrite('result.xlsx',B,'Sheet1');%xls����ʽ���
