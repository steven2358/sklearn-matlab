function [X_train, X_test, y_train, y_test] = sklearn_data_3clusters()
% Generate a data set containing three clusters.

%% PARAMETERS

n = 300;
test_size = 1/3;

%% GENERATE

X = 0.3*randn(n,2);
y = ceil(3*rand(n,1));
y(y==0) = 1;

% three clusters
X(y==1,:) = bsxfun(@plus,X(y==1,:),[.8 1]);
X(y==2,:) = bsxfun(@plus,X(y==2,:),[-.6 -1]);
X(y==3,:) = bsxfun(@plus,X(y==3,:),[-1 .7]);

[X_train, X_test, y_train, y_test] = train_test_split(X,y,test_size);

%% OUTPUT

% figure; hold all
% plot(X(y==1,1),X(y==1,2),'o')
% plot(X(y==2,1),X(y==2,2),'o')
% plot(X(y==3,1),X(y==3,2),'o')
