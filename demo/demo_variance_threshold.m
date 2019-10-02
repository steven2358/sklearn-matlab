% Remove features using a variance threshold

%%
close all
clear
rng('default');
rng(1); % for reproducibility

%% Load data
plot_idx = randi([1, 10]);
[X_train, X_test, y_train, y_test] = sklearn_data_mnist_small(plot_idx);

X_train_flat = cell2mat(cellfun(@(x) x(:).', X_train, 'UniformOutput', false));

%% Plot features with variance above the given threshold
params = struct('threshold', 0.1);
vt = VarianceThreshold(params);
vt.fit(X_train_flat);

mask = reshape(vt.get_support(), size(X_train{1}));

f1 = figure;
imshow(mask);
title(sprintf('Mask: variance-threshold=%0.1f', params.threshold))