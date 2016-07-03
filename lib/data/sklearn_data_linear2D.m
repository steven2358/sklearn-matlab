function [X_train, X_test, y_train, y_test] = sklearn_data_linear2D()

%% PARAMETERS

n = 300;
test_size = 1/3;

%% GENERATE

y = randn(n,1)>0;
X = randn(n,2);

% two clusters
X(y,:) = bsxfun(@plus,X(y,:),[1 1]);
X(~y,:) = bsxfun(@plus,X(~y,:),[-1 -1]);

[X_train, X_test, y_train, y_test] = train_test_split(X,y,test_size);

% %% OUTPUT
% 
% figure; hold all
% plot(X(y==0,1),X(y==0,2),'o')
% plot(X(y==1,1),X(y==1,2),'o')
