function r=OSC(x,y,comp)
%�����ź���֤
%reference 
%Svante Wold.Orthogonal signal correction of near-infrared spectra.
%Chemometrics and Intelligent Laboratory Systems.1998,44:175�C185

%������.��ƿƼ�.2008,2:119-124
%���޷�.���������.2008,34(5):228-230
%�����.ɽ����������ѧԺѧ��.20(2):83-87
% Qianxu Yang

%x(n*p) is sperum matrix,y(n*1)is concentration matrix
 [n,~]=size(x);
 
%give r.t_ a inital value to made loop begin
r.t_=ones(n*1);
%standerilize data
  
r.standX=x;r.standY=y;

%%below is the OSC procedure
%give r.newX and r.newX_ initial value to made loop effect
r.newX=r.standX;
r.newX_=r.standX/2;
r.i=1;
r.X=cell(1,comp+1);%��ʾ���Ϊ��������ʱ���޶����10�����룬���ߵ���������˼
% r.X=cell(1,3);%��ʾ���Ϊ��������ʱ���޶����10�����룬���ߵ���������˼
r.X{1}=r.standX;%��һ��cell�з�ԭʼ���ݵı�׼�����ݣ������CELL������������
while r.i<=comp%&sum(sum(r.newX_))/sum(sum(r.newX))<1c
    if r.newX_==r.standX/2
        r.i=r.i+1;
        r.newX=r.standX;
        %continue;
    else
        r.newX=r.newX_;
        r.i=r.i+1;
    end
    
%calcaulate the first score of x
[r.pc,r.score,r.latent]=pca(r.newX);
r.t=r.score(:,1);

%osc score according to y
I=eye(n,n);
r.newT=(I-r.standY*inv(r.standY'*r.standY)*r.standY')*r.t;

%calculate the weight vector w ,w is newT regressing with standX
o=pls(r.newX,r.newT,5); % 20111030
% o=Pls2(r.newX,r.newT,5); % 20111030
% [Xfactors,Yfactors,Core,B,ypred,ssx,ssy,reg] = npls(r.newX,r.newT,5,0); % 20111030
% o.r=diag(B);  % 20111030
%r.w=o.r;

%calculate new t
r.t_=o.t*o.r';
i=1;
%determine the whether the condition effect
 while norm(r.t_-r.t)/norm(r.t)>=10e-6
    r.t=r.t_;
    r.newT=(I-r.standY*inv(r.standY'*r.standY)*r.standY')*r.t;
    o=PLS(r.newX,r.newT,5);% 20111030
%     o=Pls2(r.newX,r.newT,5);% 20111030
    %r.w=o.r;
    %r.t_=r.newX*r.w;
    r.t_=o.t*o.r';
    i=i+1;if i>1000,break;end
     end

     

%%����Ĺ���ʹ��r.t_(r.t)����r.standY������ͬʱ��r.t_*r.standY=0�����ܾ����ܴ�
%%��X����Ϣ(r.t_=r.standX*r.w,ie,r.standX=inv(r.w)*r.t_)

%calculate the weigth p
r.p=r.t_'*r.newX/(r.t_'*r.newT);

%deduct the orthogonal signal in x
r.newX_=r.newX-r.t_*r.p;
r.X{r.i}=r.newX_; %��ÿ��OCSȥ����������ֺ�Ľ�����棬ò��һ��ֻ��ȥ�����μ��ɣ�������Ҫ������
end

r.EFFECT='1';
Value=min(length(r.X),10);
for i=1:Value-1
    if sum(sum(r.X{i+1}))/sum(sum(r.X{i}))>1
        r.EFFECT=num2str(i); %%%EFFECT��ʾ��Ч���������
        break;
    end
end



  