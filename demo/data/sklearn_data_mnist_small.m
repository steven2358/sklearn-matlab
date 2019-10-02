function [X_train, X_test, y_train, y_test] = sklearn_data_mnist_small(plot_idx)
% Load and flatten a subset of MNIST.

%% PARAMETERS
if nargin < 1
    plot_idx = [];
end

test_size = 1/3;

%% LOAD
[X, y] = digitSmallCellArrayData;

[X_train, X_test, y_train, y_test] = train_test_split(X.',y.',test_size);

% Convert from 1-hot encoding to indices
y_train = vec2ind(y_train.').';
y_test = vec2ind(y_test.').';

%% PLOT
for idx = plot_idx
    figure(idx);
    imshow(X_train{idx,:,:});
    title(sprintf('Dataset index: %d', idx));
    axis equal
end