function [X_train, X_test, y_train, y_test] = sklearn_data_noisyplane()
% noisy points on a 2D plane in 3 dimensions

%% PARAMETERS

n = 500;
test_size = 1/3;
noisepower = 1E-1;

%% GENERATE

X = randn(n,2);
noise = sqrt(noisepower)*randn(n,1);

projection = randn(2,1);
projection = projection/norm(projection);
y = X*projection + noise;

[X_train, X_test, y_train, y_test] = train_test_split(X,y,test_size);

% %% OUTPUT
%
% figure;
% plot3(X(:,1),X(:,2),y,'.')
% view([45 45 0])
% axis equal
% grid on
