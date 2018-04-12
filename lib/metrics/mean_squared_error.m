function output_errors = mean_squared_error(y_true, y_pred, sample_weight)
% Mean squared error regression loss.
%
% Inputs:
% - y_true: Ground truth target values. Shape: n_samples * n_outputs.
% - y_true: Estimated target values. Shape: n_samples * n_outputs.
% - sample_weight: Sample weights. Shape: n_samples * 1. Optional.
%
% Output:
% - output_errors: Array of MSE values. Shape: n_samples * 1.

err = y_true - y_pred;

if nargin < 3
    output_errors = mean(err(:).^2);
else
    err = bsxfun(@times,err,sample_weight);
    output_errors = mean(err(:).^2);
end
