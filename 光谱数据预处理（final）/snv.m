function [x_snv] = snv(x)
% Standard Normal Variate                        ����׼��̬������
%
% [x_snv] = snv(x) 
%
% input:
% x (samples x variables) data to preprocess     ��ҪԤ�����x������x���������ݣ�
%
% output:
% x_snv (samples x variables) preprocessed data  ������x������Ԥ�������ݣ�

%


[m,n]=size(x);
rmean=mean(x,2);
dr=x-repmat(rmean,1,n);
x_snv=dr./repmat(sqrt(sum(dr.^2,2)/(n-1)),1,n);