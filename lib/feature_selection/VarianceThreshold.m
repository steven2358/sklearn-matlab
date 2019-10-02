classdef VarianceThreshold < BaseEstimator & SelectorMixin
    % Feature selector that removes all low-variance features.
    
    properties (GetAccess = 'public', SetAccess = 'public')
        % parameters
        threshold = 0; % (float) features with a training-set variance lower than this threshold will be removed.
    end
    
    properties (GetAccess = 'public', SetAccess = 'private')
        % attributes
        variances; % (array, shape [n_features]) Variances of individual features.
    end
    
    methods
        % constructor
        function obj = VarianceThreshold(params)
            if nargin>0
                obj.set_params(params)
            end
        end
        
        % Fit the model with X.
        function fit(obj,X,~)
            % Normalize by number of observations, to match sklearn
            weighting_scheme = 1;
            var_dim = 1;
            obj.variances = var(X, weighting_scheme, var_dim);
            
            assert(~all(obj.variances <= obj.threshold),...
                   'No feature in X meets the variance threshold %f', obj.threshold);
        end
        
    end
    
    methods (Access = 'protected')
        % Return the feature selection mask
        function mask = get_support_mask(obj)
            mask = obj.variances > obj.threshold;
        end
    end
end
