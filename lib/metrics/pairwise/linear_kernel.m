function K = linear_kernel(X, Y, ~)
% Compute the linear kernel between X and Y.
%
% Inputs:
% - X: Shape: n_samples_X * n_features.
% - Y: Shape: n_samples_Y * n_features.
%
% Output:
% - K: Kernel matrix. Shape: n_samples_X * n_samples_Y.

K = X*Y';
