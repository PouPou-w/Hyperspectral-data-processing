
clc;
clear;
close all;

%% Problem Definition

data=LoadData();

nf=15;   % Desired Number of Selected Features

CostFunction=@(q) FeatureSelectionCost(q,nf,data);    % Cost Function

%% SA Parameters

MaxIt=50;     % Maximum Number of Iterations����������  ���ѭ����Ҫ���²���t��ģ���˻����

MaxSubIt=12;    % Maximum Number of Sub-iterations����ӵ�����   �ڲ�ѭ����Ѱ����һ���¶��µ�����ֵ

T0=195;         % Initial Temp.��ʼ�¶�

alpha=0.99;     % Temp. Reduction Rate�¶� ������

%% Initialization

% Create and Evaluate Initial Solution������������ʼ�������
sol.Position=CreateRandomSolution(data);
[sol.Cost, sol.Out]=CostFunction(sol.Position);%CostFunctionΪ���ۺ���

% Initialize Best Solution Ever Found��ʼ����ʷ������õĽ������
BestSol=sol;

% Array to Hold Best Cost Values�������ֵ������
BestCost=zeros(MaxIt,1);

% Intialize Temp.��ʼ�¶�
T=T0;

%% SA Main Loop

for it=1:MaxIt
    
    for subit=1:MaxSubIt
        
        % Create and Evaluate New Solution�����������½������
        newsol.Position=CreateNeighbor(sol.Position);
        [newsol.Cost, newsol.Out]=CostFunction(newsol.Position);
        
        if newsol.Cost<=sol.Cost % If NEWSOL is better than SOL
            sol=newsol;
            
        else % If NEWSOL is NOT better than SOL
            
            DELTA=(newsol.Cost-sol.Cost)/sol.Cost;
            
            P=exp(-DELTA/T);%Metropolis׼��
            if rand<=P
                sol=newsol;
            end
            
        end
        
        % Update Best Solution Ever Found������ʷ������õĽ������
        if sol.Cost<=BestSol.Cost
            BestSol=sol;
        end
    
    end
    
    % Store Best Cost Ever Found�洢��ʷ������õĳɱ�
    BestCost(it)=BestSol.Cost;
    
    % Display Iteration Information��ʾ������Ϣ
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    % Update Temp.�����¶�
    T=alpha*T;
        
end

%% Results
pp=1:1:50;
pp=pp';
figure;
%plot(BestCost,'LineWidth',2);
%plot(BestCost,'b-o');
plot(pp,BestCost,'--  gs','LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5])
xlabel('Iteration');
ylabel('Best Cost');
