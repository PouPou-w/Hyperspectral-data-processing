function [nx] = normaliz(x) 
% Normalize matrix rows dividing by its norm     ���淶�������г����䷶����
% 
% [nx] = normaliz(x)
%
% input:                                         �����룩
% x (samples x variables)   data to normalize    ��Ҫ�淶����x������x���������ݣ�
%
% output:                                        �������
% nx (samples x variables)  normalized data      ��nx������x�������淶�����ݣ�


[m,n]=size(x);
nx=x;
nm=zeros(m,1);
for i = 1:m
nm(i)=norm(nx(i,:));
nx(i,:)=nx(i,:)/nm(i);
end
 %z=[1,2,3;3,4,5];
%[m,n]=size(z);
 %nx=z;
%nm=zeros(m,1);
%for i = 1:m
 %nm(i)=norm(nx(i,:));
 %nx(i,:)=nx(i,:)/nm(i);
%end