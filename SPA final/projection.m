function chain = projection(X,k,M)

% Projections routine for the Successive Projections Algorithm using the
% built-in QR function of Matlab
%
% chain = projections(X,k,M)
%
% X --> Matrix of predictor variables (# objects N x # variables K) Ԥ��������󣨶���n x����k��
% k --> Index of the initial column for the projection operations  ͶӰ�����ĳ�ʼ������
% M --> Number of variables to include in the chain              ����Ҫ�����ı�����
%
% chain --> Index set of the variables resulting from the projection
% operations ͶӰ���������ı�����������

X_projected = X;

norms = sum(X_projected.^2);    % Square norm of each column vector ÿ��������ƽ������
norm_max = max(norms); % Norm of the "largest" column vector ������������ķ���

X_projected(:,k) = X_projected(:,k)*2*norm_max/norms(k); % Scales the kth column so that it becomes the "largest" column���ŵ�k�У�ʹ���Ϊ�������

[dummy1,dummy2,order] = qr(X_projected,0); %qr�����������ֽ�
chain = order(1:M)';