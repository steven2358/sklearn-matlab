function z = r2_score(y_true,y_pred,sample_weight)
% R^2 (coefficient of determination) regression score function. Best
% possible score is 1.0 and it can be negative (because the model can be
% arbitrarily worse). A constant model that always predicts the expected
% value of y, disregarding the input features, would get a R^2 score of
% 0.0.
%
% Inputs:
% - y_true: Ground truth (correct) target values. Shape: n_samples *
%   n_outputs.
% - y_pred: Estimated target values. Shape: n_samples * n_outputs.
% - sample_weight: Sample weights. Shape: n_samples * 1. Optional.
%
% Output:
% - output_scores: The R^2 score.

if nargin<3
    sample_weight = [];
end
if isempty(sample_weight)
    sample_weight = ones(size(y_true,1),1);
end

numerator = sum(bsxfun(@times,(y_true-y_pred).^2,sample_weight),1);
denominator = sum(bsxfun(@times,(y_true-mean(y_true)).^2,sample_weight),1);

nonzero_denominator = denominator ~= 0;
nonzero_numerator = numerator ~= 0;
valid_score = nonzero_denominator & nonzero_numerator;

output_scores = ones(size(y_true,2),1);
    
output_scores(valid_score) = 1 - ...
    numerator(valid_score)./denominator(valid_score);

z = mean(output_scores);
