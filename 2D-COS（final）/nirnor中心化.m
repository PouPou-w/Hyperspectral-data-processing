%#  function [ndata]=nirnor(data);
%#
%#  AIM:   ���滯��normalization�������ڹ�������Ԥ����
%#
%#  INPUT:  data        m��n�ľ���m�����ף�n������
%#
%#  OUTPUT: ndata       ���Ļ���Ĺ��׾���
%#          me          ��ֵ
%#
%#  AUTHOR: ���� 
%#  EMAIL:  wang727yi@hotmail.com
%#  VERSION:1.0 (16/03/2009)
%#	  

function [ndata]=nirnor(data);

[m,n]=size(data); 

mindata=zeros(1,n); % ����һ��1*n��С��ȫ0��������
maxdata=zeros(1,n);

for j=1:n
    mindata(j)=min(data(:,j));
    maxdata(j)=max(data(:,j));
    ndata(:,j)=(data(:,j)-mindata(j))/(maxdata(j)-mindata(j));
end

