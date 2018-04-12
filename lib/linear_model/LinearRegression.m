classdef LinearRegression < BaseEstimator & RegressorMixin
    % Ordinary least squares Linear Regression.
    
    properties (GetAccess = 'public', SetAccess = 'public')
        % parameters
    end
    
    properties (GetAccess = 'public', SetAccess = 'private')
        % attributes
        coef_; % coefficients for the linear regression problem
        intercept_; % independent term in the linear model
    end
    
    methods
        % constructor
        function obj = LinearRegression(params)
            if nargin>0
                obj.set_params(params)
            end
        end
        
        % Fit linear model.
        function fit(obj,X,y,~)
            ab = [X ones(size(X,1),1)]\y;
            obj.coef_ = ab(1:end-1);
            obj.intercept_ = ab(2);
        end
        
        % Predict using the linear model.
        function C = predict(obj,X)
            C = X*obj.coef_ + obj.intercept_;
        end
    end
end
