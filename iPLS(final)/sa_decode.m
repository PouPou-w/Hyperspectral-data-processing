function [out1] = sa_decode(Xcal_new, Ycal, Xtest_new, Ytest , boshu, k)
%�������Ĺ����Ƕ���ѡ������Ⱦɫ����н��룬�ó�rc,RMSEC��rp,RMSEP�Ƚ�ģ���

    plot(boshu, Xcal_new);
    Model=ipls_my(Xcal_new, Ycal, k, 'mean', 1, boshu, 'syst123', 5);%%�޸���IPLS������ʹ�䲻��ʾ�������
    rmse = Model.PLSmodel{1}.RMSE;
    [temp_rmse, topj] = min(rmse);
    plspvsm(Model,topj-1,1);
    oneModel=plsmodel(Model,1,topj-1,'auto','test',5);
    predModel=plspredict(Xtest_new,oneModel,topj-1,Ytest);
    plspvsm(predModel,topj-1,1);

    out1 = 1;

end