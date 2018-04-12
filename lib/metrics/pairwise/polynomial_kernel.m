function K = polynomial_kernel(X, Y, degree, gamma, coef0)
% Compute the polynomial kernel between X and Y:
%
% K(x, y) = (gamma*X*Y' + coef0).^degree
%
% for each pair of rows x in X and y in Y.
%
% Inputs:
% - X: Shape: n_samples_X * n_features.
% - Y: Shape: n_samples_Y * n_features.
% - degree: Polynomial degree. If degree is a struct it is a set of
%   parameters that overwrite degree, gamma and coef.
% - gamma: Kernel parameter. Defaults to 1/n_features.
% - coef0: Additive constant.
%
% Output:
% - K: kernel matrix. Shape: n_samples_X * n_samples_Y.

if nargin<3
    degree = 3;
end
if nargin<4
    gamma = [];
end
if isempty(gamma)
    n_features = size(X,2);
    gamma = 1/n_features;
end
if nargin<5
    coef0 = 1;
end

if isa(degree,'struct')
    if ismember('gamma',fieldnames(degree))
        gamma = degree.gamma;
    end
    if ismember('coef0',fieldnames(degree))
        coef0 = degree.coef0;
    end
    if ismember('degree',fieldnames(degree))
        degree = degree.degree;
    else
        degree = 3;
    end
end

K = (gamma*X*Y' + coef0).^degree;
