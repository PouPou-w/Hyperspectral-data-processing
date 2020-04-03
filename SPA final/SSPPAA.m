clear ;close all;
clc;
load RAW.mat; 
%RAW=RAW(:,1:254);


%%����ͶӰ�㷨��SPA����ȡ����������Xcal��ѵ�������ޱ�ǩ��Xval����֤�����ޱ�ǩ��ycal��ѵ�����ı�ǩ��yval����֤���ı�ǩ��

%�Ȱѱ�ǩ���Ż���
z=RAW(:,255);
y_SPA_RAW=[y_MSC,z];


%%��һ�ֱ�ǩ��ÿ100��һ����ǩ
% [m n] = size(y_SPA_RAW);                %m��������nά��
% R = randperm(m);                  %1��m��Щ��������ҵõ���һ���������������Ϊ����
% RAWtest = y_SPA_RAW(R(1:100),:);       %��������ǰ100����Ϊ��������RAWtest
% R(1:100) = [];                    %�������ű�ʾɾȥ
% RAWtraining = y_SPA_RAW(R,:);           %ʣ�µ�������Ϊѵ������RAWtraining
% RAW_c=RAWtraining(:,1:n-1);
% RAW_v=RAWtest(:,1:n-1);
% RAWc=RAWtraining(:,n);
% RAWv=RAWtest(:,n);
% Xcal=RAW_c;
% ycal=RAWc;
% Xval=RAW_v;
% yval=RAWv;

[m n] = size(y_SPA_RAW);                %m��������nά��
R = randperm(m);                      %1��m��Щ��������ҵõ���һ���������������Ϊ����
RAWtest = y_SPA_RAW(R(1:100),:);       %��������ǰ100����Ϊ��������RAWtest
R(1:100) = [];                        %�������ű�ʾɾȥ
RAWtraining = y_SPA_RAW(R,:);           %ʣ�µ�������Ϊѵ������RAWtraining
[m1 n1]=size(RAWtraining);
R1 = randperm(m1); 
RAWtest1 = RAWtraining(R1(1:75),:);
R1(1:75) = [];   
RAWtraining1 = RAWtraining(R1,:);

RAW_c=RAWtraining1(:,1:n1-1);
RAW_v=RAWtest1(:,1:n1-1);
RAWc=RAWtraining1(:,n1);
RAWv=RAWtest1(:,n1);
Xcal=RAW_c;
ycal=RAWc;
Xval=RAW_v;
yval=RAWv;





% %%�ڶ��ֱ�ǩ��ǰ300��Ϊ1����100��Ϊ2
% load('RAW_another.mat');
% [m n] = size(RAW_another);                             %m��������nά��
% R = randperm(m);                                       %1��m��Щ��������ҵõ���һ���������������Ϊ����
% RAW_anothertest = RAW_another(R(1:100),:);             %��������ǰ100����Ϊ��������RAW_anothertest
% R(1:100) = [];                                         %�������ű�ʾɾȥ
% RAW_anothertraining = RAW_another(R,:);                %ʣ�µ�������Ϊѵ������RAW_anothertraining
% RAW_another_c=RAW_anothertraining(:,1:n-1);
% RAW_another_v=RAW_anothertest(:,1:n-1);
% RAW_anotherc=RAW_anothertraining(:,n);
% RAW_anotherv=RAW_anothertest(:,n);
% Xcal=RAW_another_c;
% ycal=RAW_anotherc;
% Xval=RAW_another_v;
% yval=RAW_anotherv;
% 
% 
% 
% RAW_spa=spa(Xcal,ycal,Xval,yval,5,20,1);%���Ե���spa��������������ѡ������5������಻�ޣ�ѡ���Զ�У׼,�Զ�У׼��autoscaling��ѡ��1������ѡ��0
% 
m_min=5;
m_max=50;

N = size(Xcal,1); %Xcal��������Ҳ����������
K = size(Xcal,2); %Xcal��������Ҳ����ά��


% Phase 1: Projection operations for the selection of candidate subsetsѡ���ѡ�Ӽ���ͶӰ����
    
normalization_factor = std(Xcal);%��Xcal�ı�׼ƫ�Ҳ���Ǳ�׼�����ӣ�������Ϊһ�С���׼�������ã���׼��֮��ʹ��ͬ������������ͬ�ĳ߶�
    
for k = 1:K
    x = Xcal(:,k);
    Xcaln(:,k) = (x - mean(x)) / normalization_factor(k); %ÿһ�����ݼ�ȥƽ��ֵ���Ա�׼����Ǳ�׼���׼������׼����
end


SEL = zeros(m_max,K);%ȫ����󣬷�����������
for k = 1:K
    SEL(:,k) = projection(Xcaln,k,m_max);  %ѡ�����ͶӰ
end

% Phase 2: Evaluation of the candidate subsets according to the PRESS criterion  ����press׼�����ۺ�ѡ�Ӽ�
% PRESS (Prediction Errors Sum of Squares)��Ԥ�����ƽ���ͣ�

PRESS = Inf*ones(m_max,K);  %Inf����������������г���0�����

for k = 1:K
    for m = m_min:m_max
        var_sel = SEL(1:m,k);
        [yhat1,e1] = validation(Xcal,ycal,Xval,yval,var_sel); %e1Ϊ��֤����ѵ��������֤��û�н��棬���Բ��ǽ�����֤
        PRESS(m,k) = e1'*e1;%ת�ó���ԭ�����ǣ���֤��������������֤��������������С
    end
end

[PRESSmin,m_sel] = min(PRESS);  %�ҳ�ÿ��Ԥ�����ƽ������Сֵ��PRESS�������������У�����������m_sel�������ҳ�ÿ�������Сֵ
[dummny,k_sel] = min(PRESSmin); %�ҵ�������Ԥ�����ƽ������Сֵ��dummny���������ڵ��У�k_sel)���������ŵ��ǲ����������ҳ����е���Сֵ

%��k_sel����Ϊ��ʼ����ʱ��ѣ�������ĿΪm_sel(k_sel)
var_sel_phase2 = SEL(1:m_sel(k_sel),k_sel); 

% Phase 3: Final elimination of variables ��������������

% Step 3.1: Calculation of the relevance index ����ָ���ļ���
Xcal2 = [ones(N,1) Xcal(:,var_sel_phase2)]; %��һ��Ϊ1������ѡ������Ĳ���Ϊ������
b = Xcal2\ycal; % MLR with intercept term  ���ؾ���Ķ�Ԫ���Իع飬��֤���ı�ǩ����ѡ������Ĳ��Σ�Ҳ���ǳ��������
std_deviation = std(Xcal2);%��׼����׼ƫ��
relev = abs(b.*std_deviation');%�����������ֵ,�����ǵ�ˣ����Ǿ������
relev1 = relev(2:end);%�ѵ�һ��0��ɾ��
% Sorts the selected variables in decreasing order of "relevance"  ��������ԡ��Ľ���������ѡ����
[dummy,index_increasing_relev] = sort(relev1);%������sort��dummy������֮��ģ�index_increasing_relev���ӵĹ�����������
index_decreasing_relev = index_increasing_relev(end:-1:1);%��˳�򷴹������ӹ�����ĵ�����С��

% Step 3.2: Calculation of PRESS values  ����3.2��ѹ��ֵ����
for i = 1:length(var_sel_phase2)
    [yhat2,e2] = validation(Xcal,ycal,Xval,yval,var_sel_phase2(index_decreasing_relev(1:i)) );%��ǩ����֤��e2Ϊ��֤����
    PRESS_scree(i) = e2'*e2;
end
RMSEP_scree = sqrt(PRESS_scree/length(e2));%Ԥ��������������Ԥ�����ƽ���ͳ��Գ����ڿ�ƽ��
figure(12);
grid, hold on;
plot(RMSEP_scree);
xlabel('Number of variables included in the model'); %ģ���а����ı�������
ylabel('RMSE'); %�����������Ʊ�׼���䶨��Ϊ ��i=1��2��3����n�������޲��������У�������������ʽ��ʾ����[��di^2/n]=Re��
                %ʽ�У�nΪ����������diΪһ�����ֵ����ֵ��ƫ�
 
% Step 3.3: F-test criterion  f����׼��
PRESS_scree_min = min(PRESS_scree);
alpha = 0.25;
dof = length(e2); % Number of degrees of freedom ���ɶ�
fcrit = finv(1-alpha,dof,dof); % Critical F-value �ٽ�fֵ��F�ۻ��ֲ������ĵ���,Ҳ���Ƿ�λ��
PRESS_crit = PRESS_scree_min*fcrit;
% Finds the minimum number of variables for which PRESS_scree
% is not significantly larger than PRESS_scree_min  ���Ұ�scree������С�����������Դ���Press-Scree-Min
zx=find(PRESS_scree < PRESS_crit);
i_crit = min(zx); %�ҵ���С������
i_crit = max(m_min,i_crit); %ȡ��С����������Ҫ�����������ĸ��������ֵ

var_sel1 = var_sel_phase2( index_decreasing_relev(1:i_crit) );%����ȷ���������������������ڵĲ���
title(['Final number of selected variables: ' num2str(length(var_sel1)) '  (RMSE = ' num2str(RMSEP_scree(i_crit)) ')'],'FontSize',13);
%ѡ��������������Ŀ   ��������RMSE)����ֵ
% Indicates the selected point on the scree plot  ָʾ��״ͼ�ϵ�ѡ����
hold on;
plot(i_crit,RMSEP_scree(i_crit),'s');


% Presents the selected variables   ��ʾѡ���ı���
% in the first object of the calibration set ��У׼���ĵ�һ��������
figure(13),plot(Xcal(1,:));
hold,grid;
plot(var_sel1,Xcal(1,var_sel1),'s')   %���ѡ��һ������ʾ������ѡ����ǵ�10������
legend('First calibration object','Selected variables')%��һѵ������   ѡ������
xlabel('Variable index','FontSize',12) %��������
ylabel('Refelctance','FontSize',12);