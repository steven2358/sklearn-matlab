function p = make_pipeline(varargin)
% Construct a Pipeline from the given estimators.
%
% This is a shorthand for the Pipeline constructor; it does not require,
% and does not permit, naming the estimators. Instead, they will be given
% names automatically based on their types.

estimators = struct;
num_est = length(varargin);
for i=1:num_est
    fn = sprintf('%s%d',class(varargin{i}),i);
    estimators.(fn) = varargin{i};
end

p = Pipeline(estimators);
