classdef LinearRegression < handle
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
        function obj = LinearRegression(parameters)
            if (nargin > 0) % copy valid parameters
                for fn = fieldnames(parameters)',
                    if ismember(fn,fieldnames(obj)),
                        obj.(fn{1}) = parameters.(fn{1});
                    end
                end
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
        
        % Returns the coefficient of determination R^2 of the prediction.
        function R2 = score(obj,X,y)
            y_pred = obj.predict(X);
            u = sum((y-y_pred).^2);
            v = sum((y-mean(y)).^2);
            R2 = 1-u/v; % coefficient of determination R^2
        end
    end
end
