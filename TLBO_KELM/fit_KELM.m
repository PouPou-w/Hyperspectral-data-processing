function  CCR=fit_KELM(X1,Y1,X2,Y2,C,g)
          
          [~, ~, ELM_Kernel_Model]=elm_kernel_train(X1,Y1,7,1,C, 'RBF_kernel',g);
          [~, T_sim_1] = elm_kernel_predict(X2, X1, ELM_Kernel_Model);
          Y2=Y2';
          k1 = length(find(Y2== T_sim_1));
          n1 = length(Y2);
          CCR= n1 / k1 ;%ȡ����������minѰ�ţ�maxҲ���ԣ�min����һ�㣬��������sort����֮��Ҫ��һ��
%CCR=mse(T_sim_1-Y2);