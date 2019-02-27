% Kernel ridge regression demo.
%
% This program implements the example shown in Figure 2.1 of "Kernel
% Methods for Nonlinear Identification, Equalization and Separation of
% Signals".
%
% Author: Steven Van Vaerenbergh, 2018.

close all
clear
rng('default'); rng(1); % Reproducibility

%% PARAMETERS

% data
n_train = 50; % number of training data points
n_test = 100; % number of test data points
noise_var = 0.05; % noise variance

% noisy sinc function
my_fun = @(x,noise_var) (sin(3*x)./x + noise_var*randn(size(x)));

% kernel
alpha = 1E4; % regularization constant
kernel = 'rbf';	% kernel type
gamma = 1; % Gaussian kernel width

%% PROGRAM
tic

% generate train data
X_train = 6*(rand(n_train,1)-0.5); % sampled data
y_train = my_fun(X_train,noise_var);

% generate test data
X_test = linspace(-3,3,n_test)'; % input data on a grid
y_test = my_fun(X_test,0);

% train and test
clf = KernelRidge(struct('alpha',alpha,'kernel',kernel,'gamma',gamma));
clf.fit(X_train,y_train);
y_pred = clf.predict(X_test);

toc
%% OUTPUT

figure; hold on
plot(X_train,y_train,'o');
plot(X_test,y_pred,'r');
plot(X_test,y_test,'--','Color',[.5 .5 .5])
legend('noisy data','regression','true sinc function')
title('Kernel ridge regression demo')
