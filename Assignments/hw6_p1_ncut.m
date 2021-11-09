clear
X1 = load('hw06-data1.mat').X;
X2 = load('hw06-data2.mat').X;

[Xnew1,Xnew2] = data_partion(X2);
[Xnew1p,Xnew2p] = data_partion(Xnew1);
[Xnew3p,Xnew4p] = data_partion(Xnew2);

figure
plot(Xnew1(1,:),Xnew1(2,:),'k.',Xnew2(1,:),Xnew2(2,:),'r.');

figure
plot(Xnew1p(1,:),Xnew1p(2,:),'k.',Xnew2p(1,:),Xnew2p(2,:),'r.',...
    Xnew3p(1,:),Xnew3p(2,:),'b.',Xnew4p(1,:),Xnew4p(2,:),'g.');

% figure
% plot(Xnew1(1,:),Xnew1(2,:),'kx');
% hold on
% plot(Xnew2(1,:),Xnew2(2,:),'ro');
% hold off
% 
% figure
% plot(Xnew1(1,:),Xnew1(2,:),'kx');
% hold on
% plot(Xnew2(1,:),Xnew2(2,:),'ro');
% hold off



function [Xnew1,Xnew2] = data_partion(X)
W = compute_weights(X);
D = compute_degree_matrix(X);
A = D\(D-W);
[V,Lambda] = eig(A);   % get the eigenvalues and eigenvectors
[~,indices] = mink(max(Lambda),2);
index = max(indices);  % find the index of the second smallest eigenvalue
z1 = V(:,index);
y1 = D^-0.5*z1;
N = length(X);
Xnew1 = [];
Xnew2 = [];
for i = 1:N
    if y1(i) > 0
        data1 = X(:,i);
        Xnew1 = [Xnew1,data1];
    else
        data2 = X(:,i);
        Xnew2 = [Xnew2,data2];
    end
end
end


% Compute the attribute matrix
function W = compute_weights(X)
    N = length(X);
    W = zeros(N);
    for i = 1:N
        for j = 1:N
            W(i,j) = exp(-0.1*(norm(X(:,i)-X(:,j)))^2);
        end
    end
end

% compute the degree matrix
function D = compute_degree_matrix(X)
    N = length(X);
    d = zeros(N,1);
    w = compute_weights(X);
%     for i = 1:N
%         wsum = 0;
%         for j = 1:N
%             wsum = wsum + w(i,j);
%         end
%         d(i) = wsum;
%     end
    for i = 1:N
        d(i) = sum(w(i,:));
    end
    D = diag(d);
end
