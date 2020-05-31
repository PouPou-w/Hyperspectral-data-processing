data=[];
a = randperm( );  %��д����������
Train = data(a(1:20),:); %ȡ1��20��Ϊѵ����
Test = data(a(21:end),:);  %ʣ�µ�Ϊ���Լ�
% ѵ������
P_train = Train(:,2:end);
T_train = Train(:,1);
% ��������
P_test = Test(:,2:end);
T_test = Test(:,1);
%% �������ɭ�ַ�����
model = classRF_train(P_train,T_train);
%% �������
[T_sim,votes] = classRF_predict(P_test,model);
%%������ɭ��
ctree=ClassificationTree.fit(P_train,T_train);
%%���ɭ����ͼ
 view(ctree);
view(ctree,'mode','graph');

%%ʮ�ֽ�����֤
leafs=logspace(1,2,10);
N=numel(leafs);
err=zeros(N,1);
for n=1:N
t=ClassificationTree.fit(P_train,T_train,'crossval','on','minleaf',leafs(n));
err(n)=kfoldLoss(t);
end
plot(leafs,err);
