classdef RegressorMixin < handle
    % Mixin class for all regression estimators in sklearn-matlab.
    
    properties
        estimator_type = 'regressor';
    end
    
    methods
        
        function R2 = score(obj, X, y, sample_weight)
            % Returns the coefficient of determination R^2 of the
            % prediction. The coefficient R^2 is defined as (1 - u/v),
            % where u is the residual sum of squares sum((y_true -
            % y_pred).^2) and v is the total sum of squares sum((y_true -
            % mean(y_true)).^2). The best possible score is 1.0 and it can
            % be negative (because the model can be arbitrarily worse). A
            % constant model that always predicts the expected value of y,
            % disregarding the input features, would get a R^2 score of
            % 0.0.
            %
            % Inputs:
            % - X: Test samples. Shape: n_samples * n_features.
            % - y: True values for X. Shape: n_samples * 1.
            % - sample_weight: Weights. Shape: n_samples * 1. Optional.
            %
            % Output:
            % - score: R^2 of obj.predict(X) wrt. y.
            
            if nargin<4
                sample_weight = [];
            end
            
            y_pred = obj.predict(X);
            R2 = r2_score(y, y_pred, sample_weight);
        end
    end
end
