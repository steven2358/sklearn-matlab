function K = rbf_kernel(X, Y, gamma)
% Compute the rbf (Gaussian) kernel between X and Y:
%
% K(x, y) = exp(-gamma * (x-y).^2)
%
% for each pair of rows x in X and y in Y.
%
% Inputs:
% - X: Shape: n_samples_X * n_features.
% - Y: Shape: n_samples_Y * n_features.
% - gamma: Kernel parameter. Defaults to 1/n_features. Either a string or a
%   struct that contains the field gamma.
%
% Output:
% - K: Kernel matrix. Shape: n_samples_X * n_samples_Y.

n_features = size(X,2);

% retrieve gamma
if nargin<3
    gamma = 1/n_features;
elseif isa(gamma,'struct')
    if ismember('gamma',fieldnames(gamma))
        gamma = gamma.gamma;
    else
        gamma = 1/n_features;
    end
end

K = exp(-gamma*euclidean_distances(X,Y,true));
