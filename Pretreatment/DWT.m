function x=DWT(xyuan)

%��ȡ�����źŵĳ�������
sizex=size(xyuan);
row=sizex(1);
column=sizex(2);

%���巵�ؾ���,��С���任��ľ���
x=zeros(row,column);

%����С���任�˲��еĲ���
wname='bior3.3';  %ѡ��С��������
lev_max=wmaxlev(row,wname)
lev=5      %�趨�ֽ����

for i=1:column
    %С���ֽ�,�ó�С���ֽ�ṹ[c,l]
    [c,l]=wavedec(xyuan(:,i),lev,wname); 
 
    %��ֵѡ���ź�ȥ�롢�ź��ع�
    
    %����ԭʼ�ź�����ǿ�ȵ���ֵѡȡ
     % һ��ȱʡ����ֵģ��
%     [thr1,sorh,keepapp]=ddencmp('den','wv',xyuan(:,i));    %���ݴ�����ź�xyuan�õ�����ĸ�����ֵ
%      keepapp=1;
%      xd=wdencmp('gbl',c,l,wname,lev,thr1,'s', keepapp);   %�ؽ��������ź�
%      x(:,i)=xd;    %��ÿ�������źźϲ�Ϊȥ���Ĺ��׾���
     
    % ����Brige-Massart������ȷ������ֵ
    alpha=3;   %ѡ�����a    
    [thr2,nkeep]=wdcbm(c,l,alpha);    %ʹ��Brige-Massart����ȷ����ֵ
    keepapp=1;
    xd=wdencmp('lvd',c,l,wname,lev,thr2,'s');   %�ؽ��������ź�
    x(:,i)=xd;    %��ÿ�������źźϲ�Ϊȥ���Ĺ��׾���
   
    %����penalty������ȷ������ֵ
%     s=xyuan(:,i)';  %wbmpenֻ�ܴ������������������н���ת��
%     [c0,l0]=wavedec(s,lev,wname);  %������С���ֽ�
%     alpha=2;
%     keepapp=1;
%     sigma=wnoisest(c0,l0,1);    %ͨ����һ���ϸ��ϵ�������źŵ�����ǿ��
%     thr3=wbmpen(c0,l0,sigma,alpha);   %ʹ��penalty����ȷ����ֵ
%     [xd,cxd,lxd,perf0,perfl2]=wdencmp('gbl',c,l,wname,lev,thr3,'s', keepapp);   %�ؽ��������������ź�
%     x(:,i)=xd;    %��ÿ�������źźϲ�Ϊȥ���Ĺ��׾���
     
     %�����������Ƶ���ֵѡȡ
     % �ġ���Ҫ�������ֹ���
     %                    'rigrsure',stein��ƫ��Ȼ���ƹ���
     %                    'sqtwolog',��������ͳһ��ֵ����
     %                    'heursure',����ʽsure��ֵ����
     %                    'minimaxi',��С���󷽲���ֵ����
%      tptr='minimaxi';         %ѡ����ֵѡȡ����    
%      s=xyuan(:,i)';
%      thr4=thselect(s,tptr);
%      keepapp=1;
%      [xd,cxd,lxd,perf0,perfl2]=wdencmp('gbl',c,l,wname,lev,thr4,'s', keepapp);   %�ؽ��������ź�
%      x(:,i)=xd;    %��ÿ�������źźϲ�Ϊȥ���Ĺ��׾���
     
    %�塢ֱ��ʹ�ý���ϵ�������ع�
    
%     ca=wrcoef('a',c,l,wname,lev);     %�ؽ���lev��Ľ���ϵ��
%     x(:,i)=ca;                      %ֱ�ӽ�����Ϊ�����ź�
    
end
  %   ����ԭʼ�źźͽ������ź�
       % figure,subplot(2,1,1),plot(xyuan(:,3)),title('ԭʼ�ź�');
        %       subplot(2,1,2),plot(x(:,3)),title('�������ź�');   
    
    