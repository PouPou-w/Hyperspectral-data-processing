load 'RAW.mat';
[m n] = size(RAW);                %m��������nά��
R = randperm(m);                  %1��m��Щ��������ҵõ���һ���������������Ϊ����
RAWtest = RAW(R(1:100),:);       %��������ǰ100����Ϊ��������RAWtest
R(1:100) = [];                    %�������ű�ʾɾȥ
RAWtraining = RAW(R,:);           %ʣ�µ�������Ϊѵ������RAWtraining

dataset=RAWtraining;
 %a=gaplsopt(dataset,1);
% e=gaplsopt(dataset,2);
[b,c,d]=gaplssp(dataset,100);
