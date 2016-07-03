function [X_train, X_test, y_train, y_test] = train_test_split(X,y,...
    test_size,random_state)

if nargin<3
    test_size = 1/3;
end

if nargin>3
    rng('default');
    rng(random_state);
end

n = size(X,1);
n_test = floor(test_size*n);
n_train = n - n_test;

indp = randperm(n);
ind_train = indp(1:n_train);
ind_test = indp(n_train+1:n);

X_train = X(ind_train,:);
X_test = X(ind_test,:);
y_train = y(ind_train);
y_test = y(ind_test);
