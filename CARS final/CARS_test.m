load 'RAW.mat';
[m n] = size(RAW);   %m��������nά��
y=RAW(:,1:n-1);
y_m=mean(y);
y_MSC=msc(y,y_m);
labol=RAW(:,n);
C=[y_MSC labol];
R = randperm(m);                  %1��m��Щ��������ҵõ���һ���������������Ϊ����
RAWtest = C(R(1:100),:);       %��������ǰ100����Ϊ��������RAWtest
R(1:100) = [];                    %�������ű�ʾɾȥ
RAWtraining = C(R,:);           %ʣ�µ�������Ϊѵ������RAWtraining
X=RAWtraining(:,1:n-1);
y=RAWtraining(:,n);
%  F=carspls(X,y);
% plotcars(F);

% plotmcs(F);
%F=randomfrog_plslda(X,y);




% load ('LPCS.mat');
% 
% [m n] = size(A);                %m��������nά��
% R = randperm(m);                  %1��m��Щ��������ҵõ���һ���������������Ϊ����
% Atest = A(R(1:15),:);       %��������ǰ100����Ϊ��������Atest
% R(1:15) = [];                    %�������ű�ʾɾȥ
% Atraining = A(R,:);           %ʣ�µ�������Ϊѵ������Atraining
% X=Atraining(:,1:n-1);
% y=Atraining(:,n);
% F=carspls(X,y);
% plotcars(F);