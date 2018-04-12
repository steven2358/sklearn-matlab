function K = pairwise_kernels(X, Y, metric, kwds)
% Compute the kernel between arrays X and optional array Y.
%
% This method takes either a vector array or a kernel matrix, and returns a
% kernel matrix. If the input is a vector array, the kernels are computed.
% If the input is a kernel matrix, it is returned instead.
%
% This method provides a safe way to take a kernel matrix as input, while
% preserving compatibility with many other algorithms that take a vector array.
%
% If Y is given (default is empty), then the returned matrix is the
% pairwise kernel between the arrays from both X and Y.
%
% Valid values for metric are:
% ['rbf', 'sigmoid', 'polynomial', 'poly', 'linear', 'cosine']
%
% Inputs:
% - X: Array of pairwise kernels between samples, or a feature array.
%   Shape: n_samples * n_features, or n_samples * n_samples if precomputed.
% - Y: A second feature array only if X has shape n_samples_a * n_features.
% - metric: The metric to use when calculating kernel between instances in
%   a feature array. If metric is a string, it must be one of the metrics
%   in pairwise_kernel_functions. If metric is "precomputed", X is assumed
%   to be a kernel matrix.  Alternatively, if metric is a callable
%   function, it is called on each pair of instances (rows) and the
%   resulting value recorded. The callable should take two arrays from X as
%   input and return a value indicating the distance between them.
% - kwds: Optional keyword parameters.
%
% Output:
% - K: A kernel matrix K such that K[i, j] is the kernel between the i-th
%   and j-th vectors of the given matrix X, if Y is empty. If Y is not
%   empty, then K[i, j] is the kernel between the i-th array from X and the
%   j-th
%   array from Y.

pairwise_kernel_functions = struct(...
    ...'additive_chi2', @additive_chi2_kernel,...
    ...'chi2', @chi2_kernel,...
    'linear', @linear_kernel,...
    'rbf', @rbf_kernel,...
    ...'laplacian', @laplacian_kernel,...
    ...'sigmoid', @sigmoid_kernel,...
    ...'cosine', @cosine_similarity
    'polynomial', @polynomial_kernel,...
    'poly', @polynomial_kernel);

% If metric is 'precomputed', Y is ignored and X is returned.
if strcmp(metric,'precomputed')
    K = X;
    return
elseif isa(metric,'function_handle')
    my_fun = metric;
elseif ismember(metric,fieldnames(pairwise_kernel_functions))
    my_fun = pairwise_kernel_functions.(metric);
else
    error('Unknown kernel')
end

K = my_fun(X,Y,kwds);
