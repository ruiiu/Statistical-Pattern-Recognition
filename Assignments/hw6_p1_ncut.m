clear
X1 = load('hw06-data1.mat').X';
X2 = load('hw06-data2.mat').X';

% [Xnew1,Xnew2]=BisectionCut(X1);
X = {X1,X2};
i = 1;
for j = 1:2
    for M = [2,4,8]
        idx = spectralcluster(X{j},M);
        figure(i)
        scatter(X{j}(:,1),X{j}(:,2),40,idx,'filled');
        title(['Normalized cuts, data',num2str(j),', M = ',num2str(M)]);
        i = i+1;
    end
end
        


% % partion the data into two parts
% function [Xnew1,Xnew2] = BisectionCut(X)
%     W = compute_weights(X);
%     D = compute_degree_matrix(X);
%     A = D\(D-W);
%     [V,Lambda] = eig(A);   % get the eigenvalues and eigenvectors
%     [~,indices] = mink(max(Lambda),2);
%     index = max(indices);  % find the index of the second smallest eigenvalue
%     z1 = V(:,index);
%     y1 = D^-0.5*z1;
%     scatter(X(1,:),X(2,:),40,sign(y1),'filled');
%     N = length(X);      
%     Xnew1 = [];
%     Xnew2 = [];
%     for i = 1:N
%         if y1(i) > 0
%             data1 = X(:,i);
%             Xnew1 = [Xnew1,data1];
%         else
%             data2 = X(:,i);
%             Xnew2 = [Xnew2,data2];
%         end
%     end
% end
% 
% 
% % Compute the attribute matrix
% function W = compute_weights(X)
%     N = length(X);
%     W = zeros(N);
%     for i = 1:N
%         for j = 1:N
%             W(i,j) = exp(-0.1*(norm(X(:,i)-X(:,j)))^2);
%         end
%     end
% end
% 
% % compute the degree matrix
% function D = compute_degree_matrix(X)
%     N = length(X);
%     d = zeros(N,1);
%     w = compute_weights(X);
%     for i = 1:N
%         d(i) = sum(w(i,:));
%     end
%     D = diag(d);
% end