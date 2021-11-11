clear
X1 = load('hw06-data1.mat').X;
[U1,~,~] = svd(X1);   % the first linear principal direction
Z1 = U1(:,1)'*X1;

figure
histogram(Z1);

N = length(X1);
K = zeros(N,N);
for i = 1:N
    for j = 1:N
        K(i,j) = exp(-0.02*(norm(X1(:,i)-X1(:,j))^2));
    end
end

[V,D] = eig(K);
[~,index] = max(max(D));
a = V(:,index)/sqrt(D(index,index));   % the first kernel principal direction
Z2 = K*a;

figure
histogram(Z2);

