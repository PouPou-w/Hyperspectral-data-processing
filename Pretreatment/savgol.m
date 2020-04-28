
%x=H2O;width=7;order=3;deriv=1;
function [x_sg]= savgol(x,width,order,deriv)
% Savitsky-Golay smoothing and differentiation                        (Savitsky Golayƽ����΢��)
%
% [x_sg]= savgol(x,width,order,deriv)    ([x_sg]=savgol               ��x����ȣ��ף�������
%
% input:
% x (samples x variables) data to preprocess                          ��ҪԤ�����x������x���������ݣ�
% width (1 x 1)           number of points (optional, default=15)     ����ȣ�1x1����������ѡ��Ĭ��ֵΪ15����
% order (1 x 1)           polynomial order (optional, default=2)       (�ף�1x1������ʽ�ף���ѡ��Ĭ��ֵΪ2��)
% deriv (1 x 1)           derivative order (optional, default=0)       (��������1x1������ѡ��Ĭ��ֵΪ0����
%
% output:
% x_sg (samples x variables) preprocessed data                         ������x������Ԥ�������ݣ�




[m,n]=size(x);
x_sg=x;
if nargin<4
  deriv=0;
end
if nargin<3
  order=2; 
end
if nargin<2
  width=min(15,floor(n/2)); 
end
w=max( 3, 1+2*round((width-1)/2) );
o=min([max(0,round(order)),5,w-1]);
d=min(max(0,round(deriv)),o);
p=(w-1)/2;
xc=((-p:p)'*ones(1,1+o)).^(ones(size(1:w))'*(0:o));
we=xc\eye(w);
b=prod(ones(d,1)*[1:o+1-d]+[0:d-1]'*ones(1,o+1-d,1),1);
di=spdiags(ones(n,1)*we(d+1,:)*b(1),p:-1:-p,n,n);
w1=diag(b)*we(d+1:o+1,:);
di(1:w,1:p+1)=[xc(1:p+1,1:1+o-d)*w1]'; 
di(n-w+1:n,n-p:n)=[xc(p+1:w,1:1+o-d)*w1]';
x_sg=x*di;