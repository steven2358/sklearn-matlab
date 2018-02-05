classdef Lasso_ < BaseEstimator
    % Linear Model trained with L1 prior as regularizer.
    %
    % Requires the statistics toolbox
    
    properties (GetAccess = 'public', SetAccess = 'public')
        % parameters
        alpha = 1E-2; % regularization
    end
    
    properties (GetAccess = 'public', SetAccess = 'private')
        % attributes
        coef_; % coefficients
        intercept_; % independent term in decision function.
    end
    
    methods
        % constructor
        function obj = Lasso_(params)
            if nargin>0
                obj.set_params(params)
            end
        end
        
        function fit(obj,X,y,~)
            [coef, info] = lasso(X, y, 'Standardize', false,...
                'Lambda', obj.alpha);
            obj.coef_ = coef;
            obj.intercept_ = info.Intercept;
        end
        
        function proba = predict_proba(obj,X,~)
            proba = X*obj.coef_ + obj.intercept_;
        end
        
    end
end
