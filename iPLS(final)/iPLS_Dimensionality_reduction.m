clear all;
clc
load('A.mat');
load('RAW.mat');
xaxis=A(1,:);          %xΪ����
RAW1=RAW(:,:);
RAW2=RAW1(:,1:254);
RAW=center(RAW1(:,1:254));
LLL=RAW1(:,255);
[oo, pp]=size(RAW);
temp = randperm(oo);%ѵ������Ԥ�⼯����3:1����
Xcal = RAW(temp(1:300),:);
ycal = LLL(temp(1:300),:);
Xtest = RAW(temp(301:end),:);
ytest = LLL(temp(301:end),:);
% figure(1);
% subplot(1,2,1);
% plot(xaxis,RAW2);
% subplot(1,2,2);
% plot(xaxis,RAW);


Model=ipls(Xcal,ycal,10,'mean',20,xaxis,'syst123',5); 
% figure(2);
% plsrmse(Model,0);
% figure(3);
% iplsplot(Model,'intlabel',9);
%  figure(4);
%  iplsplot(Model,'wavlabel',9);
plspvsm(Model,9,11);
