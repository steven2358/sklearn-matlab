classdef Ridge < BaseEstimator & RegressorMixin
    % Linear least squares with L2 regularization.
    
    properties (GetAccess = 'public', SetAccess = 'public')
        % parameters
        alpha = 1E2; % Regularization. Corresponds to C^-1.
    end
    
    properties (GetAccess = 'public', SetAccess = 'private')
        % attributes
        coef_; % Weight vectors
    end
    
    methods
        % constructor
        function obj = Ridge(params)
            if nargin>0
                obj.set_params(params)
            end
        end
        
        % Fit Ridge regression model
        function fit(obj,X,y)
            lambda = 1/obj.alpha;
            w = (X'*X+lambda*eye(size(X,2)))\X'*y;
            
            obj.coef_ = w(:);
        end
        
        function C = predict(obj,X)
            C = X*obj.coef_;
        end
    end
end
