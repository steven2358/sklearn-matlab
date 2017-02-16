function [J, grad] = log_cost_function_reg(theta, X, y, lambda, weights)
% LOG_COST_FUNCTION_REG Compute cost and gradient for logistic regression
% with regularization.
%   J = LOG_COST_FUNCTION_REG(theta, X, y, lambda) computes the cost of
%   using theta as the parameter for regularized logistic regression and
%   the gradient of the cost w.r.t. to the parameters.
%   w is optional sample weight.

% Initialize some useful values
m = length(y); % number of training examples

if nargin<5
    weights = ones(m,1);
end

% Compute the cost of a particular choice of theta.

h = 1 ./ (1 + exp(-X*theta)); % sigmoid of X*theta

theta_reg = theta;
theta_reg(1) = 0; % exclude theta(1) from regularization

% cost
J = 1/m*(-y'*(log(h).*weights) - (1-y')*((log(1-h)).*weights)) + ...
    lambda/2/m*(theta_reg'*theta_reg);

% gradient
grad = 1/m*X'*((h-y).*weights) + lambda/m*theta_reg;
end
