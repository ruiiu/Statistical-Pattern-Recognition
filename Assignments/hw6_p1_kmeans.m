clear
X1 = load('hw06-data1.mat').X;
X2 = load('hw06-data2.mat').X;


X = {X1,X2};
i = 1;
for j = 1:2
    for M = [2,4,8]   
        figure(i)
        labels = KMeans(M,X{j});
        scatter(X{j}(1,:),X{j}(2,:),40,labels,'filled');
        title(['Kmeans clustering, data',num2str(j),' ,M = ',num2str(M)]);
        i = i+1;
    end
end

% input arguments, M: prefined number of clusters, N: number of data points
function labels = KMeans(M,X)
eps = 1e-6;  % to check wheter to update the mean
[D,N] = size(X);  % D is the dimension of the sample, N is the total number of data points
mean = 1/N*sum(X,2);
mu = mean*randn(1,M);   % get the initial value of mean of each cluster
labels = zeros(1,N);

while true
    for i = 1:N
        distance_set = zeros(1,M);
        for j = 1:M
            d = norm(X(:,i)-mu(:,j));
            distance_set(j) = d;
        end
        [~,index] = min(distance_set);
        labels(i) = index;
    end
    newmu = zeros(D,M);

    for j = 1:M 
        count = 0;
        for i = 1:N
            if labels(i) == j
                newmu(:,j) = newmu(:,j)+X(:,i);
                count = count + 1;
            end
        end
        newmu(:,j) = newmu(:,j)/count;      
    end

    error = 1/D*norm(newmu-mu,1);

    if(error > eps)
        mu = newmu;
    else
        break;
    end
end
end