function score = accuracy_score(y_true, y_pred, normalize, sample_weight)
% Accuracy classification score.
%
% In multilabel classification, this function computes subset accuracy: the
% set of labels predicted for a sample must *exactly* match the
% corresponding set of labels in y_true.
%
% Inputs:
% - y_true: Ground truth (correct) labels.
% - y_pred: Predicted labels, as returned by a classifier.
% - normalize:  If False, return the number of correctly classified
%   samples. Otherwise, return the fraction of correctly classified
%   samples. default=True
% - sample_weight: Sample weights. Shape: n_samples * 1. Optional.
%
% Outputs:
% - score: If normalize == True, return the correctly classified samples
%   (float), else it returns the number of correctly classified samples
%   (int). The best performance is 1 with ``normalize == True`` and the
%   number of samples with ``normalize == False``.

if nargin<3
    normalize = true;
end
if nargin<4
    sample_weight = ones(size(y_true));
end

if isa(y_true,'cell')
    sample_score = cellfun(@isequal,y_true,y_pred);
else
    sample_score = y_true == y_pred;
end

score = weighted_sum_(sample_score, sample_weight, normalize);

function weighted_sum = weighted_sum_(sample_score, sample_weight, normalize)
if normalize
    weighted_sum = mean(sample_score.*sample_weight);
elseif ~isempty(sample_weight)
    weighted_sum = sample_score'*sample_weight;
else
    weighted_sum = sum(sample_score);
end
